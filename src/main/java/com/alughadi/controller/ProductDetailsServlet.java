package com.alughadi.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/product-details")
public class ProductDetailsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("pageTitle", "Royal Prestige Automatic | AluGhadi");
        request.setAttribute("pageDesc", "Front-end product detail mockup for AluGhadi Watches. This page is ready for backend wiring later.");
        request.setAttribute("activeNav", "products");
        request.setAttribute("pageStyle", "product-details");
        request.getRequestDispatcher("/WEB-INF/views/product-details.jsp").forward(request, response);
    }
}