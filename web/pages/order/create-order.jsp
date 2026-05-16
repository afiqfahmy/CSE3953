<%-- 
    Document   : create-order
    Created on : 22 Apr 2026, 4:13:12?pm
    Author     : flora
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Create New Order</title>
    <style>
        body { font-family: 'Segoe UI', Arial, sans-serif; background-color: #f4f6f9; margin:0; padding: 40px 20px; }
        .card { max-width: 500px; margin: 0 auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.08); }
        h2 { color: #4a6fa5; margin-top: 0; border-bottom: 2px solid #eee; padding-bottom: 10px; }
        .form-group { margin-bottom: 18px; }
        label { display: block; margin-bottom: 6px; font-weight: 600; color: #555; }
        input[type="text"], input[type="number"], textarea { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; font-size: 14px; }
        textarea { resize: vertical; height: 80px; }
        .btn-group { display: flex; justify-content: space-between; align-items: center; margin-top: 25px; }
        .btn-submit { background-color: #4a6fa5; color: white; border: none; padding: 12px 20px; font-weight: bold; border-radius: 4px; cursor: pointer; }
        .btn-submit:hover { background-color: #3b5984; }
        .btn-cancel { color: #666; text-decoration: none; font-size: 14px; }
        .btn-cancel:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="card">
        <h2>📝 Create New Order</h2>
        <form action="order-list.jsp" method="POST">
            <div class="form-group">
                <label for="SupplierName">Supplier Name</label>
                <input type="text" id="supplierName" name="supplierName" placeholder="Enter full name" required />
            </div>
            <div class="form-group">
                <label for="items">Items Selected</label>
                <textarea id="items" name="items" placeholder="e.g.BBQ Soy Protein Meat x1" required></textarea>
            </div>
            <div class="form-group">
                <label for="amount">Amount</label>
                <input type="number" id="amount" name="amount" step="1" min="0" placeholder="0" required />
            </div>
            <div class="btn-group">
                <a href="order-list.jsp" class="btn-cancel">Back to List</a>
                <button type="submit" class="btn-submit">Submit Order</button>
            </div>
        </form>
    </div>
</body>
</html>