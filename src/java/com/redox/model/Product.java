package com.redox.model;

import java.text.DecimalFormat;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class Product {

    private int productId;
    private String productName;
    private String category;
    private double unitPrice; // selling price
    private int quantity;
    private int threshold;
    private String expiryDate;
    private String supplierName;
    private String status;

    public Product() {
    }

    public Product(int productId, String productName, String category,
            double unitPrice, int quantity, int threshold,
            String expiryDate, String supplierName, String status) {
        this.productId = productId;
        this.productName = productName;
        this.category = category;
        this.unitPrice = unitPrice;
        this.quantity = quantity;
        this.threshold = threshold;
        this.expiryDate = expiryDate;
        this.supplierName = supplierName;
        this.status = status;
    }

    public boolean isLowStock() {
        return quantity <= threshold;
    }

    public String getStockStatus() {

        if ("PENDING_STOCK".equalsIgnoreCase(status)) {
            return "Awaiting Delivery";
        }

        if (quantity <= 0) {
            return "Out of Stock";
        }

        if ("OUT_OF_STOCK".equalsIgnoreCase(status)) {
            return "Out of Stock";
        }

        if (isLowStock()) {
            return "Low Stock";
        }

        return "In Stock";
    }

    public String getFormattedPrice() {
        return new DecimalFormat("0.00").format(unitPrice);
    }

    public int getProductId() {
        return productId;
    }

    public int getId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public String getName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public double getUnitPrice() {
        return unitPrice;
    }

    public double getPrice() {
        return unitPrice;
    }

    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }

    public int getQuantity() {
        return quantity;
    }

    public int getStock() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getThreshold() {
        return threshold;
    }

    public void setThreshold(int threshold) {
        this.threshold = threshold;
    }

    public String getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(String expiryDate) {
        this.expiryDate = expiryDate;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getExpiryStatus() {

        if (expiryDate == null || expiryDate.trim().isEmpty()) {
            return "No Date";
        }

        try {

            LocalDate today = LocalDate.now();
            LocalDate expiry = LocalDate.parse(expiryDate);

            long daysLeft = ChronoUnit.DAYS.between(today, expiry);

            if (daysLeft < 0) {
                return "Expired";
            }

            if (daysLeft <= 30) {
                return "Expiring Soon";
            }

            return "Valid";

        } catch (Exception e) {
            return "Unknown";
        }
    }
}
