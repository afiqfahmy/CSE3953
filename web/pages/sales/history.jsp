<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.redox.model.Sale" %>
<%@ page import="com.redox.dao.SalesDAO" %>

<%
    SimpleDateFormat sdf
            = new SimpleDateFormat("dd MMM yyyy, hh:mm a");

    SalesDAO dao = new SalesDAO();
    List<Sale> sales = dao.getAllSalesHistory();

    double totalRevenue = 0;

    for (Sale sale : sales) {
        totalRevenue += sale.getTotalAmount();
    }
%>

<!DOCTYPE html>
<html>
    <head>

        <title>Transaction History | Redox RX</title>

        <script src="https://cdn.tailwindcss.com"></script>

        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined"
              rel="stylesheet">

    </head>

    <body class="bg-slate-100">

        <jsp:include page="/partials/sidebar.jsp">
            <jsp:param name="active" value="history"/>
        </jsp:include>

        <main class="pl-72 p-8">

            <!-- Header -->
            <div class="mb-8">
                <h1 class="text-3xl font-bold text-slate-800">
                    Transaction History
                </h1>

                <p class="text-slate-500">
                    View all recorded sales transactions
                </p>
            </div>

            <!-- Summary Cards -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-6">

                <div class="bg-white p-6 rounded-2xl shadow-sm">
                    <p class="text-slate-500 text-sm">
                        Total Sales
                    </p>

                    <h2 class="text-3xl font-black mt-2">
                        <%= sales.size()%>
                    </h2>
                </div>

                <div class="bg-white p-6 rounded-2xl shadow-sm">
                    <p class="text-slate-500 text-sm">
                        Revenue
                    </p>

                    <h2 class="text-3xl font-black text-green-600 mt-2">
                        RM <%= String.format("%.2f", totalRevenue)%>
                    </h2>
                </div>

                <div class="bg-white p-6 rounded-2xl shadow-sm">
                    <p class="text-slate-500 text-sm">
                        Latest Sale
                    </p>

                    <h2 class="text-xl font-bold mt-2">
                        <%= sales.isEmpty() ? "-" : sales.get(0).getSaleId()%>
                    </h2>
                </div>

            </div>

            <!-- Search Box -->
            <div class="bg-white p-6 rounded-2xl shadow-sm mb-6">

                <input
                    type="text"
                    id="searchSale"
                    placeholder="Search Sale ID..."
                    class="w-full border border-slate-200 rounded-xl px-4 py-3 focus:outline-none focus:ring-2 focus:ring-blue-500">

            </div>

            <!-- Sales Table -->
            <div class="bg-white rounded-2xl shadow-sm overflow-hidden">

                <table class="w-full">

                    <thead class="bg-slate-50 text-slate-500 text-sm">

                        <tr>
                            <th class="p-4 text-left">No.</th>
                            <th class="p-4 text-left">Sale ID</th>
                            <th class="p-4 text-left">Date</th>
                            <th class="p-4 text-right">Amount</th>
                            <th class="p-4 text-right">Action</th>
                        </tr>

                    </thead>

                    <tbody>

                        <%
                            int index = 1;

                            for (Sale sale : sales) {
                        %>

                        <tr class="border-t hover:bg-slate-50 transition">

                            <td class="p-4 font-bold">
                                <%= index++%>
                            </td>

                            <td class="p-4">
                                <span class="bg-slate-100 px-3 py-1 rounded-lg font-mono text-sm">
                                    <%= sale.getSaleId()%>
                                </span>
                            </td>

                            <td class="p-4 text-slate-600">
                                <%= sdf.format(sale.getSaleDate())%>
                            </td>

                            <td class="p-4 text-right font-bold text-green-600">
                                RM <%= String.format("%.2f", sale.getTotalAmount())%>
                            </td>

                            <td class="p-4 text-right">

                                <a href="receipt.jsp?pastId=<%= sale.getSaleId()%>"
                                   class="text-blue-600 font-bold hover:underline">
                                    View Receipt
                                </a>

                            </td>

                        </tr>

                        <% } %>

                        <% if (sales.isEmpty()) { %>

                        <tr>

                            <td colspan="5"
                                class="p-8 text-center text-slate-400">

                                No sales records found.

                            </td>

                        </tr>

                        <% }%>

                    </tbody>

                </table>

            </div>

        </main>

    </body>
</html>