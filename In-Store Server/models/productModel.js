import mongoose from "mongoose";
import { ratingSchema } from "./rating.js";

export const productSchema = mongoose.Schema({
  name: { unique: false, type: String, required: true, trim: true },
  description: { type: String, required: true, trim: true },
  //   images: [
  //     {
  //       type: String,
  //       required: true,
  //     },
  //   ],
  images: {
    type: [String],
    required: true,
  },
  quantity: {
    type: Number,
    required: true,
  },
  price: {
    type: Number,
    required: true,
  },
  category: {
    type: String,
    required: true,
  },
  rating: [ratingSchema],
});
let productModel = mongoose.model("productModel", productSchema);
export default productModel;
