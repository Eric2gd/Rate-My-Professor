const express = require("express");
const router = express.Router();

module.exports = (reviewController, authenticateToken) => {
  router.get("/mine", authenticateToken, reviewController.getMine);
  router.post("/:id/react", authenticateToken, reviewController.react);
  router.get("/", reviewController.get);
  router.post("/", authenticateToken, reviewController.create);

  return router;
};