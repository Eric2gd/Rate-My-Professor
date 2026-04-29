const express = require("express");
const router = express.Router();

module.exports = (reviewController, authenticateToken) => {
  router.get("/mine", authenticateToken, reviewController.getMine);
  router.post("/:id/react", authenticateToken, reviewController.react);
  router.put("/:id", authenticateToken, reviewController.update);
  router.delete("/:id", authenticateToken, reviewController.delete);
  router.get("/", reviewController.get);
  router.post("/", authenticateToken, reviewController.create);

  return router;
};