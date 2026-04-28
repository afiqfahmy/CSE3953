<%-- 
    Document   : create-order
    Created on : 22 Apr 2026, 4:13:12?pm
    Author     : flora
--%>

<!DOCTYPE html>
<html>
<head>
    <title>Submit New Order | Redox RX</title>
    <link rel="stylesheet" href="style.css">    
</head>
<body>
    <h2>SUBMIT NEW PROCUREMENT ORDER</h2>
    <form action="/orders/save" method="post">
        <label>Select Supplier:</label>
        <select name="supplierId">
            <c:forEach var="s" items="${suppliers}">
                <option value="${s.supplierId}">${s.supplierName}</option>
            </c:forEach>
        </select>

        <h3>Order Items</h3>
        <div id="item-list">
            <div class="row">
                <select name="productId">
                    <c:forEach var="p" items="${products}">
                        <option value="${p.productId}">${p.productName} (Stock: ${p.quantity})</option>
                    </c:forEach>
                </select>
                <input type="number" name="quantity" placeholder="Quantity" min="1">
            </div>
        </div>
        <button type="submit">Confirm and Submit Order</button>
    </form>
</body>
</html>
