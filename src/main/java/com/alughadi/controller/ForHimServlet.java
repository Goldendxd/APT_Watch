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
        List<Product> classics = productDAO.getProductsByCategory("classic");
        List<Product> sports   = productDAO.getProductsByCategory("sports");
        List<Product> luxury   = productDAO.getProductsByCategory("luxury");
        List<Product> smart    = productDAO.getProductsByCategory("smart");

        request.setAttribute("classicProducts", classics);
        request.setAttribute("sportsProducts",  sports);
        request.setAttribute("luxuryProducts",  luxury);
        request.setAttribute("smartProducts",   smart);

        request.getRequestDispatcher("/WEB-INF/views/for-him.jsp").forward(request, response);
    }
}
