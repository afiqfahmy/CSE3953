<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.redox.model.Order" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Order Report | Redox RX</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
    </head>

    <body class="bg-slate-100">

        <jsp:include page="/partials/sidebar.jsp">
            <jsp:param name="active" value="report"/>
        </jsp:include>

        <main class="pl-60 min-h-screen">
            <div class="p-8">

                <div class="flex justify-between items-center mb-8">
                    <div>
                        <h1 class="text-3xl font-bold text-slate-800">Order Report</h1>
                        <p class="text-slate-500">Summary of supplier order records</p>
                    </div>
                </div>

                <div class="grid grid-cols-4 gap-5 mb-8">

                    <div class="bg-white p-5 rounded-2xl shadow-sm">
                        <p class="text-slate-500 text-sm">Total Orders</p>
                        <h2 class="text-3xl font-bold">${totalOrders}</h2>
                    </div>

                    <div class="bg-white p-5 rounded-2xl shadow-sm">
                        <p class="text-slate-500 text-sm">Total Amount</p>
                        <h2 class="text-3xl font-bold text-green-600">RM ${totalAmount}</h2>
                    </div>

                    <div class="bg-white p-5 rounded-2xl shadow-sm">
                        <p class="text-slate-500 text-sm">Pending</p>
                        <h2 class="text-3xl font-bold text-yellow-600">${pendingCount}</h2>
                    </div>

                    <div class="bg-white p-5 rounded-2xl shadow-sm">
                        <p class="text-slate-500 text-sm">Completed</p>
                        <h2 class="text-3xl font-bold text-blue-600">${completedCount}</h2>
                    </div>

                </div>

                <div class="bg-white rounded-2xl shadow-sm overflow-hidden">

                    <table class="w-full">

                        <thead class="bg-slate-50 text-slate-600 text-sm">
                            <tr>
                                <th class="p-4 text-left">No.</th>
                                <th class="p-4 text-left">Supplier</th>
                                <th class="p-4 text-left">Amount</th>
                                <th class="p-4 text-left">Status</th>
                            </tr>
                        </thead>

                        <tbody>

                            <%
                                List<Order> orders = (List<Order>) request.getAttribute("orders");

                                if (orders != null && !orders.isEmpty()) {
                                    int index = 1;

                                    for (Order order : orders) {
                            %>

                            <tr class="border-t hover:bg-slate-50">
                                <td class="p-4 font-semibold"><%= index++%></td>
                                <td class="p-4"><%= order.getSupplierName()%></td>
                                <td class="p-4">RM <%= String.format("%.2f", order.getTotalAmount())%></td>
                                <td class="p-4"><%= order.getStatus()%></td>
                            </tr>

                            <%
                                }
                            } else {
                            %>

                            <tr>
                                <td colspan="4" class="p-10 text-center text-slate-400 italic">
                                    No order report data available.
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