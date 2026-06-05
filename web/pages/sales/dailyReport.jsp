<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.redox.dao.SalesDAO" %>

<%
    SalesDAO dao = new SalesDAO();

    double revenue = dao.getTodayRevenue();

    int transactions
            = dao.getTodayTransactionCount();

    double cash
            = dao.getTodayCashSales();

    double qr
            = dao.getTodayQrSales();
%>

<!DOCTYPE html>
<html>
    <head>

        <title>Daily Cash Flow</title>

        <script src="https://cdn.tailwindcss.com"></script>

        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined"
              rel="stylesheet">

    </head>

    <body class="bg-slate-100">

        <jsp:include page="/partials/sidebar.jsp">
            <jsp:param name="active" value="dailyreport"/>
        </jsp:include>

        <main class="pl-60 p-8">

            <div class="mb-8">
                <h1 class="text-3xl font-bold text-slate-800">
                    Daily Cash Flow Report
                </h1>

                <p class="text-slate-500">
                    Monitor today's sales performance
                </p>
            </div>

            <grid grid-cols-1 md:grid-cols-2 xl:grid-cols-4 gap-6>

                <div class="bg-white p-6 rounded-2xl shadow-sm">
                    <p class="text-slate-500">
                        Revenue
                    </p>

                    <h2 class="text-3xl font-black text-green-600">
                        RM <%= String.format("%.2f", revenue)%>
                    </h2>
                </div>

                <div class="bg-white p-6 rounded-2xl shadow-sm">
                    <p class="text-slate-500">
                        Transactions
                    </p>

                    <h2 class="text-3xl font-black">
                        <%= transactions%>
                    </h2>
                </div>

                <div class="bg-white p-6 rounded-2xl shadow-sm">
                    <p class="text-slate-500">
                        Cash Sales
                    </p>

                    <h2 class="text-3xl font-black text-blue-600">
                        RM <%= String.format("%.2f", cash)%>
                    </h2>
                </div>

                <div class="bg-white p-6 rounded-2xl shadow-sm">
                    <p class="text-slate-500">
                        QR Sales
                    </p>

                    <h2 class="text-3xl font-black text-purple-600">
                        RM <%= String.format("%.2f", qr)%>
                    </h2>
                </div>

                </div>

        </main>

    </body>
</html>