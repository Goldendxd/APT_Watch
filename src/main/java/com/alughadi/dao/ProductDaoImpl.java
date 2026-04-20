//package com.alughadi.dao;
//
//import com.alughadi.entity.Product;
//import com.alughadi.utils.DatabaseConnection;
//
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.util.ArrayList;
//
//public class ProductDaoImpl {
//
//    private Product mapProductFromResultSet(ResultSet rs) throws SQLException{
//        Product product = new Product();
//        product.setId(rs.getInt("id"));
//        product.setCategoryId(rs.getInt("category_id"));
//        product.setName(rs.getString("name"));
//        product.setBrand(rs.getString("brand"));
//        product.setDescription(rs.getString("description"));
//        product.setPrice(rs.getBigDecimal("price"));
//        product.setOldPrice(rs.getBigDecimal("old_price"));
//        product.setRating(rs.getDouble("rating"));
//        product.setImageUrl(rs.getString("image_url"));
//        product.setInStock(rs.getBoolean("in_stock"));
//        product.setCreatedAt(rs.getTimestamp("created_at"));
//        product.setCategoryName(rs.getString("category_name"));
//        return product;
//    }
//}
//    public ArrayList<Product> getAllProducts(){
//        ArrayList<Product> products = new ArrayList<>();
//        Connection conn = null;
//
//        try{
//            conn = DatabaseConnection.getConnection();
//            String sql = "SELECT product.*, category.name as category_name" +
//                    " from products product" +
//                    "JOIN categories category ON product.category_id = category.id" +
//                    "ORDER BY product.created_at DESC)";
//            PreparedStatement statement = conn.prepareStatement(sql);
//            ResultSet rs = statement.executeQuery();
////            while (rs.next()) {
////                products.add();
////            }
//        } catch (SQLException e) {
//            System.out.println("Error fetching all products; " + e.getMessage());
//        } finally {
//            DatabaseConnection.closeConnection(conn);
//        }
//        return products;
//    }
//    public ArrayList<Product> getProductsByCategory(String categoryName){
//        ArrayList<Product> products = new ArrayList<>();
//        Connection conn = null;
//        try {
//            conn = DatabaseConnection.getConnection();
//            String sql = "SELECT p.*, c.name AS category_name " +
//                    "FROM products p " +
//                    "JOIN categories c ON p.category_id = c.id " +
//                    "WHERE c.name = ? " +
//                    "ORDER BY p.created_at DESC";
//            PreparedStatement statement = conn.prepareStatement(sql);
//            statement.setString(1, categoryName);
//            ResultSet rs = statement.executeQuery();
//            while (rs.next()) {
//                Product product = new Product();
//                product.setId(rs.getInt("id"));
//                product.setCategoryId(rs.getInt("category_id"));
//                product.setName(rs.getString("name"));
//                product.setBrand(rs.getString("brand"));
//                product.setDescription(rs.getString("description"));
//                product.setPrice(rs.getBigDecimal("price"));
//                product.setOldPrice(rs.getBigDecimal("old_price"));
//                product.setRating(rs.getDouble("rating"));
//                product.setImageUrl(rs.getString("image_url"));
//                product.setInStock(rs.getBoolean("in_stock"));
//                product.setCreatedAt(rs.getTimestamp("created_at"));
//                product.setCategoryName(rs.getString("category_name"));
//                products.add(product);
//            }
//    } catch (SQLException e) {
//            throw new RuntimeException(e);
//        }
//    }
