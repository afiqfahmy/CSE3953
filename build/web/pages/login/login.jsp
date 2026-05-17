<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Login | Redox RX Inventory System</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms"></script>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet"/>
    </head>

    <body class="min-h-screen bg-slate-100 flex items-center justify-center p-6">

        <div class="w-full max-w-5xl bg-white rounded-3xl shadow-xl overflow-hidden grid grid-cols-1 md:grid-cols-2">

            <!-- Left Branding Panel -->
            <div class="bg-[#082B4C] text-white p-10 flex flex-col justify-between">

                <div>
                    <div class="flex items-center gap-3 mb-10">
                        <div class="w-12 h-12 bg-white rounded-xl flex items-center justify-center">
                            <img src="${pageContext.request.contextPath}/assets/images/Logo_Rasmi_UMT.png"
                                 alt="Redox RX Logo"
                                 class="w-9 h-9 object-contain">
                        </div>

                        <div>
                            <h1 class="text-2xl font-bold">Redox RX</h1>
                            <p class="text-blue-200 text-sm">Inventory Management System</p>
                        </div>
                    </div>

                    <h2 class="text-4xl font-extrabold leading-tight mb-4">
                        Manage stock with confidence.
                    </h2>

                    <p class="text-blue-100 leading-relaxed">
                        Track product inventory, monitor low-stock items, and manage product records in one centralized system.
                    </p>
                </div>

                <div class="grid grid-cols-3 gap-4 mt-10">
                    <div class="bg-white/10 rounded-2xl p-4">
                        <span class="material-symbols-outlined mb-2">inventory_2</span>
                        <p class="text-sm font-semibold">Products</p>
                    </div>

                    <div class="bg-white/10 rounded-2xl p-4">
                        <span class="material-symbols-outlined mb-2">warning</span>
                        <p class="text-sm font-semibold">Low Stock</p>
                    </div>

                    <div class="bg-white/10 rounded-2xl p-4">
                        <span class="material-symbols-outlined mb-2">monitoring</span>
                        <p class="text-sm font-semibold">Tracking</p>
                    </div>
                </div>

            </div>

            <!-- Login Form -->
            <div class="p-10 flex items-center">

                <div class="w-full">

                    <div class="mb-8">
                        <h2 class="text-3xl font-extrabold text-slate-900">Welcome Back</h2>
                        <p class="text-slate-500 mt-2">Sign in to access Redox RX inventory dashboard.</p>
                    </div>

                    <c:if test="${param.error != null}">
                        <div class="bg-red-100 text-red-700 p-4 rounded-xl mb-6 text-sm border border-red-200">
                            Invalid email or password. Please try again.
                        </div>
                    </c:if>

                    <c:if test="${param.registered != null}">
                        <div class="bg-green-100 text-green-700 p-4 rounded-xl mb-6 text-sm border border-green-200">
                            Account registered successfully. Please login.
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/LoginController"
                          method="POST"
                          class="space-y-5">

                        <div>
                            <label class="block text-sm font-semibold text-slate-700 mb-2">Email Address</label>
                            <div class="relative">
                                <span class="material-symbols-outlined absolute left-4 top-3 text-slate-400 text-xl">mail</span>
                                <input type="email"
                                       name="email"
                                       placeholder="staff@redoxrx.com"
                                       required
                                       class="w-full pl-12 rounded-xl border-slate-300 py-3 focus:ring-2 focus:ring-blue-500">
                            </div>
                        </div>

                        <div>
                            <label class="block text-sm font-semibold text-slate-700 mb-2">Password</label>
                            <div class="relative">
                                <span class="material-symbols-outlined absolute left-4 top-3 text-slate-400 text-xl">lock</span>
                                <input type="password"
                                       name="password"
                                       placeholder="Enter your password"
                                       required
                                       class="w-full pl-12 rounded-xl border-slate-300 py-3 focus:ring-2 focus:ring-blue-500">
                            </div>
                        </div>

                        <button type="submit"
                                class="w-full bg-blue-600 hover:bg-blue-700 text-white py-3.5 rounded-xl font-bold shadow-lg shadow-blue-100 transition">
                            Sign In
                        </button>

                        <p class="text-center text-sm text-slate-500 pt-2">
                            Don't have an account?
                            <a href="${pageContext.request.contextPath}/pages/login/register.jsp"
                               class="text-blue-600 font-bold hover:underline">
                                Register here
                            </a>
                        </p>

                    </form>

                </div>

            </div>

        </div>

    </body>
</html>