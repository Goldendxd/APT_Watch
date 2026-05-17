package com.alughadi.controller;

import com.alughadi.dao.ProductDAO;
import com.alughadi.dao.ProductDaoImpl;
import com.alughadi.entity.Product;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/gifting")
public class GiftingServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        ProductDAO productDAO = new ProductDaoImpl();
        List<Product> productList = productDAO.getAllProducts();

        req.setAttribute("productList", productList);
        req.setAttribute("pageTitle", "Gift Guide | AluGhadi Watches");
        req.setAttribute("pageDesc", "Find the perfect watch gift for him or her. Curated top picks from AluGhadi.");
        req.setAttribute("activeNav", "gifting");
        RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/views/gifting.jsp");
        rd.forward(req, res);
    }
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException,IOException{

    }
}