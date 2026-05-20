package com.alughadi.dao;

import com.alughadi.utils.DatabaseConnection;

import java.sql.*;
import java.util.*;

/**
 * OrderDaoImpl — all database operations for orders.
 *
 * saveOrder      — insert a new order row and all its line items in one transaction.
 *                  Uses a DB transaction (autoCommit=false / commit / rollback) so if
 *                  any item insert fails the whole order is rolled back. Returns the
 *                  new order's generated ID, or -1 on failure.
 * getTotalRevenue — SUM(total_amount) for all paid orders — shown on the admin dashboard.
 * getTotalOrderCount — COUNT(*) of all orders — shown on the admin dashboard.
 * getMonthlySales — revenue + order count grouped by month for the last N months.
 *                   Used to draw the revenue chart on the admin dashboard (3 / 6 / 12 month views).
 * getUserOrders  — all orders for a specific user, joined with product names from order_items.
 *                  Used on the profile page order history section.
 * getTopProducts — top N products ranked by units sold (via LEFT JOIN with order_items).
 *                  Used for the top products chart on the admin dashboard.
 */
public class OrderDaoImpl implements OrderDao {

    @Override
    public int saveOrder(int userId, double totalAmount, String paymentMethod, List<Object[]> items) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            conn.setAutoCommit(false);

            String orderSql = "INSERT INTO orders (user_id, total_amount, payment_method," +
                    " payment_status, order_status) VALUES (?, ?, ?, 'paid', 'processing')";
            PreparedStatement orderStmt = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
            orderStmt.setInt(1, userId);
            orderStmt.setDouble(2, totalAmount);
            orderStmt.setString(3, paymentMethod);
            orderStmt.executeUpdate();

            ResultSet keys = orderStmt.getGeneratedKeys();
            if (!keys.next()) { conn.rollback(); return -1; }
            int orderId = keys.getInt(1);

            String itemSql = "INSERT INTO order_items (order_id, product_id, quantity," +
                    " unit_price) VALUES (?, ?, ?, ?)";
            PreparedStatement itemStmt = conn.prepareStatement(itemSql);
            for (Object[] item : items) {
                itemStmt.setInt(1, orderId);
                itemStmt.setInt(2, (Integer) item[0]);
                itemStmt.setInt(3, (Integer) item[1]);
                itemStmt.setDouble(4, (Double) item[2]);
                itemStmt.addBatch();
            }
            itemStmt.executeBatch();
            conn.commit();
            return orderId;
        } catch (SQLException e) {
            try {
                if (conn != null){
                    conn.rollback();
                }
            } catch (SQLException ignored) {

            }
            return -1;
        } finally {
            try {
                if (conn != null){
                    conn.setAutoCommit(true);
                }
            } catch (SQLException ignored) {

            }
            DatabaseConnection.closeConnection(conn);
        }
    }

    @Override
    public double getTotalRevenue() {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement("SELECT COALESCE(SUM(total_amount), 0) FROM orders WHERE payment_status = 'paid'");
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getDouble(1);
        } catch (SQLException e) {
            throw new RuntimeException("Error getting revenue", e);
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return 0;
    }

    @Override
    public int getTotalOrderCount() {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM orders");
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            throw new RuntimeException("Error getting order count", e);
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return 0;
    }

    @Override
    public List<Map<String, Object>> getMonthlySales(int months) {
        List<Map<String, Object>> result = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT DATE_FORMAT(created_at, '%b %y') AS month, " +
                         "SUM(total_amount) AS revenue, COUNT(*) AS orders " +
                         "FROM orders " +
                         "WHERE created_at >= DATE_SUB(NOW(), INTERVAL ? MONTH) " +
                         "AND payment_status = 'paid' " +
                         "GROUP BY YEAR(created_at), MONTH(created_at) " +
                         "ORDER BY YEAR(created_at), MONTH(created_at)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, months);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Map<String, Object> row = new LinkedHashMap<>();
                row.put("month", rs.getString("month"));
                row.put("revenue", rs.getDouble("revenue"));
                row.put("orders", rs.getInt("orders"));
                result.add(row);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error getting monthly sales", e);
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return result;
    }

    @Override
    public List<Map<String, Object>> getUserOrders(int userId) {
        List<Map<String, Object>> result = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql =
                "SELECT o.id, o.total_amount, o.payment_method, o.payment_status, " +
                "o.order_status, o.created_at, " +
                "GROUP_CONCAT(p.name ORDER BY oi.id SEPARATOR ', ') AS product_names, " +
                "SUM(oi.quantity) AS total_items " +
                "FROM orders o " +
                "JOIN order_items oi ON o.id = oi.order_id " +
                "JOIN products p ON oi.product_id = p.id " +
                "WHERE o.user_id = ? " +
                "GROUP BY o.id, o.total_amount, o.payment_method, o.payment_status, o.order_status, o.created_at " +
                "ORDER BY o.created_at DESC";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Map<String, Object> row = new LinkedHashMap<>();
                row.put("id",            rs.getInt("id"));
                row.put("totalAmount",   rs.getDouble("total_amount"));
                row.put("paymentMethod", rs.getString("payment_method"));
                row.put("paymentStatus", rs.getString("payment_status"));
                row.put("orderStatus",   rs.getString("order_status"));
                row.put("createdAt",     rs.getTimestamp("created_at"));
                row.put("productNames",  rs.getString("product_names"));
                row.put("totalItems",    rs.getInt("total_items"));
                result.add(row);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error getting user orders", e);
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return result;
    }

    @Override
    public List<Map<String, Object>> getTopProducts(int limit) {
        List<Map<String, Object>> result = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT p.id, p.name, p.brand, p.price, p.rating, p.stock_quantity, " +
                         "COALESCE(SUM(oi.quantity), 0) AS units_sold, " +
                         "COALESCE(SUM(oi.quantity * oi.unit_price), 0) AS revenue " +
                         "FROM products p " +
                         "LEFT JOIN order_items oi ON p.id = oi.product_id " +
                         "GROUP BY p.id, p.name, p.brand, p.price, p.rating, p.stock_quantity " +
                         "ORDER BY units_sold DESC, p.rating DESC " +
                         "LIMIT ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Map<String, Object> row = new LinkedHashMap<>();
                row.put("id", rs.getInt("id"));
                row.put("name", rs.getString("name"));
                row.put("brand", rs.getString("brand"));
                row.put("price", rs.getDouble("price"));
                row.put("rating", rs.getDouble("rating"));
                row.put("stock", rs.getInt("stock_quantity"));
                row.put("unitsSold", rs.getInt("units_sold"));
                row.put("revenue", rs.getDouble("revenue"));
                result.add(row);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error getting top products", e);
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return result;
    }
}
