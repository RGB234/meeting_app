const jwt = require("jsonwebtoken");

// next: next call back function
const auth = async (req, res, next) => {
  try {
    const token = req.header("x-auth-token");
    if (!token)
      return res.status(401).json({ msg: "Access denied (no auth token)" });

    const verified = jwt.verify(token, "tokenSecretKey");
    if (!verified)
      return res
        .status(401)
        .json({ msg: "Acess denied (token verification failed)" });

    req.user = verified.id;
    req.token = token;
    next();
  } catch (e) {
    res.status(500).json({ error: e.msg });
  }
};

module.exports = auth;
