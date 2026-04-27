const express = require("express");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const cors = require("cors");
const mysql = require("mysql2");
const multer = require("multer");
const path = require("path");
const fs = require("fs");

const app = express();
app.use(express.json());
app.use(cors());

// Serve uploaded files as static assets
app.use("/uploads", express.static(path.join(__dirname, "uploads")));

// Multer: save profile pictures to uploads/profile_pictures/
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    const dir = path.join(__dirname, "uploads", "profile_pictures");
    fs.mkdirSync(dir, { recursive: true });
    cb(null, dir);
  },
  filename: (req, file, cb) => {
    const ext = path.extname(file.originalname).toLowerCase();
    const tag = req.user ? req.user.username : (req.params.id || "prof");
    cb(null, `${Date.now()}_${tag}${ext}`);
  }
});
const upload = multer({
  storage,
  fileFilter: (req, file, cb) => {
    if (!file.mimetype.startsWith("image/")) {
      return cb(new Error("Images only"));
    }
    cb(null, true);
  },
  limits: { fileSize: 2 * 1024 * 1024 } // 2 MB
});

const SECRET = "mysecretkey";

// =========================
// DATABASE CONNECTION
// =========================
const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "rate_my_professor"
});

db.connect(err => {
  if (err) throw err;
  console.log("Database connected!");
  db.query(`
    CREATE TABLE IF NOT EXISTS reply_likes (
      id INT(11) NOT NULL AUTO_INCREMENT,
      reply_id INT(11) NOT NULL,
      username VARCHAR(100) NOT NULL,
      value TINYINT(1) NOT NULL,
      PRIMARY KEY (id),
      UNIQUE KEY uq_reply_user (reply_id, username),
      KEY idx_reply_likes_reply_id (reply_id)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
  `, (err) => { if (err) console.error("reply_likes table error:", err); });

  db.query(`
    CREATE TABLE IF NOT EXISTS notifications (
      id INT(11) NOT NULL AUTO_INCREMENT,
      username VARCHAR(100) NOT NULL,
      type VARCHAR(50) NOT NULL,
      message TEXT NOT NULL,
      link VARCHAR(255) DEFAULT NULL,
      is_read TINYINT(1) NOT NULL DEFAULT 0,
      created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      PRIMARY KEY (id),
      KEY idx_notifications_username (username)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
  `, (err) => { if (err) console.error("notifications table error:", err); });
});

// =========================
// REGISTER
// =========================
app.post("/register", async (req, res) => {
  try {
    const { username, password } = req.body;

    // Check if user exists
    db.query("SELECT * FROM users WHERE username = ?", [username], async (err, results) => {
      if (err) return res.status(500).json({ message: "Database error" });

      if (results.length > 0) {
        return res.status(400).json({ message: "User already exists" });
      }

      // Hash password
      const hashedPassword = await bcrypt.hash(password, 10);

      // Save user
      db.query("INSERT INTO users (username, password) VALUES (?, ?)", [username, hashedPassword], (err) => {
        if (err) return res.status(500).json({ message: "Error saving user" });
        res.json({ message: "User registered successfully" });
      });
    });

  } catch (error) {
    res.status(500).json({ message: "Error registering user" });
  }
});

// =========================
// LOGIN
// =========================
app.post("/login", async (req, res) => {
  try {
    const { username, password } = req.body;

    db.query("SELECT * FROM users WHERE username = ?", [username], async (err, results) => {
      if (err) return res.status(500).json({ message: "Database error" });

      if (results.length === 0) {
        return res.status(400).json({ message: "Invalid credentials" });
      }

      const user = results[0];

      // Compare password
      const isMatch = await bcrypt.compare(password, user.password);
      if (!isMatch) {
        return res.status(400).json({ message: "Invalid credentials" });
      }

      // Create token
      const token = jwt.sign({ username: user.username }, SECRET, { expiresIn: "1h" });
      res.json({ message: "Login successful", token });
    });

  } catch (error) {
    res.status(500).json({ message: "Error logging in" });
  }
});

// =========================
// AUTH MIDDLEWARE
// =========================
function optionalAuth(req, res, next) {
  const token = (req.headers["authorization"] || "").split(" ")[1];
  if (!token) { req.user = null; return next(); }
  jwt.verify(token, SECRET, (err, user) => {
    req.user = err ? null : user;
    next();
  });
}

function authenticateToken(req, res, next) {
  const authHeader = req.headers["authorization"];
  const token = authHeader && authHeader.split(" ")[1];

  if (!token) return res.sendStatus(401);

  jwt.verify(token, SECRET, (err, user) => {
    if (err) return res.sendStatus(403);
    req.user = user;
    next();
  });
}

// =========================
// GET DEPARTMENTS
// =========================
app.get("/departments", (req, res) => {
  db.query("SELECT id, name FROM departments ORDER BY name ASC", (err, results) => {
    if (err) return res.status(500).json({ message: "Database error" });
    res.json(results);
  });
});

// =========================
// GET PROFESSORS
// =========================
app.get("/professors", (req, res) => {
  db.query(
    `SELECT p.id, p.name, p.profile_picture, p.bio, p.created_at,
            COALESCE(d.name, 'Unknown') AS department
     FROM professors p
     LEFT JOIN departments d ON p.department_id = d.id`,
    (err, results) => {
      if (err) return res.status(500).json({ message: "Database error" });
      res.json(results);
    }
  );
});

// =========================
// POST PROFESSOR (Protected)
// =========================
app.post("/professors", authenticateToken, (req, res) => {
  const { name, department_id } = req.body;

  db.query("INSERT INTO professors (name, department_id) VALUES (?, ?)", [name, department_id], (err, result) => {
    if (err) return res.status(500).json({ message: "Error adding professor" });

    const profId = result.insertId;

    // Notify all users about the new lecturer
    db.query("SELECT username FROM users", (err2, users) => {
      if (!err2 && users.length > 0) {
        const link = `/professor-profile.html?id=${profId}`;
        const message = `New lecturer added: ${name}`;
        users.forEach(u => {
          db.query(
            "INSERT INTO notifications (username, type, message, link) VALUES (?, 'professor_added', ?, ?)",
            [u.username, message, link]
          );
        });
      }
    });

    res.json({
      message: "Professor added",
      professor: { id: profId, name, department_id }
    });
  });
});

// =========================
// GET REVIEWS
// ?professor_id=X  → reviews for one professor
// (no param)       → global feed (all reviews, newest first, with professor name)
// =========================
app.get("/reviews", (req, res) => {
  const { professor_id } = req.query;

  if (professor_id) {
    db.query(
      `SELECT r.*, p.name AS professor_name, COALESCE(d.name, 'Unknown') AS department,
              u.profile_picture AS user_picture
       FROM reviews r
       JOIN professors p ON r.professor_id = p.id
       LEFT JOIN departments d ON p.department_id = d.id
       LEFT JOIN users u ON r.username = u.username
       WHERE r.professor_id = ?
       ORDER BY r.created_at DESC`,
      [professor_id],
      (err, results) => {
        if (err) return res.status(500).json({ message: "Database error" });
        res.json(results);
      }
    );
  } else {
    db.query(
      `SELECT r.*, p.name AS professor_name, COALESCE(d.name, 'Unknown') AS department,
              u.profile_picture AS user_picture
       FROM reviews r
       JOIN professors p ON r.professor_id = p.id
       LEFT JOIN departments d ON p.department_id = d.id
       LEFT JOIN users u ON r.username = u.username
       ORDER BY r.created_at DESC
       LIMIT 50`,
      (err, results) => {
        if (err) return res.status(500).json({ message: "Database error" });
        res.json(results);
      }
    );
  }
});

// =========================
// POST REVIEW (Protected)
// =========================
app.post("/reviews", authenticateToken, (req, res) => {
  const { professor_id, review_text, rating } = req.body;

  if (!professor_id || !review_text || !rating) {
    return res.status(400).json({ message: "professor_id, review_text, and rating are required" });
  }

  if (rating < 1 || rating > 5) {
    return res.status(400).json({ message: "Rating must be between 1 and 5" });
  }

  db.query(
    "INSERT INTO reviews (professor_id, username, review_text, rating) VALUES (?, ?, ?, ?)",
    [professor_id, req.user.username, review_text, rating],
    (err, result) => {
      if (err) return res.status(500).json({ message: "Error saving review" });
      res.json({
        message: "Review submitted",
        review: { id: result.insertId, professor_id, username: req.user.username, review_text, rating }
      });
    }
  );
});

// =========================
// GET MY REVIEWS (Protected)
// =========================
app.get("/reviews/mine", authenticateToken, (req, res) => {
  db.query(
    `SELECT r.*, p.name AS professor_name, COALESCE(d.name, 'Unknown') AS department
     FROM reviews r
     JOIN professors p ON r.professor_id = p.id
     LEFT JOIN departments d ON p.department_id = d.id
     WHERE r.username = ?
     ORDER BY r.created_at DESC`,
    [req.user.username],
    (err, results) => {
      if (err) return res.status(500).json({ message: "Database error" });
      res.json(results);
    }
  );
});

// =========================
// EDIT REVIEW (Protected, owner only)
// =========================
app.put("/reviews/:id", authenticateToken, (req, res) => {
  const { review_text, rating } = req.body;
  if (!review_text || !rating) {
    return res.status(400).json({ message: "review_text and rating are required" });
  }
  if (rating < 1 || rating > 5) {
    return res.status(400).json({ message: "Rating must be between 1 and 5" });
  }
  db.query(
    "UPDATE reviews SET review_text = ?, rating = ? WHERE id = ? AND username = ?",
    [review_text, rating, req.params.id, req.user.username],
    (err, result) => {
      if (err) return res.status(500).json({ message: "Database error" });
      if (result.affectedRows === 0) {
        return res.status(404).json({ message: "Review not found or not yours" });
      }
      res.json({ message: "Review updated" });
    }
  );
});

// =========================
// DELETE REVIEW (Protected, owner only)
// =========================
app.delete("/reviews/:id", authenticateToken, (req, res) => {
  db.query(
    "DELETE FROM reviews WHERE id = ? AND username = ?",
    [req.params.id, req.user.username],
    (err, result) => {
      if (err) return res.status(500).json({ message: "Database error" });
      if (result.affectedRows === 0) {
        return res.status(404).json({ message: "Review not found or not yours" });
      }
      res.json({ message: "Review deleted" });
    }
  );
});

// =========================
// GET REPLIES (by review)
// =========================
app.get("/replies", optionalAuth, (req, res) => {
  const { review_id } = req.query;
  if (!review_id) return res.status(400).json({ message: "review_id is required" });

  const viewer = req.user ? req.user.username : null;

  db.query(
    `SELECT rp.id, rp.review_id, rp.username, rp.reply_text, rp.created_at,
            u.profile_picture AS user_picture,
            COALESCE(SUM(CASE WHEN rl.value = 1  THEN 1 ELSE 0 END), 0) AS likes,
            COALESCE(SUM(CASE WHEN rl.value = -1 THEN 1 ELSE 0 END), 0) AS dislikes,
            MAX(CASE WHEN rl.username = ? THEN rl.value ELSE NULL END) AS my_vote
     FROM replies rp
     LEFT JOIN users u ON rp.username = u.username
     LEFT JOIN reply_likes rl ON rp.id = rl.reply_id
     WHERE rp.review_id = ?
     GROUP BY rp.id, rp.review_id, rp.username, rp.reply_text, rp.created_at, u.profile_picture
     ORDER BY rp.created_at ASC`,
    [viewer, review_id],
    (err, results) => {
      if (err) return res.status(500).json({ message: "Database error" });
      res.json(results);
    }
  );
});

// =========================
// POST REPLY (Protected)
// =========================
app.post("/replies", authenticateToken, (req, res) => {
  const { review_id, reply_text } = req.body;

  if (!review_id || !reply_text) {
    return res.status(400).json({ message: "review_id and reply_text are required" });
  }

  db.query(
    "INSERT INTO replies (review_id, username, reply_text) VALUES (?, ?, ?)",
    [review_id, req.user.username, reply_text],
    (err, result) => {
      if (err) return res.status(500).json({ message: "Error saving reply" });

      // Notify the review author (if different from replier)
      db.query(
        "SELECT r.username, r.professor_id FROM reviews r WHERE r.id = ?",
        [review_id],
        (err2, rows) => {
          if (!err2 && rows.length > 0 && rows[0].username !== req.user.username) {
            const link = `/professor-profile.html?id=${rows[0].professor_id}&review=${review_id}`;
            db.query(
              "INSERT INTO notifications (username, type, message, link) VALUES (?, 'reply', ?, ?)",
              [rows[0].username, `${req.user.username} replied to your review`, link]
            );
          }
        }
      );

      res.json({
        message: "Reply posted",
        reply: { id: result.insertId, review_id, username: req.user.username, reply_text }
      });
    }
  );
});

// =========================
// CHANGE PASSWORD (Protected)
// =========================
app.put("/users/password", authenticateToken, async (req, res) => {
  const { current_password, new_password } = req.body;
  if (!current_password || !new_password) {
    return res.status(400).json({ message: "current_password and new_password are required" });
  }
  db.query("SELECT * FROM users WHERE username = ?", [req.user.username], async (err, results) => {
    if (err) return res.status(500).json({ message: "Database error" });
    if (results.length === 0) return res.status(404).json({ message: "User not found" });
    const isMatch = await bcrypt.compare(current_password, results[0].password);
    if (!isMatch) return res.status(400).json({ message: "Current password is incorrect" });
    const hashed = await bcrypt.hash(new_password, 10);
    db.query("UPDATE users SET password = ? WHERE username = ?", [hashed, req.user.username], (err2) => {
      if (err2) return res.status(500).json({ message: "Database error" });
      res.json({ message: "Password updated successfully" });
    });
  });
});

// =========================
// DELETE ACCOUNT (Protected)
// =========================
app.delete("/users/me", authenticateToken, (req, res) => {
  db.query("DELETE FROM users WHERE username = ?", [req.user.username], (err) => {
    if (err) return res.status(500).json({ message: "Database error" });
    res.json({ message: "Account deleted" });
  });
});

// =========================
// GET CURRENT USER (me)
// =========================
app.get("/users/me", authenticateToken, (req, res) => {
  db.query(
    "SELECT id, username, profile_picture, created_at FROM users WHERE username = ?",
    [req.user.username],
    (err, results) => {
      if (err) return res.status(500).json({ message: "Database error" });
      if (results.length === 0) return res.status(404).json({ message: "User not found" });
      res.json(results[0]);
    }
  );
});

// =========================
// UPLOAD USER PROFILE PICTURE (Protected)
// =========================
app.post("/users/profile-picture", authenticateToken, upload.single("picture"), (req, res) => {
  if (!req.file) return res.status(400).json({ message: "No file uploaded" });
  const picturePath = "uploads/profile_pictures/" + req.file.filename;

  db.query(
    "UPDATE users SET profile_picture = ? WHERE username = ?",
    [picturePath, req.user.username],
    (err) => {
      if (err) return res.status(500).json({ message: "Database error" });
      res.json({ message: "Profile picture updated", profile_picture: picturePath });
    }
  );
});

// =========================
// UPLOAD PROFESSOR PICTURE (Protected)
// =========================
app.post("/professors/:id/profile-picture", authenticateToken, upload.single("picture"), (req, res) => {
  if (!req.file) return res.status(400).json({ message: "No file uploaded" });
  const picturePath = "uploads/profile_pictures/" + req.file.filename;

  db.query(
    "UPDATE professors SET profile_picture = ? WHERE id = ?",
    [picturePath, req.params.id],
    (err) => {
      if (err) return res.status(500).json({ message: "Database error" });
      res.json({ message: "Professor picture updated", profile_picture: picturePath });
    }
  );
});

// =========================
// REACT TO REPLY — like (1) or dislike (-1), toggle off if same (Protected)
// =========================
app.post("/replies/:id/react", authenticateToken, (req, res) => {
  const replyId = req.params.id;
  const { value } = req.body;
  if (value !== 1 && value !== -1) {
    return res.status(400).json({ message: "value must be 1 or -1" });
  }

  const returnCounts = () => {
    db.query(
      `SELECT
         COALESCE(SUM(CASE WHEN value = 1  THEN 1 ELSE 0 END), 0) AS likes,
         COALESCE(SUM(CASE WHEN value = -1 THEN 1 ELSE 0 END), 0) AS dislikes,
         MAX(CASE WHEN username = ? THEN value ELSE NULL END) AS my_vote
       FROM reply_likes WHERE reply_id = ?`,
      [req.user.username, replyId],
      (err, rows) => {
        if (err) return res.status(500).json({ message: "Database error" });
        const r = rows[0];
        res.json({ likes: Number(r.likes), dislikes: Number(r.dislikes), my_vote: r.my_vote });
      }
    );
  };

  db.query(
    "SELECT value FROM reply_likes WHERE reply_id = ? AND username = ?",
    [replyId, req.user.username],
    (err, existing) => {
      if (err) return res.status(500).json({ message: "Database error" });

      if (existing.length > 0) {
        if (existing[0].value === value) {
          db.query(
            "DELETE FROM reply_likes WHERE reply_id = ? AND username = ?",
            [replyId, req.user.username],
            (err2) => { if (err2) return res.status(500).json({ message: "Database error" }); returnCounts(); }
          );
        } else {
          db.query(
            "UPDATE reply_likes SET value = ? WHERE reply_id = ? AND username = ?",
            [value, replyId, req.user.username],
            (err2) => { if (err2) return res.status(500).json({ message: "Database error" }); returnCounts(); }
          );
        }
      } else {
        db.query(
          "INSERT INTO reply_likes (reply_id, username, value) VALUES (?, ?, ?)",
          [replyId, req.user.username, value],
          (err2) => { if (err2) return res.status(500).json({ message: "Database error" }); returnCounts(); }
        );
      }
    }
  );
});

// =========================
// GET NOTIFICATIONS (Protected)
// =========================
app.get("/notifications", authenticateToken, (req, res) => {
  db.query(
    "SELECT * FROM notifications WHERE username = ? ORDER BY created_at DESC LIMIT 50",
    [req.user.username],
    (err, results) => {
      if (err) return res.status(500).json({ message: "Database error" });
      res.json(results);
    }
  );
});

// =========================
// MARK NOTIFICATIONS READ (Protected)
// =========================
app.put("/notifications/mark-read", authenticateToken, (req, res) => {
  db.query(
    "UPDATE notifications SET is_read = 1 WHERE username = ? AND is_read = 0",
    [req.user.username],
    (err) => {
      if (err) return res.status(500).json({ message: "Database error" });
      res.json({ message: "Notifications marked as read" });
    }
  );
});

// =========================
// START SERVER
// =========================
app.listen(3000, () => {
  console.log("Server running on http://localhost:3000");
});