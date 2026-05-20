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
 * AuthenticationFilter — intercepts every request (@WebFilter("/*")) and enforces access rules.
 *
 * How it works for each request:
 *   1. Static files (/static/*) — let through always, no login needed.
 *   2. /cart — redirect to /login if not logged in.
 *   3. If logged in — preload cart data (items, count, total) as request attributes
 *      so any page that includes the cart modal already has the data ready.
 *   4. Admin-only paths (/admin, /admin-profile):
 *        - Not logged in → /login
 *        - Logged in but not admin role → /home
 *   5. Admin users trying to access non-admin paths (except /logout):
 *        → redirect to /admin so admins can't browse the shop.
 *   6. Everything else — pass through.
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
        // Allow static resources (CSS, images, JS) through without login
        if (path.startsWith("/static/")) {
            chain.doFilter(request, response);
            return;
        }

        boolean isLoggedIn = SessionUtil.getAttribute(req, "authUser") != null;
        boolean isCartPath = "/cart".equals(path);
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
        if (isAdminPath) {
            if (!isLoggedIn) {
                res.sendRedirect(contextPath + "/login");
                return;
            }
            Object role = SessionUtil.getAttribute(req, "authRole");
            if (!"admin".equals(role)) {
                res.sendRedirect(contextPath + "/home");
                return;
            }
        }

        // Admins can only access admin routes and logout
        Object role = SessionUtil.getAttribute(req, "authRole");
        if ("admin".equals(role) && !isAdminPath && !"/logout".equals(path)) {
            res.sendRedirect(contextPath + "/admin");
            return;
        }

        chain.doFilter(request, response);
    }
}
