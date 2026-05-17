<%-- 
    Document   : history
    Created on : 16 May 2026, 9:36:46 pm
    Author     : AIZAT
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Sale" %>
<%@ page import="java.util.List" %>
<%
    // Set this to "history" so the sidebar knows which tab to highlight
    request.setAttribute("activeMenu", "history");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sales History - Redox RX</title>

        <script src="https://cdn.tailwindcss.com?plugins=forms"></script>
        <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;600;700;800&display=swap" rel="stylesheet"/>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />

        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        fontFamily: {sans: ['Manrope', 'sans-serif'], headline: ['Manrope', 'sans-serif']},
                        colors: {primary: '#3b82f6', 'surface-tint': '#1d4ed8'}
                    }
                }
            }
        </script>
    </head>
    <body class="bg-gray-100 font-sans h-screen overflow-hidden flex">

        <%@ include file="/partials/sidebar.jsp" %>

        <main class="ml-64 flex-1 h-screen overflow-y-auto p-8 bg-gray-50">

            <div class="max-w-6xl mx-auto">
                <div class="flex justify-between items-end mb-8">
                    <div>
                        <h1 class="text-3xl font-extrabold text-gray-800">Sales History</h1>
                        <p class="text-gray-500 font-medium mt-1">View past transactions and receipts</p>
                    </div>
                </div>

                <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
                    <table class="w-full text-left border-collapse">
                        <thead>
                            <tr class="bg-gray-50 border-b border-gray-200 text-gray-500 text-xs uppercase tracking-wider font-extrabold">
                                <th class="p-4 pl-6">Sale ID</th>
                                <th class="p-4">Date</th>
                                <th class="p-4">Total Amount</th>
                                <th class="p-4 text-right pr-6">Status</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-100">
                            <%                            dao.SalesDAO salesDAO = new dao.SalesDAO();
                                List<Sale> pastSales = salesDAO.getAllSalesHistory();

                                if (pastSales != null && !pastSales.isEmpty()) {
                                    for (Sale s : pastSales) {
                            %>
                            <tr class="hover:bg-blue-50/50 transition-colors group cursor-default">
                                <td class="p-4 pl-6">
                                    <span class="font-bold text-gray-800"><%= s.getSaleId()%></span>
                                </td>
                                <td class="p-4 text-gray-600 font-medium">
                                    <%= s.getSaleDate()%>
                                </td>
                                <td class="p-4">
                                    <span class="font-black text-green-600 bg-green-50 px-2 py-1 rounded-md">
                                        RM<%= String.format("%.2f", s.getTotalAmount())%>
                                    </span>
                                </td>
                                <td class="p-4 text-right pr-6">
                                    <span class="inline-flex items-center gap-1 text-xs font-bold text-blue-600 bg-blue-100 px-3 py-1.5 rounded-full">
                                        <span class="material-symbols-outlined text-[14px]">check_circle</span>
                                        Completed
                                    </span>
                                </td>
                                <td class="p-4 text-right pr-6">
                                    <a href="${pageContext.request.contextPath}/pages/sales/receipt.jsp?pastId=<%= s.getSaleId()%>" 
                                       class="inline-flex items-center gap-2 text-xs font-bold text-white bg-blue-600 hover:bg-blue-700 px-4 py-2.5 rounded-lg transition-transform active:scale-95 shadow-sm">
                                        <span class="material-symbols-outlined text-[16px]">receipt</span>
                                        View Receipt
                                    </a>
                                </td>
                            </tr>
                            <%
                                }
                            } else {
                            %>
                            <tr>
                                <td colspan="4" class="p-12 text-center text-gray-400">
                                    <span class="material-symbols-outlined text-4xl mb-2 opacity-50">history_toggle_off</span>
                                    <p class="font-semibold">No past sales found.</p>
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