<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.redox.model.Order" %>
<%@ page import="com.redox.model.OrderItem" %>

<%
    Order order = (Order) request.getAttribute("order");
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Edit Order | Redox RX</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
    </head>

    <body class="bg-slate-100">

        <jsp:include page="/partials/sidebar.jsp">
            <jsp:param name="active" value="order"/>
        </jsp:include>

        <main class="pl-60 min-h-screen">
            <div class="max-w-5xl mx-auto p-8">

                <a href="${pageContext.request.contextPath}/OrderServlet?action=list"
                   class="text-blue-600 font-semibold text-sm">
                    ← Back to Orders
                </a>

                <div class="bg-white rounded-2xl shadow-sm p-8 mt-6">

                    <h1 class="text-3xl font-bold text-slate-800 mb-2">Edit Supplier Order</h1>
                    <p class="text-slate-500 mb-8">Update supplier order details and purchased items.</p>

                    <form action="${pageContext.request.contextPath}/OrderServlet"
                          method="POST"
                          onsubmit="return validateOrderForm()"
                          class="space-y-6">

                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="orderId" value="<%= order.getOrderId()%>">

                        <div>
                            <label class="block font-semibold mb-2">Supplier Name</label>
                            <input type="text" name="supplierName" required
                                   value="<%= order.getSupplierName()%>"
                                   class="w-full border rounded-xl px-4 py-3">
                        </div>

                        <div>
                            <div class="flex justify-between items-center mb-3">
                                <label class="block font-semibold">Order Items</label>

                                <button type="button"
                                        onclick="addItemRow('', 1, 0)"
                                        class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-xl font-semibold">
                                    + Add Item
                                </button>
                            </div>

                            <div id="itemsContainer" class="space-y-4"></div>
                        </div>

                        <div class="bg-slate-50 rounded-2xl p-5 flex justify-between items-center">
                            <span class="text-slate-600 font-bold">Total Supplier Cost</span>
                            <span id="totalDisplay" class="text-3xl font-black text-blue-600">RM 0.00</span>
                        </div>

                        <div>
                            <label class="block font-semibold mb-2">Status</label>
                            <select name="status" class="w-full border rounded-xl px-4 py-3">
                                <option value="Pending" <%= "Pending".equals(order.getStatus()) ? "selected" : ""%>>Pending</option>
                                <option value="Processing" <%= "Processing".equals(order.getStatus()) ? "selected" : ""%>>Processing</option>
                                <option value="Completed" <%= "Completed".equals(order.getStatus()) ? "selected" : ""%>>Completed</option>
                            </select>
                        </div>

                        <div class="flex justify-end gap-3 pt-4">
                            <a href="${pageContext.request.contextPath}/OrderServlet?action=list"
                               class="bg-slate-200 px-5 py-3 rounded-xl font-semibold">
                                Cancel
                            </a>

                            <button type="submit"
                                    class="bg-blue-600 hover:bg-blue-700 text-white px-5 py-3 rounded-xl font-semibold">
                                Update Order
                            </button>
                        </div>

                    </form>

                </div>

            </div>
        </main>

        <script>
            function addItemRow(itemName, quantity, unitPrice) {
                const container = document.getElementById("itemsContainer");

                const row = document.createElement("div");
                row.className = "grid grid-cols-12 gap-3 bg-slate-50 border rounded-2xl p-4";

                row.innerHTML =
                        '<div class="col-span-5">' +
                        '<label class="block text-sm font-semibold mb-1">Item Name</label>' +
                        '<input type="text" name="itemName" required value="' + itemName + '" ' +
                        'class="w-full border rounded-xl px-3 py-2">' +
                        '</div>' +
                        '<div class="col-span-2">' +
                        '<label class="block text-sm font-semibold mb-1">Qty</label>' +
                        '<input type="number" name="quantity" min="1" value="' + quantity + '" required oninput="calculateTotal()" ' +
                        'class="w-full border rounded-xl px-3 py-2">' +
                        '</div>' +
                        '<div class="col-span-2">' +
                        '<label class="block text-sm font-semibold mb-1">Supplier Price</label>' +
                        '<input type="number" name="unitPrice" min="0" step="0.01" value="' + unitPrice + '" required oninput="calculateTotal()" ' +
                        'class="w-full border rounded-xl px-3 py-2">' +
                        '</div>' +
                        '<div class="col-span-2">' +
                        '<label class="block text-sm font-semibold mb-1">Subtotal</label>' +
                        '<input type="text" class="subtotalField w-full border rounded-xl px-3 py-2 bg-white" readonly value="RM 0.00">' +
                        '</div>' +
                        '<div class="col-span-1 flex items-end">' +
                        '<button type="button" onclick="removeItemRow(this)" class="text-red-600 font-bold px-2 py-2">X</button>' +
                        '</div>';

                container.appendChild(row);
                calculateTotal();
            }

            function removeItemRow(button) {
                button.closest(".grid").remove();
                calculateTotal();
            }

            function calculateTotal() {
                const rows = document.querySelectorAll("#itemsContainer > div");
                let total = 0;

                rows.forEach(function (row) {
                    const quantity = parseFloat(row.querySelector('input[name="quantity"]').value) || 0;
                    const unitPrice = parseFloat(row.querySelector('input[name="unitPrice"]').value) || 0;
                    const subtotal = quantity * unitPrice;

                    row.querySelector(".subtotalField").value = "RM " + subtotal.toFixed(2);
                    total += subtotal;
                });

                document.getElementById("totalDisplay").innerText = "RM " + total.toFixed(2);
            }

            function validateOrderForm() {
                const rows = document.querySelectorAll("#itemsContainer > div");

                if (rows.length === 0) {
                    alert("Please add at least one order item.");
                    return false;
                }

                return true;
            }

            <%
                if (order.getOrderItems() != null && !order.getOrderItems().isEmpty()) {
                    for (OrderItem item : order.getOrderItems()) {
            %>
            addItemRow(
                    '<%= item.getItemName().replace("'", "\\'")%>',
            <%= item.getQuantity()%>,
            <%= item.getUnitPrice()%>
            );
            <%
                }
            } else {
            %>
            addItemRow('', 1, 0);
            <% }%>
        </script>

    </body>
</html>