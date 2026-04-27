<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Register | Redox RX</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms"></script>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet"/>
    </head>

    <body class="bg-slate-100 min-h-screen flex items-center justify-center p-6">

        <div class="w-full max-w-2xl">

            <div class="text-center mb-8">
                <h1 class="text-3xl font-extrabold text-slate-900">Create New Account</h1>
                <p class="text-slate-500 mt-2">Register for Redox RX Inventory Management System</p>
            </div>

            <c:if test="${param.error != null}">
                <div class="bg-red-100 text-red-700 p-4 rounded-xl mb-6 text-sm border border-red-200">
                    Registration failed. Email may already exist.
                </div>
            </c:if>

            <div id="errorMessage" class="hidden bg-red-100 text-red-700 p-4 rounded-xl mb-6 text-sm border border-red-200">
                Passwords do not match.
            </div>

            <form id="registerForm"
                  action="${pageContext.request.contextPath}/RegisterController"
                  method="POST"
                  class="bg-white p-10 rounded-3xl shadow-sm border space-y-6"
                  onsubmit="return validateForm()">

                <div>
                    <label class="block text-sm font-semibold mb-2 text-slate-700">Full Name</label>
                    <input type="text" name="name"
                           class="w-full rounded-xl border-slate-300 focus:ring-2 focus:ring-blue-500"
                           placeholder="Enter full name" required>
                </div>

                <div class="grid grid-cols-2 gap-6">
                    <div>
                        <label class="block text-sm font-semibold mb-2 text-slate-700">Email</label>
                        <input type="email" name="email"
                               class="w-full rounded-xl border-slate-300 focus:ring-2 focus:ring-blue-500"
                               placeholder="name@example.com" required>
                    </div>

                    <div>
                        <label class="block text-sm font-semibold mb-2 text-slate-700">Phone Number</label>
                        <input type="text" name="phone"
                               class="w-full rounded-xl border-slate-300 focus:ring-2 focus:ring-blue-500"
                               placeholder="012-3456789" required>
                    </div>
                </div>

                <div>
                    <label class="block text-sm font-semibold mb-2 text-slate-700">Account Role</label>
                    <select name="roleId"
                            class="w-full rounded-xl border-slate-300 focus:ring-2 focus:ring-blue-500">
                        <option value="1">Staff - Manage Inventory</option>
                        <option value="2">Manager/Admin - Full Access</option>
                    </select>
                </div>

                <div class="grid grid-cols-2 gap-6">
                    <div>
                        <label class="block text-sm font-semibold mb-2 text-slate-700">Password</label>
                        <input type="password" id="password" name="password"
                               class="w-full rounded-xl border-slate-300 focus:ring-2 focus:ring-blue-500"
                               required>
                    </div>

                    <div>
                        <label class="block text-sm font-semibold mb-2 text-slate-700">Confirm Password</label>
                        <input type="password" id="confirmPassword"
                               class="w-full rounded-xl border-slate-300 focus:ring-2 focus:ring-blue-500"
                               required>
                    </div>
                </div>

                <button type="submit"
                        class="w-full bg-blue-600 text-white py-3.5 rounded-xl font-bold hover:bg-blue-700 flex items-center justify-center gap-2 transition">
                    <span class="material-symbols-outlined">person_add</span>
                    Register Account
                </button>

                <p class="text-center text-sm text-slate-500">
                    Already have an account?
                    <a href="${pageContext.request.contextPath}/pages/login/login.jsp"
                       class="text-blue-600 font-bold hover:underline">Login</a>
                </p>
            </form>
        </div>

        <script>
            function validateForm() {
                const password = document.getElementById("password").value;
                const confirm = document.getElementById("confirmPassword").value;
                const errorBox = document.getElementById("errorMessage");

                if (password !== confirm) {
                    errorBox.classList.remove("hidden");
                    window.scrollTo(0, 0);
                    return false;
                }

                return true;
            }
        </script>

    </body>
</html>