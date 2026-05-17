package com.alughadi.controller;

import com.alughadi.dao.UserDao;
import com.alughadi.dao.UserDaoImpl;
import com.alughadi.entity.User;
import com.alughadi.utils.PasswordUtil;
import com.alughadi.utils.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final UserDao userDao = new UserDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/register.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        StringBuilder errorMessage = new StringBuilder();

        if (ValidationUtil.isNullOrEmpty(username) ||
                ValidationUtil.isNullOrEmpty(email) ||
                ValidationUtil.isNullOrEmpty(password) ||
                ValidationUtil.isNullOrEmpty(confirmPassword)) {

            request.setAttribute("registerError", "Please fill in all fields.");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp")
                    .forward(request, response);
            return;
        }
        if (ValidationUtil.isNullOrEmpty(username) ||
                !ValidationUtil.isAlphanumericStartingWithLetter(username) ||
                username.length() < 6) {
            errorMessage.append("Username must be alphanumeric, start with a letter, and be at least 6 characters. ");
        }
        if (!ValidationUtil.isValidEmail(email)) {
            errorMessage.append("Invalid email format. ");
        }
        if (!ValidationUtil.isValidPassword(password)) {
            errorMessage.append("Password must be 8+ characters with uppercase, number, and symbol. ");
        }
        if (!ValidationUtil.doPasswordsMatch(password, confirmPassword)) {
            errorMessage.append("Passwords do not match. ");
        }
        if (errorMessage.length() > 0) {
            request.setAttribute("registerError", errorMessage.toString().trim());
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        String hashedPassword = PasswordUtil.getHashPassword(password);
        User user = new User(username, email, hashedPassword);

        boolean success = userDao.insertUser(user);

        if(!success) {
            request.setAttribute("registerError", "Username or email already exists.");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }
        response.sendRedirect(request.getContextPath() + "/login?registered=1");
    }

}