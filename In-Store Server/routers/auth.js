import express from "express";
import {
  createUser,
  loginUser,
  saveAddress,
  validateTokenAndGetData,
} from "../controllers/auth.js";
import { authChecker } from "../middlewares/authCheck.js";

const authRouter = express.Router();

authRouter.post("/signup", createUser);
authRouter.post("/api/save-user-address", authChecker, saveAddress);
authRouter.post("/signin", loginUser);
authRouter.post("/validate", authChecker, validateTokenAndGetData);
export default authRouter;
