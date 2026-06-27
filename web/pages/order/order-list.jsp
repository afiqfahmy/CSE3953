<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.redox.model.Order" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Manage Orders | Redox RX</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
    </head>

    <body class="bg-slate-100">

        <jsp:include page="/partials/sidebar.jsp">
            <jsp:param name="active" value="order"/>
        </jsp:include>

        <main class="pl-60 min-h-screen">
            <div class="p-8">

                <div class="flex justify-between items-center mb-8">
                    <div>
                        <h1 class="text-3xl font-bold text-slate-800">Manage Orders</h1>
                        <p class="text-slate-500">Supplier order management for Redox RX</p>
                    </div>

                    <a href="${pageContext.request.contextPath}/OrderServlet?action=create"
                       class="bg-blue-600 hover:bg-blue-700 text-white px-5 py-3 rounded-xl font-semibold shadow">
                        + Create Order
                    </a>
                </div>

                <div class="bg-white rounded-2xl shadow-sm overflow-hidden">

                    <table class="w-full">

                        <thead class="bg-slate-50 text-slate-600 text-sm">
                            <tr>
                                <th class="p-4 text-left">No.</th>
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

                                    int index = 1;

                                    for (Order order : orders) {

                                        String status = order.getStatus();

                                        String displayStatus;
                                        String badge;

                                        if ("PENDING_PAYMENT".equalsIgnoreCase(status)) {

                                            displayStatus = "PENDING";
                                            badge = "bg-yellow-100 text-yellow-700";

                                        } else {

                                            displayStatus = "PAID";
                                            badge = "bg-green-100 text-green-700";

                                        }
                            %>

                            <tr class="border-t hover:bg-slate-50">
                                <td class="p-4 font-semibold"><%= index++%></td>

                                <td class="p-4 text-slate-700">
                                    <%= order.getSupplierName()%>
                                </td>

                                <td class="p-4 text-slate-700">
                                    RM <%= String.format("%.2f", order.getTotalAmount())%>
                                </td>

                                <td class="p-4 text-slate-700">
                                    <%= order.getOrderDate()%>
                                </td>

                                <td class="p-4">
                                    <span class="<%= badge%> px-3 py-1 rounded-full text-sm font-semibold">
                                        <%= displayStatus%>
                                    </span>
                                </td>

                                <td class="p-4 text-right space-x-3">
                                    <a href="${pageContext.request.contextPath}/OrderServlet?action=details&id=<%= order.getOrderId()%>"
                                       class="text-slate-600 font-semibold hover:underline">View</a>
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
        </main>

    </body>
</html>