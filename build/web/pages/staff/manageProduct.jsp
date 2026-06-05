<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Manage Products | Redox RX</title>

        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
    </head>

    <body class="bg-slate-100">

        <jsp:include page="/partials/sidebar.jsp">
            <jsp:param name="active" value="product"/>
        </jsp:include>

        <main class="pl-60 min-h-screen">

            <div class="p-8">

                <!-- Header -->
                <div class="flex justify-between items-center mb-6">

                    <div>
                        <h1 class="text-3xl font-bold text-slate-800">Manage Products</h1>
                        <p class="text-slate-500">Inventory management for Redox RX</p>
                    </div>

                    <c:if test="${sessionScope.user.roleId == 1 || sessionScope.user.roleId == 2}">
                        <a href="${pageContext.request.contextPath}/ProductController?action=add"
                           class="bg-blue-600 hover:bg-blue-700 text-white px-5 py-3 rounded-xl font-semibold shadow-sm">
                            + Add Product
                        </a>
                    </c:if>

                </div>

                <!-- Messages -->
                <c:if test="${param.success == 'added'}">
                    <div class="mb-5 bg-green-100 border border-green-200 text-green-700 px-5 py-4 rounded-xl font-medium">
                        Product added successfully.
                    </div>
                </c:if>

                <c:if test="${param.success == 'updated'}">
                    <div class="mb-5 bg-blue-100 border border-blue-200 text-blue-700 px-5 py-4 rounded-xl font-medium">
                        Product updated successfully.
                    </div>
                </c:if>

                <c:if test="${param.success == 'deleted'}">
                    <div class="mb-5 bg-red-100 border border-red-200 text-red-700 px-5 py-4 rounded-xl font-medium">
                        Product deleted successfully.
                    </div>
                </c:if>

                <!-- Stats -->
                <div class="grid grid-cols-3 gap-5 mb-8">

                    <div class="bg-white p-5 rounded-2xl shadow-sm">
                        <p class="text-slate-500 text-sm">Total Products</p>
                        <h2 class="text-3xl font-bold text-slate-800">${totalProducts}</h2>
                    </div>

                    <div class="bg-white p-5 rounded-2xl shadow-sm">
                        <p class="text-slate-500 text-sm">Low Stock</p>
                        <h2 class="text-3xl font-bold text-red-600">${lowStockCount}</h2>
                    </div>

                    <div class="bg-white p-5 rounded-2xl shadow-sm">
                        <p class="text-slate-500 text-sm">Total Units</p>
                        <h2 class="text-3xl font-bold text-green-600">${totalQuantity}</h2>
                    </div>

                </div>

                <!-- Search -->
                <form method="GET"
                      action="${pageContext.request.contextPath}/ProductController"
                      class="bg-white p-5 rounded-2xl shadow-sm mb-8">

                    <input type="hidden" name="action" value="list">

                    <div class="grid grid-cols-4 gap-4">

                        <input type="text"
                               name="keyword"
                               value="${keyword}"
                               placeholder="Search product..."
                               class="border rounded-xl px-4 py-3 focus:ring-2 focus:ring-blue-500 outline-none">

                        <select name="category"
                                class="border rounded-xl px-4 py-3 focus:ring-2 focus:ring-blue-500 outline-none">

                            <option value="ALL">All Category</option>
                            <option value="SNACKS" ${category == 'SNACKS' ? 'selected' : ''}>Snacks</option>
                            <option value="DRINKS" ${category == 'DRINKS' ? 'selected' : ''}>Drinks</option>
                            <option value="INSTANT_FOOD" ${category == 'INSTANT_FOOD' ? 'selected' : ''}>Instant Food</option>
                            <option value="DAIRY" ${category == 'DAIRY' ? 'selected' : ''}>Dairy</option>
                            <option value="FROZEN" ${category == 'FROZEN' ? 'selected' : ''}>Frozen Food</option>
                            <option value="HOUSEHOLD" ${category == 'HOUSEHOLD' ? 'selected' : ''}>Household Items</option>

                        </select>

                        <button type="submit"
                                class="bg-blue-600 hover:bg-blue-700 text-white rounded-xl font-semibold">
                            Search
                        </button>

                        <a href="${pageContext.request.contextPath}/ProductController?action=list"
                           class="bg-slate-200 hover:bg-slate-300 rounded-xl text-center py-3 font-semibold text-slate-700">
                            Reset
                        </a>

                    </div>

                </form>

                <!-- Product Table -->
                <div class="bg-white rounded-2xl shadow-sm overflow-hidden">

                    <table class="w-full">

                        <thead class="bg-slate-50 border-b text-slate-600 text-sm">

                            <tr>
                                <th class="text-left p-4">Product</th>
                                <th class="text-left p-4">Category</th>
                                <th class="text-left p-4">Supplier</th>
                                <th class="text-left p-4">Selling Price</th>
                                <th class="text-left p-4">Stock</th>
                                <th class="text-left p-4">Expiry Date</th>
                                <th class="text-left p-4">Status</th>
                                <th class="text-right p-4">Action</th>
                            </tr>

                        </thead>

                        <tbody>

                            <c:choose>

                                <c:when test="${not empty productList}">

                                    <c:forEach var="p" items="${productList}">

                                        <tr class="border-t hover:bg-slate-50 transition">

                                            <td class="p-4">

                                                <div class="font-semibold text-slate-800">
                                                    ${p.productName}
                                                </div>

                                                <div class="text-xs text-slate-400">
                                                    Product ID: ${p.productId}
                                                </div>

                                            </td>

                                            <td class="p-4 text-slate-600">
                                                ${p.category}
                                            </td>

                                            <td class="p-4 text-slate-600">

                                                <c:choose>
                                                    <c:when test="${empty p.supplierName}">
                                                        -
                                                    </c:when>

                                                    <c:otherwise>
                                                        ${p.supplierName}
                                                    </c:otherwise>
                                                </c:choose>

                                            </td>

                                            <td class="p-4 font-semibold text-slate-700">
                                                RM ${p.formattedPrice}
                                            </td>

                                            <td class="p-4 text-slate-600">
                                                ${p.quantity}
                                            </td>

                                            <td class="p-4 text-slate-600">

                                                <c:choose>
                                                    <c:when test="${empty p.expiryDate}">
                                                        -
                                                    </c:when>

                                                    <c:otherwise>
                                                        ${p.expiryDate}
                                                    </c:otherwise>
                                                </c:choose>

                                            </td>

                                            <td class="p-4">

                                                <c:choose>

                                                    <c:when test="${p.stockStatus == 'Out of Stock'}">

                                                        <span class="bg-slate-200 text-slate-700 px-3 py-1 rounded-full text-sm font-semibold">
                                                            Out of Stock
                                                        </span>

                                                    </c:when>

                                                    <c:when test="${p.lowStock}">

                                                        <span class="bg-red-100 text-red-600 px-3 py-1 rounded-full text-sm font-semibold">
                                                            Low Stock
                                                        </span>

                                                    </c:when>

                                                    <c:otherwise>

                                                        <span class="bg-green-100 text-green-600 px-3 py-1 rounded-full text-sm font-semibold">
                                                            In Stock
                                                        </span>

                                                    </c:otherwise>

                                                </c:choose>

                                            </td>

                                            <td class="p-4">

                                                <div class="flex justify-end items-center gap-3">

                                                    <a href="${pageContext.request.contextPath}/ProductController?action=view&id=${p.productId}"
                                                       class="text-slate-600 hover:text-slate-800 font-semibold text-sm">
                                                        View
                                                    </a>

                                                    <c:if test="${sessionScope.user.roleId == 1 || sessionScope.user.roleId == 2}">

                                                        <a href="${pageContext.request.contextPath}/ProductController?action=edit&id=${p.productId}"
                                                           class="text-blue-600 hover:text-blue-700 font-semibold text-sm">
                                                            Edit
                                                        </a>

                                                    </c:if>

                                                    <c:if test="${sessionScope.user.roleId == 2}">

                                                        <form method="POST"
                                                              action="${pageContext.request.contextPath}/ProductController"
                                                              class="inline">

                                                            <input type="hidden" name="action" value="delete">
                                                            <input type="hidden" name="id" value="${p.productId}">

                                                            <button type="submit"
                                                                    onclick="return confirm('Delete this product?')"
                                                                    class="text-red-600 hover:text-red-700 font-semibold text-sm">
                                                                Delete
                                                            </button>

                                                        </form>

                                                    </c:if>

                                                </div>

                                            </td>

                                        </tr>

                                    </c:forEach>

                                </c:when>

                                <c:otherwise>

                                    <tr>
                                        <td colspan="8"
                                            class="text-center p-12 text-slate-400 italic">
                                            No products found.
                                        </td>
                                    </tr>

                                </c:otherwise>

                            </c:choose>

                        </tbody>

                    </table>

                </div>

            </div>

        </main>

    </body>
</html>