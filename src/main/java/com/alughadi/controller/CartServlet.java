package com.alughadi.controller;

import java.io.IOException;
import java.util.List;

import com.alughadi.dao.CartDao;
import com.alughadi.dao.CartDaoImpl;
import com.alughadi.dao.ProductDAO;
import com.alughadi.dao.ProductDaoImpl;
import com.alughadi.entity.Cart;
import com.alughadi.entity.Product;
import com.alughadi.utils.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * CartServlet — handles cart operations.
 *
 * URL: /cart
 *
 * GET  /cart -> show cart page with items and total
 * POST /cart -> add, remove, update, clear cart
 */
@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private final CartDao cartDao = new CartDaoImpl();
    private final ProductDAO productDAO = new ProductDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Object userIdObj = SessionUtil.getAttribute(request, "authUserId");
        if (userIdObj == null){
            response.sendRedirect(request.getContextPath()+"/login");
            return;
        }
        int userId = (Integer) userIdObj;
//        int userId = (userIdObj != null) ? (Integer) userIdObj : 0;

        List<Cart> cartItems  = cartDao.getCartItems(userId);
        int        cartCount  = cartDao.getCartCount(userId);
        double     grandTotal = cartDao.getGrandTotal(userId);

        request.setAttribute("cartItems",  cartItems);
        request.setAttribute("cartCount",  cartCount);
        request.setAttribute("grandTotal", grandTotal);

        request.getRequestDispatcher("/WEB-INF/views/cart.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Object userIdObj = SessionUtil.getAttribute(request, "authUserId");
        if (userIdObj == null){
            response.sendRedirect(request.getContextPath()+"/login");
            return;
        }
        int userId = (Integer) userIdObj;
        String action = request.getParameter("action");

        if (action.equals("add")) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity  = Integer.parseInt(request.getParameter("quantity"));

            Product product = productDAO.getProductById(productId);
            if (product == null || product.getStockQuantity() <= 0) {
                String referer = request.getHeader("Referer");
                if (referer != null && !referer.isBlank()) {
                    response.sendRedirect(referer);
                } else {
                    response.sendRedirect(request.getContextPath() + "/products");
                }
                return;
            }

            if (request.getParameter("buyNow") != null) {
                cartDao.clearCart(userId);
                cartDao.addToCart(userId, productId, quantity);
                response.sendRedirect(request.getContextPath() + "/checkout");
                return;
            }

            cartDao.addToCart(userId, productId, quantity);

        } else if (action.equals("remove")) {
            int cartId = Integer.parseInt(request.getParameter("cartId"));
            cartDao.removeFromCart(cartId, userId);

        } else if (action.equals("update")) {
            int cartId   = Integer.parseInt(request.getParameter("cartId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            cartDao.updateQuantity(cartId, userId, quantity);

        } else if (action.equals("clear")) {
            cartDao.clearCart(userId);
        }
        String redirectTo = request.getParameter("redirectTo");
        if (redirectTo != null && !redirectTo.isBlank()) {
            response.sendRedirect(redirectTo);
            return;
        }
        String referer = request.getHeader("Referer");
        if (referer != null && !referer.isBlank()) {
            response.sendRedirect(referer);
            return;
        }
        response.sendRedirect(request.getContextPath() + "/products");
    }
    private int getLoggedInUserId(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Object userIdObj = SessionUtil.getAttribute(request, "authUserId");
        if (userIdObj == null){
            response.sendRedirect(request.getContextPath());
            return -1;
        }

        return (Integer) userIdObj;
    }
}