const mongoose = require("mongoose");

const userAccountSchema = mongoose.Schema({
  username: {
    require: true,
    type: String,
    trim: true,
    validate: {
      validator: (value) => {
        return value.length > 0 && value.length < 13;
      },
      // if not validate
      message: "Invalid username (length 1 ~ 12)",
    },
  },
  email: {
    require: true,
    type: String,
    trim: true,
    validate: {
      validator: (value) => {
        const re =
          /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        return value.match(re);
      },
      // if not validate
      message: "Invalid Email address",
    },
  },
  password: {
    require: true,
    type: String,
    trim: true,
    validate: {
      validator: (value) => {
        // Minimum eight characters, at least one uppercase letter, one lowercase letter and one number
        const re = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,20}$/;
        return value.match(re);
      },
      // if not validate
      message:
        "Invalid password(8 ~ 20 characters, at least one uppercase letter, one lowercase letter and one number)",
    },
  },
  type: {
    type: String,
    default: "user",
  },
});

const User = mongoose.model("User", userAccountSchema);
module.exports = User;
