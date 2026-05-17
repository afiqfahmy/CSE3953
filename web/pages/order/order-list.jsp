<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.redox.model.Order" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Manage Orders | Redox RX</title>

        <script src="https://cdn.tailwindcss.com"></script>
    </head>

    <body class="bg-slate-100">

        <div class="max-w-7xl mx-auto p-8">

            <div class="flex justify-between items-center mb-8">
                <div>
                    <h1 class="text-3xl font-bold text-slate-800">Manage Orders</h1>
                    <p class="text-slate-500">Supplier order management system</p>
                </div>

                <a href="${pageContext.request.contextPath}/OrderServlet?action=create"
                   class="bg-blue-600 hover:bg-blue-700 text-white px-5 py-3 rounded-xl font-semibold">
                    + Create Order
                </a>
            </div>

            <div class="bg-white rounded-2xl shadow-sm overflow-hidden">

                <table class="w-full">

                    <thead class="bg-slate-50 text-slate-600">
                        <tr>
                            <th class="p-4 text-left">Order ID</th>
                            <th class="p-4 text-left">Supplier</th>
                            <th class="p-4 text-left">Amount</th>
                            <th class="p-4 text-left">Date</th>
                            <th class="p-4 text-left">Status</th>
                            <th class="p-4 text-right">Action</th>
                        </tr>
                    </thead>

                    <tbody>

                        <%
                            List<Order> orders = (List<Order>) request.getAttribute("orders");

                            if (orders != null && !orders.isEmpty()) {

                                for (Order order : orders) {
                        %>

                        <tr class="border-t hover:bg-slate-50">

                            <td class="p-4 font-semibold">
                                #<%= order.getOrderId()%>
                            </td>

                            <td class="p-4">
                                <%= order.getSupplierName()%>
                            </td>

                            <td class="p-4">
                                RM <%= String.format("%.2f", order.getTotalAmount())%>
                            </td>

                            <td class="p-4">
                                <%= order.getOrderDate()%>
                            </td>

                            <td class="p-4">

                                <%
                                    String status = order.getStatus();

                                    String badge = "bg-yellow-100 text-yellow-700";

                                    if ("Completed".equalsIgnoreCase(status)) {
                                        badge = "bg-green-100 text-green-700";
                                    } else if ("Processing".equalsIgnoreCase(status)) {
                                        badge = "bg-blue-100 text-blue-700";
                                    }
                                %>

                                <span class="<%= badge%> px-3 py-1 rounded-full text-sm font-semibold">
                                    <%= status%>
                                </span>

                            </td>

                            <td class="p-4 text-right space-x-3">

                                <a href="${pageContext.request.contextPath}/OrderServlet?action=details&id=<%= order.getOrderId()%>"
                                   class="text-slate-600 font-semibold hover:underline">
                                    View
                                </a>

                                <a href="${pageContext.request.contextPath}/OrderServlet?action=edit&id=<%= order.getOrderId()%>"
                                   class="text-blue-600 font-semibold hover:underline">
                                    Edit
                                </a>

                                <a href="${pageContext.request.contextPath}/OrderServlet?action=delete&id=<%= order.getOrderId()%>"
                                   onclick="return confirm('Delete this order?')"
                                   class="text-red-600 font-semibold hover:underline">
                                    Delete
                                </a>

                            </td>

                        </tr>

                        <%
                            }

                        } else {
                        %>

                        <tr>
                            <td colspan="6" class="p-10 text-center text-slate-400 italic">
                                No orders found.
                            </td>
                        </tr>

                        <% }%>

                    </tbody>

                </table>

            </div>

        </div>

    </body>
</html>