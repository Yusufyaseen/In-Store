import express from "express";
import {
  addToCart,
  deleteFromCart,
  getAllOrders,
  getMyOrders,
  placeOrder,
  changeOrderStatus,
} from "../controllers/user.js";

import { authChecker } from "../middlewares/authCheck.js";

const userRouter = express.Router();

userRouter.post("/api/change-order-status", authChecker, changeOrderStatus);
userRouter.post("/api/add-product", authChecker, addToCart);
userRouter.get("/api/orders/me", authChecker, getMyOrders);
userRouter.get("/api/get-all-orders", authChecker, getAllOrders);
userRouter.post("/api/place-order", authChecker, placeOrder);
userRouter.delete("/api/remove-from-cart/:id", authChecker, deleteFromCart);

export default userRouter;
