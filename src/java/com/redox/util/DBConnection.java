package com.redox.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL
            = "jdbc:mysql://localhost:3306/cse3953";

    private static final String USER = "root";

    private static final String PASSWORD = "toor";

    public static Connection getConnection() {

        Connection conn = null;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            conn = DriverManager.getConnection(URL, USER, PASSWORD);

        } catch (ClassNotFoundException | SQLException e) {

            e.printStackTrace();
        }

        return conn;
    }
}
