<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.redox.model.Order" %>

<%
    Order order = (Order) request.getAttribute("order");
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Edit Order | Redox RX</title>

        <script src="https://cdn.tailwindcss.com"></script>
    </head>

    <body class="bg-slate-100">

        <div class="max-w-2xl mx-auto p-8">

            <div class="bg-white rounded-2xl shadow-sm p-8">

                <h1 class="text-3xl font-bold text-slate-800 mb-8">
                    Edit Order
                </h1>

                <form action="${pageContext.request.contextPath}/OrderServlet"
                      method="POST"
                      class="space-y-5">

                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="orderId" value="<%= order.getOrderId()%>">

                    <div>
                        <label class="block font-semibold mb-2">Supplier Name</label>

                        <input type="text"
                               name="supplierName"
                               value="<%= order.getSupplierName()%>"
                               required
                               class="w-full border rounded-xl px-4 py-3">
                    </div>

                    <div>
                        <label class="block font-semibold mb-2">Items</label>

                        <textarea name="items"
                                  rows="5"
                                  required
                                  class="w-full border rounded-xl px-4 py-3"><%= order.getItems()%></textarea>
                    </div>

                    <div>
                        <label class="block font-semibold mb-2">Total Amount</label>

                        <input type="number"
                               step="0.01"
                               min="0"
                               name="totalAmount"
                               value="<%= order.getTotalAmount()%>"
                               required
                               class="w-full border rounded-xl px-4 py-3">
                    </div>

                    <div>
                        <label class="block font-semibold mb-2">Status</label>

                        <select name="status"
                                class="w-full border rounded-xl px-4 py-3">

                            <option value="Pending"
                                    <%= "Pending".equals(order.getStatus()) ? "selected" : ""%>>
                                Pending
                            </option>

                            <option value="Processing"
                                    <%= "Processing".equals(order.getStatus()) ? "selected" : ""%>>
                                Processing
                            </option>

                            <option value="Completed"
                                    <%= "Completed".equals(order.getStatus()) ? "selected" : ""%>>
                                Completed
                            </option>

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

    </body>
</html>