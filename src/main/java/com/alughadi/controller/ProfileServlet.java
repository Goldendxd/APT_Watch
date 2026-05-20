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
import java.util.List;
import java.util.Map;

/**
 * ProfileServlet — lets a logged-in customer view and edit their profile.
 *
 * URL: /profile
 *
 * GET  /profile         -> load user + order history, forward to profile.jsp
 * POST /profile action=updateProfile  -> save name/phone/city/etc changes
 * POST /profile action=changePassword -> verify old password, save new hash
 * POST /profile action=uploadAvatar   -> save uploaded photo, store path in DB
 */
@WebServlet("/profile")
@MultipartConfig
public class ProfileServlet extends HttpServlet {

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
        List<Map<String, Object>> orders = orderDao.getUserOrders(userId);

        request.setAttribute("profileUser",  user);
        request.setAttribute("userOrders",   orders);
        request.setAttribute("pageTitle",    "My Profile | AluGhadi");
        request.setAttribute("activeNav",    "profile");
        request.setAttribute("pageStyle",    "profile");

        request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
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
                response.sendRedirect(request.getContextPath() + "/profile");
                return;
            }

            // Update the profile fields that exist in the DB schema
            user.setFull_name(trim(request.getParameter("fullName")));
            user.setPhone(trim(request.getParameter("phone")));
            user.setGender(trim(request.getParameter("gender")));
            user.setAddress(trim(request.getParameter("address")));
            user.setCity(trim(request.getParameter("city")));
            user.setProvince(trim(request.getParameter("province")));

            // Email uniqueness check
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
            response.sendRedirect(request.getContextPath() + "/profile?updated=1");

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
            response.sendRedirect(request.getContextPath() + "/profile?pwChanged=1");

        } else if ("uploadAvatar".equals(action)) {
            Part filePart = request.getPart("avatarFile");
            if (filePart == null || filePart.getSize() == 0) {
                response.sendRedirect(request.getContextPath() + "/profile?avatarError=empty");
                return;
            }
            String origName = filePart.getSubmittedFileName();
            if (origName == null) {
                response.sendRedirect(request.getContextPath() + "/profile?avatarError=invalid");
                return;
            }
            String ext = origName.substring(origName.lastIndexOf('.')).toLowerCase();
            if (!ext.equals(".jpg") && !ext.equals(".jpeg") && !ext.equals(".png") && !ext.equals(".webp")) {
                response.sendRedirect(request.getContextPath() + "/profile?avatarError=type");
                return;
            }

            User user = userDao.findById(userId);
            String username = user != null ? user.getUsername() : String.valueOf(userId);
            String date = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new java.util.Date());
            String newFileName = username + "_" + date + ext;

            // Save to deployed path
            String deployedPath = getServletContext().getRealPath("/static/images/avatars/");
            File deployedDir = new File(deployedPath);
            if (!deployedDir.exists()) deployedDir.mkdirs();
            File destDeployed = new File(deployedDir, newFileName);
            filePart.write(destDeployed.getAbsolutePath());

            // Also save to source so it persists across rebuilds
            File sourceDir = new File(System.getProperty("user.dir"), "src/main/webapp/static/images/avatars/");
            if (!sourceDir.exists()) sourceDir.mkdirs();
            File destSource = new File(sourceDir, newFileName);
            if (!destSource.exists()) Files.copy(destDeployed.toPath(), destSource.toPath());

            String imagePath = "/static/images/avatars/" + newFileName;
            userDao.updateProfileImage(userId, imagePath);
            response.sendRedirect(request.getContextPath() + "/profile?avatarUpdated=1");
        }
    }

    private String trim(String s) {
        return (s != null && !s.trim().isEmpty()) ? s.trim() : null;
    }
}
