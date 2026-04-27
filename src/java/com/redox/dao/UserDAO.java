package com.redox.dao;

import com.redox.model.User;
import com.redox.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    public User login(String email, String password) throws SQLException {
        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapUser(rs);
                }
            }
        }

        return null;
    }

    public boolean register(User user) throws SQLException {
        String sql = "INSERT INTO users (name, email, phone, password, role_id) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getPassword());
            ps.setInt(5, user.getRoleId());

            return ps.executeUpdate() > 0;
        }
    }

    public boolean updateProfile(User user) throws SQLException {
        String sql;

        if (user.getPassword() != null && !user.getPassword().trim().isEmpty()) {
            sql = "UPDATE users SET name = ?, phone = ?, password = ? WHERE user_id = ?";
        } else {
            sql = "UPDATE users SET name = ?, phone = ? WHERE user_id = ?";
        }

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getPhone());

            if (user.getPassword() != null && !user.getPassword().trim().isEmpty()) {
                ps.setString(3, user.getPassword());
                ps.setInt(4, user.getUserId());
            } else {
                ps.setInt(3, user.getUserId());
            }

            return ps.executeUpdate() > 0;
        }
    }

    private User mapUser(ResultSet rs) throws SQLException {
        return new User(
                rs.getInt("user_id"),
                rs.getString("name"),
                rs.getString("email"),
                rs.getString("phone"),
                rs.getString("password"),
                rs.getInt("role_id")
        );
    }
}
