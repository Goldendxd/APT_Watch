package com.alughadi.controller;

import com.alughadi.dao.UserDao;
import com.alughadi.dao.UserDaoImpl;
import com.alughadi.entity.User;
import com.alughadi.utils.PasswordUtil;
import com.alughadi.utils.SessionUtil;

import com.alughadi.utils.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * LoginServlet — handles user login.
 *
 * URL: /login
 *
 * GET  /login -> forward to login.jsp (displays the form)
 * POST /login -> find user by username, verify BCrypt password, store session, redirect
 *
 * On success, three session attributes are set:
 *   - authUser   (username string)
 *   - authUserId (int)
 *   - authRole   (e.g. "user" or "admin")
 *
 * Admin accounts are sent to /admin; regular users go to /home.
 * Wrong username or password → show "Invalid username or password." and stay on form.
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UserDao userDao = new UserDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/login.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (ValidationUtil.isNullOrEmpty(username) || ValidationUtil.isNullOrEmpty(password)){
            request.setAttribute("loginError", "Please enter both username and password. ");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp")
                    .forward(request, response);
            return;
        }
        User user = userDao.findByUsername(username.trim());

        if (user == null || !PasswordUtil.checkPassword(password.trim(), user.getPassword() )) {
            request.setAttribute("loginError", "Invalid username or password.");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp")
                    .forward(request, response);
            return;
        }

        SessionUtil.setAttribute(request, "authUser", user.getUsername());
        SessionUtil.setAttribute(request, "authUserId", user.getId());
        SessionUtil.setAttribute(request, "authRole", user.getRole());
        if("admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath()+"/admin");
        } else {
            response.sendRedirect(request.getContextPath()+"/home");
        }

    }

}
