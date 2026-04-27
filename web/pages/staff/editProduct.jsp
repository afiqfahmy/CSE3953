<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Edit Product | Redox RX</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>

    <body class="bg-slate-100">

        <jsp:include page="/partials/sidebar.jsp">
            <jsp:param name="active" value="product"/>
        </jsp:include>

        <main class="pl-60 min-h-screen p-8">

            <div class="max-w-3xl mx-auto">

                <a href="${pageContext.request.contextPath}/ProductController?action=list"
                   class="text-blue-600 font-semibold text-sm">
                    ← Back to Products
                </a>

                <h1 class="text-3xl font-bold mt-4">Edit Product</h1>
                <p class="text-slate-500 mb-6">Update existing product data.</p>

                <form method="POST"
                      action="${pageContext.request.contextPath}/ProductController"
                      class="bg-white p-8 rounded-2xl shadow space-y-6">

                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="productId" value="${product.productId}">

                    <div>
                        <label class="font-semibold text-sm">Product Name</label>
                        <input type="text"
                               name="productName"
                               value="${product.productName}"
                               required
                               class="w-full border rounded-xl px-4 py-3 mt-2">
                    </div>

                    <div>
                        <label class="font-semibold text-sm">Category</label>
                        <select name="category"
                                class="w-full border rounded-xl px-4 py-3 mt-2">

                            <option value="SNACKS" ${product.category == 'SNACKS' ? 'selected' : ''}>Snacks</option>
                            <option value="DRINKS" ${product.category == 'DRINKS' ? 'selected' : ''}>Drinks</option>
                            <option value="DAIRY" ${product.category == 'DAIRY' ? 'selected' : ''}>Dairy</option>
                            <option value="FROZEN" ${product.category == 'FROZEN' ? 'selected' : ''}>Frozen</option>

                        </select>
                    </div>

                    <div class="grid grid-cols-3 gap-4">

                        <div>
                            <label class="font-semibold text-sm">Price</label>
                            <input type="number"
                                   step="0.01"
                                   name="unitPrice"
                                   value="${product.unitPrice}"
                                   required
                                   class="w-full border rounded-xl px-4 py-3 mt-2">
                        </div>

                        <div>
                            <label class="font-semibold text-sm">Quantity</label>
                            <input type="number"
                                   name="quantity"
                                   value="${product.quantity}"
                                   required
                                   class="w-full border rounded-xl px-4 py-3 mt-2">
                        </div>

                        <div>
                            <label class="font-semibold text-sm">Threshold</label>
                            <input type="number"
                                   name="threshold"
                                   value="${product.threshold}"
                                   required
                                   class="w-full border rounded-xl px-4 py-3 mt-2">
                        </div>

                    </div>

                    <div class="flex justify-end gap-3 pt-4">

                        <a href="${pageContext.request.contextPath}/ProductController?action=list"
                           class="px-5 py-3 bg-slate-200 rounded-xl font-semibold">
                            Cancel
                        </a>

                        <button type="submit"
                                class="px-5 py-3 bg-blue-600 text-white rounded-xl font-semibold">
                            Update Product
                        </button>

                    </div>

                </form>

            </div>
        </main>

    </body>
</html>