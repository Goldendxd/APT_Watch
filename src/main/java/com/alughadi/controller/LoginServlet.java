package com.alughadi.controller;

import com.alughadi.dao.UserDao;
import com.alughadi.dao.UserDaoImpl;
import com.alughadi.entity.User;
import com.alughadi.utils.PasswordUtil;
import com.alughadi.utils.SessionUtil;

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
 * POST /login -> find user, verify password, store session, redirect on success
 *
 * Week 7: doPost now stores the User object in the session after successful
 * authentication (previously just redirected with no session state).
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

        String username = request.getParameter("username").trim();
        String password = request.getParameter("password").trim();

        if (username == null || username.isEmpty() ||
            password == null || password.isEmpty()){
            request.setAttribute("loginError", "Please enter both username and password. ");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp")
                    .forward(request, response);
            return;
        }
        User user = userDao.findByUsername(username);

        if (user == null) {
            request.setAttribute("loginError", "Invalid username or password.");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp")
                    .forward(request, response);
            return;
        }

        if(!PasswordUtil.checkPassword(password, user.getPassword())){
            request.setAttribute("loginError", "Invalid username or password. ");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp")
                    .forward(request, response);
            return;
        }

        SessionUtil.setAttribute(request, "authUser", user.getUsername());
        SessionUtil.setAttribute(request, "authRole", user);
        response.sendRedirect(request.getContextPath() + "/home");
    }

}
