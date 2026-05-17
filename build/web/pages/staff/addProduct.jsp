<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Add Product | Redox RX</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
    </head>

    <body class="bg-slate-100">

        <jsp:include page="/partials/product-sidebar.jsp">
            <jsp:param name="active" value="product"/>
        </jsp:include>

        <main class="pl-60 min-h-screen p-8">

            <div class="max-w-3xl mx-auto">

                <div class="mb-6">
                    <a href="${pageContext.request.contextPath}/ProductController?action=list"
                       class="text-blue-600 font-semibold text-sm">
                        ← Back to Products
                    </a>

                    <h1 class="text-3xl font-bold text-slate-800 mt-4">Add New Product</h1>
                    <p class="text-slate-500">Create a new product record for Redox RX inventory.</p>
                </div>

                <form method="POST"
                      action="${pageContext.request.contextPath}/ProductController"
                      class="bg-white rounded-2xl shadow-sm p-8 space-y-6">

                    <input type="hidden" name="action" value="insert">

                    <div>
                        <label class="block text-sm font-semibold text-slate-700 mb-2">Product Name</label>
                        <input type="text" name="productName" required
                               placeholder="Example: Mineral Water 500ml"
                               class="w-full border rounded-xl px-4 py-3 focus:ring-2 focus:ring-blue-500 outline-none">
                    </div>

                    <div>
                        <label class="block text-sm font-semibold text-slate-700 mb-2">Category</label>
                        <select name="category" required
                                class="w-full border rounded-xl px-4 py-3 focus:ring-2 focus:ring-blue-500 outline-none">
                            <option value="">Select category</option>
                            <option value="SNACKS">Snacks</option>
                            <option value="DRINKS">Drinks</option>
                            <option value="INSTANT_FOOD">Instant Food</option>
                            <option value="DAIRY">Dairy</option>
                            <option value="FROZEN">Frozen Food</option>
                            <option value="HOUSEHOLD">Household Items</option>
                        </select>
                    </div>

                    <div class="grid grid-cols-3 gap-4">

                        <div>
                            <label class="block text-sm font-semibold text-slate-700 mb-2">Unit Price (RM)</label>
                            <input type="number" name="unitPrice" step="0.01" min="0" required
                                   placeholder="0.00"
                                   class="w-full border rounded-xl px-4 py-3 focus:ring-2 focus:ring-blue-500 outline-none">
                        </div>

                        <div>
                            <label class="block text-sm font-semibold text-slate-700 mb-2">Quantity</label>
                            <input type="number" name="quantity" min="0" required
                                   placeholder="0"
                                   class="w-full border rounded-xl px-4 py-3 focus:ring-2 focus:ring-blue-500 outline-none">
                        </div>

                        <div>
                            <label class="block text-sm font-semibold text-slate-700 mb-2">Low Stock Threshold</label>
                            <input type="number" name="threshold" min="0" required
                                   placeholder="10"
                                   class="w-full border rounded-xl px-4 py-3 focus:ring-2 focus:ring-blue-500 outline-none">
                        </div>

                    </div>

                    <div class="flex justify-end gap-3 pt-4">

                        <a href="${pageContext.request.contextPath}/ProductController?action=list"
                           class="px-5 py-3 rounded-xl bg-slate-200 text-slate-700 font-semibold">
                            Cancel
                        </a>

                        <button type="submit"
                                class="px-5 py-3 rounded-xl bg-blue-600 hover:bg-blue-700 text-white font-semibold shadow">
                            Save Product
                        </button>

                    </div>

                </form>

            </div>

        </main>

    </body>
</html>