const express = require("express");
const router = express.Router();

/**
 * This route file follows the Dependency Injection pattern.
 * We pass in the controller instead of importing it directly.
 */

module.exports = (authController) => {
  // =========================
  // REGISTER
  // =========================
  router.post("/register", authController.register);

  // =========================
  // LOGIN
  // =========================
  router.post("/login", authController.login);

  return router;
};