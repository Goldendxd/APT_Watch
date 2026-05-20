package com.alughadi.controller;

import com.alughadi.utils.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * LogoutServlet — logs the current user out.
 *
 * URL: /logout
 *
 * GET /logout -> destroy the session (wipes authUser, authUserId, authRole, cart data)
 *               then redirect to the home page so the user lands somewhere clean.
 *
 * This is the only route admins are allowed to visit outside of /admin and /admin-profile
 * (enforced in AuthenticationFilter).
 */
@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kill the session — everything stored in it disappears
        SessionUtil.invalidateSession(request);
        response.sendRedirect(request.getContextPath() + "/");
    }
}
