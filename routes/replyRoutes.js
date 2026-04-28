const express = require("express");
const router = express.Router();

module.exports = (replyController, authenticateToken) => {
  router.get("/", replyController.get);
  router.post("/", authenticateToken, replyController.create);

  return router;
};