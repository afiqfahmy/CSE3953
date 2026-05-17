<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.redox.model.Sale" %>
<%@ page import="com.redox.dao.SalesDAO" %>

<%
    String pastId = request.getParameter("pastId");

    String saleId = "";
    String saleDate = "";
    double total = 0;
    String receiptData = "[]";

    if (pastId != null) {
        SalesDAO dao = new SalesDAO();
        String[] data = dao.getPastReceiptData(pastId);

        if (data[0] != null) {
            saleId = pastId;
            saleDate = data[0];
            total = Double.parseDouble(data[1]);
            receiptData = data[2] != null ? data[2] : "[]";
        }
    } else {
        Sale sale = (Sale) request.getAttribute("saleDetails");

        if (sale != null) {
            saleId = sale.getSaleId();
            saleDate = sale.getSaleDate().toString();
            total = sale.getTotalAmount();

            String cart = (String) request.getAttribute("cartItemsJson");
            receiptData = cart != null ? cart : "[]";
        }
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Receipt | Redox RX</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
    </head>

    <body class="bg-slate-100">

        <jsp:include page="/partials/sales-sidebar.jsp">
            <jsp:param name="active" value="history"/>
        </jsp:include>

        <main class="pl-60 min-h-screen p-8 flex items-center justify-center">

            <div class="max-w-xl w-full bg-white rounded-2xl shadow-sm p-8">

                <div class="text-center mb-8">
                    <h1 class="text-3xl font-black text-slate-800">Receipt</h1>
                    <p class="text-slate-500">Redox RX Inventory System</p>
                </div>

                <div class="space-y-3 mb-6">
                    <div class="flex justify-between">
                        <span class="text-slate-500 font-semibold">Sale ID</span>
                        <span class="font-bold"><%= saleId%></span>
                    </div>

                    <div class="flex justify-between">
                        <span class="text-slate-500 font-semibold">Date</span>
                        <span class="font-bold"><%= saleDate%></span>
                    </div>
                </div>

                <div class="border-t border-b py-5 mb-6">
                    <ul id="receiptItems" class="space-y-4"></ul>
                </div>

                <div class="flex justify-between items-center">
                    <span class="text-xl font-bold">Total</span>
                    <span class="text-3xl font-black text-green-600">
                        RM <%= String.format("%.2f", total)%>
                    </span>
                </div>

                <a href="${pageContext.request.contextPath}/pages/sales/sales.jsp"
                   class="block text-center mt-8 bg-blue-600 hover:bg-blue-700 text-white py-3 rounded-xl font-bold">
                    Back to Sales
                </a>

            </div>

        </main>

        <script>
    const items = <%= receiptData%>;
    const container = document.getElementById("receiptItems");

    if (items && items.length > 0) {
        items.forEach(function (item) {
            container.innerHTML +=
                    '<li class="flex justify-between">' +
                    '<div>' +
                    '<h3 class="font-bold text-slate-800">' + item.productName + '</h3>' +
                    '<p class="text-sm text-slate-500">' +
                    item.quantity + ' × RM ' + item.price.toFixed(2) +
                    '</p>' +
                    '</div>' +
                    '<span class="font-bold">RM ' + item.total.toFixed(2) + '</span>' +
                    '</li>';
        });
    } else {
        container.innerHTML =
                '<li class="text-slate-400 italic text-center">No item details available.</li>';
    }
        </script>

    </body>
</html>