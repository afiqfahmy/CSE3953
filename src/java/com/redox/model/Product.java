package com.redox.model;

import java.text.DecimalFormat;

public class Product {

    private int productId;
    private String productName;
    private String category;
    private double unitPrice;
    private int quantity;
    private int threshold;

    public Product() {
    }

    public Product(int productId, String productName, String category, double unitPrice, int quantity, int threshold) {
        this.productId = productId;
        this.productName = productName;
        this.category = category;
        this.unitPrice = unitPrice;
        this.quantity = quantity;
        this.threshold = threshold;
    }

    public boolean isLowStock() {
        return quantity <= threshold;
    }

    public String getStockStatus() {
        if (quantity <= 0) {
            return "Out of Stock";
        } else if (quantity <= threshold) {
            return "Low Stock";
        } else {
            return "In Stock";
        }
    }

    public String getFormattedPrice() {
        DecimalFormat df = new DecimalFormat("0.00");
        return df.format(unitPrice);
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
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

    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }

    public int getQuantity() {
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
}
