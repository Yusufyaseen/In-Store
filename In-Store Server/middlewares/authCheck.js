import jwt from "jsonwebtoken";
import userModel from "../models/userModel.js";
export const authChecker = (req, res, next) => {
  try {
    const token = req.header("auth-token");
    if (!token) {
      return res
        .status(401)
        .send({ message: "No auth token found. Authorization denied." });
    }

    const decodedToken = jwt.verify(token, process.env.SECRET_KEY);

    if (!decodedToken.id) {
      return res
        .status(401)
        .send({ message: "Token verification failed. Authorization denied." });
    }

    req.user = decodedToken.id;
    req.token = token;
    next();
  } catch (error) {
    res.status(500).send({ message: error.message });
  }
};

export const adminChecker = async (req, res, next) => {
  try {
    const token = req.header("auth-token");
    if (!token) {
      return res
        .status(401)
        .send({ message: "No auth token found. Authorization denied." });
    }

    const decodedToken = jwt.verify(token, process.env.SECRET_KEY);

    if (!decodedToken.id) {
      return res
        .status(401)
        .send({ message: "Token verification failed. Authorization denied." });
    }
    const user = await userModel.findById(decodedToken.id);
    if (user.type != "admin") {
      return res.status(401).json({ message: "You are not an admin!" });
    }
    req.user = decodedToken.id;
    req.token = token;
    next();
  } catch (error) {
    res.status(500).send({ message: error.message });
  }
};
