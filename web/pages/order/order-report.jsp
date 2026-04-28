<%-- 
    Document   : order-report
    Created on : 22 Apr 2026, 4:16:06 pm
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
    <h2>PROCUREMENT REPORT</h2>
    <form action="/reports/generate" method="get">
        <label>Select Month:</label>
        <input type="month" name="reportMonth">
        <button type="submit">Generate Summary</button>
    </form>

    <div class="report-results">
        <h3>Usage Summary</h3>
        <p>Total Orders this period: ${totalOrders}</p>
        <p>Total Expenditure: $${totalCost}</p>
        </div>
</body>
</html>
