<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.redox.model.Product" %>

<%
    List<Product> products
            = (List<Product>) request.getAttribute("productList");
%>

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
                            <input type="text"
                                   id="supplierName"
                                   name="supplierName"
                                   readonly
                                   required
                                   placeholder="Select a product first..."
                                   class="w-full border rounded-xl px-4 py-3 bg-slate-100">
                        </div>

                        <div>
                            <div class="flex justify-between items-center mb-3">
                                <label class="block font-semibold">Order Items</label>
                                <button type="button"
                                        onclick="openItemModal()"
                                        class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-xl font-semibold">
                                    + Add Item
                                </button>
                            </div>

                            <div class="overflow-x-auto border rounded-2xl">

                                <table class="w-full">
                                    <thead>
                                        <tr>
                                            <th class="p-4 text-left">Product</th>
                                            <th class="p-4 text-left">Qty</th>
                                            <th class="p-4 text-left">Supplier Price</th>
                                            <th class="p-4 text-left">Subtotal</th>
                                            <th class="p-4 text-center">Action</th>
                                        </tr>
                                    </thead>

                                    <tbody id="itemsContainer">
                                    </tbody>
                                </table>

                            </div>
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

                        <!-- Add Item Modal -->
                        <div id="itemModal"
                             class="hidden fixed inset-0 bg-black/40 flex items-center justify-center z-50">

                            <div class="bg-white rounded-2xl shadow-xl w-full max-w-2xl p-6">

                                <div class="flex justify-between items-center mb-5">
                                    <h2 class="text-xl font-bold">
                                        Add Product
                                    </h2>

                                    <div id="modalSupplierInfo"
                                         class="hidden bg-blue-50 border border-blue-200 rounded-xl p-3 mb-4">

                                        Supplier:
                                        <span id="modalSupplierDisplay"
                                              class="font-semibold text-blue-700">
                                        </span>

                                    </div>

                                    <button type="button"
                                            onclick="closeItemModal()"
                                            class="text-slate-500 text-xl">
                                    </button>
                                </div>

                                <div class="space-y-4">

                                    <div>
                                        <label class="font-semibold text-sm">
                                            Product Type
                                        </label>

                                        <div class="flex gap-5 mt-2">

                                            <label>
                                                <input type="radio"
                                                       name="modalProductMode"
                                                       value="existing"
                                                       checked
                                                       onchange="toggleModalProductMode(this)">
                                                Existing Product
                                            </label>

                                            <label>
                                                <input type="radio"
                                                       name="modalProductMode"
                                                       value="new"
                                                       onchange="toggleModalProductMode(this)">
                                                New Product
                                            </label>

                                        </div>
                                    </div>

                                    <!-- Existing Product -->

                                    <div id="modalExistingSection">

                                        <label class="font-semibold text-sm">
                                            Product
                                        </label>

                                        <select id="modalProduct"
                                                onchange="handleModalProductSelection(this)"
                                                class="w-full border rounded-xl px-4 py-3 mt-2">

                                            <option value="">
                                                -- Select Product --
                                            </option>

                                            <%
                                                if (products != null) {
                                                    for (Product p : products) {
                                            %>

                                            <option value="<%= p.getProductId()%>"
                                                    data-supplier="<%= p.getSupplierName()%>">

                                                <%= p.getSupplierName()%> : <%= p.getProductName()%>

                                            </option>

                                            <% }
                                                }%>

                                        </select>

                                    </div>

                                    <!-- New Product -->

                                    <div id="modalNewSection"
                                         class="hidden space-y-3">

                                        <input type="text"
                                               id="modalNewProduct"
                                               placeholder="Product Name"
                                               class="w-full border rounded-xl px-4 py-3">

                                        <select id="modalCategory"
                                                class="w-full border rounded-xl px-4 py-3">

                                            <option value="">Category</option>

                                            <option value="SNACKS">Snacks</option>
                                            <option value="DRINKS">Drinks</option>
                                            <option value="INSTANT_FOOD">Instant Food</option>
                                            <option value="DAIRY">Dairy</option>
                                            <option value="FROZEN">Frozen Food</option>
                                            <option value="HOUSEHOLD">Household</option>

                                        </select>

                                    </div>

                                    <div class="grid grid-cols-3 gap-3">

                                        <div>
                                            <label class="font-semibold text-sm">
                                                Quantity
                                            </label>

                                            <input type="number"
                                                   id="modalQty"
                                                   value="1"
                                                   min="1"
                                                   class="w-full border rounded-xl px-4 py-3">
                                        </div>

                                        <div>
                                            <label class="font-semibold text-sm">
                                                Supplier Price
                                            </label>

                                            <input type="number"
                                                   id="modalPrice"
                                                   value="0.00"
                                                   min="0"
                                                   step="0.01"
                                                   class="w-full border rounded-xl px-4 py-3">
                                        </div>

                                    </div>

                                </div>

                                <div class="flex justify-end gap-3 mt-6">

                                    <button type="button"
                                            onclick="closeItemModal()"
                                            class="bg-slate-200 px-5 py-3 rounded-xl">

                                        Cancel

                                    </button>

                                    <button type="button"
                                            onclick="saveModalItem()"
                                            class="bg-blue-600 text-white px-5 py-3 rounded-xl">

                                        Add Item

                                    </button>

                                </div>

                            </div>

                        </div>

                    </form>

                </div>

            </div>
        </main>

        <script>

            function createItemRow(
                    productId,
                    productName,
                    quantity,
                    unitPrice,
                    isNew,
                    category
                    ) {

                const container =
                        document.getElementById("itemsContainer");

                const subtotal =
                        parseFloat(quantity) * parseFloat(unitPrice);

                const row =
                        document.createElement("tr");

                row.className =
                        "border-t hover:bg-slate-50";

                row.innerHTML =
                        '<td class="p-4">' +
                        productName +
                        '<input type="hidden" name="productId" value="' + (productId || '') + '">' +
                        '<input type="hidden" name="newProductName" value="' + (isNew ? productName : '') + '">' +
                        '<input type="hidden" name="newProductCategory" value="' + (category || '') + '">' +
                        '</td>' +
                        '<td class="p-4">' +
                        quantity +
                        '<input type="hidden" name="quantity" value="' + quantity + '">' +
                        '</td>' +
                        '<td class="p-4">' +
                        parseFloat(unitPrice).toFixed(2) +
                        '<input type="hidden" name="unitPrice" value="' + unitPrice + '">' +
                        '</td>' +
                        '<td class="p-4 font-semibold text-blue-600">' +
                        'RM ' + subtotal.toFixed(2) +
                        '</td>' +
                        '<td class="p-4 text-center">' +
                        '<button type="button" ' +
                        'onclick="removeItemRow(this)" ' +
                        'class="text-red-600 hover:text-red-800 font-semibold">' +
                        'Delete' +
                        '</button>' +
                        '</td>';

                container.appendChild(row);

                calculateTotal();
            }

            function removeItemRow(button) {

                button.closest("tr").remove();

                calculateTotal();

                const rows =
                        document.querySelectorAll("#itemsContainer tr");

                if (rows.length === 0) {

                    document.getElementById("supplierName").value = "";
                }
            }

            function calculateTotal() {

                const rows =
                        document.querySelectorAll("#itemsContainer tr");

                let total = 0;

                rows.forEach(function (row) {

                    const quantity =
                            parseFloat(
                                    row.querySelector('input[name="quantity"]').value
                                    ) || 0;

                    const unitPrice =
                            parseFloat(
                                    row.querySelector('input[name="unitPrice"]').value
                                    ) || 0;

                    total += quantity * unitPrice;
                });

                document.getElementById("totalDisplay").innerText =
                        "RM " + total.toFixed(2);
            }

            function validateOrderForm() {

                const rows =
                        document.querySelectorAll("#itemsContainer tr");

                if (rows.length === 0) {

                    alert("Please add at least one order item.");

                    return false;
                }

                return true;
            }

            function openItemModal() {

                resetModal();

                const supplier =
                        document.getElementById("supplierName").value;

                const supplierInfo =
                        document.getElementById("modalSupplierInfo");

                const supplierDisplay =
                        document.getElementById("modalSupplierDisplay");

                const dropdown =
                        document.getElementById("modalProduct");

                Array.from(dropdown.options).forEach(option => {

                    if (option.value === "") {
                        option.hidden = false;
                        return;
                    }

                    const optionSupplier =
                            option.getAttribute("data-supplier");

                    if (supplier === "") {

                        option.hidden = false;

                    } else {

                        option.hidden =
                                optionSupplier !== supplier;
                    }
                });

                if (supplier !== "") {

                    supplierDisplay.innerText =
                            supplier;

                    supplierInfo.classList.remove("hidden");

                } else {

                    supplierInfo.classList.add("hidden");
                }

                document
                        .getElementById("itemModal")
                        .classList
                        .remove("hidden");
            }

            function closeItemModal() {

                document
                        .getElementById("itemModal")
                        .classList
                        .add("hidden");
            }

            function toggleModalProductMode(radio) {

                const existingSection =
                        document.getElementById("modalExistingSection");

                const newSection =
                        document.getElementById("modalNewSection");

                if (radio.value === "existing") {

                    existingSection.classList.remove("hidden");
                    newSection.classList.add("hidden");

                } else {

                    existingSection.classList.add("hidden");
                    newSection.classList.remove("hidden");
                }
            }

            function handleModalProductSelection(dropdown) {

                const option =
                        dropdown.options[dropdown.selectedIndex];

                const supplier =
                        option.getAttribute("data-supplier");

                if (!supplier)
                    return;

                const supplierField =
                        document.getElementById("supplierName");

                if (
                        supplierField.value === "" ||
                        supplierField.value === supplier
                        ) {

                    supplierField.value = supplier;

                } else {

                    alert(
                            "Only one supplier is allowed per order."
                            );

                    dropdown.selectedIndex = 0;
                }
            }

            function saveModalItem() {

                const mode =
                        document.querySelector(
                                'input[name="modalProductMode"]:checked'
                                ).value;

                const qty =
                        document.getElementById("modalQty").value;

                const price =
                        document.getElementById("modalPrice").value;

                if (!qty || qty <= 0) {

                    alert("Invalid quantity");

                    return;
                }

                if (!price || price < 0) {

                    alert("Invalid supplier price");

                    return;
                }

                if (mode === "existing") {

                    const dropdown =
                            document.getElementById("modalProduct");

                    const option =
                            dropdown.options[dropdown.selectedIndex];

                    if (!dropdown.value) {

                        alert("Please select a product.");

                        return;
                    }

                    const selectedSupplier =
                            option.getAttribute("data-supplier");

                    const supplierField =
                            document.getElementById("supplierName");

                    if (
                            supplierField.value === "" ||
                            supplierField.value === selectedSupplier
                            ) {

                        supplierField.value =
                                selectedSupplier;

                    } else {

                        alert(
                                "Only one supplier is allowed per order."
                                );

                        return;
                    }

                    createItemRow(
                            dropdown.value,
                            option.text,
                            qty,
                            price,
                            false,
                            null
                            );

                } else {

                    const productName =
                            document.getElementById("modalNewProduct").value.trim();

                    const category =
                            document.getElementById("modalCategory").value;

                    if (productName === "") {

                        alert("Enter product name.");

                        return;
                    }

                    if (category === "") {

                        alert("Select product category.");

                        return;
                    }

                    createItemRow(
                            "",
                            productName,
                            qty,
                            price,
                            true,
                            category
                            );
                }

                resetModal();
                closeItemModal();
            }

            function resetModal() {

                document.getElementById("modalProduct").selectedIndex = 0;

                document.getElementById("modalNewProduct").value = "";

                document.getElementById("modalCategory").selectedIndex = 0;

                document.getElementById("modalQty").value = 1;

                document.getElementById("modalPrice").value = "0.00";

                document.querySelector(
                        'input[name="modalProductMode"][value="existing"]'
                        ).checked = true;

                document.getElementById("modalExistingSection")
                        .classList.remove("hidden");

                document.getElementById("modalNewSection")
                        .classList.add("hidden");
            }

        </script>

    </body>
</html>