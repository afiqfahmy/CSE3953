<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Sale" %>
<%
    Sale sale = (Sale) request.getAttribute("saleDetails");
    String cartItemsJson = (String) request.getAttribute("cartItemsJson");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sale Receipt - Redox RX</title>

        <script src="https://cdn.tailwindcss.com?plugins=forms"></script>
        <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;600;700;800&display=swap" rel="stylesheet"/>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />

        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        fontFamily: {
                            sans: ['Manrope', 'sans-serif'],
                            headline: ['Manrope', 'sans-serif']
                        },
                        colors: {
                            primary: '#3b82f6',
                            'surface-tint': '#1d4ed8'
                        }
                    }
                }
            }
        </script>
    </head>
    <body class="bg-gray-50 text-gray-800 font-sans">

        <%@ include file="/partials/sidebar.jsp" %>

        <main class="ml-64 p-8 min-h-screen flex items-center justify-center">
            <div class="max-w-md w-full bg-white p-8 rounded-lg shadow-lg border border-gray-200 text-center">

                <div class="mb-6 flex justify-center">
                    <svg class="h-16 w-16 text-green-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                    </svg>
                </div>

                <h2 class="text-3xl font-extrabold text-gray-900 mb-2">Sale Successful</h2>
                <p class="text-sm text-gray-500 mb-8">The transaction has been recorded and stock updated.</p>

                <% if (sale != null) {%>
                <div class="bg-gray-50 p-6 rounded-lg text-left border border-gray-100 mb-8">

                    <div class="space-y-3 mb-4">
                        <div class="flex justify-between border-b border-gray-200 pb-2">
                            <span class="text-sm font-semibold text-gray-500">Sale ID:</span>
                            <span class="text-sm font-bold text-gray-900"><%= sale.getSaleId()%></span>
                        </div>
                        <div class="flex justify-between border-b border-gray-200 pb-2">
                            <span class="text-sm font-semibold text-gray-500">Date:</span>
                            <span class="text-sm font-bold text-gray-900"><%= sale.getSaleDate()%></span>
                        </div>
                    </div>

                    <div class="mb-4">
                        <h3 class="text-xs font-extrabold text-gray-400 uppercase tracking-wider mb-3">Items Purchased</h3>
                        <ul id="receiptItemsList" class="space-y-2 border-b border-dashed border-gray-300 pb-4">
                        </ul>
                    </div>

                    <div class="flex justify-between pt-2">
                        <span class="text-base font-bold text-gray-700">Total Amount:</span>
                        <span class="text-xl font-extrabold text-green-600">RM<%= String.format("%.2f", sale.getTotalAmount())%></span>
                    </div>
                </div>
                <% } else { %>
                <div class="bg-red-50 p-4 rounded-lg text-red-600 mb-8 text-sm font-semibold">
                    Error retrieving sale details.
                </div>
                <% }%>

                <a href="pages/sales/sales.jsp" 
                   class="inline-block w-full py-3 px-4 border border-transparent rounded-md shadow-sm text-sm font-bold text-white bg-[#002147] hover:bg-blue-900 focus:outline-none transition-colors">
                    Record Another Sale
                </a>
            </div>
        </main>

        <script>
            // Retrieve the JSON string passed from the Servlet
            const rawCartData = <%= cartItemsJson != null ? cartItemsJson : "[]"%>;
            const listContainer = document.getElementById('receiptItemsList');

            if (rawCartData && rawCartData.length > 0) {
                rawCartData.forEach(item => {
                    const li = document.createElement('li');
                    li.className = 'flex justify-between items-start text-sm';
                    li.innerHTML = `
                        <div class="flex-1 pr-4">
                            <p class="font-bold text-gray-800 leading-tight">` + item.productName + `</p>
                            <p class="text-xs font-semibold text-gray-500 mt-0.5">` + item.quantity + ` x RM` + item.price.toFixed(2) + `</p>
                        </div>
                        <span class="font-bold text-gray-900">RM` + item.total.toFixed(2) + `</span>
                    `;
                    listContainer.appendChild(li);
                });
            } else {
                listContainer.innerHTML = '<li class="text-sm text-gray-500 italic">No item details available.</li>';
            }
        </script>
    </body>
</html>