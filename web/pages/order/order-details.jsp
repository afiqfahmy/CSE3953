<%-- 
    Document   : order-details
    Created on : 22 Apr 2026, 4:15:02 pm
    Author     : flora
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Submit New Order | Redox RX</title>
    <link rel="stylesheet" href="style.css">    
</head>
<body>
    <h2>ORDER DETAILS: #${order.orderId}</h2>
    <p><strong>Status:</strong> ${order.status}</p>
    <p><strong>Created By:</strong> ${order.adminName}</p> <table border="1">
        <thead>
            <tr>
                <th>Product Name</th>
                <th>Quantity Ordered</th>
                <th>Unit Price</th>
                <th>Subtotal</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${orderItems}">
                <tr>
                    <td>${item.productName}</td>
                    <td>${item.quantity}</td>
                    <td>$${item.price}</td>
                    <td>$${item.quantity * item.price}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <a href="order-list.jsp">Back to List</a>
</body>
</html>
 