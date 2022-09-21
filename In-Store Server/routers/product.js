import express from "express";
import {
  addProduct,
  deleteProduct,
  getProducts,
  getProductsBySearch,
  rateProduct,
  dealOfTheDay,
} from "../controllers/product.js";

import { adminChecker, authChecker } from "../middlewares/authCheck.js";

const productRouter = express.Router();

productRouter.post("/add-product", adminChecker, addProduct);
productRouter.delete("/delete-product", adminChecker, deleteProduct);
productRouter.get("/:cat", getProducts);
productRouter.get("/search/:query", getProductsBySearch);
productRouter.get("/api/deal-of-day", authChecker, dealOfTheDay);
productRouter.post("/api/rate-product", authChecker, rateProduct);
export default productRouter;
