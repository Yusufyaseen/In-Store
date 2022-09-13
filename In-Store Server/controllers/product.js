import productModel from "../models/productModel.js";

export const addProduct = async (req, res) => {
  try {
    const { name, description, quantity, images, price, category } = req.body;
    const product = await productModel.create({
      name,
      description,
      quantity,
      images,
      price,
      category,
    });
    await product.save();
    return res.status(200).json({ data: product });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

export const getProducts = async (req, res) => {
  try {
    const { cat } = req.params;
    const product = await productModel.find({
      category: cat,
    });

    return res.status(200).json({ data: product });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

export const deleteProduct = async (req, res) => {
  try {
    const { id } = req.body;
    await productModel.findByIdAndRemove(id);
    return res.status(200).json({ data: "done" });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};
