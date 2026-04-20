// package com.alughadi.dao;

// import com.alughadi.entity.Cart;
// import com.alughadi.utils.DatabaseConnection;

// import java.sql.Connection;
// import java.sql.PreparedStatement;
// import java.sql.ResultSet;
// import java.sql.SQLException;
// import java.util.ArrayList;
// import java.util.List;

// public class CartDaoImpl implements CartDao {

//     @Override
//     public void addToCart(int userId, int productId, int quantity) {
//         Connection conn = null;
//         try {
//             conn = DatabaseConnection.getConnection();

//             // Check if product already in cart
//             String checkSql = "SELECT id FROM cart WHERE user_id = ? AND product_id = ?";
//             PreparedStatement checkStmt = conn.prepareStatement(checkSql);
//             checkStmt.setInt(1, userId);
//             checkStmt.setInt(2, productId);
//             ResultSet rs = checkStmt.executeQuery();

//             if (rs.next()) {
//                 // Already in cart — increase quantity
//                 String updateSql = "UPDATE cart SET quantity = quantity + ? WHERE user_id = ? AND product_id = ?";
//                 PreparedStatement statement = conn.prepareStatement(updateSql);
//                 statement.setInt(1, quantity);
//                 statement.setInt(2, userId);
//                 statement.setInt(3, productId);
//                 statement.executeUpdate();
//             } else {
//                 // New item — insert
//                 String insertSql = "INSERT INTO cart (user_id, product_id, quantity) VALUES (?, ?, ?)";
//                 PreparedStatement statement = conn.prepareStatement(insertSql);
//                 statement.setInt(1, userId);
//                 statement.setInt(2, productId);
//                 statement.setInt(3, quantity);
//                 statement.executeUpdate();
//             }
//         } catch (SQLException e) {
//             System.out.println("Error adding to cart: " + e.getMessage());
//         } finally {
//             DatabaseConnection.closeConnection(conn);
//         }
//     }
// }