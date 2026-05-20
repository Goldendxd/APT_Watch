package com.alughadi.controller;

import com.alughadi.dao.CartDaoImpl;
import com.alughadi.dao.OrderDao;
import com.alughadi.dao.OrderDaoImpl;
import com.alughadi.entity.Cart;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * PlaceOrderServlet — finalizes checkout and creates the order in the DB.
 *
 * URL: /place-order  (POST only — form submits from checkout.jsp)
 *
 * Flow:
 *   1. Check user is logged in; if not, redirect to /login.
 *   2. Load the user's cart items. If empty, send back to /cart.
 *   3. Read paymentMethod param (defaults to "cod" if missing).
 *   4. Calculate grand total: subtotal + shipping (Rs 200; free if subtotal >= Rs 5000).
 *   5. Save the order and its line items to the DB via OrderDao.
 *   6. Clear the user's cart.
 *   7. Store orderId, paymentMethod, orderTotal in the session so
 *      OrderSuccessServlet can display them on the confirmation page.
 *   8. Redirect to /order-success.
 *
 * The order ID shown to the user is prefixed "AG-" (e.g. AG-42).
 */
@WebServlet("/place-order")
public class PlaceOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Object userIdObj = request.getSession(false) != null
                ? request.getSession(false).getAttribute("authUserId") : null;
        if (userIdObj == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        int userId = (Integer) userIdObj;

        CartDaoImpl cartDao = new CartDaoImpl();
        List<Cart> cartItems = cartDao.getCartItems(userId);

        if (cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        String paymentMethod = request.getParameter("paymentMethod");
        if (paymentMethod == null || paymentMethod.isBlank()) {
            paymentMethod = "cod";
        }

        double subtotal   = cartDao.getGrandTotal(userId);
        double shipping   = subtotal >= 5000 ? 0 : 200;
        double grandTotal = subtotal + shipping;

        List<Object[]> items = new ArrayList<>();
        for (Cart c : cartItems) {
            items.add(new Object[]{c.getProductId(), c.getQuantity(), c.getPrice()});
        }

        OrderDao orderDao = new OrderDaoImpl();
        int dbOrderId = orderDao.saveOrder(userId, grandTotal, paymentMethod, items);
        cartDao.clearCart(userId);

        String orderId = dbOrderId > 0 ? "AG-" + dbOrderId : "AG-" + System.currentTimeMillis();
        request.getSession().setAttribute("lastOrderId", orderId);
        request.getSession().setAttribute("lastPaymentMethod", paymentMethod);
        request.getSession().setAttribute("lastOrderTotal", grandTotal);

        response.sendRedirect(request.getContextPath() + "/order-success");
    }
}
