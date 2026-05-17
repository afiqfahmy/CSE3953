<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sales Menu - Redox RX</title>
    
    <script src="https://cdn.tailwindcss.com?plugins=forms"></script>
    <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;600;700;800&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
    
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: {
                        sans: ['Manrope', 'sans-serif'],
                        headline: ['Manrope', 'sans-serif']
                    },
                    colors: {
                        primary: '#3b82f6',
                        'surface-tint': '#1d4ed8'
                    }
                }
            }
        }
    </script>
</head>
<body class="bg-gray-100 font-sans h-screen overflow-hidden">

<%@ include file="/partials/sidebar.jsp" %>

    <main class="ml-64 flex h-screen w-[calc(100%-16rem)]">
        
        <div class="w-2/3 flex flex-col p-8 bg-gray-50 overflow-y-auto">
            <div class="flex justify-between items-center mb-8">
                <div>
                    <h1 class="text-3xl font-extrabold text-gray-800">Sales Menu</h1>
                    <p class="text-gray-500 font-medium mt-1">Tap items to add to the current order</p>
                </div>
                <span class="bg-white py-2 px-4 rounded-lg shadow-sm text-gray-600 font-bold border border-gray-200" id="currentDate"></span>
            </div>

            <div class="grid grid-cols-2 lg:grid-cols-3 gap-4 pb-8">
                <%
                    java.sql.Connection conn = null;
                    java.sql.PreparedStatement ps = null;
                    java.sql.ResultSet rs = null;
                    
                    try {
                        conn = dao.DBConnection.getConnection();
                        String sql = "SELECT productId, productName, price, stock FROM products WHERE stock > 0";
                        ps = conn.prepareStatement(sql);
                        rs = ps.executeQuery();
                        
                        while (rs.next()) {
                            String dbProductId = rs.getString("productId");
                            String dbProductName = rs.getString("productName");
                            double dbPrice = rs.getDouble("price");
                            int dbStock = rs.getInt("stock");
                %>
                
                <button onclick="addToCart('<%= dbProductId %>', '<%= dbProductName.replace("'", "\\'") %>', <%= dbPrice %>)" 
                        class="bg-white border border-gray-200 rounded-2xl p-5 flex flex-col items-center justify-center hover:border-blue-500 hover:shadow-md hover:bg-blue-50 transition-all active:scale-95 group relative">
                    
                    <span class="absolute top-3 right-3 bg-gray-100 text-gray-600 text-[10px] font-bold px-2 py-1 rounded-md">
                        Qty: <%= dbStock %>
                    </span>

                    <div class="h-16 w-16 bg-blue-100 text-blue-600 rounded-full flex items-center justify-center mb-3 group-hover:scale-110 transition-transform">
                        <span class="material-symbols-outlined text-3xl">local_mall</span>
                    </div>
                    
                    <span class="font-extrabold text-gray-800 text-base text-center leading-tight mb-1"><%= dbProductName %></span>
                    <span class="text-xs font-semibold text-gray-400 mb-2"><%= dbProductId %></span>
                    <span class="font-black text-blue-600 text-lg">RM<%= String.format("%.2f", dbPrice) %></span>
                </button>

                <%
                        } 
                    } catch (Exception e) {
                        out.println("<div class='col-span-3 p-4 bg-red-50 text-red-600 rounded-lg font-bold'>Error loading products: " + e.getMessage() + "</div>");
                    } finally {
                        if (rs != null) try { rs.close(); } catch (Exception e) {}
                        if (ps != null) try { ps.close(); } catch (Exception e) {}
                        if (conn != null) try { conn.close(); } catch (Exception e) {}
                    }
                %>
            </div> </div> <div class="w-1/3 bg-white border-l border-gray-200 flex flex-col shadow-2xl z-10">
            <div class="p-6 border-b border-gray-100 flex justify-between items-center bg-white">
                <h2 class="text-xl font-bold text-gray-800 flex items-center gap-2">
                    <span class="material-symbols-outlined text-blue-600">receipt_long</span>
                    Current Order
                </h2>
                <button onclick="clearCart()" class="text-sm text-red-500 hover:text-red-700 bg-red-50 hover:bg-red-100 px-3 py-1.5 rounded-lg font-bold flex items-center transition-colors">
                    <span class="material-symbols-outlined text-sm mr-1">delete</span> Clear
                </button>
            </div>

            <div class="flex-1 overflow-y-auto p-4 bg-gray-50/50">
                <ul id="cartList" class="space-y-3">
                    <li id="emptyCartMsg" class="text-center text-gray-400 py-12 flex flex-col items-center h-full justify-center">
                        <span class="material-symbols-outlined text-6xl mb-3 opacity-30">shopping_cart</span>
                        <p class="font-semibold">Your cart is empty</p>
                        <p class="text-sm mt-1">Tap a product to start</p>
                    </li>
                </ul>
            </div>

            <div class="p-6 bg-white border-t border-gray-200 shadow-[0_-4px_6px_-1px_rgba(0,0,0,0.05)]">
                <div class="flex justify-between items-center mb-2">
                    <span class="text-gray-500 font-semibold text-sm">Subtotal</span>
                    <span class="text-gray-800 font-bold" id="subtotalDisplay">RM0.00</span>
                </div>
                <div class="flex justify-between items-center mb-4 border-b border-gray-100 pb-4">
                    <span class="text-gray-500 font-semibold text-sm">Tax (0%)</span>
                    <span class="text-gray-800 font-bold">RM0.00</span>
                </div>
                <div class="flex justify-between items-end mb-6">
                    <span class="text-lg font-bold text-gray-500">Total</span>
                    <span class="text-4xl font-black text-blue-600 tracking-tight" id="totalDisplay">RM0.00</span>
                </div>

                <form action="../../SalesServlet" method="POST" id="checkoutForm">
                    <input type="hidden" name="cartData" id="cartDataInput">
                    <input type="hidden" name="grandTotal" id="grandTotalInput">
                    
                    <button type="button" onclick="processCheckout()" 
                            class="w-full bg-[#002147] hover:bg-blue-800 text-white font-extrabold py-4 rounded-xl shadow-lg transition-transform active:scale-95 flex justify-center items-center gap-2 text-lg border border-transparent">
                        <span class="material-symbols-outlined">payments</span>
                        Process Payment
                    </button>
                </form>
            </div>
        </div>
    </main>

    <script>
        document.getElementById('currentDate').textContent = new Date().toLocaleDateString('en-US', { weekday: 'short', month: 'short', day: 'numeric' });

        let cart = [];

        function addToCart(productId, productName, price) {
            const existingItem = cart.find(item => item.productId === productId);
            
            if (existingItem) {
                existingItem.quantity += 1;
                existingItem.total = existingItem.price * existingItem.quantity;
            } else {
                cart.push({
                    productId: productId,
                    productName: productName,
                    price: price,
                    quantity: 1,
                    total: price
                });
            }
            updateCartUI();
        }

        function increaseQty(index) {
            cart[index].quantity += 1;
            cart[index].total = cart[index].price * cart[index].quantity;
            updateCartUI();
        }

        function decreaseQty(index) {
            if (cart[index].quantity > 1) {
                cart[index].quantity -= 1;
                cart[index].total = cart[index].price * cart[index].quantity;
            } else {
                removeFromCart(index);
                return; 
            }
            updateCartUI();
        }

        function removeFromCart(index) {
            cart.splice(index, 1);
            updateCartUI();
        }

        function clearCart() {
            if(confirm("Are you sure you want to clear the current order?")) {
                cart = [];
                updateCartUI();
            }
        }

        function updateCartUI() {
            const cartList = document.getElementById('cartList');
            const emptyCartMsg = document.getElementById('emptyCartMsg');
            let grandTotal = 0;

            cartList.innerHTML = '';

            if (cart.length === 0) {
                cartList.appendChild(emptyCartMsg);
                emptyCartMsg.style.display = 'flex';
            } else {
                cart.forEach((item, index) => {
                    grandTotal += item.total;
                    
                    const li = document.createElement('li');
                    li.className = 'bg-white p-4 rounded-xl border border-gray-100 shadow-[0_2px_4px_rgba(0,0,0,0.02)] flex flex-col gap-3';
                    
                    li.innerHTML = `
                        <div class="flex justify-between items-start">
                            <div>
                                <h4 class="font-extrabold text-gray-800">` + item.productName + `</h4>
                                <p class="text-xs font-semibold text-gray-400">` + item.productId + `</p>
                            </div>
                            <span class="font-black text-gray-900 text-lg">RM` + item.total.toFixed(2) + `</span>
                        </div>
                        
                        <div class="flex justify-between items-center mt-1">
                            <span class="text-sm font-bold text-gray-500">RM` + item.price.toFixed(2) + ` each</span>
                            
                            <div class="flex items-center gap-3 bg-gray-100 rounded-lg p-1">
                                <button onclick="decreaseQty(` + index + `)" class="w-7 h-7 bg-white rounded-md shadow-sm text-gray-600 hover:text-blue-600 flex items-center justify-center font-bold text-xl active:scale-95 transition-transform">-</button>
                                <span class="w-6 text-center font-bold text-gray-800">` + item.quantity + `</span>
                                <button onclick="increaseQty(` + index + `)" class="w-7 h-7 bg-white rounded-md shadow-sm text-gray-600 hover:text-blue-600 flex items-center justify-center font-bold text-xl active:scale-95 transition-transform">+</button>
                            </div>
                        </div>
                    `;
                    cartList.appendChild(li);
                });
            }

            document.getElementById('subtotalDisplay').textContent = 'RM' + grandTotal.toFixed(2);
            document.getElementById('totalDisplay').textContent = 'RM' + grandTotal.toFixed(2);
            
            document.getElementById('cartDataInput').value = JSON.stringify(cart);
            document.getElementById('grandTotalInput').value = grandTotal.toFixed(2);
        }

        function processCheckout() {
            if(cart.length === 0) {
                alert("The cart is empty. Please add items before checking out.");
                return;
            }
            document.getElementById('checkoutForm').submit();
        }
    </script>
</body>
</html>