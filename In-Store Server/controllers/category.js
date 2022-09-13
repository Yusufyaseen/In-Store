import categoryModel from "../models/categoryModel.js";

export const addCategory = async (req, res) => {
  try {
    const { name, image, quantity } = req.body;
    const newCategory = await categoryModel.create({
      name,
      image,
      quantity,
    });
    await newCategory.save();
    return res.status(200).json({ data: newCategory });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

export const deleteCategory = async (req, res) => {
  try {
    const { id } = req.body;
    await categoryModel.findByIdAndRemove(id);
    return res.status(200).json({ data: "done" });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

export const getCategories = async (req, res) => {
  try {
    const categories = await categoryModel.find({});
    console.log(categories);
    return res.status(200).json({ data: categories });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};
