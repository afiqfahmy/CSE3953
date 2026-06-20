<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.redox.dao.SalesDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.redox.model.Sale" %>

<%
    SalesDAO dao = new SalesDAO();

    double revenue = dao.getTodayRevenue();
    int transactions = dao.getTodayTransactionCount();
    double cash = dao.getTodayCashSales();
    double qr = dao.getTodayQrSales();

    List<Sale> recentSales = dao.getAllSalesHistory();
%>

<!DOCTYPE html>

<html>

    <head>
        <title>Sales Summary Report | Redox RX</title>

        <script src="https://cdn.tailwindcss.com"></script>

        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined"
              rel="stylesheet">

    </head>

    <body class="bg-slate-100">

        ```
        <jsp:include page="/partials/sidebar.jsp">
            <jsp:param name="active" value="dailyreport"/>
        </jsp:include>

        <main class="pl-60 p-8">
            <div class="max-w-7xl mx-auto">
                <h1 class="text-3xl font-bold text-slate-800">
                    Sales Summary Report
                </h1>

                <p class="text-slate-500">
                    Overview of overall sales performance
                </p>

                <!-- Summary Cards -->
                <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-4 gap-6">

                    <div class="bg-white p-6 rounded-2xl shadow-sm">
                        <p class="text-slate-500 text-sm">
                            Revenue
                        </p>

                        <h2 class="text-3xl font-black text-green-600 mt-2">
                            RM <%= String.format("%.2f", revenue)%>
                        </h2>
                    </div>

                    <div class="bg-white p-6 rounded-2xl shadow-sm">
                        <p class="text-slate-500 text-sm">
                            Transactions
                        </p>

                        <h2 class="text-3xl font-black mt-2">
                            <%= transactions%>
                        </h2>
                    </div>

                    <div class="bg-white p-6 rounded-2xl shadow-sm">
                        <p class="text-slate-500 text-sm">
                            Cash Sales
                        </p>

                        <h2 class="text-3xl font-black text-blue-600 mt-2">
                            RM <%= String.format("%.2f", cash)%>
                        </h2>
                    </div>

                    <div class="bg-white p-6 rounded-2xl shadow-sm">
                        <p class="text-slate-500 text-sm">
                            QR Sales
                        </p>

                        <h2 class="text-3xl font-black text-purple-600 mt-2">
                            RM <%= String.format("%.2f", qr)%>
                        </h2>
                    </div>

                </div>

                <div class="mt-8 bg-white rounded-2xl shadow-sm overflow-hidden">

                    <div class="p-6 border-b">
                        <h2 class="text-xl font-bold text-slate-800">
                            Recent Sales
                        </h2>
                    </div>

                    <table class="w-full">

                        <thead class="bg-slate-50 text-slate-500 text-sm">

                            <tr>
                                <th class="p-4 text-left">No.</th>
                                <th class="p-4 text-left">Sale ID</th>
                                <th class="p-4 text-left">Date</th>
                                <th class="p-4 text-left">Amount</th>
                            </tr>

                        </thead>

                        <tbody>

                            <%
                                int index = 1;

                                for (Sale sale : recentSales) {
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

                                <td class="p-4 font-bold text-green-600">
                                    RM <%= String.format("%.2f", sale.getTotalAmount())%>
                                </td>

                            </tr>

                            <%
                                }
                            %>

                        </tbody>

                    </table>

                </div>

            </div>

        </main>
    </body>

</html>
