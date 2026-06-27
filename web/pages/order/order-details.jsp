<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.redox.model.Order" %>
<%@ page import="com.redox.model.OrderItem" %>
<%@ page import="com.redox.model.User" %>

<%
    Order order = (Order) request.getAttribute("order");
    User user = (User) session.getAttribute("user");
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

        <main class="pl-60 min-h-screen p-8">

            <div class="max-w-5xl mx-auto">

                <a href="${pageContext.request.contextPath}/OrderServlet?action=list"
                   class="text-blue-600 font-semibold text-sm">
                    ← Back to Orders
                </a>

                <div class="bg-white rounded-2xl shadow-sm mt-6 overflow-hidden">

                    <div class="p-6 border-b">

                        <div class="p-6">

                            <div class="grid grid-cols-2 gap-6">

                                <div class="bg-slate-50 rounded-2xl p-5">

                                    <h3 class="font-bold text-slate-800 mb-4">
                                        Supplier Information
                                    </h3>

                                    <div class="space-y-3">

                                        <p>
                                            <span class="text-slate-500">Supplier:</span>
                                            <span class="font-semibold ml-2">
                                                <%= order.getSupplierName()%>
                                            </span>
                                        </p>

                                        <p>
                                            <span class="text-slate-500">Order Date:</span>
                                            <span class="font-semibold ml-2">
                                                <%= order.getOrderDate()%>
                                            </span>
                                        </p>

                                    </div>

                                </div>

                                <div class="bg-slate-50 rounded-2xl p-5">

                                    <h3 class="font-bold text-slate-800 mb-4">
                                        Order Summary
                                    </h3>

                                    <div class="bg-slate-50 rounded-2xl p-5">

                                        <p class="text-slate-500 text-sm mb-3">
                                            Order Summary
                                        </p>

                                        <% if (user.getRoleId() == 2) { %>

                                        <% if ("PENDING_PAYMENT".equalsIgnoreCase(order.getStatus())) { %>

                                        <span class="bg-yellow-100 text-yellow-700 px-3 py-1 rounded-full text-sm font-semibold">
                                            PENDING
                                        </span>

                                        <% } else { %>

                                        <span class="bg-green-100 text-green-700 px-3 py-1 rounded-full text-sm font-semibold">
                                            PAID
                                        </span>

                                        <% } %>

                                        <% }%>

                                        <h3 class="text-3xl font-bold text-green-600 mt-3">
                                            RM <%= String.format("%.2f", order.getTotalAmount())%>
                                        </h3>

                                    </div>

                                </div>

                            </div>

                        </div>

                        <div class="flex justify-between items-center">

                            <div>
                                <h1 class="text-2xl font-bold text-slate-800">
                                    Order #<%= order.getOrderId()%>
                                </h1>

                                <p class="text-slate-500">
                                    <%= order.getSupplierName()%>
                                </p>
                            </div>

                        </div>

                    </div>


                    <div class="px-8 pb-8">
                        <h2 class="text-xl font-bold text-slate-800 mb-4">Ordered Items</h2>

                        <div class="border rounded-2xl overflow-hidden">
                            <table class="w-full">
                                <thead class="bg-slate-50 text-slate-600 text-sm">
                                    <tr>
                                        <th class="text-left p-4">No.</th>
                                        <th class="text-left p-4">Item Name</th>
                                        <th class="text-left p-4">Quantity</th>
                                        <th class="text-left p-4">Supplier Price</th>
                                        <th class="text-left p-4">Subtotal</th>
                                    </tr>
                                </thead>

                                <tbody>
                                    <%
                                        if (order.getOrderItems() != null && !order.getOrderItems().isEmpty()) {
                                            int index = 1;

                                            for (OrderItem item : order.getOrderItems()) {
                                    %>

                                    <tr class="border-t">
                                        <td class="p-4 font-semibold"><%= index++%></td>
                                        <td class="p-4"><%= item.getItemName()%></td>
                                        <td class="p-4"><%= item.getQuantity()%></td>
                                        <td class="p-4">RM <%= String.format("%.2f", item.getUnitPrice())%></td>
                                        <td class="p-4 font-bold text-blue-600">
                                            RM <%= String.format("%.2f", item.getSubtotal())%>
                                        </td>
                                    </tr>

                                    <%
                                        }
                                    } else {
                                    %>

                                    <tr>
                                        <td colspan="5" class="p-8 text-center text-slate-400 italic">
                                            No item details found.
                                        </td>
                                    </tr>

                                    <% }%>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="px-8 pb-8 border-t pt-6 flex justify-between items-center">

                        <div>
                            <p class="text-sm text-slate-500">
                                Total Order Value
                            </p>

                            <p class="text-3xl font-bold text-green-600">
                                RM <%= String.format("%.2f", order.getTotalAmount())%>
                            </p>
                        </div>

                        <% if (user.getRoleId() == 2) { %>

                        <% if ("PENDING_PAYMENT".equalsIgnoreCase(order.getStatus())) {%>

                        <div class="flex gap-3">

                            <a href="<%=request.getContextPath()%>/OrderServlet?action=delete&id=<%=order.getOrderId()%>"
                               onclick="return confirm('Delete this supplier order?');"
                               class="bg-red-600 hover:bg-red-700 text-white px-6 py-3 rounded-xl font-semibold">

                                Delete Order

                            </a>

                            <a href="<%=request.getContextPath()%>/ToyyibPayServlet?id=<%=order.getOrderId()%>"
                               class="bg-green-600 hover:bg-green-700 text-white px-6 py-3 rounded-xl font-semibold">

                                Pay Supplier

                            </a>

                        </div>

                        <% } else { %>

                        <span class="bg-green-100 text-green-700 px-5 py-3 rounded-xl font-semibold">
                            ✓ Payment Completed
                        </span>

                        <% } %>

                        <% }%>
                    </div>

                </div>

            </div>

        </main>

    </body>
</html>