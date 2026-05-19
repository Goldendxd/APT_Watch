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
        if (action == null || action.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/products");
            return;
        }
        if ("add".equals(action)) {
            Integer productId = parsePositiveInt(request.getParameter("productId"));
            Integer quantity = parsePositiveInt(request.getParameter("quantity"));

            if (productId == null || quantity == null) {
                response.sendRedirect(request.getContextPath() + "/products");
                return;
            }

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

        } else if ("remove".equals(action)) {
            Integer cartId = parsePositiveInt(request.getParameter("cartId"));
            if (cartId == null) {
                response.sendRedirect(request.getContextPath() + "/products?cart=open");
                return;
            }
            cartDao.removeFromCart(cartId, userId);

        } else if ("update".equals(action)) {
            Integer cartId = parsePositiveInt(request.getParameter("cartId"));
            Integer quantity = parsePositiveInt(request.getParameter("quantity"));

            if (cartId == null || quantity == null) {
                response.sendRedirect(request.getContextPath() + "/products?cart=open");
                return;
            }
            cartDao.updateQuantity(cartId, userId, quantity);

        } else if ("clear".equals(action)) {
            cartDao.clearCart(userId);
        }
        if (request.getParameter("buyNow") != null) {
            response.sendRedirect(request.getContextPath() + "/checkout");
            return;
        }
        String redirectTo = request.getParameter("redirectTo");

        if (redirectTo != null && !redirectTo.isBlank()) {
            response.sendRedirect(addCartOpen(redirectTo));
            return;
        }

        String referer = request.getHeader("Referer");

        if (referer != null && !referer.isBlank()) {
            response.sendRedirect(addCartOpen(referer));
            return;
        }

        response.sendRedirect(request.getContextPath() + "/products?cart=open");
    }
//    private int getLoggedInUserId(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        Object userIdObj = SessionUtil.getAttribute(request, "authUserId");
//        if (userIdObj == null){
//            response.sendRedirect(request.getContextPath());
//            return -1;
//        }
//
//        return (Integer) userIdObj;
//    }
    private Integer parsePositiveInt(String value) {
        try {
            int parsed = Integer.parseInt(value);
            return parsed > 0 ? parsed : null;
        } catch (NumberFormatException e) {
            return null;
        }
    }
    private String addCartOpen(String url) {
        if (url.contains("cart=open")) {
            return url;
        }

        String separator = url.contains("?") ? "&" : "?";
        return url + separator + "cart=open";
    }
}