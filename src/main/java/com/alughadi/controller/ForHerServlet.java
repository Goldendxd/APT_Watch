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
        List<Product> womens  = productDAO.getProductsByCategory("womens");
        List<Product> luxury  = productDAO.getProductsByCategory("luxury");
        List<Product> classic = productDAO.getProductsByCategory("classic");

        request.setAttribute("womensProducts",  womens);
        request.setAttribute("luxuryProducts",  luxury);
        request.setAttribute("classicProducts", classic);

        request.getRequestDispatcher("/WEB-INF/views/for-her.jsp").forward(request, response);
    }
}
