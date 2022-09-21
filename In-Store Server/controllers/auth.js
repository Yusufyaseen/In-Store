import userModel from "../models/userModel.js";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import dotenv from "dotenv";
dotenv.config();
const { SECRET_KEY } = process.env;

export const createUser = async (req, res) => {
  try {
    console.log("entered");
    const { name, email, password } = req.body;
    const existingUser = await userModel.find({ email });
    if (existingUser.length > 0) {
      return res.status(400).json({ message: "Account is already exist." });
    }
    const saltRounds = 10;
    const passwordHash = await bcrypt.hash(password, saltRounds);
    const newUser = await userModel.create({
      name,
      password: passwordHash,
      email,
      cart: [],
    });
    console.log(newUser);
    await newUser.save();

    const token = jwt.sign({ id: newUser._id }, SECRET_KEY);
    return res.status(200).json({
      token,
      ...newUser._doc,
    });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

export const loginUser = async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await userModel.findOne({ email });
    console.log(user);
    if (!user) {
      return res.status(400).send({ message: `User: '${email}' not found.` });
    }

    const credentialsValid = await bcrypt.compare(password, user.password);
    if (!credentialsValid) {
      return res.status(400).send({ message: "Invalid credentials." });
    }
    const token = jwt.sign({ id: user._id }, SECRET_KEY);
    console.log(user._doc);
    return res.status(200).json({
      token,
      ...user._doc,
    });
  } catch (error) {
    console.log(error);
    return res.status(404).json({ message: error.message });
  }
};

export const validateTokenAndGetData = async (req, res) => {
  try {
    const user = await userModel.findById(req.user);
    if (!user) return res.status(400).json({ message: "User is not found" });
    res.status(200).json({ token: req.token, ...user._doc });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

export const saveAddress = async (req, res) => {
  try {
    const { address } = req.body;
    let user = await userModel.findById(req.user);
    user.address = address;
    user = await user.save();
    return res.status(200).json({ data: user });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};
