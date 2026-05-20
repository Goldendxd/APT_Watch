package com.alughadi.controller;

import com.alughadi.dao.CartDao;
import com.alughadi.dao.CartDaoImpl;
import com.alughadi.dao.ProductDAO;
import com.alughadi.dao.ProductDaoImpl;
import com.alughadi.entity.Product;
import com.alughadi.utils.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * ProductDetailsServlet — shows a single product's full detail page.
 *
 * URL: /product-details?id=X
 *
 * GET /product-details?id=X -> look up product by ID, forward to product-details.jsp.
 *
 * Safety checks:
 *   - No id param or non-numeric id → redirect to /products
 *   - Product not found in DB       → redirect to /products
 *
 * Also loads cart data for the logged-in user so the cart modal in the nav
 * shows the correct item count and grand total.
 */
@WebServlet("/product-details")
public class ProductDetailsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/products");
            return;
        }

        int productId;
        try {
            productId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/products");
            return;
        }

        ProductDAO productDAO = new ProductDaoImpl();
        Product product = productDAO.getProductById(productId);

        if (product == null) {
            response.sendRedirect(request.getContextPath() + "/products");
            return;
        }

        request.setAttribute("product", product);
        request.setAttribute("pageTitle", product.getName() + " | AluGhadi Watches");
        request.setAttribute("pageDesc", product.getDescription());
        request.setAttribute("activeNav", "products");
        request.setAttribute("pageStyle", "product-details");

        // Load cart data for the cart modal
        Object userIdObj = SessionUtil.getAttribute(request, "authUserId");
        if (userIdObj != null) {
            int userId = (Integer) userIdObj;
            CartDao cartDao = new CartDaoImpl();
            request.setAttribute("cartItems", cartDao.getCartItems(userId));
            request.setAttribute("cartCount", cartDao.getCartCount(userId));
            request.setAttribute("grandTotal", cartDao.getGrandTotal(userId));
        }

        request.getRequestDispatcher("/WEB-INF/views/product-details.jsp").forward(request, response);
    }
}