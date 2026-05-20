package com.alughadi.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DatabaseConnection — opens and closes MySQL connections for the rest of the app.
 *
 * getConnection()  — returns a new connection each time it's called.
 *                    Every DAO method is responsible for closing its own connection.
 * closeConnection()— wraps connection.close() in a try/catch so DAOs don't have
 *                    to repeat the boilerplate.
 *
 * Connects to the local XAMPP MySQL instance (localhost:3306, database: alughadi,
 * user: root, no password). The MySQL JDBC driver is registered in a static block
 * so it only runs once when the class is first loaded.
 */
public class DatabaseConnection {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/alughadi";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL Driver not found: " + e.getMessage());
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    public static void closeConnection(Connection connection) {
        try {
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            System.out.println("Error closing connection: " + e.getMessage());
        }
    }
}
