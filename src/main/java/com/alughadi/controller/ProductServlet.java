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

@WebServlet("/products")
public class ProductServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductDAO productDAO = new ProductDaoImpl();
        List<Product> productList = productDAO.getAllProducts();
        request.setAttribute("productList", productList);
        request.setAttribute("pageTitle", "Shop - Premium Watches | AluGhadi");
        request.setAttribute("pageDesc", "Browse our complete collection of premium watches. Find the perfect timepiece.");
        request.setAttribute("activeNav", "products");
        request.getRequestDispatcher("/WEB-INF/views/products.jsp").forward(request, response);
    }
}
