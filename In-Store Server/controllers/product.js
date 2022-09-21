import productModel from "../models/productModel.js";

export const addProduct = async (req, res) => {
  try {
    const { name, description, quantity, images, price, category } = req.body;
    const ratingSchema = {
      userId: req.user,
      rating: 2,
    };
    const product = await productModel.create({
      name,
      description,
      quantity,
      images,
      price,
      category,
      rating: ratingSchema,
    });
    await product.save();
    return res.status(200).json({ data: product });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: error.message });
  }
};

export const getProducts = async (req, res) => {
  try {
    const { cat } = req.params;
    console.log(cat);
    const product = await productModel.find({
      category: cat,
    });

    return res.status(200).json({ data: product });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

export const getProductsBySearch = async (req, res) => {
  try {
    let { query } = req.params;
    const products = await productModel.find({
      name: { $regex: query, $options: "i" },
    });
    console.log("----------" + typeof products);
    console.log("----------" + Boolean(products));
    if (!Boolean(products)) {
      return res.status(400).json({ message: "There is no products." });
    }
    return res.status(200).json({ data: products });
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

export const rateProduct = async (req, res) => {
  try {
    const { id, rating } = req.body;
    let product = await productModel.findById(id);
    if (!Boolean(product)) {
      return res.status(400).send({ message: "Product is not exist." });
    }
    const ratingScema = {
      userId: req.user,
      rating,
    };

    const index = product.rating.findIndex((rate) => rate.userId === req.user);
    if (index !== -1) {
      product.rating = product.rating.map((rate) =>
        rate.userId != req.user ? rate : ratingScema
      );
    } else {
      product.rating.push(ratingScema);
    }

    const updatedProduct = await productModel.findByIdAndUpdate(id, product, {
      new: true,
    });
    console.log("....." + updatedProduct);
    return res.status(200).json({ data: updatedProduct });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

export const dealOfTheDay = async (req, res) => {
  try {
    let products = await productModel.find({});
    products = products.sort((a, b) => {
      let aSum = 0;
      let bSum = 0;

      a.rating.forEach((rate) => {
        aSum += rate.rating;
      });
      b.rating.forEach((rate) => {
        bSum += rate.rating;
      });

      return bSum - aSum;
    });

    return res.status(200).json({ data: products[0] });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};
