import mongoose from "mongoose";

const userSchema = mongoose.Schema({
  name: { unique: true, type: String, required: true, trim: true },
  password: {
    type: String,
    required: true,
  },
  email: {
    unique: true,
    type: String,
    required: true,
    trim: true,
    validate: {
      validator: (value) => {
        const re =
          /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:.[a-zA-Z0-9-]+)*$/;
        return value.match(re);
      },
      message: "Please enter a valid e-mail",
    },
  },
  type: {
    type: String,
    default: "user",
  },
});

let userModel = mongoose.model("userModel", userSchema);

export default userModel;
