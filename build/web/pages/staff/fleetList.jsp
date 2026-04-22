<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Staff | Manage Fleet & Bookings</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms"></script>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet"/>
    </head>
    <body class="bg-gray-50">
        <jsp:include page="/partials/sidebar.jsp"><jsp:param name="active" value="fleet" /></jsp:include>

            <main class="pl-64">
            <jsp:include page="/partials/navbar.jsp" />

            <div class="p-8 mt-16">
                <div class="flex justify-between items-center mb-6">
                    <div>
                        <h1>Fleet Management</h1>
                        <p>Manage university vehicles inventory</p>
                    </div>
                    <a href="addVehicle.jsp" class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg transition-colors flex items-center gap-2">
                        <span class="material-symbols-outlined text-sm">add</span> Add Vehicle
                    </a>
                </div>

                <form method="GET" action="${pageContext.request.contextPath}/VehicleController" class="mb-4 flex gap-2">
                    <input type="text" name="keyword" placeholder="Search plate or type..."
                           class="border rounded-lg px-4 py-2 w-64">

                    <select name="status" class="border rounded-lg px-3 py-2">
                        <option value="">All Status</option>
                        <option value="AVAILABLE">Available</option>
                        <option value="MAINTENANCE">Maintenance</option>
                        <option value="UNAVAILABLE">Unavailable</option>
                    </select>

                    <button class="bg-blue-600 text-white px-4 py-2 rounded-lg">
                        Search
                    </button>
                </form>

                <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
                    <table class="w-full text-left border-collapse">
                        <thead class="bg-gray-50 text-gray-600 text-sm uppercase tracking-wider">
                            <tr>
                                <th class="p-4 font-semibold">Request Info</th>
                                <th class="p-4 font-semibold">User</th>
                                <th class="p-4 font-semibold">Trip Dates</th>
                                <th class="p-4 font-semibold">Vehicle Type</th>
                                <th class="p-4 font-semibold">Status</th>
                                <th class="p-4 font-semibold text-right">Decision</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-100">
                            <c:forEach var="v" items="${vehicles}">
                                <tr class="hover:bg-gray-50 transition-colors">

                                    <td class="p-4 font-semibold text-gray-800">
                                        ${v.licensePlate}
                                    </td>

                                    <td class="p-4 text-sm text-gray-600">
                                        ${v.type}
                                    </td>

                                    <td class="p-4 text-sm text-gray-600">
                                        ${v.capacity}
                                    </td>

                                    <td class="p-4">
                                        <span class="px-2.5 py-1 rounded-full text-xs font-medium
                                              ${v.status == 'AVAILABLE' ? 'bg-green-100 text-green-700' :
                                                v.status == 'MAINTENANCE' ? 'bg-yellow-100 text-yellow-700' :
                                                'bg-red-100 text-red-700'}">
                                                  ${v.status}
                                              </span>
                                        </td>

                                        <td class="p-4 text-right">
                                            <div class="flex justify-end gap-2">

                                                <!-- EDIT -->
                                                <a href="${pageContext.request.contextPath}/VehicleController?action=edit&id=${v.id}"
                                                   class="text-blue-600 hover:text-blue-800">
                                                    Edit
                                                </a>

                                                <!-- DELETE -->
                                                <form action="${pageContext.request.contextPath}/VehicleController" method="POST"
                                                      onsubmit="return confirm('Delete this vehicle?')">
                                                    <input type="hidden" name="action" value="delete">
                                                    <input type="hidden" name="id" value="${v.id}">
                                                    <button class="text-red-600 hover:text-red-800">
                                                        Delete
                                                    </button>
                                                </form>

                                            </div>
                                        </td>

                                    </tr>
                                </c:forEach>

                                <c:if test="${empty vehicles}">
                                    <tr>
                                        <td colspan="5" class="p-8 text-center text-gray-500 italic">
                                            No vehicles found.
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </main>
        </body>
    </html>