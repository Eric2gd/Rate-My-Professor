const express = require("express");
const router = express.Router();

module.exports = (reviewController, authenticateToken) => {
  router.get("/", reviewController.get);
  router.post("/", authenticateToken, reviewController.create);

  return router;
};