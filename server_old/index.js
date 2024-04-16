const express = require("express");
const mongoose = require("mongoose");

const authRouter = require("./routes/auth");

const mongodbConfig = require("../secret/mongodb_config");

//INIT
const app = express();
const PORT = 3000;
const DB = mongodbConfig.API_KEY;

//middleware
app.use(express.json());
app.use(authRouter);

//connections
mongoose
  .connect(DB)
  .then(() => {
    console.log("connected");
  })
  .catch((e) => {
    console.log(e);
  });

// listening to any ip address('0.0.0.0')
// Android emulator can't access to localhost(http://127.0.0.1/)
app.listen(PORT, "0.0.0.0", () => {
  console.log(`connected at PORT : ${PORT}`);
});
