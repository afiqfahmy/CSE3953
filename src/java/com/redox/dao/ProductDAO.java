package com.redox.dao;

import com.redox.model.Product;
import com.redox.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    // SQL Queries
    private static final String INSERT_PRODUCT_SQL = "INSERT INTO products (product_name, category, unit_price, quantity, threshold) VALUES (?, ?, ?, ?, ?);";
    private static final String SELECT_PRODUCT_BY_ID = "SELECT * FROM products WHERE product_id = ?;";
    private static final String SELECT_ALL_PRODUCTS = "SELECT * FROM products;";
    private static final String DELETE_PRODUCT_SQL = "DELETE FROM products WHERE product_id = ?;";
    private static final String UPDATE_PRODUCT_SQL = "UPDATE products SET product_name = ?, category = ?, unit_price = ?, quantity = ?, threshold = ? WHERE product_id = ?;";

    // 1. CREATE: Add New Product
    public void insertProduct(Product product) throws SQLException {
        try (Connection connection = DBConnection.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(INSERT_PRODUCT_SQL)) {
            preparedStatement.setString(1, product.getProductName());
            preparedStatement.setString(2, product.getCategory());
            preparedStatement.setDouble(3, product.getUnitPrice());
            preparedStatement.setInt(4, product.getQuantity());
            preparedStatement.setInt(5, product.getThreshold());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 2. READ: Get All Products (For your main table)
    public List<Product> selectAllProducts() {
        List<Product> products = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_PRODUCTS)) {
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("product_id");
                String name = rs.getString("product_name");
                String category = rs.getString("category");
                double price = rs.getDouble("unit_price");
                int qty = rs.getInt("quantity");
                int threshold = rs.getInt("threshold");
                products.add(new Product(id, name, category, price, qty, threshold));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    // 3. READ: Get Single Product (For the Edit form)
    public Product selectProduct(int id) {
        Product product = null;
        try (Connection connection = DBConnection.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(SELECT_PRODUCT_BY_ID)) {
            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                String name = rs.getString("product_name");
                String category = rs.getString("category");
                double price = rs.getDouble("unit_price");
                int qty = rs.getInt("quantity");
                int threshold = rs.getInt("threshold");
                product = new Product(id, name, category, price, qty, threshold);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product;
    }

    // 4. UPDATE: Save changes from Edit form
    public boolean updateProduct(Product product) throws SQLException {
        boolean rowUpdated;
        try (Connection connection = DBConnection.getConnection(); PreparedStatement statement = connection.prepareStatement(UPDATE_PRODUCT_SQL)) {
            statement.setString(1, product.getProductName());
            statement.setString(2, product.getCategory());
            statement.setDouble(3, product.getUnitPrice());
            statement.setInt(4, product.getQuantity());
            statement.setInt(5, product.getThreshold());
            statement.setInt(6, product.getProductId());

            rowUpdated = statement.executeUpdate() > 0;
        }
        return rowUpdated;
    }

    // 5. DELETE: Remove product
    public boolean deleteProduct(int id) throws SQLException {
        boolean rowDeleted;
        try (Connection connection = DBConnection.getConnection(); PreparedStatement statement = connection.prepareStatement(DELETE_PRODUCT_SQL)) {
            statement.setInt(1, id);
            rowDeleted = statement.executeUpdate() > 0;
        }
        return rowDeleted;
    }
}
