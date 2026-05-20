package com.alughadi.dao;

import com.alughadi.entity.Cart;
import com.alughadi.utils.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * CartDaoImpl — all database operations for the shopping cart.
 *
 * addToCart    — check if the product is already in the user's cart.
 *                If yes, add the quantity to the existing row.
 *                If no, insert a new row.
 * getCartItems — join cart + products to get full item details (name, price,
 *                image, stock_quantity) for every row in the user's cart.
 * getCartCount — SUM(quantity) across all cart rows for this user — used for
 *                the cart badge in the nav.
 * getGrandTotal— SUM(price * quantity) for all items — used in checkout + cart modal.
 * removeFromCart — DELETE one cart row by cartId AND userId (userId prevents
 *                  users deleting each other's items).
 * updateQuantity — UPDATE the quantity on a specific cart row (same userId guard).
 * clearCart    — DELETE all cart rows for this user (called after order is placed).
 * getCartProductIds — return just the list of product IDs in the cart; used to
 *                     highlight "already in cart" products on the product listing page.
 */
public class CartDaoImpl implements CartDao {

    @Override
    public void addToCart(int userId, int productId, int quantity) {
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
                String updateSql = "UPDATE cart SET quantity = quantity + ? WHERE user_id = ? AND product_id = ?";
                PreparedStatement statement = conn.prepareStatement(updateSql);
                statement.setInt(1, quantity);
                statement.setInt(2, userId);
                statement.setInt(3, productId);
                statement.executeUpdate();
            } else {
                // New item — insert
                String insertSql = "INSERT INTO cart (user_id, product_id, quantity) VALUES (?, ?, ?)";
                PreparedStatement statement = conn.prepareStatement(insertSql);
                statement.setInt(1, userId);
                statement.setInt(2, productId);
                statement.setInt(3, quantity);
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
                    "p.name, p.brand, p.image_url, p.price, p.old_price, p.stock_quantity, " +
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
                cart.setStockQuantity(rs.getInt("stock_quantity"));
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
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "UPDATE cart SET quantity = ? WHERE id = ? AND user_id = ?";
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
