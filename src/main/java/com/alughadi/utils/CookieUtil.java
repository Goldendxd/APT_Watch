package com.alughadi.utils;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * CookieUtil — helper methods for reading and writing HTTP cookies.
 *
 * addCookie(response, name, value, maxAge) — create a cookie with HttpOnly=true
 *   so JavaScript can't read it, and path="/" so it's sent on all requests.
 *   maxAge is in seconds (e.g. 60*60*24 = 1 day).
 *
 * getCookieValue(request, name) — scan the request's cookie array for a cookie
 *   with the given name. Returns its value, or null if not found.
 *
 * deleteCookie(response, name) — overwrite a cookie with maxAge=0 so the browser
 *   removes it immediately.
 */
public class CookieUtil {
    public static void addCookie(HttpServletResponse response, String name, String value, int maxAge){
        Cookie cookie = new Cookie(name, value);
        cookie.setMaxAge(maxAge);
        cookie.setPath("/");
        cookie.setHttpOnly(true);
        response.addCookie(cookie);
    }
    public static String getCookieValue(HttpServletRequest request, String name){
        Cookie[] cookies = request.getCookies();
        if(cookies != null){
            for (Cookie cookie: cookies){
                if (name.equals(cookie.getName())){
                    return cookie.getValue();
                }
            }
        }
        return null;
    }
    public static void deleteCookie(HttpServletResponse response, String name){
        Cookie cookie = new Cookie(name, "");
        cookie.setMaxAge(0);
        cookie.setPath("/");
        response.addCookie(cookie);
    }
}
