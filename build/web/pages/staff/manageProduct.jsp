<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Staff | Manage Products</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms"></script>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet"/>
    </head>
    <body class="bg-gray-50">
        <jsp:include page="/partials/sidebar.jsp"><jsp:param name="active" value="product" /></jsp:include>

            <main class="pl-64">
            <jsp:include page="/partials/navbar.jsp" />

            <div class="p-8 mt-16">
                <div class="flex justify-between items-center mb-6">
                    <div>
                        <h1 class="text-2xl font-bold text-gray-800">Product Management</h1>
                        <p class="text-gray-600">Manage Redox RX Enterprise stock inventory</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/ProductController?action=add"
                       class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg transition-colors flex items-center gap-2">                        <span class="material-symbols-outlined text-sm">add</span> Add Product
                    </a>
                </div>

                <form method="GET" action="${pageContext.request.contextPath}/ProductController" class="mb-4 flex gap-2">
                    <input type="text" name="keyword" placeholder="Search product name..."
                           class="border border-gray-300 rounded-lg px-4 py-2 w-64 focus:ring-2 focus:ring-blue-500 outline-none">

                    <select name="status" class="border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500">
                        <option value="">All Categories</option>
                        <option value="TABLET">Tablets</option>
                        <option value="SYRUP">Syrups</option>
                        <option value="EQUIPMENT">Medical Equipment</option>
                    </select>

                    <button class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg transition-colors">
                        Search
                    </button>
                </form>

                <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
                    <table class="w-full text-left border-collapse">
                        <thead class="bg-gray-50 text-gray-600 text-sm uppercase tracking-wider">
                            <tr>
                                <th class="p-4 font-semibold">Product Info</th>
                                <th class="p-4 font-semibold">Category</th>
                                <th class="p-4 font-semibold">Price (RM)</th>
                                <th class="p-4 font-semibold">Status</th>
                                <th class="p-4 font-semibold text-right">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-100">
                            <c:forEach var="p" items="${productList}">
                                <tr class="hover:bg-gray-50 transition-colors">
                                    <td class="p-4 font-semibold text-gray-800">
                                        ${p.productName}
                                    </td>

                                    <td class="p-4 text-sm text-gray-600">
                                        ${p.category}
                                    </td>

                                    <td class="p-4 text-sm text-gray-600">
                                        ${p.unitPrice}
                                    </td>

                                    <td class="p-4">
                                        <span class="px-2.5 py-1 rounded-full text-xs font-medium
                                              ${p.quantity > p.threshold ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'}">
                                            ${p.quantity} In Stock
                                        </span>
                                    </td>

                                    <td class="p-4 text-right">
                                        <div class="flex justify-end gap-2">
                                            <a href="${pageContext.request.contextPath}/ProductController?action=edit&id=${p.productId}"
                                               class="text-blue-600 hover:text-blue-800 text-sm font-medium">
                                                Edit
                                            </a>

                                            <form action="${pageContext.request.contextPath}/ProductController" method="POST"
                                                  onsubmit="return confirm('Delete this product?')">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="id" value="${p.productId}">
                                                <button class="text-red-600 hover:text-red-800 text-sm font-medium">
                                                    Delete
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>

                            <c:if test="${empty productList}">
                                <tr>
                                    <td colspan="5" class="p-8 text-center text-gray-500 italic">
                                        No products currently found in inventory.
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </body>
</html>