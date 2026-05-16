/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    // Change "root" and "" to match your local MySQL username and password
    private static final String URL = "jdbc:mysql://localhost:3306/order_db?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root"; 
    private static final String PASSWORD = ""; 

    public static Connection getConnection() {
        Connection connection = null;
        try {
            // Forces the JVM to load the MySQL Driver class safely
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL Driver not found! Did you add the JAR file to WEB-INF/lib?");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Database connection failed! Check if your MySQL server is running.");
            e.printStackTrace();
        }
        return connection;
    }
}
