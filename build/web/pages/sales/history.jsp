<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.redox.model.Sale" %>
<%@ page import="com.redox.dao.SalesDAO" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Sales History | Redox RX</title>

        <script src="https://cdn.tailwindcss.com"></script>

        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
    </head>

    <body class="bg-slate-100">

        <jsp:include page="/partials/sidebar.jsp">
            <jsp:param name="active" value="history"/>
        </jsp:include>

        <main class="pl-60 p-8">

            <div class="mb-8">
                <h1 class="text-3xl font-bold text-slate-800">
                    Sales History
                </h1>
            </div>

            <div class="bg-white rounded-2xl shadow-sm overflow-hidden">

                <table class="w-full">

                    <thead class="bg-slate-50 text-slate-500 text-sm">
                        <tr>
                            <th class="p-4 text-left">No.</th>
                            <th class="p-4 text-left">Sale ID</th>
                            <th class="p-4 text-left">Date</th>
                            <th class="p-4 text-left">Amount</th>
                            <th class="p-4 text-right">Action</th>
                        </tr>
                    </thead>

                    <tbody>

                        <%
                            SalesDAO dao = new SalesDAO();

                            List<Sale> sales
                                    = dao.getAllSalesHistory();

                            int index = 1;

                            for (Sale sale : sales) {
                        %>

                        <tr class="border-t">

                            <td class="p-4 font-bold">
                                <%= index++%>
                            </td>

                            <td class="p-4">
                                <%= sale.getSaleId()%>
                            </td>

                            <td class="p-4">
                                <%= sale.getSaleDate()%>
                            </td>

                            <td class="p-4 text-green-600 font-bold">
                                RM <%= String.format("%.2f",
                                        sale.getTotalAmount())%>
                            </td>

                            <td class="p-4 text-right">

                                <a href="receipt.jsp?pastId=<%= sale.getSaleId()%>"
                                   class="text-blue-600 font-bold hover:underline">
                                    View Receipt
                                </a>

                            </td>

                        </tr>

                        <% }%>

                    </tbody>

                </table>

            </div>

        </main>

    </body>
</html>