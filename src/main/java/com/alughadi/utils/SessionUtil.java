package com.alughadi.utils;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

/**
 * SessionUtil — wraps HttpSession operations so servlets don't repeat the same boilerplate.
 *
 * setAttribute(request, key, value) — create/get the session and set an attribute.
 *   Also resets the session timeout to 30 minutes each time it's called.
 *   Used by LoginServlet to store authUser, authUserId, authRole after login.
 *
 * getAttribute(request, key) — read a session attribute without creating a new session
 *   if none exists (getSession(false)). Returns null if there is no session or the
 *   key is not set.
 *
 * invalidateSession(request) — destroy the session completely.
 *   Used by LogoutServlet to log the user out.
 */

public class SessionUtil {

    public static void setAttribute(HttpServletRequest request,
                                    String key, Object value) {
        HttpSession session = request.getSession();
        session.setMaxInactiveInterval(30 * 60);
        session.setAttribute(key, value);
    }

    public static Object getAttribute(HttpServletRequest request,
                                      String key) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return session.getAttribute(key);
        }
        return null;
    }

    public static void invalidateSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();

        }
    }
}
