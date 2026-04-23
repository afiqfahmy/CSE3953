<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Staff | Add Product</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms"></script>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet"/>
    </head>
    <body class="bg-gray-50">
        <jsp:include page="/partials/sidebar.jsp"><jsp:param name="active" value="product" /></jsp:include>
            <main class="pl-64">
            <jsp:include page="/partials/navbar.jsp" />
            <div class="p-8 mt-16">
                <div class="max-w-2xl mx-auto bg-white rounded-xl shadow-sm border border-gray-200 p-8">
                    <h2 class="text-xl font-bold mb-6">Register New Product</h2>
                    <form action="${pageContext.request.contextPath}/ProductController" method="POST" class="space-y-4">
                        <input type="hidden" name="action" value="insert">

                        <div>
                            <label class="block text-sm font-medium text-gray-700">Product Name</label>
                            <input type="text" name="productName" required class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                        </div>

                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Category</label>
                                <select name="category" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                                    <option value="TABLET">Tablets</option>
                                    <option value="SYRUP">Syrups</option>
                                    <option value="EQUIPMENT">Medical Equipment</option>
                                </select>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Unit Price (RM)</label>
                                <input type="number" step="0.01" name="unitPrice" required class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                            </div>
                        </div>

                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Initial Quantity</label>
                                <input type="number" name="quantity" required class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Low Stock Threshold</label>
                                <input type="number" name="threshold" required class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                            </div>
                        </div>

                        <div class="pt-4 flex gap-3">
                            <button type="submit" class="bg-blue-600 text-white px-6 py-2 rounded-lg hover:bg-blue-700 transition-colors">Save Product</button>
                            <a href="manageProduct.jsp" class="bg-gray-100 text-gray-600 px-6 py-2 rounded-lg hover:bg-gray-200 transition-colors">Cancel</a>
                        </div>
                    </form>
                </div>
            </div>
        </main>
    </body>
</html>