package com.redox.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    // Database credentials
    private static final String URL = "jdbc:mysql://localhost:3306/redox_rx_db";
    private static final String USER = "root";
    private static final String PASS = "toor"; // Replace with the password you set during SQL installation

    public static Connection getConnection() {
        Connection conn = null;
        try {
            // Load the driver manually since we aren't using Maven
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASS);
            System.out.println("Database Connection Successful!");
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Connection Failed! Check console for errors.");
            e.printStackTrace();
        }
        return conn;
    }
}
