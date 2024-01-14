const express = require("express");
const authRouter = express.Router();

authRouter.get("/auth/signup", (req, res) => {
  const { username, email, password } = req.body;
});

module.exports = authRouter;
