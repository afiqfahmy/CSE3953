<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Staff | Edit Product</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms"></script>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet"/>
    </head>
    <body class="bg-gray-50">
        <jsp:include page="/partials/sidebar.jsp"><jsp:param name="active" value="product" /></jsp:include>
            <main class="pl-64">
            <jsp:include page="/partials/navbar.jsp" />
            <div class="p-8 mt-16">
                <div class="max-w-2xl mx-auto bg-white rounded-xl shadow-sm border border-gray-200 p-8">
                    <div class="flex items-center gap-2 mb-6 text-gray-600">
                        <a href="manageProduct.jsp" class="hover:text-blue-600 transition-colors">Products</a>
                        <span class="material-symbols-outlined text-sm">chevron_right</span>
                        <span class="font-bold text-gray-800">Edit Product</span>
                    </div>

                    <form action="${pageContext.request.contextPath}/ProductController" method="POST" class="space-y-4">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="productId" value="${product.productId}">

                        <div>
                            <label class="block text-sm font-medium text-gray-700">Product Name</label>
                            <input type="text" name="productName" value="${product.productName}" required 
                                   class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                        </div>

                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Category</label>
                                <select name="category" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                                    <option value="TABLET" ${product.category == 'TABLET' ? 'selected' : ''}>Tablets</option>
                                    <option value="SYRUP" ${product.category == 'SYRUP' ? 'selected' : ''}>Syrups</option>
                                    <option value="EQUIPMENT" ${product.category == 'EQUIPMENT' ? 'selected' : ''}>Medical Equipment</option>
                                </select>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Unit Price (RM)</label>
                                <input type="number" step="0.01" name="unitPrice" value="${product.unitPrice}" required 
                                       class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                            </div>
                        </div>

                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Current Stock</label>
                                <input type="number" name="quantity" value="${product.quantity}" required 
                                       class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Low Stock Threshold</label>
                                <input type="number" name="threshold" value="${product.threshold}" required 
                                       class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                            </div>
                        </div>

                        <div class="pt-6 border-t border-gray-100 flex gap-3">
                            <button type="submit" class="bg-blue-600 text-white px-6 py-2 rounded-lg hover:bg-blue-700 transition-colors flex items-center gap-2">
                                <span class="material-symbols-outlined text-sm">save</span> Update Product
                            </button>
                            <a href="manageProduct.jsp" class="bg-gray-100 text-gray-600 px-6 py-2 rounded-lg hover:bg-gray-200 transition-colors">Cancel</a>
                        </div>
                    </form>
                </div>
            </div>
        </main>
    </body>
</html>