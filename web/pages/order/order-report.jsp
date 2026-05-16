<%-- 
    Document   : order-report
    Created on : 22 Apr 2026, 4:16:06 pm
    Author     : flora
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Order" %>
<!DOCTYPE html>
<html>
<head>
    <title>Business Metrics Report</title>
    <style>
        body { font-family: 'Segoe UI', Arial, sans-serif; background-color: #f4f6f9; padding: 20px; margin: 0; }
        .container { max-width: 1000px; margin: 0 auto; }
        .grid { display: flex; gap: 20px; margin-bottom: 30px; }
        .card { flex: 1; background: white; padding: 20px; border-radius: 6px; box-shadow: 0 2px 5px rgba(0,0,0,0.05); text-align: center; }
        .card h3 { margin: 0 0 10px 0; color: #666; font-size: 14px; text-transform: uppercase; }
        .card .metric { font-size: 28px; font-weight: bold; color: #4a6fa5; }
        .card .metric.revenue { color: #2ec4b6; }
        .table-title { color: #4a6fa5; border-bottom: 2px solid #ddd; padding-bottom: 8px; margin-top: 30px; }
        table { width: 100%; border-collapse: collapse; background: white; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #eee; }
        th { background-color: #f8f9fa; color: #555; }
        .btn-back { display: inline-block; margin-bottom: 20px; color: #4a6fa5; text-decoration: none; font-weight: bold; }
    </style>
</head>
<body>
    <div class="container">
        <a href="order-list.jsp" class="btn-back">← Back to Dashboard</a>
        <h2 style="color: #333; margin-top: 0;">📊 Operational Summary Performance</h2>
        
        <div class="grid">
            <div class="card">
                <h3>Total Gross Revenue</h3>
                <div class="metric revenue">RM <%= String.format("%.2f", (Double)request.getAttribute("totalRevenue")) %></div>
            </div>
            <div class="card">
                <h3>Total volume processed</h3>
                <div class="metric"><%= request.getAttribute("totalOrders") %> Orders</div>
            </div>
            <div class="card">
                <h3>Awaiting Fulfilment</h3>
                <div class="metric" style="color: #e63946;"><%= request.getAttribute("pendingCount") %> Pending</div>
            </div>
            <div class="card">
                <h3>Successfully Finalized</h3>
                <div class="metric" style="color: #2a9d8f;"><%= request.getAttribute("completedCount") %> Closed</div>
            </div>
        </div>

        <h3 class="table-title">Audit Log Registry Feed</h3>
        <table>
            <thead>
                <tr>
                    <th>Timestamp</th>
                    <th>Invoice Reference</th>
                    <th>Client Identifier</th>
                    <th>Total Remittance</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    List<Order> orders = (List<Order>) request.getAttribute("orders");
                    if(orders != null) {
                        for(Order o : orders) {
                %>
                <tr>
                    <td><%= o.getOrderDate() %></td>
                    <td>#<%= o.getId() %></td>
                    <td><%= o.getSupplierName() %></td>
                    <td style="font-weight: bold;">RM <%= String.format("%.2f", o.getTotalAmount()) %></td>
                </tr>
                <% 
                        }
                    } 
                %>
            </tbody>
        </table>
    </div>
</body>
</html>