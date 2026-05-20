package com.alughadi.controller;

import com.alughadi.dao.ProductDAO;
import com.alughadi.dao.ProductDaoImpl;
import com.alughadi.entity.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * ForHimServlet — loads the "For Him" gift guide page.
 *
 * URL: /for-him  or  /for-him?category=sports
 *
 * GET /for-him              -> show all non-women's products
 * GET /for-him?category=X   -> filter to a specific style (luxury/sports/classic/smart)
 *
 * Women's category products are excluded from the default "all" view
 * because this page is men's watches only.
 */
@WebServlet("/for-him")
public class ForHimServlet extends HttpServlet {
    private final ProductDAO productDAO = new ProductDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String category = request.getParameter("category");
        List<Product> productList;

        if (category != null && category.trim().length() > 0 && !category.equals("all")) {
            productList = productDAO.getProductsByCategory(category);
        } else {
            List<Product> all = productDAO.getAllProducts();
            productList = new ArrayList<Product>();
            for (Product p : all) {
                if (!"Womens".equalsIgnoreCase(p.getCategoryName())) {
                    productList.add(p);
                }
            }
        }

        request.setAttribute("productList", productList);
        request.setAttribute("activeCategory", category != null ? category : "all");
        request.setAttribute("pageTitle", "Gifts For Him | AluGhadi Watches");
        request.setAttribute("pageDesc", "Curated watch gifts for him.");
        request.setAttribute("activeNav", "gifting");

        request.getRequestDispatcher("/WEB-INF/views/for-him.jsp").forward(request, response);
    }
}
