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
  db.query("SELECT * FROM professors", (err, results) => {
    if (err) return res.status(500).json({ message: "Database error" });
    res.json(results);
  });
});

// =========================
// POST PROFESSOR (Protected)
// =========================
app.post("/professors", authenticateToken, (req, res) => {
  const { name, department } = req.body;

  db.query("INSERT INTO professors (name, department) VALUES (?, ?)", [name, department], (err, result) => {
    if (err) return res.status(500).json({ message: "Error adding professor" });

    res.json({
      message: "Professor added",
      professor: { id: result.insertId, name, department }
    });
  });
});

// =========================
// START SERVER
// =========================
app.listen(3000, () => {
  console.log("Server running on http://localhost:3000");
});