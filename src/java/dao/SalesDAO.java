package dao;

import model.Sale;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class SalesDAO {
    
    public boolean processMultipleSalesManual(Sale sale, String cartData) {
        boolean isSuccess = false;
        Connection conn = DBConnection.getConnection();
        
        try {
            if (conn == null) return false;
            
            conn.setAutoCommit(false); // Start transaction protection
            
            // THE FIX: Using exact column names from your database screenshot
            String insertSale = "INSERT INTO sales (sale_id, sale_date, total_amount) VALUES (?, ?, ?)";
            PreparedStatement psSale = conn.prepareStatement(insertSale);
            psSale.setString(1, sale.getSaleId());
            psSale.setDate(2, new java.sql.Date(sale.getSaleDate().getTime()));
            psSale.setDouble(3, sale.getTotalAmount());
            psSale.executeUpdate();
            
            // Assuming your products table column is 'productId'. 
            // If it is 'product_id', change it here!
            String updateStock = "UPDATE products SET stock = stock - ? WHERE productId = ?";
            PreparedStatement psStock = conn.prepareStatement(updateStock);
            
            String cleanData = cartData.trim();
            if (cleanData.startsWith("[")) cleanData = cleanData.substring(1);
            if (cleanData.endsWith("]")) cleanData = cleanData.substring(0, cleanData.length() - 1);
            
            String[] itemSegments = cleanData.split("\\},\\{");
            
            for (String segment : itemSegments) {
                segment = segment.replace("{", "").replace("}", "");
                
                String productId = parseValue(segment, "productId");
                String quantityStr = parseValue(segment, "quantity");
                
                if (productId != null && quantityStr != null) {
                    if(quantityStr.contains(".")) {
                        quantityStr = quantityStr.substring(0, quantityStr.indexOf("."));
                    }
                    int quantity = Integer.parseInt(quantityStr.trim());
                    
                    psStock.setInt(1, quantity);
                    psStock.setString(2, productId.trim());
                    psStock.executeUpdate();
                }
            }
            
            conn.commit(); 
            isSuccess = true;
            
        } catch (Exception e) {
            System.out.println("DB ERROR: " + e.getMessage());
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return isSuccess;
    }
    
    private String parseValue(String segment, String key) {
        String searchKey = "\"" + key + "\":";
        int startIdx = segment.indexOf(searchKey);
        if (startIdx == -1) return null;
        
        startIdx += searchKey.length();
        int endIdx = segment.indexOf(",", startIdx);
        if (endIdx == -1) endIdx = segment.length();
        
        String val = segment.substring(startIdx, endIdx).trim();
        if (val.startsWith("\"")) val = val.substring(1);
        if (val.endsWith("\"")) val = val.substring(0, val.length() - 1);
        return val;
    }
    
    // Add this method to fetch all past sales
    public java.util.List<model.Sale> getAllSalesHistory() {
        java.util.List<model.Sale> salesList = new java.util.ArrayList<>();
        Connection conn = DBConnection.getConnection();
        
        try {
            if (conn != null) {
                // Fetch all sales, ordering by the newest ones first
                String sql = "SELECT sale_id, sale_date, total_amount FROM sales ORDER BY sale_date DESC";
                PreparedStatement ps = conn.prepareStatement(sql);
                java.sql.ResultSet rs = ps.executeQuery();
                
                while (rs.next()) {
                    String id = rs.getString("sale_id");
                    java.util.Date date = rs.getDate("sale_date");
                    double total = rs.getDouble("total_amount");
                    
                    salesList.add(new model.Sale(id, date, total));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try { if (conn != null) conn.close(); } catch (SQLException e) {}
        }
        return salesList;
    }
}