<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Staff | Add Vehicle</title>

        <script src="https://cdn.tailwindcss.com?plugins=forms"></script>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;600;700;800&display=swap" rel="stylesheet"/>
    </head>

    <script>
        function validateVehicleForm() {
            const plate = document.querySelector('input[name="licensePlate"]').value.trim();
            const capacity = document.querySelector('input[name="capacity"]').value;

            // Plate format: ABC 1234
            const platePattern = /^[A-Z]{1,3}\s?[0-9]{1,4}$/;

            if (!platePattern.test(plate.toUpperCase())) {
                alert("Invalid license plate format. Example: VAA 1234");
                return false;
            }

            if (capacity <= 0) {
                alert("Capacity must be greater than 0");
                return false;
            }

            return true;
        }
    </script>

    <body class="bg-gray-50 font-sans">

        <jsp:include page="/partials/sidebar.jsp">
            <jsp:param name="active" value="fleet" />
        </jsp:include>

        <main class="pl-64 min-h-screen">

            <jsp:include page="/partials/navbar.jsp" />

            <div class="p-8 mt-16 max-w-4xl">

                <div class="mb-8">
                    <h1 class="text-2xl font-bold text-gray-800">Register New Fleet Unit</h1>
                    <p class="text-gray-500 text-sm">
                        Fill in the details below to add a vehicle to the campus inventory.
                    </p>
                </div>

                <c:if test="${not empty param.error}">
                    <div class="bg-red-50 border-l-4 border-red-500 text-red-700 p-4 rounded-lg mb-6 flex items-center gap-3">
                        <span class="material-symbols-outlined">error</span>
                        <p class="text-sm font-medium">Failed to add vehicle. Please check your inputs and try again.</p>
                    </div>
                </c:if>

                <c:if test="${param.success == '1'}">
                    <div class="bg-green-50 border-l-4 border-green-500 text-green-700 p-4 rounded-lg mb-6 flex items-center gap-3">
                        <span class="material-symbols-outlined">check_circle</span>
                        <p class="text-sm font-medium">Vehicle added successfully.</p>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/VehicleController" method="POST"
                      class="bg-white p-8 rounded-2xl shadow-sm border space-y-6">

                    <input type="hidden" name="action" value="create">

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">

                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">License Plate</label>
                            <input type="text" name="licensePlate"
                                   oninput="this.value = this.value.toUpperCase()"
                                   class="w-full rounded-xl border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                                   placeholder="e.g. VAA 1234"
                                   required>
                        </div>

                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Vehicle Type</label>
                            <select name="type"
                                    class="w-full rounded-xl border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                                    required>
                                <option value="Bus">Bus</option>
                                <option value="Van">Van</option>
                                <option value="SUV">SUV</option>
                                <option value="Sedan">Sedan</option>
                            </select>
                        </div>

                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Seating Capacity</label>
                            <input type="number" name="capacity" min="1"
                                   class="w-full rounded-xl border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                                   placeholder="e.g. 40"
                                   required>
                        </div>

                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Current Status</label>
                            <select name="status" ...>
                                <option value="AVAILABLE" selected>AVAILABLE</option>
                                <option value="MAINTENANCE">MAINTENANCE</option>
                                <option value="UNAVAILABLE">UNAVAILABLE</option>
                            </select>
                        </div>

                    </div>

                    <div class="flex justify-end gap-4 pt-6 border-t border-gray-100">

                        <a href="${pageContext.request.contextPath}/VehicleController?action=list"
                           class="px-6 py-2.5 rounded-xl bg-gray-100 text-gray-600 font-semibold hover:bg-gray-200 transition-colors">
                            Cancel
                        </a>

                        <button type="submit" onclick="return validateVehicleForm()" class="bg-blue-600 text-white px-8 py-2.5 rounded-xl font-semibold hover:bg-blue-700 flex items-center gap-2 shadow-lg shadow-blue-200 transition-all">
                            <span class="material-symbols-outlined text-lg">save</span>
                            Save Vehicle
                        </button>

                    </div>

                </form>

            </div>
        </main>

    </body>
</html>