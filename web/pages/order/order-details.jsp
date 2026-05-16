<%-- 
    Document   : order-details
    Created on : 22 Apr 2026, 4:15:02 pm
    Author     : flora
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Order" %>
<!DOCTYPE html>
<html>
<head>
    <title>Order Receipt Details</title>
    <style>
        body { font-family: 'Segoe UI', Arial, sans-serif; background-color: #f4f6f9; padding: 40px 20px; }
        .receipt { max-width: 550px; margin: 0 auto; background: white; padding: 30px; border-radius: 4px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); border-top: 8px solid #4a6fa5; }
        .receipt-header { text-align: center; border-bottom: 1px dashed #ccc; padding-bottom: 15px; margin-bottom: 20px; }
        .receipt-header h2 { margin: 5px 0; color: #4a6fa5; }
        .row { display: flex; justify-content: space-between; margin-bottom: 12px; font-size: 15px; }
        .label { color: #777; }
        .value { font-weight: bold; color: #333; }
        .items-box { background: #f8f9fa; padding: 15px; border-radius: 4px; margin: 15px 0; border-left: 3px solid #4a6fa5; font-style: italic; }
        .total-row { border-top: 1px solid #eee; padding-top: 15px; margin-top: 15px; font-size: 18px; }
        .total-val { color: #e63946; font-size: 20px; font-weight: bold; }
        .btn-back { display: block; text-align: center; margin-top: 25px; color: #4a6fa5; text-decoration: none; font-weight: bold; }
    </style>
</head>
<body>
    <% 
        Order order = (Order) request.getAttribute("order");
        if (order != null) {
    %>
    <div class="receipt">
        <div class="receipt-header">
            <h2>Order Invoice Receipt</h2>
            <p style="color: #999; margin:0;">Transaction Verified</p>
        </div>
        
        <div class="row">
            <span class="label">Order reference ID:</span>
            <span class="value">#<%= order.getId() %></span>
        </div>
        <div class="row">
            <span class="label">Customer Account:</span>
            <span class="value"><%= order.getSupplierName() %></span>
        </div>
        <div class="row">
            <span class="label">Timestamp Logged:</span>
            <span class="value"><%= order.getOrderDate() %></span>
        </div>
        <div class="row">
            <span class="label">Fulfilment Status:</span>
            <span class="value" style="color: #2a9d8f;"><%= order.getStatus() %></span>
        </div>

        <p class="label" style="margin-bottom: 5px;">Line Items Summary:</p>
        <div class="items-box">
            <%= order.getItemNames() %>
        </div>

        <div class="row total-row">
            <span class="label" style="font-weight: bold; color: #333;">Total Collected:</span>
            <span class="total-val">RM <%= String.format("%.2f", order.getTotalAmount()) %></span>
        </div>

        <a href="orders?action=list" class="btn-back">← Back to Order Feed</a>
    </div>
    <% } else { %>
        <p style="text-align: center; color: red;">Error: Order reference data could not be parsed.</p>
        <a href="orders?action=list" class="btn-back">Return to Safety</a>
    <% } %>
</body>
</html>