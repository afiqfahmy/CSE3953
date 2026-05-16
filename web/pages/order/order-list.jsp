<%-- 
    Document   : order-list
    Created on : 22 Apr 2026, 4:10:17 pm
    Author     : flora
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Order" %>
<!DOCTYPE html>
<html>
<head>
    <title>Order Management Dashboard</title>
    <style>
        :root { --primary: #4a6fa5; --bg: #f4f6f9; --text: #333; --white: #fff; }
        body { font-family: 'Segoe UI', Arial, sans-serif; background-color: var(--bg); color: var(--text); margin: 0; padding: 20px; }
        .container { max-width: 1100px; margin: 0 auto; }
        header { display: flex; justify-content: space-between; align-items: center; padding-bottom: 20px; border-bottom: 2px solid #ddd; margin-bottom: 20px; }
        h1 { color: var(--primary); margin: 0; }
        .nav-btn { background-color: var(--primary); color: white; padding: 10px 15px; text-decoration: none; border-radius: 4px; font-weight: bold; margin-left: 10px; }
        .nav-btn.alt { background-color: #2ec4b6; }
        table { width: 100%; border-collapse: collapse; background: var(--white); box-shadow: 0 4px 6px rgba(0,0,0,0.05); border-radius: 8px; overflow: hidden; }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #eee; }
        th { background-color: var(--primary); color: white; }
        tr:hover { background-color: #f1f5f9; }
        .status { padding: 5px 10px; border-radius: 20px; font-size: 12px; font-weight: bold; text-align: center; display: inline-block; }
        .status.completed { background-color: #d4edda; color: #155724; }
        .status.pending { background-color: #fff3cd; color: #856404; }
        .status.processing { background-color: #cce5ff; color: #004085; }
        .action-link { color: var(--primary); font-weight: bold; text-decoration: none; }
        .action-link:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>📦 Order Dashboard</h1>
            <div>
                <a href="create-order.jsp" class="nav-btn">+ Create New Order</a>
                <a href="order-report.jsp" class="nav-btn alt">📊 View Sales Report</a>
            </div>
        </header>

        <table>
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Supplier Name</th>
                    <th>Date Ordered</th>
                    <th>Total Price</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    List<Order> orders = (List<Order>) request.getAttribute("orders");
                    if (orders != null && !orders.isEmpty()) {
                        for (Order order : orders) {
                %>
                <tr>
                    <td>#<%= order.getId() %></td>
                    <td><%= order.getSupplierName() %></td>
                    <td><%= order.getOrderDate() %></td>
                    <td>RM <%= String.format("%.2f", order.getTotalAmount()) %></td>
                    <td>
                        <span class="status <%= order.getStatus().toLowerCase() %>">
                            <%= order.getStatus() %>
                        </span>
                    </td>
                    <td>
                        <a href="orders?action=details&id=<%= order.getId() %>" class="action-link">View Details</a>
                    </td>
                </tr>
                <% 
                        }
                    } else {
                %>
                <tr>
                    <td colspan="6" style="text-align: center; color: #666;">No orders found. Add one to begin!</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>