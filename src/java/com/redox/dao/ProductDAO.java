package com.redox.dao;

import com.redox.model.Product;
import com.redox.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    private static final String INSERT_PRODUCT_SQL
            = "INSERT INTO products (product_name, category, unit_price, quantity, threshold) VALUES (?, ?, ?, ?, ?)";

    private static final String SELECT_PRODUCT_BY_ID
            = "SELECT * FROM products WHERE product_id = ?";

    private static final String SELECT_ALL_PRODUCTS
            = "SELECT * FROM products ORDER BY product_name ASC";

    private static final String UPDATE_PRODUCT_SQL
            = "UPDATE products SET product_name = ?, category = ?, unit_price = ?, quantity = ?, threshold = ? WHERE product_id = ?";

    private static final String DELETE_PRODUCT_SQL
            = "DELETE FROM products WHERE product_id = ?";

    public void insertProduct(Product product) throws SQLException {
        try (Connection connection = DBConnection.getConnection(); PreparedStatement statement = connection.prepareStatement(INSERT_PRODUCT_SQL)) {

            statement.setString(1, product.getProductName());
            statement.setString(2, product.getCategory());
            statement.setDouble(3, product.getUnitPrice());
            statement.setInt(4, product.getQuantity());
            statement.setInt(5, product.getThreshold());

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
        boolean updated;

        try (Connection connection = DBConnection.getConnection(); PreparedStatement statement = connection.prepareStatement(UPDATE_PRODUCT_SQL)) {

            statement.setString(1, product.getProductName());
            statement.setString(2, product.getCategory());
            statement.setDouble(3, product.getUnitPrice());
            statement.setInt(4, product.getQuantity());
            statement.setInt(5, product.getThreshold());
            statement.setInt(6, product.getProductId());

            updated = statement.executeUpdate() > 0;
        }

        return updated;
    }

    public boolean deleteProduct(int productId) throws SQLException {
        boolean deleted;

        try (Connection connection = DBConnection.getConnection(); PreparedStatement statement = connection.prepareStatement(DELETE_PRODUCT_SQL)) {

            statement.setInt(1, productId);
            deleted = statement.executeUpdate() > 0;
        }

        return deleted;
    }

    private Product mapProduct(ResultSet rs) throws SQLException {
        return new Product(
                rs.getInt("product_id"),
                rs.getString("product_name"),
                rs.getString("category"),
                rs.getDouble("unit_price"),
                rs.getInt("quantity"),
                rs.getInt("threshold")
        );
    }
}
