package com.alughadi.controller;

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
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

        request.setAttribute("pageTitle", "Checkout | AluGhadi Watches");
        request.setAttribute("pageDesc", "Review your cart and complete your order.");
        request.setAttribute("activeNav", "products");
        request.setAttribute("pageStyle", "checkout");

        request.getRequestDispatcher("/WEB-INF/views/checkout.jsp")
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
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity  = parsePositiveInt(request.getParameter("quantity"), 1);

            Product product = productDAO.getProductById(productId);
            if (product == null || product.getStockQuantity() <= 0) {
                redirectBack(request, response);
                return;
            }

            cartDao.addToCart(userId, productId, quantity);

        } else if ("remove".equals(action)) {
            int cartId = Integer.parseInt(request.getParameter("cartId"));
            cartDao.removeFromCart(cartId, userId);

        } else if ("update".equals(action)) {
            int cartId   = Integer.parseInt(request.getParameter("cartId"));
            int quantity = parsePositiveInt(request.getParameter("quantity"), 0);
            if (quantity <= 0) {
                cartDao.removeFromCart(cartId, userId);
            } else {
                cartDao.updateQuantity(cartId, userId, quantity);
            }

        } else if ("clear".equals(action)) {
            cartDao.clearCart(userId);
        }
        if (request.getParameter("buyNow") != null) {
            response.sendRedirect(request.getContextPath() + "/checkout");
            return;
        }
        String redirectTo = normalizeLocalRedirect(request, request.getParameter("redirectTo"));
        if (redirectTo != null) {
            response.sendRedirect(redirectTo);
            return;
        }
        redirectBack(request, response);
    }

    private int parsePositiveInt(String value, int defaultValue) {
        try {
            int parsed = Integer.parseInt(value);
            return parsed > 0 ? parsed : defaultValue;
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    private void redirectBack(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String referer = normalizeLocalRedirect(request, request.getHeader("Referer"));
        response.sendRedirect(referer != null ? referer : request.getContextPath() + "/products");
    }

    private String normalizeLocalRedirect(HttpServletRequest request, String target) {
        if (target == null || target.isBlank()) {
            return null;
        }
        String contextPath = request.getContextPath();
        String requestOrigin = request.getScheme() + "://" + request.getServerName()
                + (isDefaultPort(request) ? "" : ":" + request.getServerPort());
        try {
            URI targetUri = new URI(target);
            if (targetUri.isAbsolute()) {
                String targetOrigin = targetUri.getScheme() + "://" + targetUri.getHost()
                        + (targetUri.getPort() == -1 ? "" : ":" + targetUri.getPort());
                if (requestOrigin.equals(targetOrigin)) {
                    return targetUri.getRawPath()
                            + (targetUri.getRawQuery() == null ? "" : "?" + targetUri.getRawQuery());
                }
                return null;
            }
        } catch (URISyntaxException e) {
            return null;
        }
        if (target.startsWith(contextPath + "/")) {
            return target;
        }
        if (target.startsWith("/")) {
            return contextPath + target;
        }
        return null;
    }

    private boolean isDefaultPort(HttpServletRequest request) {
        int port = request.getServerPort();
        return ("http".equals(request.getScheme()) && port == 80)
                || ("https".equals(request.getScheme()) && port == 443);
    }
}
