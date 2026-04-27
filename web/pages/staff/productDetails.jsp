<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Product Details | Redox RX</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
    </head>

    <body class="bg-slate-100">

        <jsp:include page="/partials/sidebar.jsp">
            <jsp:param name="active" value="product"/>
        </jsp:include>

        <main class="pl-60 min-h-screen p-8">

            <div class="max-w-4xl mx-auto">

                <div class="mb-6">
                    <a href="${pageContext.request.contextPath}/ProductController?action=list"
                       class="text-blue-600 font-semibold text-sm">
                        ← Back to Products
                    </a>

                    <h1 class="text-3xl font-bold text-slate-800 mt-4">Product Details</h1>
                    <p class="text-slate-500">View complete inventory information.</p>
                </div>

                <div class="bg-white rounded-2xl shadow-sm overflow-hidden">

                    <div class="p-8 border-b bg-gradient-to-r from-blue-600 to-blue-800 text-white">

                        <div class="flex justify-between items-start">

                            <div>
                                <p class="text-blue-100 text-sm">Product Name</p>
                                <h2 class="text-3xl font-bold mt-1">${product.productName}</h2>
                                <p class="text-blue-100 mt-2">${product.category}</p>
                            </div>

                            <div>
                                <c:choose>
                                    <c:when test="${product.lowStock}">
                                        <span class="bg-red-100 text-red-700 px-4 py-2 rounded-full text-sm font-bold">
                                            Low Stock
                                        </span>
                                    </c:when>

                                    <c:otherwise>
                                        <span class="bg-green-100 text-green-700 px-4 py-2 rounded-full text-sm font-bold">
                                            In Stock
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                        </div>

                    </div>

                    <div class="p-8 grid grid-cols-2 gap-6">

                        <div class="bg-slate-50 rounded-2xl p-5">
                            <p class="text-slate-500 text-sm">Product ID</p>
                            <h3 class="text-xl font-bold text-slate-800">${product.productId}</h3>
                        </div>

                        <div class="bg-slate-50 rounded-2xl p-5">
                            <p class="text-slate-500 text-sm">Category</p>
                            <h3 class="text-xl font-bold text-slate-800">${product.category}</h3>
                        </div>

                        <div class="bg-slate-50 rounded-2xl p-5">
                            <p class="text-slate-500 text-sm">Unit Price</p>
                            <h3 class="text-xl font-bold text-slate-800">RM ${product.formattedPrice}</h3>
                        </div>

                        <div class="bg-slate-50 rounded-2xl p-5">
                            <p class="text-slate-500 text-sm">Current Quantity</p>
                            <h3 class="text-xl font-bold text-slate-800">${product.quantity} units</h3>
                        </div>

                        <div class="bg-slate-50 rounded-2xl p-5">
                            <p class="text-slate-500 text-sm">Low Stock Threshold</p>
                            <h3 class="text-xl font-bold text-slate-800">${product.threshold} units</h3>
                        </div>

                        <div class="bg-slate-50 rounded-2xl p-5">
                            <p class="text-slate-500 text-sm">Stock Status</p>
                            <h3 class="text-xl font-bold text-slate-800">${product.stockStatus}</h3>
                        </div>

                    </div>

                    <div class="p-8 border-t flex justify-end gap-3">

                        <a href="${pageContext.request.contextPath}/ProductController?action=edit&id=${product.productId}"
                           class="px-5 py-3 rounded-xl bg-blue-600 hover:bg-blue-700 text-white font-semibold shadow">
                            Edit Product
                        </a>

                        <form method="POST"
                              action="${pageContext.request.contextPath}/ProductController">

                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="${product.productId}">

                            <button onclick="return confirm('Delete this product?')"
                                    class="px-5 py-3 rounded-xl bg-red-600 hover:bg-red-700 text-white font-semibold shadow">
                                Delete Product
                            </button>

                        </form>

                    </div>

                </div>

            </div>

        </main>

    </body>
</html>