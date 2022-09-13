import express from "express";
import {
  addCategory,
  deleteCategory,
  getCategories,
} from "../controllers/category.js";

import { adminChecker } from "../middlewares/authCheck.js";

const categoryRouter = express.Router();

categoryRouter.post("/add-category", adminChecker, addCategory);
categoryRouter.delete("/delete-category", adminChecker, deleteCategory);
categoryRouter.get("/fetch-categories", getCategories);
export default categoryRouter;
