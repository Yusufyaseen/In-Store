import mongoose from "mongoose";
import { productSchema } from "./productModel.js";
export const cartSchema = mongoose.Schema({
  product: productSchema,
  quantity: {
    type: Number,
    // required: true,
  },
});
