<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Login | Redox RX</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms"></script>
    </head>

    <body class="bg-slate-100 flex items-center justify-center min-h-screen">

        <div class="max-w-md w-full p-8">

            <div class="text-center mb-10">
                <h1 class="text-3xl font-extrabold text-slate-900">Redox RX</h1>
                <p class="text-slate-500 mt-2">Inventory Management System</p>
            </div>

            <c:if test="${param.error != null}">
                <div class="bg-red-100 text-red-700 p-4 rounded-xl mb-6 text-sm border border-red-200">
                    Invalid email or password.
                </div>
            </c:if>

            <c:if test="${param.registered != null}">
                <div class="bg-green-100 text-green-700 p-4 rounded-xl mb-6 text-sm border border-green-200">
                    Account registered successfully. Please login.
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/LoginController"
                  method="POST"
                  class="bg-white p-8 rounded-2xl shadow-sm border space-y-5">

                <div>
                    <label class="block text-sm font-semibold mb-2">Email</label>
                    <input type="email" name="email"
                           class="w-full rounded-xl border-slate-300 focus:ring-2 focus:ring-blue-500"
                           placeholder="name@example.com" required>
                </div>

                <div>
                    <label class="block text-sm font-semibold mb-2">Password</label>
                    <input type="password" name="password"
                           class="w-full rounded-xl border-slate-300 focus:ring-2 focus:ring-blue-500"
                           placeholder="••••••••" required>
                </div>

                <button type="submit"
                        class="w-full bg-blue-600 text-white py-3 rounded-xl font-bold hover:bg-blue-700">
                    Sign In
                </button>

                <p class="text-center text-sm text-slate-500">
                    Don't have an account?
                    <a href="${pageContext.request.contextPath}/pages/login/register.jsp"
                       class="text-blue-600 font-semibold hover:underline">Register here</a>
                </p>
            </form>
        </div>

    </body>
</html>