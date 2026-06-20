package com.redox.dao;

import com.redox.model.Product;
import com.redox.model.OrderedItemSource;
import com.redox.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    private static final String INSERT_PRODUCT_SQL
            = "INSERT INTO products "
            + "(product_name, category, unit_price, quantity, threshold, expiry_date, supplier_name, status) "
            + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

    private static final String SELECT_PRODUCT_BY_ID
            = "SELECT * FROM products WHERE product_id = ?";

    private static final String SELECT_ALL_PRODUCTS
            = "SELECT * FROM products ORDER BY product_name ASC";

    private static final String UPDATE_PRODUCT_SQL
            = "UPDATE products SET "
            + "product_name = ?, "
            + "category = ?, "
            + "unit_price = ?, "
            + "quantity = ?, "
            + "threshold = ?, "
            + "expiry_date = ?, "
            + "supplier_name = ?, "
            + "status = ? "
            + "WHERE product_id = ?";

    private static final String DELETE_PRODUCT_SQL
            = "DELETE FROM products WHERE product_id = ?";

    public void insertProduct(Product product) throws SQLException {
        try (Connection connection = DBConnection.getConnection(); PreparedStatement statement = connection.prepareStatement(INSERT_PRODUCT_SQL)) {

            statement.setString(1, product.getProductName());
            statement.setString(2, product.getCategory());
            statement.setDouble(3, product.getUnitPrice());
            statement.setInt(4, product.getQuantity());
            statement.setInt(5, product.getThreshold());
            statement.setString(6, product.getExpiryDate());
            statement.setString(7, product.getSupplierName());
            statement.setString(8, product.getStatus());

            statement.executeUpdate();
        }
    }

    public List<Product> selectAllProducts() throws SQLException {
        List<Product> products = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection(); PreparedStatement statement = connection.prepareStatement(SELECT_ALL_PRODUCTS); ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                products.add(mapProduct(rs));
            }
        }

        return products;
    }

    public Product selectProduct(int productId) throws SQLException {
        Product product = null;

        try (Connection connection = DBConnection.getConnection(); PreparedStatement statement = connection.prepareStatement(SELECT_PRODUCT_BY_ID)) {

            statement.setInt(1, productId);

            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    product = mapProduct(rs);
                }
            }
        }

        return product;
    }

    public List<Product> searchProducts(String keyword, String category) throws SQLException {
        List<Product> products = new ArrayList<>();

        StringBuilder sql = new StringBuilder("SELECT * FROM products WHERE 1=1");

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND product_name LIKE ?");
        }

        if (category != null && !category.trim().isEmpty() && !"ALL".equalsIgnoreCase(category)) {
            sql.append(" AND category = ?");
        }

        sql.append(" ORDER BY product_name ASC");

        try (Connection connection = DBConnection.getConnection(); PreparedStatement statement = connection.prepareStatement(sql.toString())) {

            int index = 1;

            if (keyword != null && !keyword.trim().isEmpty()) {
                statement.setString(index++, "%" + keyword.trim() + "%");
            }

            if (category != null && !category.trim().isEmpty() && !"ALL".equalsIgnoreCase(category)) {
                statement.setString(index++, category.trim());
            }

            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    products.add(mapProduct(rs));
                }
            }
        }

        return products;
    }

    public boolean updateProduct(Product product) throws SQLException {

        try (Connection connection = DBConnection.getConnection(); PreparedStatement statement = connection.prepareStatement(UPDATE_PRODUCT_SQL)) {

            statement.setString(1, product.getProductName());
            statement.setString(2, product.getCategory());
            statement.setDouble(3, product.getUnitPrice());
            statement.setInt(4, product.getQuantity());
            statement.setInt(5, product.getThreshold());
            statement.setString(6, product.getExpiryDate());
            statement.setString(7, product.getSupplierName());
            statement.setString(8, product.getStatus());
            statement.setInt(9, product.getProductId());

            return statement.executeUpdate() > 0;
        }
    }

    public boolean deleteProduct(int productId) throws SQLException {
        try (Connection connection = DBConnection.getConnection(); PreparedStatement statement = connection.prepareStatement(DELETE_PRODUCT_SQL)) {

            statement.setInt(1, productId);
            return statement.executeUpdate() > 0;
        }
    }

    public List<String> getSupplierNames() throws SQLException {
        List<String> suppliers = new ArrayList<>();

        String sql = "SELECT DISTINCT supplier_name FROM orders WHERE supplier_name IS NOT NULL ORDER BY supplier_name ASC";

        try (Connection connection = DBConnection.getConnection(); PreparedStatement statement = connection.prepareStatement(sql); ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                suppliers.add(rs.getString("supplier_name"));
            }
        }

        return suppliers;
    }

    private Product mapProduct(ResultSet rs) throws SQLException {
        return new Product(
                rs.getInt("product_id"),
                rs.getString("product_name"),
                rs.getString("category"),
                rs.getDouble("unit_price"),
                rs.getInt("quantity"),
                rs.getInt("threshold"),
                rs.getString("expiry_date"),
                rs.getString("supplier_name"),
                rs.getString("status")
        );
    }

    public Product selectProductByName(String productName) throws SQLException {
        String sql = "SELECT * FROM products WHERE LOWER(product_name) = LOWER(?) LIMIT 1";

        try (Connection connection = DBConnection.getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, productName);

            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return mapProduct(rs);
                }
            }
        }

        return null;
    }

    public boolean increaseStockByProductName(String productName, int quantityToAdd)
            throws SQLException {

        String sql
                = "UPDATE products "
                + "SET quantity = quantity + ? "
                + "WHERE LOWER(product_name) = LOWER(?)";

        try (
                Connection connection = DBConnection.getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, quantityToAdd);
            statement.setString(2, productName);

            return statement.executeUpdate() > 0;
        }
    }

    public boolean increaseStockByProductId(int productId, int quantityToAdd) throws SQLException {
        String sql = "UPDATE products SET quantity = quantity + ? WHERE product_id = ?";

        try (Connection connection = DBConnection.getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, quantityToAdd);
            statement.setInt(2, productId);

            return statement.executeUpdate() > 0;
        }
    }

    public List<OrderedItemSource> getCompletedOrderItemsForProduct() throws SQLException {

        List<OrderedItemSource> items = new ArrayList<>();

        String sql
                = "SELECT oi.order_item_id, oi.item_name, o.supplier_name, oi.quantity, oi.unit_price "
                + "FROM order_items oi "
                + "JOIN orders o ON oi.order_id = o.order_id "
                + "WHERE o.status = 'Completed' "
                + "AND NOT EXISTS ( "
                + "    SELECT 1 "
                + "    FROM products p "
                + "    WHERE LOWER(p.product_name) = LOWER(oi.item_name) "
                + ") "
                + "ORDER BY o.order_date DESC";

        try (
                Connection connection = DBConnection.getConnection(); PreparedStatement statement = connection.prepareStatement(sql); ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {

                items.add(
                        new OrderedItemSource(
                                rs.getInt("order_item_id"),
                                rs.getString("item_name"),
                                rs.getString("supplier_name"),
                                rs.getInt("quantity"),
                                rs.getDouble("unit_price")
                        )
                );
            }
        }

        return items;
    }

    public void markOrderItemAsCreated(String itemName) throws SQLException {

        String sql
                = "UPDATE order_items "
                + "SET product_created = 1 "
                + "WHERE item_name = ?";

        try (
                Connection connection = DBConnection.getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, itemName);

            statement.executeUpdate();
        }
    }

    public boolean updateStatus(int productId, String status) throws SQLException {

        String sql = "UPDATE products SET status = ? WHERE product_id = ?";

        try (Connection connection = DBConnection.getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, status);
            statement.setInt(2, productId);

            return statement.executeUpdate() > 0;
        }
    }
}
