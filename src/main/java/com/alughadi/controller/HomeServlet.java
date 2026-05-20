package com.alughadi.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * HomeServlet — loads the home page.
 *
 * URL: /home
 *
 * GET /home -> just forward to index.jsp. Products are loaded in the JSP directly.
 * The AuthenticationFilter runs first and attaches cart data to the request
 * if the user is logged in, so index.jsp can show the cart count in the nav.
 */
@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/index.jsp").forward(req, res);
    }
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        // Home page has no POST actions
    }
}
