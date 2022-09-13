import express from "express";
import {
  addProduct,
  deleteProduct,
  getProducts,
} from "../controllers/product.js";

import { adminChecker } from "../middlewares/authCheck.js";

const productRouter = express.Router();

productRouter.post("/add-product", adminChecker, addProduct);
productRouter.delete("/delete-product", adminChecker, deleteProduct);
productRouter.get("/:cat", getProducts);
export default productRouter;
