import mongoose from "mongoose";

const categorySchema = mongoose.Schema({
  name: { unique: true, type: String, required: true, trim: true },
  image: { type: String, required: true, trim: true },
  quantity: { type: Number, default: 0 },
});
let categoryModel = mongoose.model("categoryModel", categorySchema);
export default categoryModel;
