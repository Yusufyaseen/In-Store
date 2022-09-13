import express from "express";
import dotenv from "dotenv";
import cors from "cors";
import authRouter from "./routers/auth.js";
import mongoose from "mongoose";
import productRouter from "./routers/product.js";
import categoryRouter from "./routers/category.js";

dotenv.config();
const port = process.env.PORT || 3500;
const app = express();
app.use(express.json());
app.use(
  cors({
    origin: "*",
  })
);

app.get("/", (req, res) => {
  res.json({ data: "Welcome Yusuf" });
});

app.use("/", authRouter);
app.use("/products", productRouter);
app.use("/category", categoryRouter);
mongoose
  .connect(process.env.CONNECTION_URL, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then(() =>
    app.listen(port, () =>
      console.log(`Server Running on Port: http://localhost:${port}`)
    )
  )
  .catch((error) => console.log(`${error} did not connect`));
