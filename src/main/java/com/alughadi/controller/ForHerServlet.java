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
import java.util.List;

@WebServlet("/for-her")
public class ForHerServlet extends HttpServlet {
    private final ProductDAO productDAO = new ProductDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String category = request.getParameter("category");
        List<Product> productList;

        if (category != null && category.trim().length() > 0 && !category.equals("all")) {
            productList = productDAO.getProductsByCategory(category);
        } else {
            productList = productDAO.getProductsByCategory("womens");
        }

        request.setAttribute("productList", productList);
        request.setAttribute("activeCategory", category != null ? category : "all");
        request.setAttribute("pageTitle", "Gifts For Her | AluGhadi Watches");
        request.setAttribute("pageDesc", "Curated watch gifts for her.");
        request.setAttribute("activeNav", "gifting");

        request.getRequestDispatcher("/WEB-INF/views/for-her.jsp").forward(request, response);
    }
}
