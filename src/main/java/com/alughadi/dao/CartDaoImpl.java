package com.alughadi.dao;

import com.alughadi.entity.Cart;
import com.alughadi.utils.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CartDaoImpl implements CartDao {

    @Override
    public void addToCart(int userId, int productId, int quantity) {
        if (quantity <= 0) {
            return;
        }
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();

            // Check if product already in cart
            String checkSql = "SELECT id FROM cart WHERE user_id = ? AND product_id = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setInt(1, userId);
            checkStmt.setInt(2, productId);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                // Already in cart — increase quantity
                String updateSql = "UPDATE cart c " +
                        "JOIN products p ON c.product_id = p.id " +
                        "SET c.quantity = LEAST(c.quantity + ?, p.stock_quantity) " +
                        "WHERE c.user_id = ? AND c.product_id = ? AND p.stock_quantity > 0";
                PreparedStatement statement = conn.prepareStatement(updateSql);
                statement.setInt(1, quantity);
                statement.setInt(2, userId);
                statement.setInt(3, productId);
                statement.executeUpdate();
            } else {
                // New item — insert
                String insertSql = "INSERT INTO cart (user_id, product_id, quantity) " +
                        "SELECT ?, p.id, LEAST(?, p.stock_quantity) " +
                        "FROM products p WHERE p.id = ? AND p.stock_quantity > 0";
                PreparedStatement statement = conn.prepareStatement(insertSql);
                statement.setInt(1, userId);
                statement.setInt(2, quantity);
                statement.setInt(3, productId);
                statement.executeUpdate();
            }
        } catch (SQLException e) {
            System.out.println("Error adding to cart: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }
    @Override
    public List<Cart> getCartItems(int userId) {
        List<Cart> items = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT c.id, c.user_id, c.product_id, c.quantity, c.created_at, " +
                    "p.name, p.brand, p.image_url, p.price, p.old_price, " +
                    "(p.price * c.quantity) AS total_price " +
                    "FROM cart c join products p ON c.product_id = p.id " +
                    "WHERE c.user_id = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, userId);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Cart cart = new Cart();
                cart.setId(rs.getInt("id"));
                cart.setUserId(rs.getInt("user_id"));
                cart.setProductId(rs.getInt("product_id"));
                cart.setQuantity(rs.getInt("quantity"));
                cart.setCreatedAt(rs.getTimestamp("created_at"));
                cart.setProductName(rs.getString("name"));
                cart.setBrand(rs.getString("brand"));
                cart.setImageUrl(rs.getString("image_url"));
                cart.setPrice(rs.getDouble("price"));
                cart.setOldPrice(rs.getDouble("old_price"));
                cart.setTotalPrice(rs.getDouble("total_price"));
                items.add(cart);
            }
        } catch (SQLException e) {
            System.out.println("Error getting cart items: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return items;
    }
    @Override
    public int getCartCount(int userId) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT SUM(quantity) AS cart_count FROM cart WHERE user_id = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, userId);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) return rs.getInt("cart_count");
        } catch (SQLException e) {
            System.out.println("Error getting cart count: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return 0;
    }
    @Override
    public double getGrandTotal(int userId) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT SUM(p.price * c.quantity) AS grand_total " +
                    "FROM cart c, products p " +
                    "WHERE c.product_id = p.id " +
                    "AND c.user_id = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, userId);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) return rs.getDouble("grand_total");
        } catch (SQLException e) {
            System.out.println("Error getting grand total: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return 0.0;
    }
    @Override
    public void removeFromCart(int cartId, int userId) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "DELETE FROM cart WHERE id = ? AND user_id = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, cartId);
            statement.setInt(2, userId);
            statement.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error removing from cart: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }
    @Override
    public void updateQuantity(int cartId, int userId, int quantity) {
        if (quantity <= 0) {
            removeFromCart(cartId, userId);
            return;
        }
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "UPDATE cart c " +
                    "JOIN products p ON c.product_id = p.id " +
                    "SET c.quantity = LEAST(?, p.stock_quantity) " +
                    "WHERE c.id = ? AND c.user_id = ? AND p.stock_quantity > 0";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, quantity);
            statement.setInt(2, cartId);
            statement.setInt(3, userId);
            statement.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error updating quantity: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }
    @Override
    public void clearCart(int userId) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "DELETE FROM cart WHERE user_id = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, userId);
            statement.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error clearing cart: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }

    @Override
    public List<Integer> getCartProductIds(int userId) {
        List<Integer> productIds = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT product_id FROM cart WHERE user_id = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1,userId);
            ResultSet rs = statement.executeQuery();
            while (rs.next()){
                productIds.add(rs.getInt("product_id"));
            }
        } catch (SQLException e) {
            System.out.println("Error getting cart product ids: " + e.getMessage());
        }
        finally {
            DatabaseConnection.closeConnection(conn);
        }
        return productIds;
    }
}
