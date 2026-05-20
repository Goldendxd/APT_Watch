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
 * CartServlet — handles the cart page and all cart actions.
 *
 * URL: /cart
 *
 * GET  /cart -> load the user's cart items + total, forward to cart.jsp.
 *              Redirects to /login if not logged in.
 *
 * POST /cart?action=add    -> add a product to the cart (or clear + add for "Buy Now")
 * POST /cart?action=remove -> remove one item by cartId
 * POST /cart?action=update -> change the quantity of a cart item
 * POST /cart?action=clear  -> empty the entire cart
 *
 * After any POST action, the user is sent back to wherever they came from
 * (redirectTo param → Referer header → /products as fallback).
 * The ?cart=open query param is stripped from the redirect URL to avoid
 * re-opening the cart modal automatically on every reload.
 *
 * parsePositiveInt() is used everywhere to safely parse IDs and quantities —
 * returns null instead of throwing on bad input.
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

            String addRedirect = request.getParameter("redirectTo");
            if (addRedirect == null || addRedirect.isBlank()) addRedirect = request.getHeader("Referer");
            if (addRedirect == null || addRedirect.isBlank()) addRedirect = request.getContextPath() + "/products";
            String sep = addRedirect.contains("?") ? "&" : "?";
            response.sendRedirect(addRedirect + sep + "cart=added");
            return;

        } else if ("remove".equals(action)) {
            Integer cartId = parsePositiveInt(request.getParameter("cartId"));
            if (cartId == null) {
                response.sendRedirect(request.getContextPath() + "/products");
                return;
            }
            cartDao.removeFromCart(cartId, userId);

        } else if ("update".equals(action)) {
            Integer cartId = parsePositiveInt(request.getParameter("cartId"));
            Integer quantity = parsePositiveInt(request.getParameter("quantity"));

            if (cartId == null || quantity == null) {
                response.sendRedirect(request.getContextPath() + "/products");
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
            response.sendRedirect(stripCartOpen(redirectTo));
            return;
        }

        String referer = request.getHeader("Referer");

        if (referer != null && !referer.isBlank()) {
            response.sendRedirect(stripCartOpen(referer));
            return;
        }

        response.sendRedirect(request.getContextPath() + "/products");
    }
    private Integer parsePositiveInt(String value) {
        try {
            int parsed = Integer.parseInt(value);
            return parsed > 0 ? parsed : null;
        } catch (NumberFormatException e) {
            return null;
        }
    }
    private String stripCartOpen(String url) {
        return url.replaceAll("[?&]cart=open", "").replaceAll("\\?$", "");
    }
}