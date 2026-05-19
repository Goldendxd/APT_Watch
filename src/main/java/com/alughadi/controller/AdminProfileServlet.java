package com.alughadi.controller;

import com.alughadi.dao.OrderDao;
import com.alughadi.dao.OrderDaoImpl;
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
import java.text.ParseException;
import java.text.SimpleDateFormat;

@WebServlet("/admin-profile")
public class AdminProfileServlet extends HttpServlet {

    private final UserDao  userDao  = new UserDaoImpl();
    private final OrderDao orderDao = new OrderDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Object uid = SessionUtil.getAttribute(request, "authUserId");
        if (uid == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        int userId = (Integer) uid;

        User user = userDao.findById(userId);

        request.setAttribute("profileUser",   user);
        request.setAttribute("totalRevenue",  orderDao.getTotalRevenue());
        request.setAttribute("totalOrders",   orderDao.getTotalOrderCount());

        request.getRequestDispatcher("/WEB-INF/views/admin-profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Object uid = SessionUtil.getAttribute(request, "authUserId");
        if (uid == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        int userId = (Integer) uid;
        String action = request.getParameter("action");

        if ("updateProfile".equals(action)) {
            User user = userDao.findById(userId);
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/admin-profile");
                return;
            }

            user.setFull_name(trim(request.getParameter("fullName")));
            user.setPhone(trim(request.getParameter("phone")));
            user.setGender(trim(request.getParameter("gender")));
            user.setAddress(trim(request.getParameter("address")));
            user.setCity(trim(request.getParameter("city")));
            user.setProvince(trim(request.getParameter("province")));
            user.setDistrict(trim(request.getParameter("district")));

            String dob = trim(request.getParameter("dateOfBirth"));
            if (dob != null && !dob.isEmpty()) {
                try {
                    user.setDate_of_birth(new SimpleDateFormat("yyyy-MM-dd").parse(dob));
                } catch (ParseException ignored) {}
            }

            String newEmail = trim(request.getParameter("email"));
            if (newEmail != null && !newEmail.isEmpty() && !newEmail.equalsIgnoreCase(user.getEmail())) {
                User existing = userDao.findByEmail(newEmail);
                if (existing != null && existing.getId() != userId) {
                    request.setAttribute("profileError", "That email is already in use.");
                    doGet(request, response);
                    return;
                }
                user.setEmail(newEmail);
            }

            userDao.updateProfile(user);
            response.sendRedirect(request.getContextPath() + "/admin-profile?updated=1");

        } else if ("changePassword".equals(action)) {
            String current = request.getParameter("currentPassword");
            String next    = request.getParameter("newPassword");
            String confirm = request.getParameter("confirmPassword");

            User user = userDao.findById(userId);
            if (user == null || !PasswordUtil.checkPassword(current != null ? current.trim() : "", user.getPassword())) {
                request.setAttribute("pwError", "Current password is incorrect.");
                doGet(request, response);
                return;
            }
            if (next == null || next.trim().length() < 8) {
                request.setAttribute("pwError", "New password must be at least 8 characters.");
                doGet(request, response);
                return;
            }
            if (!next.equals(confirm)) {
                request.setAttribute("pwError", "Passwords do not match.");
                doGet(request, response);
                return;
            }

            userDao.changePassword(userId, PasswordUtil.getHashPassword(next.trim()));
            response.sendRedirect(request.getContextPath() + "/admin-profile?pwChanged=1");
        }
    }

    private String trim(String s) {
        return (s != null && !s.trim().isEmpty()) ? s.trim() : null;
    }
}
