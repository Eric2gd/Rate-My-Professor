const express = require("express");
const router = express.Router();

module.exports = (db) => {
  router.get("/", (req, res) => {
    db.query("SELECT * FROM departments ORDER BY name ASC", (err, results) => {
      if (err) return res.status(500).json({ message: "Database error" });
      res.json(results);
    });
  });

  return router;
};
