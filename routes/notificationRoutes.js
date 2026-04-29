const express = require("express");
const router = express.Router();

module.exports = (notificationController, authenticateToken) => {
  router.get("/", authenticateToken, notificationController.getAll);
  router.put("/mark-read", authenticateToken, notificationController.markRead);
  router.delete("/", authenticateToken, notificationController.clearAll);
  return router;
};
