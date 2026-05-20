package com.alughadi.controller;

import java.io.IOException;
import java.util.List;

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

/**
 * ProductServlet — shows the products listing page.
 *
 * URL: /products  or  /products?category=luxury
 *
 * GET /products             -> load ALL products, forward to products.jsp
 * GET /products?category=X  -> load products in that category only (luxury/sports/classic/smart/womens)
 *
 * Also loads cart product IDs for the logged-in user so the JSP can highlight
 * which products are already in the cart.
 */
@WebServlet("/products")
public class ProductServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductDAO productDAO = new ProductDaoImpl();
        String categoryParam = request.getParameter("category");
        String activeCategory = "all";
        List<Product> productList;

        if (categoryParam != null) {
            categoryParam = categoryParam.trim();
        }

        if (categoryParam != null && !categoryParam.isEmpty() && !"all".equalsIgnoreCase(categoryParam)) {
            productList = productDAO.getProductsByCategory(categoryParam);
            activeCategory = categoryParam.toLowerCase();
        } else {
            productList = productDAO.getAllProducts();
        }

        request.setAttribute("productList", productList);
        request.setAttribute("activeCategory", activeCategory);
        request.setAttribute("pageTitle", "Shop - Premium Watches | AluGhadi");
        request.setAttribute("pageDesc", "Browse our complete collection of premium watches. Find the perfect timepiece.");
        request.setAttribute("activeNav", "products");
        request.setAttribute("pageStyle", "products");
        Object userIdObj = SessionUtil.getAttribute(request, "authUserId");
        if (userIdObj != null) {
            int userId = (Integer) userIdObj;
            CartDao cartDao = new CartDaoImpl();
            List<Integer> cartProductIds = cartDao.getCartProductIds((Integer) userIdObj);

            request.setAttribute("cartProductIds", cartProductIds);
            request.setAttribute("cartItems", cartDao.getCartItems(userId));
            request.setAttribute("cartCount", cartDao.getCartCount(userId));
            request.setAttribute("grandTotal", cartDao.getGrandTotal(userId));
        }

        request.getRequestDispatcher("/WEB-INF/views/products.jsp").forward(request, response);
    }
}
