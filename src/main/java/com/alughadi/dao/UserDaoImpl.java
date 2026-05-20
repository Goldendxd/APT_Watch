package com.alughadi.dao;

import com.alughadi.entity.User;
import com.alughadi.utils.DatabaseConnection;

import java.sql.*;

/**
 * UserDaoImpl — talks to the "users" table in MySQL.
 *
 * Columns used: id, username, email, password, role,
 *               full_name, phone, gender, profile_image,
 *               address, city, province,
 *               is_active, last_login, created_at, updated_at
 *
 * How it works:
 *   1. Get a DB connection from DatabaseConnection.
 *   2. Run a PreparedStatement (safe — prevents SQL injection).
 *   3. Read the ResultSet / return a count.
 *   4. Always close the connection in the finally block.
 */
public class UserDaoImpl implements UserDao {

    /**
     * Register a new user.
     * First checks username and email aren't already taken,
     * then inserts a new row with just username, email, password (hashed).
     */
    @Override
    public boolean insertUser(User user) {
        // Stop if username or email already exists
        if (findByUsername(user.getUsername()) != null) return false;
        if (findByEmail(user.getEmail())       != null) return false;

        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            PreparedStatement st = conn.prepareStatement(
                "INSERT INTO users (username, email, password) VALUES (?, ?, ?)");
            st.setString(1, user.getUsername());
            st.setString(2, user.getEmail());
            st.setString(3, user.getPassword());
            st.executeUpdate();
            return true;
        } catch (SQLException e) {
            throw new RuntimeException("Error inserting user", e);
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }

    /**
     * Look up a user by their username (case-insensitive).
     * Used during login to verify credentials.
     */
    @Override
    public User findByUsername(String username) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            PreparedStatement st = conn.prepareStatement(
                "SELECT * FROM users WHERE LOWER(username) = LOWER(?)");
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) {
            throw new RuntimeException("Error finding user by username", e);
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return null;
    }

    /**
     * Look up a user by their email address (case-insensitive).
     * Used during registration to detect duplicate emails.
     */
    @Override
    public User findByEmail(String email) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            PreparedStatement st = conn.prepareStatement(
                "SELECT * FROM users WHERE LOWER(email) = LOWER(?)");
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) {
            throw new RuntimeException("Error finding user by email", e);
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return null;
    }

    /**
     * Look up a user by their numeric database ID.
     * Used in profile, admin dashboard, and cart loading.
     */
    @Override
    public User findById(int id) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            PreparedStatement st = conn.prepareStatement(
                "SELECT * FROM users WHERE id = ?");
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) {
            throw new RuntimeException("Error finding user by id", e);
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return null;
    }

    /**
     * Save changes the user made on the profile page.
     * Only updates the editable profile fields — username and password
     * are changed through separate flows.
     */
    @Override
    public boolean updateProfile(User user) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            // Only update columns that actually exist in the DB schema
            PreparedStatement st = conn.prepareStatement(
                "UPDATE users SET full_name=?, phone=?, email=?, gender=?, " +
                "address=?, city=?, province=? WHERE id=?");
            st.setString(1, user.getFull_name());
            st.setString(2, user.getPhone());
            st.setString(3, user.getEmail());
            st.setString(4, user.getGender());
            st.setString(5, user.getAddress());
            st.setString(6, user.getCity());
            st.setString(7, user.getProvince());
            st.setInt(8, user.getId());
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error updating profile", e);
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }

    /**
     * Replace the user's password hash in the DB.
     * Called after verifying the old password in ProfileServlet / AdminProfileServlet.
     */
    @Override
    public boolean changePassword(int userId, String newHashedPassword) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            PreparedStatement st = conn.prepareStatement(
                "UPDATE users SET password=? WHERE id=?");
            st.setString(1, newHashedPassword);
            st.setInt(2, userId);
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error changing password", e);
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }

    /**
     * Save a new profile image path (relative URL like /static/images/avatars/xxx.jpg).
     * Called after successfully uploading the file.
     */
    @Override
    public boolean updateProfileImage(int userId, String imagePath) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            PreparedStatement st = conn.prepareStatement(
                "UPDATE users SET profile_image=? WHERE id=?");
            st.setString(1, imagePath);
            st.setInt(2, userId);
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error updating profile image", e);
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }

    /**
     * Count how many regular customer accounts exist.
     * Used in the admin dashboard KPI strip.
     */
    @Override
    public int countCustomers() {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            PreparedStatement st = conn.prepareStatement(
                "SELECT COUNT(*) FROM users WHERE role = 'customer'");
            ResultSet rs = st.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            throw new RuntimeException("Error counting customers", e);
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return 0;
    }

    /**
     * Maps a single ResultSet row into a User object.
     * Called only after a SELECT * FROM users, so all columns are guaranteed present.
     */
    private User mapRow(ResultSet rs) throws SQLException {
        // Build the core user first (always present columns)
        User u = new User(
            rs.getInt("id"),
            rs.getString("username"),
            rs.getString("email"),
            rs.getString("password"),
            rs.getTimestamp("created_at"),
            rs.getTimestamp("updated_at")
        );

        // Role — decides admin vs customer access
        u.setRole(rs.getString("role"));

        // Optional profile fields — rs.getString returns null for SQL NULL, no exception thrown
        u.setFull_name(rs.getString("full_name"));
        u.setPhone(rs.getString("phone"));
        u.setGender(rs.getString("gender"));
        u.setAddress(rs.getString("address"));
        u.setCity(rs.getString("city"));
        u.setProvince(rs.getString("province"));
        u.setProfile_image(rs.getString("profile_image"));

        // Account state fields
        u.setIs_active(rs.getInt("is_active"));
        u.setLast_login(rs.getTimestamp("last_login"));

        return u;
    }
}
