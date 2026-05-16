/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/File.java to edit this template
 */
package model;

/**
 *
 * @author flora
 */
import java.io.Serializable;

public class Order implements Serializable {
    private int id;
    private String supplierName;
    private String itemNames; // E.g., "Chicken Rice x2, Iced Tea x1"
    private double totalAmount;
    private String orderDate;
    private String status;

    // Constructor
    public Order(int id, String supplierName, String itemNames, double totalAmount, String orderDate, String status) {
        this.id = id;
        this.supplierName = supplierName;
        this.itemNames = itemNames;
        this.totalAmount = totalAmount;
        this.orderDate = orderDate;
        this.status = status;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getSupplierName() { return supplierName; }
    public void setSupplierName(String supplierName) { this.supplierName = supplierName; }

    public String getItemNames() { return itemNames; }
    public void setItemNames(String itemNames) { this.itemNames = itemNames; }

    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }

    public String getOrderDate() { return orderDate; }
    public void setOrderDate(String orderDate) { this.orderDate = orderDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}