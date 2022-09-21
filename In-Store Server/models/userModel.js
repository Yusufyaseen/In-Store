import mongoose from "mongoose";
import { cartSchema } from "./cart.js";

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
  address: {
    type: String,
    default: "",
  },
  type: {
    type: String,
    default: "user",
  },

  cart: {
    type: [cartSchema],
    required: false,
  },
});

let userModel = mongoose.model("userModel", userSchema);

export default userModel;
