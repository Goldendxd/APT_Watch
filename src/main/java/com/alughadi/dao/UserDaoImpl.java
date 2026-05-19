package com.alughadi.dao;

import com.alughadi.entity.User;
import com.alughadi.utils.DatabaseConnection;

import java.sql.*;

public class UserDaoImpl implements UserDao {

    @Override
    public boolean insertUser(User user) {
        if (findByUsername(user.getUsername()) != null) return false;
        if (findByEmail(user.getEmail()) != null) return false;
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
            System.out.println("Error inserting user: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }

    @Override
    public User findByUsername(String username) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            PreparedStatement st = conn.prepareStatement(
                "SELECT * FROM users WHERE LOWER(username) = LOWER(?)");
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            if (rs.next()) return mapFull(rs);
        } catch (SQLException e) {
            System.out.println("Error finding user by username: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return null;
    }

    @Override
    public User findByEmail(String email) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            PreparedStatement st = conn.prepareStatement(
                "SELECT * FROM users WHERE LOWER(email) = LOWER(?)");
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) return mapFull(rs);
        } catch (SQLException e) {
            System.out.println("Error finding user by email: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return null;
    }

    @Override
    public User findById(int id) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            PreparedStatement st = conn.prepareStatement("SELECT * FROM users WHERE id = ?");
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) return mapFull(rs);
        } catch (SQLException e) {
            System.out.println("Error finding user by id: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return null;
    }

    @Override
    public boolean updateProfile(User user) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            PreparedStatement st = conn.prepareStatement(
                "UPDATE users SET full_name=?, phone=?, email=?, gender=?, " +
                "date_of_birth=?, address=?, city=?, province=?, district=? WHERE id=?");
            st.setString(1, user.getFull_name());
            st.setString(2, user.getPhone());
            st.setString(3, user.getEmail());
            st.setString(4, user.getGender());
            st.setDate(5, user.getDate_of_birth() != null
                ? new java.sql.Date(user.getDate_of_birth().getTime()) : null);
            st.setString(6, user.getAddress());
            st.setString(7, user.getCity());
            st.setString(8, user.getProvince());
            st.setString(9, user.getDistrict());
            st.setInt(10, user.getId());
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error updating profile: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }

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
            System.out.println("Error changing password: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }

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
            System.out.println("Error counting customers: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return 0;
    }

    private User mapFull(ResultSet rs) throws SQLException {
        User u = new User(
            rs.getInt("id"),
            rs.getString("username"),
            rs.getString("email"),
            rs.getString("password"),
            rs.getTimestamp("created_at"),
            rs.getTimestamp("updated_at")
        );
        u.setRole(rs.getString("role"));
        // Profile fields — may be null for older rows
        try { u.setFull_name(rs.getString("full_name")); } catch (SQLException ignored) {}
        try { u.setPhone(rs.getString("phone")); } catch (SQLException ignored) {}
        try { u.setGender(rs.getString("gender")); } catch (SQLException ignored) {}
        try { u.setDate_of_birth(rs.getDate("date_of_birth")); } catch (SQLException ignored) {}
        try { u.setAddress(rs.getString("address")); } catch (SQLException ignored) {}
        try { u.setCity(rs.getString("city")); } catch (SQLException ignored) {}
        try { u.setProvince(rs.getString("province")); } catch (SQLException ignored) {}
        try { u.setDistrict(rs.getString("district")); } catch (SQLException ignored) {}
        try { u.setIs_active(rs.getInt("is_active")); } catch (SQLException ignored) {}
        try { u.setIs_verified(rs.getInt("is_verified")); } catch (SQLException ignored) {}
        try { u.setLast_login(rs.getTimestamp("last_login")); } catch (SQLException ignored) {}
        return u;
    }
}
