const express = require("express");
const router = express.Router();

module.exports = (authController, authenticateToken) => {
  router.get("/me", authenticateToken, authController.getMe);
  return router;
};
