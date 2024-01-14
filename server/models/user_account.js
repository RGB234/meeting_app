const mongoose = require("mongoose");

const userAccountSchema = mongoose.Schema({
  username: {
    require: true,
    type: String,
    trim: true,
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
      message: "Invalid Email address",
    },
  },
  password: {
    require: true,
    type: String,
    trim: true,
  },
});
