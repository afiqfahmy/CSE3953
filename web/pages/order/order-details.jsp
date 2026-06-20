<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.redox.model.Order" %>
<%@ page import="com.redox.model.OrderItem" %>

<%
    Order order = (Order) request.getAttribute("order");
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

                        <div class="bg-slate-50 rounded-2xl p-5">
                            <p class="text-slate-500 text-sm">Status</p>

                            <%
                                String status = order.getStatus();
                                String badge = "bg-yellow-100 text-yellow-700";

                                if ("Completed".equalsIgnoreCase(status)) {
                                    badge = "bg-green-100 text-green-700";
                                }
                            %>

                            <span class="<%= badge%> px-3 py-1 rounded-full text-sm font-semibold">
                                <%= status%>
                            </span>
                        </div>

                        <div class="bg-slate-50 rounded-2xl p-5">
                            <p class="text-slate-500 text-sm">Total Amount</p>
                            <h3 class="text-xl font-bold text-green-600">
                                RM <%= String.format("%.2f", order.getTotalAmount())%>
                            </h3>
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
                </div>

            </div>

        </main>

    </body>
</html>