package com.alughadi.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * OrderSuccessServlet — shows the order confirmation page.
 *
 * URL: /order-success
 *
 * GET /order-success -> read the order details that PlaceOrderServlet stored in the session,
 *                       put them on the request, forward to order-success.jsp, then clear
 *                       them from the session so refreshing the page redirects away.
 *
 * Flow: PlaceOrderServlet → saves order → stores lastOrderId/lastPaymentMethod/lastOrderTotal
 *       in session → redirects here → we display it → clear session data.
 *
 * If there is no order in the session (e.g. user typed the URL directly),
 * redirect to /products instead.
 */
@WebServlet("/order-success")
public class OrderSuccessServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("authUserId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String orderId        = (String)  session.getAttribute("lastOrderId");
        String paymentMethod  = (String)  session.getAttribute("lastPaymentMethod");
        Double total          = (Double)  session.getAttribute("lastOrderTotal");

        if (orderId == null) {
            response.sendRedirect(request.getContextPath() + "/products");
            return;
        }

        session.removeAttribute("lastOrderId");
        session.removeAttribute("lastPaymentMethod");
        session.removeAttribute("lastOrderTotal");

        request.setAttribute("orderId",       orderId);
        request.setAttribute("paymentMethod", paymentMethod != null ? paymentMethod : "cod");
        request.setAttribute("orderTotal",    total != null ? total : 0.0);
        request.setAttribute("pageTitle",     "Order Confirmed | AluGhadi Watches");
        request.setAttribute("pageDesc",      "Your order has been placed successfully.");
        request.setAttribute("activeNav",     "products");
        request.setAttribute("pageStyle",     "order-success");

        request.getRequestDispatcher("/WEB-INF/views/order-success.jsp").forward(request, response);
    }
}
