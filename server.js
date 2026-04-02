const express = require("express");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const cors = require("cors");

const app = express();
app.use(express.json());
app.use(cors());

// SECRET KEY (store safely in real apps)
const SECRET = "mysecretkey";

// In-memory storage (replace with DB later)
let users = [];
let professors = [];

// =========================
// REGISTER

app.post("/register", async (req, res) => {
  try {
    const { username, password } = req.body;

    // Check if user exists
    const existingUser = users.find(u => u.username === username);
    if (existingUser) {
      return res.status(400).json({ message: "User already exists" });
    }

    // Hash password
    const hashedPassword = await bcrypt.hash(password, 10);

    // Save user
    const newUser = { username, password: hashedPassword };
    users.push(newUser);

    res.json({ message: "User registered successfully" });

  } catch (error) {
    res.status(500).json({ message: "Error registering user" });
  }
});

// =========================
//LOGIN
app.post("/login", async (req, res) => {
  try {
    const { username, password } = req.body;

    const user = users.find(u => u.username === username);
    if (!user) {
      return res.status(400).json({ message: "Invalid credentials" });
    }

    // Compare password
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ message: "Invalid credentials" });
    }

    // Create token
    const token = jwt.sign({ username: user.username }, SECRET, {
      expiresIn: "1h"
    });

    res.json({ message: "Login successful", token });

  } catch (error) {
    res.status(500).json({ message: "Error logging in" });
  }
});

// =========================
//  AUTH MIDDLEWARE

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
  res.json(professors);
});

// =========================
//  POST PROFESSOR (Protected)
// =========================
app.post("/professors", authenticateToken, (req, res) => {
  const { name, department } = req.body;

  const newProfessor = {
    id: professors.length + 1,
    name,
    department
  };

  professors.push(newProfessor);

  res.json({ message: "Professor added", professor: newProfessor });
});

// =========================
//  START SERVER
// =========================
app.listen(3000, () => {
  console.log("Server running on http://localhost:3000");
});