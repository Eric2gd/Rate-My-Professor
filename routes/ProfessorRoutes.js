const express = require("express");
const router = express.Router();

module.exports = (professorController, authenticateToken) => {
  router.get("/", professorController.getAll);
  router.post("/", authenticateToken, professorController.create);

  return router;
};