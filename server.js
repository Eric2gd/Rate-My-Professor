const express = require("express");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const cors = require("cors");
const mysql = require("mysql2");

const app = express();
app.use(express.json());
app.use(cors());

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
// GET PROFESSORS
// =========================
app.get("/professors", (req, res) => {
  db.query(
    `SELECT p.id, p.name, p.profile_picture, p.created_at,
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

    res.json({
      message: "Professor added",
      professor: { id: result.insertId, name, department_id }
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
      `SELECT r.*, p.name AS professor_name, COALESCE(d.name, 'Unknown') AS department
       FROM reviews r
       JOIN professors p ON r.professor_id = p.id
       LEFT JOIN departments d ON p.department_id = d.id
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
      `SELECT r.*, p.name AS professor_name, COALESCE(d.name, 'Unknown') AS department
       FROM reviews r
       JOIN professors p ON r.professor_id = p.id
       LEFT JOIN departments d ON p.department_id = d.id
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
// GET REPLIES (by review)
// =========================
app.get("/replies", (req, res) => {
  const { review_id } = req.query;
  if (!review_id) return res.status(400).json({ message: "review_id is required" });

  db.query(
    "SELECT * FROM replies WHERE review_id = ? ORDER BY created_at ASC",
    [review_id],
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
      res.json({
        message: "Reply posted",
        reply: { id: result.insertId, review_id, username: req.user.username, reply_text }
      });
    }
  );
});

// =========================
// START SERVER
// =========================
app.listen(3000, () => {
  console.log("Server running on http://localhost:3000");
});