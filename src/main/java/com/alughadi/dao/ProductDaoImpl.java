package com.alughadi.dao;

import com.alughadi.entity.Product;
import com.alughadi.utils.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * ProductDaoImpl — all database operations for products.
 *
 * getAllProducts      — fetch every product joined with its category name,
 *                       ordered by newest first.
 * getProductsByCategory — same join but filtered by category name (case-insensitive).
 * getProductById     — fetch one product by its primary key; returns null if not found.
 * addProduct         — INSERT a new product row with all fields.
 * updateProduct      — UPDATE all product fields by id.
 * deleteProduct      — DELETE a product by id.
 * mapProductFromResultSet — shared helper that maps a ResultSet row to a Product object.
 *                           Called by all the SELECT methods to avoid repeating field reads.
 */
public class ProductDaoImpl implements ProductDAO {

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        Connection conn = null;

        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT product.*, category.name as category_name " +
                    " from products product " +
                    "JOIN categories category ON product.category_id = category.id " +
                    "ORDER BY product.created_at DESC";
            PreparedStatement statement = conn.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                products.add(mapProductFromResultSet(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching all products", e);
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return products;
    }


    public List<Product> getProductsByCategory(String categoryName) {
        List<Product> products = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT p.*, c.name AS category_name " +
                    "FROM products p " +
                    "JOIN categories c ON p.category_id = c.id " +
                    "WHERE LOWER(c.name) = LOWER(?) " +
                    "ORDER BY p.created_at DESC";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, categoryName);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                products.add(mapProductFromResultSet(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching products by category", e);
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return products;
    }

    public Product getProductById(int id) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT p.*, c.name AS category_name " +
                    "FROM products p " +
                    "JOIN categories c ON p.category_id = c.id " +
                    "WHERE p.id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapProductFromResultSet(rs);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching product by id", e);
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return null;
    }

    @Override
    public boolean addProduct(Product product){
        Connection conn = null;
        try{
            conn = DatabaseConnection.getConnection();

            String sql = "INSERT INTO products " +
                    "(category_id, name, brand, description, price, old_price, rating, image_url, in_stock, stock_quantity) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, product.getCategoryId());
            stmt.setString(2, product.getName());
            stmt.setString(3, product.getBrand());
            stmt.setString(4, product.getDescription());
            stmt.setBigDecimal(5, product.getPrice());
            stmt.setBigDecimal(6, product.getOldPrice());
            stmt.setDouble(7, product.getRating());
            stmt.setString(8, product.getImageUrl());
            stmt.setBoolean(9, product.isInStock());
            stmt.setInt(10, product.getStockQuantity());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Error adding product", e);
        } finally {
            DatabaseConnection.closeConnection(conn);
        }

    }

    @Override
    public boolean updateProduct(Product product){
        Connection conn = null;

        try{
            conn = DatabaseConnection.getConnection();

            String sql = "UPDATE products SET " +
                    "category_id = ?, name = ?, brand = ?, description = ?, price = ?, " +
                    "old_price = ?, rating = ?, image_url = ?, in_stock = ?, stock_quantity = ? " +
                    "WHERE id = ?";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, product.getCategoryId());
            stmt.setString(2, product.getName());
            stmt.setString(3, product.getBrand());
            stmt.setString(4, product.getDescription());
            stmt.setBigDecimal(5, product.getPrice());
            stmt.setBigDecimal(6, product.getOldPrice());
            stmt.setDouble(7, product.getRating());
            stmt.setString(8, product.getImageUrl());
            stmt.setBoolean(9, product.isInStock());
            stmt.setInt(10, product.getStockQuantity());
            stmt.setInt(11, product.getId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error updating product", e);
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }

    @Override
    public boolean deleteProduct(int id){
        Connection conn = null;

        try {
            conn = DatabaseConnection.getConnection();

            String sql = "DELETE FROM products WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Error deleting product", e);
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }

    private Product mapProductFromResultSet(ResultSet rs) throws SQLException {
        Product product = new Product();
        product.setId(rs.getInt("id"));
        product.setCategoryId(rs.getInt("category_id"));
        product.setName(rs.getString("name"));
        product.setBrand(rs.getString("brand"));
        product.setDescription(rs.getString("description"));
        product.setPrice(rs.getBigDecimal("price"));
        product.setOldPrice(rs.getBigDecimal("old_price"));
        product.setRating(rs.getDouble("rating"));
        product.setImageUrl(rs.getString("image_url"));
        product.setInStock(rs.getBoolean("in_stock"));
        product.setStockQuantity(rs.getInt("stock_quantity"));
        product.setCreatedAt(rs.getTimestamp("created_at"));
        product.setCategoryName(rs.getString("category_name"));
        return product;
    }
}
