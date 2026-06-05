<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.redox.model.OrderedItemSource" %>

<%
    List<OrderedItemSource> orderedItemList
            = (List<OrderedItemSource>) request.getAttribute("orderedItemList");
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Add Product | Redox RX</title>

        <script src="https://cdn.tailwindcss.com"></script>

        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined"
              rel="stylesheet">
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

                    <h1 class="text-4xl font-black text-slate-800 mt-4">
                        Add New Product
                    </h1>

                    <p class="text-slate-500 mt-2">
                        Create a product from supplier ordered items.
                    </p>

                </div>

                <form method="POST"
                      action="${pageContext.request.contextPath}/ProductController"
                      class="bg-white rounded-3xl shadow-sm p-8 space-y-8">

                    <input type="hidden" name="action" value="insert">

                    <!-- ORDER ITEM -->

                    <div>

                        <label class="block text-sm font-bold text-slate-700 mb-2">
                            Ordered Item
                        </label>

                        <select id="orderedItemSelect"
                                onchange="fillOrderData(this)"
                                class="w-full border rounded-2xl px-4 py-3 focus:ring-2 focus:ring-blue-500 outline-none">

                            <option value="">Select ordered item</option>

                            <%
                                if (orderedItemList != null) {
                                    for (OrderedItemSource item : orderedItemList) {
                            %>

                            <option
                                value="<%= item.getItemName()%>"
                                data-supplier="<%= item.getSupplierName()%>"
                                data-quantity="<%= item.getQuantity()%>"
                                data-supplierprice="<%= item.getSupplierPrice()%>">

                                <%= item.getItemName()%> - Supplier: <%= item.getSupplierName()%>

                            </option>

                            <%
                                    }
                                }
                            %>

                        </select>

                    </div>

                    <!-- PRODUCT NAME -->

                    <div>

                        <label class="block text-sm font-bold text-slate-700 mb-2">
                            Product Name
                        </label>

                        <input type="text"
                               id="productName"
                               name="productName"
                               required
                               placeholder="Example: MAGGI 2-Minit Kari"
                               class="w-full border rounded-2xl px-4 py-3 focus:ring-2 focus:ring-blue-500 outline-none">

                    </div>

                    <!-- CATEGORY + SUPPLIER -->

                    <div class="grid grid-cols-2 gap-5">

                        <div>

                            <label class="block text-sm font-bold text-slate-700 mb-2">
                                Category
                            </label>

                            <select name="category"
                                    required
                                    class="w-full border rounded-2xl px-4 py-3 focus:ring-2 focus:ring-blue-500 outline-none">

                                <option value="">Select category</option>

                                <option value="SNACKS">Snacks</option>
                                <option value="DRINKS">Drinks</option>
                                <option value="INSTANT_FOOD">Instant Food</option>
                                <option value="DAIRY">Dairy</option>
                                <option value="FROZEN">Frozen Food</option>
                                <option value="HOUSEHOLD">Household Items</option>

                            </select>

                        </div>

                        <div>

                            <label class="block text-sm font-bold text-slate-700 mb-2">
                                Supplier Name
                            </label>

                            <input type="text"
                                   id="supplierName"
                                   name="supplierName"
                                   readonly
                                   class="w-full bg-slate-100 border rounded-2xl px-4 py-3">

                        </div>

                    </div>

                    <!-- PRICES -->

                    <div class="grid grid-cols-4 gap-5">

                        <div>

                            <label class="block text-sm font-bold text-slate-700 mb-2">
                                Supplier Price
                            </label>

                            <input type="number"
                                   step="0.01"
                                   id="supplierPrice"
                                   readonly
                                   class="w-full bg-slate-100 border rounded-2xl px-4 py-3">

                        </div>

                        <div>

                            <label class="block text-sm font-bold text-slate-700 mb-2">
                                Selling Price (RM)
                            </label>

                            <input type="number"
                                   step="0.01"
                                   min="0"
                                   name="sellingPrice"
                                   required
                                   placeholder="0.00"
                                   class="w-full border rounded-2xl px-4 py-3 focus:ring-2 focus:ring-blue-500 outline-none">

                        </div>

                        <div>

                            <label class="block text-sm font-bold text-slate-700 mb-2">
                                Quantity
                            </label>

                            <input type="number"
                                   id="quantity"
                                   name="quantity"
                                   readonly
                                   class="w-full bg-slate-100 border rounded-2xl px-4 py-3">

                        </div>

                        <div>

                            <label class="block text-sm font-bold text-slate-700 mb-2">
                                Expiry Date
                            </label>

                            <input type="date"
                                   name="expiryDate"
                                   required
                                   class="w-full border rounded-2xl px-4 py-3 focus:ring-2 focus:ring-blue-500 outline-none">

                        </div>

                    </div>

                    <!-- THRESHOLD -->

                    <div>

                        <label class="block text-sm font-bold text-slate-700 mb-2">
                            Low Stock Threshold
                        </label>

                        <input type="number"
                               name="threshold"
                               min="0"
                               required
                               value="10"
                               class="w-full border rounded-2xl px-4 py-3 focus:ring-2 focus:ring-blue-500 outline-none">

                    </div>

                    <!-- BUTTONS -->

                    <div class="flex justify-end gap-3 pt-4">

                        <a href="${pageContext.request.contextPath}/ProductController?action=list"
                           class="px-5 py-3 rounded-2xl bg-slate-200 text-slate-700 font-bold">

                            Cancel

                        </a>

                        <button type="submit"
                                class="px-5 py-3 rounded-2xl bg-blue-600 hover:bg-blue-700 text-white font-bold shadow">

                            Save Product

                        </button>

                    </div>

                </form>

            </div>

        </main>

        <script>

            function fillOrderData(selectElement) {

                const option = selectElement.options[selectElement.selectedIndex];

                document.getElementById("productName").value
                        = option.value || "";

                document.getElementById("supplierName").value
                        = option.getAttribute("data-supplier") || "";

                document.getElementById("quantity").value
                        = option.getAttribute("data-quantity") || "";

                document.getElementById("supplierPrice").value
                        = option.getAttribute("data-supplierprice") || "";
            }

        </script>

    </body>
</html>