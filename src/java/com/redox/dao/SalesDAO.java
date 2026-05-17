package com.redox.dao;

import com.redox.model.Sale;
import com.redox.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SalesDAO {

    public boolean processSale(Sale sale, String cartData) {
        boolean success = false;

        try (Connection conn = DBConnection.getConnection()) {

            conn.setAutoCommit(false);

            String insertSaleSql
                    = "INSERT INTO sales (sale_id, total_amount, receipt_data) VALUES (?, ?, ?)";

            try (PreparedStatement psSale = conn.prepareStatement(insertSaleSql)) {
                psSale.setString(1, sale.getSaleId());
                psSale.setDouble(2, sale.getTotalAmount());
                psSale.setString(3, cartData);
                psSale.executeUpdate();
            }

            String updateStockSql
                    = "UPDATE products SET quantity = quantity - ? WHERE product_id = ? AND quantity >= ?";

            try (PreparedStatement psStock = conn.prepareStatement(updateStockSql)) {

                String cleanData = cartData.trim();

                if (cleanData.startsWith("[")) {
                    cleanData = cleanData.substring(1);
                }

                if (cleanData.endsWith("]")) {
                    cleanData = cleanData.substring(0, cleanData.length() - 1);
                }

                if (!cleanData.trim().isEmpty()) {
                    String[] itemSegments = cleanData.split("\\},\\{");

                    for (String segment : itemSegments) {
                        segment = segment.replace("{", "").replace("}", "");

                        String productIdStr = parseValue(segment, "productId");
                        String quantityStr = parseValue(segment, "quantity");

                        if (productIdStr != null && quantityStr != null) {
                            if (quantityStr.contains(".")) {
                                quantityStr = quantityStr.substring(0, quantityStr.indexOf("."));
                            }

                            int productId = Integer.parseInt(productIdStr.trim());
                            int quantity = Integer.parseInt(quantityStr.trim());

                            psStock.setInt(1, quantity);
                            psStock.setInt(2, productId);
                            psStock.setInt(3, quantity);

                            int affectedRows = psStock.executeUpdate();

                            if (affectedRows == 0) {
                                conn.rollback();
                                return false;
                            }
                        }
                    }
                }
            }

            conn.commit();
            success = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return success;
    }

    public List<Sale> getAllSalesHistory() {
        List<Sale> salesList = new ArrayList<>();

        String sql = "SELECT sale_id, sale_date, total_amount FROM sales ORDER BY sale_date DESC";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                salesList.add(new Sale(
                        rs.getString("sale_id"),
                        rs.getTimestamp("sale_date"),
                        rs.getDouble("total_amount")
                ));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return salesList;
    }

    public String[] getPastReceiptData(String saleId) {
        String[] result = new String[3];

        String sql = "SELECT sale_date, total_amount, receipt_data FROM sales WHERE sale_id = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, saleId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    result[0] = rs.getTimestamp("sale_date").toString();
                    result[1] = String.valueOf(rs.getDouble("total_amount"));
                    result[2] = rs.getString("receipt_data");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }

    private String parseValue(String segment, String key) {
        String searchKey = "\"" + key + "\":";
        int startIdx = segment.indexOf(searchKey);

        if (startIdx == -1) {
            return null;
        }

        startIdx += searchKey.length();

        int endIdx = segment.indexOf(",", startIdx);

        if (endIdx == -1) {
            endIdx = segment.length();
        }

        String value = segment.substring(startIdx, endIdx).trim();

        if (value.startsWith("\"")) {
            value = value.substring(1);
        }

        if (value.endsWith("\"")) {
            value = value.substring(0, value.length() - 1);
        }

        return value;
    }
}
