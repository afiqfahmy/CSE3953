package com.redox.model;

public class OrderedItemSource {

    private int orderItemId;
    private String itemName;
    private String supplierName;
    private int quantity;
    private double supplierPrice;

    public OrderedItemSource() {
    }

    public OrderedItemSource(int orderItemId, String itemName, String supplierName, int quantity, double supplierPrice) {
        this.orderItemId = orderItemId;
        this.itemName = itemName;
        this.supplierName = supplierName;
        this.quantity = quantity;
        this.supplierPrice = supplierPrice;
    }

    public int getOrderItemId() {
        return orderItemId;
    }

    public String getItemName() {
        return itemName;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public int getQuantity() {
        return quantity;
    }

    public double getSupplierPrice() {
        return supplierPrice;
    }
}
