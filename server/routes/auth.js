const express = require("express");
const bcryptjs = require("bcryptjs");

const User = require("../models/user_account");

const authRouter = express.Router();

authRouter.post("/auth/signup", async (req, res) => {
  try {
    const { username, email, password } = req.body;

    const existingUser = await User.findOne({ email: email });
    // checking duplicated email in DB
    if (existingUser) {
      // client error
      return res
        .status(400)
        .json({ msg: "User with same email already exists" });
    }

    const hashedPassword = await bcryptjs.hash(password, 8);

    let user = new User({
      username,
      email,
      password: hashedPassword,
    });

    user = await user.save();
    // 200
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = authRouter;
