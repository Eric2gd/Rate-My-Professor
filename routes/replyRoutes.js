const express = require("express");
const router = express.Router();

module.exports = (replyController, authenticateToken) => {
  router.post("/:id/react", authenticateToken, replyController.react);
  router.put("/:id", authenticateToken, replyController.update);
  router.delete("/:id", authenticateToken, replyController.delete);
  router.get("/", replyController.get);
  router.post("/", authenticateToken, replyController.create);

  return router;
};