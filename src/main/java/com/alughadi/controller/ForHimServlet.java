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

@WebServlet("/for-him")
public class ForHimServlet extends HttpServlet {
    private final ProductDAO productDAO = new ProductDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Product> productList = productDAO.getAllProducts();

        request.setAttribute("productList", productList);
        request.setAttribute("pageTitle", "Gifts For Him | AluGhadi Watches");
        request.setAttribute("pageDesc", "Curated watch gifts for him.");
        request.setAttribute("activeNav", "gifting");

        request.getRequestDispatcher("/WEB-INF/views/for-him.jsp").forward(request, response);
    }
}
