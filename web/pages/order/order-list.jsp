<%-- 
    Document   : order-list
    Created on : 22 Apr 2026, 4:10:17 pm
    Author     : flora
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Order Tracking | Redox RX</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h2>ORDER TRACKING DASHBOARD</h2>
    <div class="actions">
        <a href="create-order.jsp" class="btn">+ Submit New Order</a>
    </div>
    <table border="1">
        <thead>
            <tr>
                <th>Order ID</th> <th>Order Date</th> <th>Supplier</th> <th>Status</th> <th>Admin</th> <th>Operations</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="order" items="${orders}">
                <tr>
                    <td>ORD-${order.orderId}</td>
                    <td>${order.orderDate}</td>
                    <td>${order.supplierName}</td>
                    <td><strong>${order.status}</strong></td>
                    <td>${order.adminName}</td>
                    <td>
                        <a href="order-details.jsp?id=${order.orderId}">View/Check</a> |
                        <c:if test="${order.status == 'Pending'}">
                            <a href="edit-order.jsp?id=${order.orderId}">Correction</a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
