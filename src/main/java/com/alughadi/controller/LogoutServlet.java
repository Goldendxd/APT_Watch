//package com.alughadi.controller;
//
//import com.alughadi.dao.UserDao;
//import com.alughadi.dao.UserDaoImpl;
//import com.alughadi.entity.User;
//import com.alughadi.utils.PasswordUtil;
//import com.alughadi.utils.SessionUtil;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.Cookie;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//
//import java.io.IOException;
//
///**
// * LoginServlet — handles user login.
// *
// * URL: /login
// *
// * GET  /login -> forward to login.jsp (displays the form)
// * POST /login -> find user, verify password, store session, redirect on success
// *
// * Week 7: doPost now stores the User object in the session after successful
// * authentication (previously just redirected with no session state).
// */
//@WebServlet("/logout")
//public class LogoutServlet extends HttpServlet {
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        SessionUtil.invalidateSession(request);
//
//        response.sendRedirect(request.getContextPath()+"/login");
//    }
//}
