package com.alughadi.controller;

import com.alughadi.dao.OrderDao;
import com.alughadi.dao.OrderDaoImpl;
import com.alughadi.dao.UserDao;
import com.alughadi.dao.UserDaoImpl;
import com.alughadi.entity.User;
import com.alughadi.utils.PasswordUtil;
import com.alughadi.utils.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;

/**
 * AdminProfileServlet — lets the admin view and edit their own account.
 *
 * URL: /admin-profile
 *
 * GET  /admin-profile        -> load admin user + store stats, forward to admin-profile.jsp
 * POST action=updateProfile  -> save name/phone/city/etc
 * POST action=changePassword -> verify old password, save new hash
 * POST action=uploadAvatar   -> upload and store a new profile photo
 *
 * Access: admin role only (enforced by AuthenticationFilter before this even runs).
 */
@WebServlet("/admin-profile")
@MultipartConfig
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

            // Update only the profile fields that exist in the DB schema
            user.setFull_name(trim(request.getParameter("fullName")));
            user.setPhone(trim(request.getParameter("phone")));
            user.setGender(trim(request.getParameter("gender")));
            user.setAddress(trim(request.getParameter("address")));
            user.setCity(trim(request.getParameter("city")));
            user.setProvince(trim(request.getParameter("province")));

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

        } else if ("uploadAvatar".equals(action)) {
            Part filePart = request.getPart("avatarFile");
            if (filePart == null || filePart.getSize() == 0) {
                response.sendRedirect(request.getContextPath() + "/admin-profile?avatarError=empty");
                return;
            }
            String origName = filePart.getSubmittedFileName();
            if (origName == null) {
                response.sendRedirect(request.getContextPath() + "/admin-profile?avatarError=invalid");
                return;
            }
            String ext = origName.substring(origName.lastIndexOf('.')).toLowerCase();
            if (!ext.equals(".jpg") && !ext.equals(".jpeg") && !ext.equals(".png") && !ext.equals(".webp")) {
                response.sendRedirect(request.getContextPath() + "/admin-profile?avatarError=type");
                return;
            }

            User user = userDao.findById(userId);
            String username = user != null ? user.getUsername() : String.valueOf(userId);
            String date = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new java.util.Date());
            String newFileName = username + "_" + date + ext;

            String deployedPath = getServletContext().getRealPath("/static/images/avatars/");
            File deployedDir = new File(deployedPath);
            if (!deployedDir.exists()) deployedDir.mkdirs();
            File destDeployed = new File(deployedDir, newFileName);
            filePart.write(destDeployed.getAbsolutePath());

            File sourceDir = new File(System.getProperty("user.dir"), "src/main/webapp/static/images/avatars/");
            if (!sourceDir.exists()) sourceDir.mkdirs();
            File destSource = new File(sourceDir, newFileName);
            if (!destSource.exists()) Files.copy(destDeployed.toPath(), destSource.toPath());

            String imagePath = "/static/images/avatars/" + newFileName;
            userDao.updateProfileImage(userId, imagePath);
            response.sendRedirect(request.getContextPath() + "/admin-profile?avatarUpdated=1");
        }
    }

    private String trim(String s) {
        return (s != null && !s.trim().isEmpty()) ? s.trim() : null;
    }
}
