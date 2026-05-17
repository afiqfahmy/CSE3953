package com.redox.model;

public class Order {

    private int orderId;
    private String supplierName;
    private String items;
    private double totalAmount;
    private String orderDate;
    private String status;

    public Order() {
    }

    public Order(int orderId, String supplierName, String items, double totalAmount, String orderDate, String status) {
        this.orderId = orderId;
        this.supplierName = supplierName;
        this.items = items;
        this.totalAmount = totalAmount;
        this.orderDate = orderDate;
        this.status = status;
    }

    public int getOrderId() {
        return orderId;
    }

    public int getId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    public String getItems() {
        return items;
    }

    public void setItems(String items) {
        this.items = items;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public double getAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public String getStatus() {
        return status;
    }

    public String getStatusClass() {
        if (status == null) {
            return "pending";
        }
        return status.toLowerCase().replace(" ", "-");
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
