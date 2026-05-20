package com.alughadi.dao;

import com.alughadi.entity.Cart;
import java.util.List;

/** Defines all cart DB operations. CartDaoImpl provides the actual SQL. */
public interface CartDao {

    void       addToCart(int userId, int productId, int quantity);
    List<Cart> getCartItems(int userId);
    int        getCartCount(int userId);
    double     getGrandTotal(int userId);
    void       removeFromCart(int cartId, int userId);
    void       updateQuantity(int cartId, int userId, int quantity);
    void       clearCart(int userId);
    List<Integer> getCartProductIds(int userId);
}