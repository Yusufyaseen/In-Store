import Order from "../models/order.js";
import productModel from "../models/productModel.js";
import userModel from "../models/userModel.js";

export const addToCart = async (req, res) => {
  try {
    const { id } = req.body;
    const product = await productModel.findById(id);
    let user = await userModel.findById(req.user);
    if (user.cart.length == 0) {
      console.log("enter");
      user.cart.push({ product, quantity: 1 });
      console.log(user.cart);
    } else {
      const index = user.cart.findIndex((cart) =>
        cart.product._id.equals(product._id)
      );
      if (index !== -1) {
        user.cart = user.cart.map((cart) => {
          if (cart.product._id.equals(product._id)) {
            cart.quantity += 1;
            return cart;
          }
          return cart;
        });
      } else {
        user.cart.push({ product, quantity: 1 });
      }
    }
    const updatedUser = await userModel.findByIdAndUpdate(req.user, user, {
      new: true,
    });

    return res.status(200).json({ data: updatedUser });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};
export const deleteFromCart = async (req, res) => {
  try {
    const { id } = req.params;
    const product = await productModel.findById(id);
    let user = await userModel.findById(req.user);

    for (let i = 0; i < user.cart.length; i++) {
      if (user.cart[i].product._id.equals(product._id)) {
        if (user.cart[i].quantity == 1) {
          user.cart.splice(i, 1);
        } else {
          user.cart[i].quantity -= 1;
        }
      }
    }

    // user.cart = user.cart.map((cart, i) => {
    //   if (cart.product._id.equals(product._id)) {
    //     if (cart.quantity == 1) {
    //       user.cart.splice(i, 1);
    //       return cart;
    //     } else {
    //       cart.quantity -= 1;
    //       return cart;
    //     }
    //   }
    // });
    console.log("----------------------");
    console.log(user.cart);

    const updatedUser = await userModel.findByIdAndUpdate(req.user, user, {
      new: true,
    });
    return res.status(200).json({ data: updatedUser });
  } catch (e) {
    return res.status(500).json({ message: e.message });
  }
};

export const placeOrder = async (req, res) => {
  try {
    const { cart, totalPrice, address } = req.body;
    let products = [];
    for (let i = 0; i < cart.length; i++) {
      let product = await productModel.findById(cart[i].product._id);
      if (product.quantity >= cart[i].quantity) {
        product.quantity -= cart[i].quantity;
        products.push({ product, quantity: cart[i].quantity });
        await product.save();
      } else {
        return res
          .status(400)
          .json({ message: `${product.name} is not at the stock` });
      }
    }
    let user = await userModel.findById(req.user);
    user.cart = [];
    user = await user.save();
    let order = await Order.create({
      products,
      address,
      totalPrice,
      userId: req.user,
      orderedAt: new Date().getTime(),
    });
    await order.save();
    return res.status(200).json({ data: order });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: error.message });
  }
};

export const getMyOrders = async (req, res) => {
  try {
    const orders = await Order.find({ userId: req.user });
    return res.status(200).json({ data: orders });
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
};

export const getAllOrders = async (req, res) => {
  try {
    const orders = await Order.find({});
    return res.status(200).json({ data: orders });
  } catch (error) {
    return res.status(500).json({ error: e.message });
  }
};

export const changeOrderStatus = async (req, res) => {
  try {
    const { id, status } = req.body;
    let orders = await Order.findById(id);
    orders.status = status;
    orders = await orders.save();
    return res.status(200).json({ data: orders });
  } catch (error) {
    return res.status(500).json({ error: e.message });
  }
};
