<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Edit Product | Redox RX</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
    </head>

    <body class="bg-slate-100">

        <jsp:include page="/partials/sidebar.jsp">
            <jsp:param name="active" value="product"/>
        </jsp:include>

        <main class="pl-60 min-h-screen p-8">

            <div class="max-w-4xl mx-auto">

                <a href="${pageContext.request.contextPath}/ProductController?action=list"
                   class="text-blue-600 font-semibold text-sm">
                    ← Back to Products
                </a>

                <h1 class="text-3xl font-bold text-slate-800 mt-4">Edit Product</h1>
                <p class="text-slate-500 mb-6">Update product selling price, supplier, expiry date, and stock data.</p>

                <form method="POST"
                      action="${pageContext.request.contextPath}/ProductController"
                      class="bg-white p-8 rounded-2xl shadow-sm space-y-6">

                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="productId" value="${product.productId}">

                    <div>
                        <label class="block text-sm font-semibold text-slate-700 mb-2">Product Name</label>
                        <input type="text"
                               name="productName"
                               value="${product.productName}"
                               required
                               class="w-full border rounded-xl px-4 py-3 focus:ring-2 focus:ring-blue-500 outline-none">
                    </div>

                    <div class="grid grid-cols-2 gap-4">

                        <div>
                            <label class="block text-sm font-semibold text-slate-700 mb-2">Category</label>
                            <select name="category"
                                    class="w-full border rounded-xl px-4 py-3 focus:ring-2 focus:ring-blue-500 outline-none">

                                <option value="SNACKS" ${product.category == 'SNACKS' ? 'selected' : ''}>Snacks</option>
                                <option value="DRINKS" ${product.category == 'DRINKS' ? 'selected' : ''}>Drinks</option>
                                <option value="INSTANT_FOOD" ${product.category == 'INSTANT_FOOD' ? 'selected' : ''}>Instant Food</option>
                                <option value="DAIRY" ${product.category == 'DAIRY' ? 'selected' : ''}>Dairy</option>
                                <option value="FROZEN" ${product.category == 'FROZEN' ? 'selected' : ''}>Frozen Food</option>
                                <option value="HOUSEHOLD" ${product.category == 'HOUSEHOLD' ? 'selected' : ''}>Household Items</option>

                            </select>
                        </div>

                        <div>
                            <label class="block text-sm font-semibold text-slate-700 mb-2">Supplier Name</label>
                            <select name="supplierName"
                                    class="w-full border rounded-xl px-4 py-3 focus:ring-2 focus:ring-blue-500 outline-none">

                                <option value="">Select supplier</option>

                                <%
                                    List<String> supplierList = (List<String>) request.getAttribute("supplierList");
                                    String selectedSupplier = "";

                                    if (request.getAttribute("product") != null) {
                                        selectedSupplier = ((com.redox.model.Product) request.getAttribute("product")).getSupplierName();
                                        if (selectedSupplier == null) {
                                            selectedSupplier = "";
                                        }
                                    }

                                    if (supplierList != null) {
                                        for (String supplier : supplierList) {
                                %>

                                <option value="<%= supplier%>" <%= supplier.equals(selectedSupplier) ? "selected" : ""%>>
                                    <%= supplier%>
                                </option>

                                <%
                                        }
                                    }
                                %>

                            </select>
                            <p class="text-xs text-slate-400 mt-1">Supplier list is taken from Manage Order.</p>
                        </div>

                    </div>

                    <div class="grid grid-cols-4 gap-4">

                        <div>
                            <label class="block text-sm font-semibold text-slate-700 mb-2">Selling Price (RM)</label>
                            <input type="number"
                                   step="0.01"
                                   min="0"
                                   name="unitPrice"
                                   value="${product.unitPrice}"
                                   required
                                   class="w-full border rounded-xl px-4 py-3 focus:ring-2 focus:ring-blue-500 outline-none">
                        </div>

                        <div>
                            <label class="block text-sm font-semibold text-slate-700 mb-2">Quantity</label>
                            <input type="number"
                                   min="0"
                                   name="quantity"
                                   value="${product.quantity}"
                                   required
                                   class="w-full border rounded-xl px-4 py-3 focus:ring-2 focus:ring-blue-500 outline-none">
                        </div>

                        <div>
                            <label class="block text-sm font-semibold text-slate-700 mb-2">Threshold</label>
                            <input type="number"
                                   min="0"
                                   name="threshold"
                                   value="${product.threshold}"
                                   required
                                   class="w-full border rounded-xl px-4 py-3 focus:ring-2 focus:ring-blue-500 outline-none">
                        </div>

                        <div>
                            <label class="block text-sm font-semibold text-slate-700 mb-2">Expiry Date</label>
                            <input type="date"
                                   name="expiryDate"
                                   value="${product.expiryDate}"
                                   class="w-full border rounded-xl px-4 py-3 focus:ring-2 focus:ring-blue-500 outline-none">
                        </div>

                    </div>

                    <div class="flex justify-end gap-3 pt-4">

                        <a href="${pageContext.request.contextPath}/ProductController?action=list"
                           class="px-5 py-3 bg-slate-200 rounded-xl font-semibold text-slate-700">
                            Cancel
                        </a>

                        <button type="submit"
                                class="px-5 py-3 bg-blue-600 hover:bg-blue-700 text-white rounded-xl font-semibold shadow">
                            Update Product
                        </button>

                    </div>

                </form>

            </div>

        </main>

    </body>
</html>