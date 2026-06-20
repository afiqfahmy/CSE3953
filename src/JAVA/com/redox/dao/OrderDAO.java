package com.redox.dao;

import com.redox.model.Order;
import com.redox.model.OrderItem;
import com.redox.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    private static final String INSERT_ORDER
            = "INSERT INTO orders (supplier_name, items, total_amount, status) VALUES (?, ?, ?, ?)";

    private static final String INSERT_ORDER_ITEM
            = "INSERT INTO order_items (order_id, product_id, item_name, quantity, unit_price, subtotal) VALUES (?, ?, ?, ?, ?, ?)";

    private static final String SELECT_ALL_ORDERS
            = "SELECT * FROM orders ORDER BY order_date DESC";

    private static final String SELECT_ORDER_BY_ID
            = "SELECT * FROM orders WHERE order_id = ?";

    private static final String SELECT_ORDER_ITEMS
            = "SELECT * FROM order_items WHERE order_id = ?";

    private static final String UPDATE_ORDER
            = "UPDATE orders SET supplier_name = ?, items = ?, total_amount = ?, status = ? WHERE order_id = ?";

    private static final String DELETE_ORDER_ITEMS
            = "DELETE FROM order_items WHERE order_id = ?";

    private static final String DELETE_ORDER
            = "DELETE FROM orders WHERE order_id = ?";

    public void insertOrder(Order order) throws SQLException {
        Connection conn = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            try (PreparedStatement ps = conn.prepareStatement(INSERT_ORDER, Statement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, order.getSupplierName());
                ps.setString(2, order.getItems());
                ps.setDouble(3, order.getTotalAmount());
                ps.setString(4, order.getStatus());
                ps.executeUpdate();

                try (ResultSet keys = ps.getGeneratedKeys()) {
                    if (keys.next()) {
                        order.setOrderId(keys.getInt(1));
                    }
                }
            }

            insertOrderItems(conn, order);

            conn.commit();

        } catch (SQLException e) {
            if (conn != null) {
                conn.rollback();
            }
            throw e;

        } finally {
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
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
                    order.setOrderItems(getOrderItemsByOrderId(orderId));
                }
            }
        }

        return order;
    }

    public List<OrderItem> getOrderItemsByOrderId(int orderId) throws SQLException {
        List<OrderItem> items = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(SELECT_ORDER_ITEMS)) {

            ps.setInt(1, orderId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    items.add(new OrderItem(
                            rs.getInt("order_item_id"),
                            rs.getInt("order_id"),
                            rs.getInt("product_id"),
                            rs.getString("item_name"),
                            rs.getInt("quantity"),
                            rs.getDouble("unit_price"),
                            rs.getDouble("subtotal")
                    ));
                }
            }
        }

        return items;
    }

    public boolean updateOrder(Order order) throws SQLException {
        Connection conn = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            try (PreparedStatement ps = conn.prepareStatement(UPDATE_ORDER)) {
                ps.setString(1, order.getSupplierName());
                ps.setString(2, order.getItems());
                ps.setDouble(3, order.getTotalAmount());
                ps.setString(4, order.getStatus());
                ps.setInt(5, order.getOrderId());
                ps.executeUpdate();
            }

            try (PreparedStatement ps = conn.prepareStatement(DELETE_ORDER_ITEMS)) {
                ps.setInt(1, order.getOrderId());
                ps.executeUpdate();
            }

            insertOrderItems(conn, order);

            conn.commit();
            return true;

        } catch (SQLException e) {
            if (conn != null) {
                conn.rollback();
            }
            throw e;

        } finally {
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
        }
    }

    public boolean deleteOrder(int orderId) throws SQLException {
        Connection conn = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            try (PreparedStatement ps = conn.prepareStatement(DELETE_ORDER_ITEMS)) {
                ps.setInt(1, orderId);
                ps.executeUpdate();
            }

            boolean deleted;
            try (PreparedStatement ps = conn.prepareStatement(DELETE_ORDER)) {
                ps.setInt(1, orderId);
                deleted = ps.executeUpdate() > 0;
            }

            conn.commit();
            return deleted;

        } catch (SQLException e) {
            if (conn != null) {
                conn.rollback();
            }
            throw e;

        } finally {
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
        }
    }

    private void insertOrderItems(Connection conn, Order order) throws SQLException {
        try (PreparedStatement ps = conn.prepareStatement(INSERT_ORDER_ITEM)) {
            for (OrderItem item : order.getOrderItems()) {
                ps.setInt(1, order.getOrderId());
                ps.setInt(2, item.getProductId());
                ps.setString(3, item.getItemName());
                ps.setInt(4, item.getQuantity());
                ps.setDouble(5, item.getUnitPrice());
                ps.setDouble(6, item.getSubtotal());
                ps.addBatch();
            }
            ps.executeBatch();
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

    public boolean markAsPaid(int orderId) throws SQLException {

        Connection conn = null;

        try {

            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            // Get order and items
            Order order = getOrderById(orderId);

            if (order == null) {
                return false;
            }

            // Update order status
            String sql = "UPDATE orders "
                    + "SET status = 'COMPLETED' "
                    + "WHERE order_id = ?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected == 0) {
                conn.rollback();
                return false;
            }

            // Update stock for all ordered items
            ProductDAO productDAO = new ProductDAO();

            for (OrderItem item : order.getOrderItems()) {

                System.out.println(
                        "Updating Product ID: "
                        + item.getProductId()
                        + " Qty: "
                        + item.getQuantity()
                );

                productDAO.increaseStockByProductId(
                        item.getProductId(),
                        item.getQuantity()
                );
            }

            conn.commit();
            return true;

        } catch (Exception e) {

            if (conn != null) {
                conn.rollback();
            }

            throw new SQLException("Failed to complete supplier payment.", e);

        } finally {

            if (conn != null) {
                conn.close();
            }
        }
    }
}
