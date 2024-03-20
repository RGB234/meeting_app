const express = require("express");
const bcryptjs = require("bcryptjs");

const User = require("../models/user_account");
const jwt = require("jsonwebtoken");
const auth = require("../middlewares/auth");

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

authRouter.post("/api/signin", async (req, res) => {
  try {
    const { email, password } = req.body;
    // const User = mongoose.model("User", userAccountSchema);
    // shorthand form of # User.findOne({email : email}); #
    const user = await User.findOne({ email });
    if (!user) {
      return res
        .status(400)
        .json({ msg: "User with this email does not exitst" });
    }

    const isMatch = await bcryptjs.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ msg: "Incorrect password" });
    }

    // const verified = jwt.verify(token, "tokenSecretKey")
    // make 'verified' contain verified.id
    const token = jwt.sign({ id: user._id }, "tokenSecretKey");
    res.json({ token, ...user._doc });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

authRouter.post("/tokenIsValid", async (req, res) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) return res.json(false);
    const verified = jwt.verify(token, "tokenSecretKey");
    if (!verified) return res.json(false);

    const user = await User.findById(verified.id);
    if (!user) return res.json(false);

    res.json(true);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// fetch user data
authRouter.get("/", auth, async (req, res) => {
  const user = await User.findById(req.user);
  res.json({ ...user._doc, token: req.token });
});

module.exports = authRouter;
