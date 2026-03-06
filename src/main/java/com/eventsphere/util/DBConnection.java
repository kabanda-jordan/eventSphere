package com.eventsphere.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    // Database configuration with environment variable support
    // Supports both Docker and local XAMPP deployments
    private static final String DB_HOST = System.getenv("DB_HOST") != null ? System.getenv("DB_HOST") : "localhost";
    private static final String DB_PORT = System.getenv("DB_PORT") != null ? System.getenv("DB_PORT") : "3306";
    private static final String DB_NAME = System.getenv("DB_NAME") != null ? System.getenv("DB_NAME") : "eventsphere";
    private static final String USERNAME = System.getenv("DB_USER") != null ? System.getenv("DB_USER") : "root";
    private static final String PASSWORD = System.getenv("DB_PASSWORD") != null ? System.getenv("DB_PASSWORD") : "";
    
    private static final String URL = "jdbc:mysql://" + DB_HOST + ":" + DB_PORT + "/" + DB_NAME 
        + "?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true&autoReconnect=true";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("MySQL Driver loaded successfully");
            System.out.println("Database Configuration:");
            System.out.println("  Host: " + DB_HOST);
            System.out.println("  Port: " + DB_PORT);
            System.out.println("  Database: " + DB_NAME);
            System.out.println("  User: " + USERNAME);
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver not found!");
            throw new RuntimeException("MySQL JDBC Driver not found", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        System.out.println("Attempting to connect to: " + URL);
        System.out.println("Using username: " + USERNAME);
        Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
        System.out.println("Database connection successful!");
        return conn;
    }

    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
