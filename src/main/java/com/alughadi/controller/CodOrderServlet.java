package com.alughadi.controller;

import com.alughadi.dao.CartDaoImpl;
import com.alughadi.dao.OrderDao;
import com.alughadi.dao.OrderDaoImpl;
import com.alughadi.entity.Cart;
import com.alughadi.utils.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cod-order")
public class CodOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Object userIdObj = SessionUtil.getAttribute(request, "authUserId");
        if (userIdObj == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        int userId = (Integer) userIdObj;

        CartDaoImpl cartDao = new CartDaoImpl();
        List<Cart> cartItems = cartDao.getCartItems(userId);

        if (cartItems.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        double total    = cartDao.getGrandTotal(userId);
        double shipping = total >= 5000 ? 0 : 200;
        double grandTotal = total + shipping;

        List<Object[]> items = new ArrayList<>();
        for (Cart c : cartItems) {
            items.add(new Object[]{c.getProductId(), c.getQuantity(), c.getPrice()});
        }

        OrderDao orderDao = new OrderDaoImpl();
        orderDao.saveOrder(userId, grandTotal, "cod", items);
        cartDao.clearCart(userId);

        // Return a simple JSON with the order confirmation
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.print("{\"orderId\":\"AG-" + System.currentTimeMillis() + "\"}");
    }
}
