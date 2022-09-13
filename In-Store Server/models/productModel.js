import mongoose from "mongoose";

const productSchema = mongoose.Schema({
  name: { unique: true, type: String, required: true, trim: true },
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
});
let productModel = mongoose.model("productModel", productSchema);
export default productModel;
