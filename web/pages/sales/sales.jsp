<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.redox.util.DBConnection" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Sales Menu | Redox RX</title>

        <script src="https://cdn.tailwindcss.com"></script>

        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
    </head>

    <body class="bg-slate-100">

        <jsp:include page="/partials/sidebar.jsp">
            <jsp:param name="active" value="sales"/>
        </jsp:include>

        <main class="pl-60 min-h-screen flex">

            <div class="w-2/3 p-8 overflow-y-auto">

                <div class="mb-8">
                    <h1 class="text-3xl font-bold text-slate-800">Sales Menu</h1>
                    <p class="text-slate-500">Record customer purchases</p>
                </div>

                <div class="grid grid-cols-3 gap-5">

                    <%
                        try (
                                Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(
                                "SELECT * FROM products WHERE quantity > 0"
                        ); ResultSet rs = ps.executeQuery();) {

                            while (rs.next()) {

                                int productId = rs.getInt("product_id");
                                String productName = rs.getString("product_name");
                                double unitPrice = rs.getDouble("unit_price");
                                int quantity = rs.getInt("quantity");
                    %>

                    <button
                        onclick="addToCart(
                        <%= productId%>,
                                        '<%= productName.replace("'", "\\'")%>',
                        <%= unitPrice%>
                                )"

                        class="bg-white rounded-2xl shadow-sm p-5 hover:shadow-md hover:-translate-y-1 transition text-left border border-slate-100">

                        <div class="flex justify-between items-start mb-5">
                            <div class="bg-blue-100 text-blue-600 p-3 rounded-xl">
                                <span class="material-symbols-outlined">shopping_bag</span>
                            </div>

                            <span class="text-xs bg-slate-100 px-2 py-1 rounded-lg font-semibold text-slate-500">
                                Stock: <%= quantity%>
                            </span>
                        </div>

                        <h3 class="font-bold text-slate-800 text-lg">
                            <%= productName%>
                        </h3>

                        <p class="text-blue-600 font-black text-xl mt-2">
                            RM <%= String.format("%.2f", unitPrice)%>
                        </p>
                    </button>

                    <%
                            }
                        } catch (Exception e) {
                            out.println(e.getMessage());
                        }
                    %>

                </div>
            </div>

            <div class="w-1/3 bg-white border-l border-slate-200 flex flex-col">

                <div class="p-6 border-b">
                    <h2 class="font-bold text-xl text-slate-800">
                        Current Order
                    </h2>
                </div>

                <div id="cartItems"
                     class="flex-1 overflow-y-auto p-5 space-y-4">
                </div>

                <div class="p-6 border-t">

                    <div class="flex justify-between mb-5">
                        <span class="font-bold text-slate-600">Total</span>

                        <span id="totalDisplay"
                              class="text-2xl font-black text-blue-600">
                            RM0.00
                        </span>
                    </div>

                    <form action="${pageContext.request.contextPath}/SalesServlet"
                          method="POST">

                        <input type="hidden" name="cartData" id="cartData">
                        <input type="hidden" name="grandTotal" id="grandTotal">

                        <button type="button"
                                onclick="checkout()"

                                class="w-full bg-blue-600 hover:bg-blue-700 text-white py-4 rounded-xl font-bold">
                            Process Payment
                        </button>
                    </form>

                </div>

            </div>

        </main>

        <script>

            let cart = [];

            function addToCart(productId, productName, unitPrice) {

                const existing = cart.find(
                        item => item.productId === productId
                );

                if (existing) {

                    existing.quantity++;

                    existing.total =
                            existing.quantity * existing.price;

                } else {

                    cart.push({
                        productId: productId,
                        productName: productName,
                        price: unitPrice,
                        quantity: 1,
                        total: unitPrice
                    });
                }

                renderCart();
            }

            function renderCart() {
                const container = document.getElementById("cartItems");
                container.innerHTML = "";

                let grandTotal = 0;

                cart.forEach(function (item, index) {
                    grandTotal += item.total;

                    container.innerHTML +=
                            '<div class="bg-slate-50 rounded-xl p-4 border">' +
                            '<div class="flex justify-between">' +
                            '<div>' +
                            '<h3 class="font-bold text-slate-800">' + item.productName + '</h3>' +
                            '<p class="text-sm text-slate-500">RM ' + item.price.toFixed(2) + '</p>' +
                            '</div>' +
                            '<button onclick="removeItem(' + index + ')" class="text-red-500">✕</button>' +
                            '</div>' +
                            '<div class="flex justify-between items-center mt-4">' +
                            '<div class="flex items-center gap-3">' +
                            '<button onclick="changeQty(' + index + ', -1)" class="bg-white border px-3 rounded-lg">-</button>' +
                            '<span class="font-bold">' + item.quantity + '</span>' +
                            '<button onclick="changeQty(' + index + ', 1)" class="bg-white border px-3 rounded-lg">+</button>' +
                            '</div>' +
                            '<span class="font-bold text-blue-600">RM ' + item.total.toFixed(2) + '</span>' +
                            '</div>' +
                            '</div>';
                });

                document.getElementById("totalDisplay").innerText = "RM" + grandTotal.toFixed(2);
                document.getElementById("cartData").value = JSON.stringify(cart);
                document.getElementById("grandTotal").value = grandTotal.toFixed(2);
            }

            function changeQty(index, amount) {

                cart[index].quantity += amount;

                if (cart[index].quantity <= 0) {
                    cart.splice(index, 1);
                } else {
                    cart[index].total =
                            cart[index].quantity * cart[index].price;
                }

                renderCart();
            }

            function removeItem(index) {

                cart.splice(index, 1);

                renderCart();
            }

            function checkout() {

                if (cart.length === 0) {
                    alert("Cart is empty.");
                    return;
                }

                document.forms[0].submit();
            }

        </script>

    </body>
</html>