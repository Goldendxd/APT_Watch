package com.alughadi.controller.filter;

import com.alughadi.dao.CartDao;
import com.alughadi.dao.CartDaoImpl;
import com.alughadi.utils.SessionUtil;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * AuthenticationFilter — protects all routes behind login.
 *
 * Acts as middleware (gatekeeper) that intercepts every request and checks
 * if the user is logged in before allowing access.
 *
 * Rules:
 *   - Static resources (.css, .png, .js, .jpg) -> always allowed
 *   - /login and /register -> allowed only if NOT logged in
 *   - Everything else -> allowed only if logged in
 *
 * Complete from Week 7 tutorial.
 */
@WebFilter("/*")
public class AuthenticationFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request,
                         ServletResponse response,
                         FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();
        String path = uri.substring(contextPath.length());
//        String method = req.getMethod();

        // Allow static resources (CSS, images, JS) through without login
        if (path.startsWith("/static/")) {
            chain.doFilter(request, response);
            return;
        }

        boolean isLoggedIn = SessionUtil.getAttribute(req, "authUser") != null;
        boolean isCartPath = "/cart".equals(path);
//        boolean isCartToBUyAction = "POST".equalsIgnoreCase(method) && path.equals("/cart");
        if (!isLoggedIn && isCartPath){
            res.sendRedirect(contextPath + "/login");
            return;
        }
        if (isLoggedIn) {
            Object userIdObj = SessionUtil.getAttribute(req, "authUserId");

            if (userIdObj != null) {
                int userId = (Integer) userIdObj;
                CartDao cartDao = new CartDaoImpl();

                req.setAttribute("cartItems", cartDao.getCartItems(userId));
                req.setAttribute("cartCount", cartDao.getCartCount(userId));
                req.setAttribute("grandTotal", cartDao.getGrandTotal(userId));
            }
        }

        boolean isAdminPath = "/admin".equals(path) || "/admin-profile".equals(path);
        if (isAdminPath){
            if (!isLoggedIn){
                res.sendRedirect(contextPath+"/login");
                return;
            }
            Object role = SessionUtil.getAttribute(req, "authRole");

            if (!"admin".equals(role)){
                res.sendRedirect(contextPath+"/home");
                return;
            }
        }

        chain.doFilter(request, response);
//        boolean isAuthPage = "/login".equals(path) || "/register".equals(path);
//
//        if (!isLoggedIn && !isAuthPage) {
//            // Not logged in + trying to access protected page -> go to login
//            res.sendRedirect(contextPath + "/login");
//            return;
//        }
//
//        if (isLoggedIn && isAuthPage) {
//            // Already logged in + trying to access login/register -> go to topics
//            res.sendRedirect(contextPath + "/home");
//            return;
//        }

        // All other cases: allow through

    }
}
