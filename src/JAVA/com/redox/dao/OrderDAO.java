package com.redox.dao;

import com.redox.model.Order;
import com.redox.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    private static final String INSERT_ORDER
            = "INSERT INTO orders (supplier_name, items, total_amount, status) VALUES (?, ?, ?, ?)";

    private static final String SELECT_ALL_ORDERS
            = "SELECT * FROM orders ORDER BY order_date DESC";

    private static final String SELECT_ORDER_BY_ID
            = "SELECT * FROM orders WHERE order_id = ?";

    private static final String UPDATE_ORDER
            = "UPDATE orders SET supplier_name = ?, items = ?, total_amount = ?, status = ? WHERE order_id = ?";

    private static final String DELETE_ORDER
            = "DELETE FROM orders WHERE order_id = ?";

    public void insertOrder(Order order) throws SQLException {
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(INSERT_ORDER)) {

            ps.setString(1, order.getSupplierName());
            ps.setString(2, order.getItems());
            ps.setDouble(3, order.getTotalAmount());
            ps.setString(4, order.getStatus());

            ps.executeUpdate();
        }
    }

    public List<Order> getAllOrders() throws SQLException {
        List<Order> orders = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(SELECT_ALL_ORDERS); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                orders.add(mapOrder(rs));
            }
        }

        return orders;
    }

    public Order getOrderById(int orderId) throws SQLException {
        Order order = null;

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(SELECT_ORDER_BY_ID)) {

            ps.setInt(1, orderId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    order = mapOrder(rs);
                }
            }
        }

        return order;
    }

    public boolean updateOrder(Order order) throws SQLException {
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(UPDATE_ORDER)) {

            ps.setString(1, order.getSupplierName());
            ps.setString(2, order.getItems());
            ps.setDouble(3, order.getTotalAmount());
            ps.setString(4, order.getStatus());
            ps.setInt(5, order.getOrderId());

            return ps.executeUpdate() > 0;
        }
    }

    public boolean deleteOrder(int orderId) throws SQLException {
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(DELETE_ORDER)) {

            ps.setInt(1, orderId);

            return ps.executeUpdate() > 0;
        }
    }

    private Order mapOrder(ResultSet rs) throws SQLException {
        return new Order(
                rs.getInt("order_id"),
                rs.getString("supplier_name"),
                rs.getString("items"),
                rs.getDouble("total_amount"),
                rs.getString("order_date"),
                rs.getString("status")
        );
    }
}
