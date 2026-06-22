<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.redox.model.Product" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Create Order | Redox RX</title>
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

                    <h1 class="text-3xl font-bold text-slate-800 mb-2">Create Supplier Order</h1>
                    <p class="text-slate-500 mb-8">Record items purchased from supplier.</p>

                    <form action="${pageContext.request.contextPath}/OrderServlet"
                          method="POST"
                          onsubmit="return validateOrderForm()"
                          class="space-y-6">

                        <input type="hidden" name="action" value="insert">

                        <div>
                            <label class="block font-semibold mb-2">Supplier Name</label>
                            <input type="text" name="supplierName" required placeholder="E.g. Megah Holding"
                                   class="w-full border rounded-xl px-4 py-3">
                        </div>

                        <div>
                            <div class="flex justify-between items-center mb-3">
                                <label class="block font-semibold">Order Items</label>

                                <button type="button"
                                        onclick="addItemRow()"
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

                        <div class="flex justify-end gap-3 pt-4">
                            <a href="${pageContext.request.contextPath}/OrderServlet?action=list"
                               class="bg-slate-200 px-5 py-3 rounded-xl font-semibold">
                                Cancel
                            </a>

                            <button type="submit"
                                    class="bg-blue-600 hover:bg-blue-700 text-white px-5 py-3 rounded-xl font-semibold">
                                Save Order
                            </button>
                        </div>

                    </form>

                </div>

            </div>
        </main>

        <script>
            function addItemRow() {

                const container =
                        document.getElementById("itemsContainer");

                const uniqueId =
                        Date.now() + Math.floor(Math.random() * 1000);

                const row =
                        document.createElement("div");

                row.className =
                        "grid grid-cols-12 gap-3 bg-slate-50 border rounded-2xl p-4 items-end";

                row.innerHTML =
                        '<div class="col-span-4">' +
                        '<label class="block text-sm font-semibold mb-2">Product</label>' +
                        '<div class="flex gap-4 mb-2 text-sm">' +
                        '<label>' +
                        '<input type="radio" ' +
                        'name="productMode' + uniqueId + '" ' +
                        'value="existing" checked ' +
                        'onchange="toggleProductMode(this)"> ' +
                        'Existing' +
                        '</label>' +
                        '<label>' +
                        '<input type="radio" ' +
                        'name="productMode' + uniqueId + '" ' +
                        'value="new" ' +
                        'onchange="toggleProductMode(this)"> ' +
                        'New' +
                        '</label>' +
                        '</div>' +
                        '<div class="existingProductSection">' +
                        '<select name="productId" ' +
                        'class="productDropdown w-full border rounded-xl px-3 py-2">' +
                        '<option value="">-- Select Product --</option>' +
            <%
                List<Product> products
                        = (List<Product>) request.getAttribute("productList");

                if (products != null) {
                    for (Product p : products) {
            %>

                '<option value="<%= p.getProductId()%>">' +
                        '<%= p.getProductName()%>' +
                        '</option>' +
            <%
                    }
                }
            %>

                '</select>' +
                        '</div>' +
                        '<div class="newProductSection hidden">' +
                        '<input type="text" ' +
                        'name="newProductName" ' +
                        'placeholder="Enter new product name" ' +
                        'class="productTextbox w-full border rounded-xl px-3 py-2 mb-2">' +
                        '<select name="newProductCategory" ' +
                        'class="w-full border rounded-xl px-3 py-2">' +
                        '<option value="">-- Select Category --</option>' +
                        '<option value="General">General</option>' +
                        '<option value="Household">Household</option>' +
                        '</select>' +
                        '</div>' +
                        '</div>' +
                        '<div class="col-span-2">' +
                        '<label class="block text-sm font-semibold mb-1">Qty</label>' +
                        '<input type="number" name="quantity" min="1" value="1" required oninput="calculateTotal()" ' +
                        'class="w-full border rounded-xl px-3 py-2">' +
                        '</div>' +
                        '<div class="col-span-2">' +
                        '<label class="block text-sm font-semibold mb-1">Supplier Price</label>' +
                        '<input type="number" name="unitPrice" min="0" step="0.01" value="0.00" required oninput="calculateTotal()" ' +
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

            function toggleProductMode(radio) {

                const row = radio.closest(".grid");

                const existingSection =
                        row.querySelector(".existingProductSection");

                const newSection =
                        row.querySelector(".newProductSection");

                const dropdown =
                        row.querySelector(".productDropdown");

                const textbox =
                        row.querySelector(".productTextbox");

                if (radio.value === "existing") {

                    existingSection.classList.remove("hidden");
                    newSection.classList.add("hidden");

                    textbox.value = "";

                } else {

                    existingSection.classList.add("hidden");
                    newSection.classList.remove("hidden");

                    dropdown.value = "";
                }
            }

            addItemRow();
        </script>

    </body>
</html>