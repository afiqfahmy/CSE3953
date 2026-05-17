<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.redox.model.Order" %>

<%
    Order order = (Order) request.getAttribute("order");

    String status = order.getStatus();
    String badge = "bg-yellow-100 text-yellow-700";

    if ("Completed".equalsIgnoreCase(status)) {
        badge = "bg-green-100 text-green-700";
    } else if ("Processing".equalsIgnoreCase(status)) {
        badge = "bg-blue-100 text-blue-700";
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Order Details | Redox RX</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
    </head>

    <body class="bg-slate-100">

        <jsp:include page="/partials/sidebar.jsp">
            <jsp:param name="active" value="order"/>
        </jsp:include>

        <main class="pl-60 min-h-screen">
            <div class="max-w-4xl mx-auto p-8">

                <a href="${pageContext.request.contextPath}/OrderServlet?action=list"
                   class="text-blue-600 font-semibold text-sm">
                    ← Back to Orders
                </a>

                <div class="bg-white rounded-2xl shadow-sm mt-6 overflow-hidden">

                    <div class="bg-blue-600 text-white p-8">
                        <p class="text-blue-100 text-sm">Order ID</p>
                        <h1 class="text-3xl font-bold">#<%= order.getOrderId()%></h1>
                        <p class="text-blue-100 mt-2"><%= order.getSupplierName()%></p>
                    </div>

                    <div class="p-8 grid grid-cols-2 gap-6">

                        <div class="bg-slate-50 rounded-2xl p-5">
                            <p class="text-slate-500 text-sm">Supplier Name</p>
                            <h3 class="text-xl font-bold"><%= order.getSupplierName()%></h3>
                        </div>

                        <div class="bg-slate-50 rounded-2xl p-5">
                            <p class="text-slate-500 text-sm">Order Date</p>
                            <h3 class="text-xl font-bold"><%= order.getOrderDate()%></h3>
                        </div>

                        <div class="bg-slate-50 rounded-2xl p-5 col-span-2">
                            <p class="text-slate-500 text-sm">Items Ordered</p>
                            <h3 class="text-xl font-bold whitespace-pre-line"><%= order.getItems()%></h3>
                        </div>

                        <div class="bg-slate-50 rounded-2xl p-5">
                            <p class="text-slate-500 text-sm">Total Amount</p>
                            <h3 class="text-xl font-bold">RM <%= String.format("%.2f", order.getTotalAmount())%></h3>
                        </div>

                        <div class="bg-slate-50 rounded-2xl p-5">
                            <p class="text-slate-500 text-sm">Status</p>
                            <span class="<%= badge%> px-3 py-1 rounded-full text-sm font-semibold">
                                <%= status%>
                            </span>
                        </div>

                    </div>

                    <div class="p-8 border-t flex justify-end gap-3">

                        <a href="${pageContext.request.contextPath}/OrderServlet?action=edit&id=<%= order.getOrderId()%>"
                           class="bg-blue-600 hover:bg-blue-700 text-white px-5 py-3 rounded-xl font-semibold">
                            Edit Order
                        </a>

                        <a href="${pageContext.request.contextPath}/OrderServlet?action=delete&id=<%= order.getOrderId()%>"
                           onclick="return confirm('Delete this order?')"
                           class="bg-red-600 hover:bg-red-700 text-white px-5 py-3 rounded-xl font-semibold">
                            Delete Order
                        </a>

                    </div>

                </div>

            </div>
        </main>

    </body>
</html>