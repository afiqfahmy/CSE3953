<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Staff | Product Details</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms"></script>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet"/>
    </head>
    <body class="bg-gray-50">
        <jsp:include page="/partials/sidebar.jsp"><jsp:param name="active" value="product" /></jsp:include>
            <main class="pl-64">
            <jsp:include page="/partials/navbar.jsp" />
            <div class="p-8 mt-16">
                <div class="grid grid-cols-3 gap-6">
                    <div class="col-span-1 space-y-6">
                        <div class="bg-white p-6 rounded-xl shadow-sm border border-gray-200">
                            <h3 class="text-lg font-bold text-gray-800 mb-4 border-bottom pb-2">Product Info</h3>
                            <div class="space-y-3 text-sm">
                                <p><span class="text-gray-500 block">Product ID</span> <span class="font-mono font-bold">#${product.productId}</span></p>
                                <p><span class="text-gray-500 block">Name</span> <span class="font-semibold text-gray-800">${product.productName}</span></p>
                                <p><span class="text-gray-500 block">Category</span> <span>${product.category}</span></p>
                                <p><span class="text-gray-500 block">Price</span> <span class="text-blue-600 font-bold">RM ${product.unitPrice}</span></p>
                            </div>
                            <div class="mt-6 pt-4 border-t">
                                <a href="editProduct.jsp?id=${product.productId}" class="text-center block w-full bg-blue-50 text-blue-600 py-2 rounded-lg font-medium hover:bg-blue-100 transition-colors">Edit Item</a>
                            </div>
                        </div>
                    </div>

                    <div class="col-span-2 space-y-6">
                        <div class="bg-white p-6 rounded-xl shadow-sm border border-gray-200">
                            <h3 class="text-lg font-bold text-gray-800 mb-4">Stock Overview</h3>
                            <div class="flex items-center gap-4">
                                <div class="bg-gray-50 p-4 rounded-lg flex-1 text-center">
                                    <span class="text-gray-500 text-xs uppercase">Current Quantity</span>
                                    <div class="text-3xl font-bold ${product.quantity <= product.threshold ? 'text-red-600' : 'text-gray-800'}">
                                        ${product.quantity}
                                    </div>
                                </div>
                                <div class="bg-gray-50 p-4 rounded-lg flex-1 text-center">
                                    <span class="text-gray-500 text-xs uppercase">Safety Threshold</span>
                                    <div class="text-3xl font-bold text-gray-800">${product.threshold}</div>
                                </div>
                            </div>
                        </div>

                        <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
                            <div class="p-4 border-b bg-gray-50 flex justify-between items-center">
                                <h3 class="font-bold text-gray-800">Recent Stock Transactions</h3>
                                <button class="text-blue-600 text-sm font-medium">+ Record Movement</button>
                            </div>
                            <table class="w-full text-left text-sm">
                                <thead class="bg-gray-100 text-gray-500 uppercase text-[10px] tracking-widest">
                                    <tr>
                                        <th class="p-3">Date</th>
                                        <th class="p-3">Type</th>
                                        <th class="p-3">Quantity</th>
                                        <th class="p-3">User</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y">
                                    <tr class="hover:bg-gray-50">
                                        <td class="p-3 text-gray-400">No logs yet</td>
                                        <td colspan="3" class="p-3"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </body>
</html>