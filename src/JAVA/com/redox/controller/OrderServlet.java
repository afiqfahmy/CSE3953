package com.redox.controller;

import com.redox.dao.OrderDAO;
import com.redox.model.Order;
import com.redox.model.OrderItem;
import com.redox.dao.ProductDAO;
import com.redox.model.Product;
import com.redox.model.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderServlet extends HttpServlet {

    private OrderDAO orderDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null || action.trim().isEmpty()) {
            action = "list";
        }

        try {
            switch (action) {
                case "create":
                    showCreateForm(request, response);
                    break;

                case "edit":
                    showEditForm(request, response);
                    break;

                case "details":
                    showDetails(request, response);
                    break;

                case "delete":
                    response.sendRedirect(
                            request.getContextPath()
                            + "/OrderServlet?action=list&error=unauthorized"
                    );
                    break;

                case "report":
                    showReport(request, response);
                    break;

                case "list":
                default:
                    listOrders(request, response);
                    break;
            }

        } catch (SQLException | NumberFormatException ex) {
            throw new ServletException("Order request failed: " + ex.getMessage(), ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if ("insert".equals(action)) {
                insertOrder(request, response);

            } else if ("update".equals(action)) {
                updateOrder(request, response);

            } else {
                response.sendRedirect(request.getContextPath() + "/OrderServlet?action=list");
            }

        } catch (SQLException | NumberFormatException ex) {
            throw new ServletException("Order operation failed: " + ex.getMessage(), ex);
        }
    }

    private void listOrders(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user.getRoleId() == 2) {
            response.sendRedirect(
                    request.getContextPath()
                    + "/OrderServlet?action=report"
            );
            return;
        }

        List<Order> orders = orderDAO.getAllOrders();

        request.setAttribute("orders", orders);
        request.setAttribute("totalOrders", orders.size());

        RequestDispatcher dispatcher
                = request.getRequestDispatcher("/pages/order/order-list.jsp");

        dispatcher.forward(request, response);
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user.getRoleId() == 2) {
            response.sendRedirect(request.getContextPath()
                    + "/OrderServlet?action=list");
            return;
        }

        ProductDAO productDAO = new ProductDAO();

        request.setAttribute("productList", productDAO.selectAllProducts());

        RequestDispatcher dispatcher
                = request.getRequestDispatcher("/pages/order/create-order.jsp");

        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user.getRoleId() == 2) {
            response.sendRedirect(request.getContextPath()
                    + "/OrderServlet?action=list");
            return;
        }

        int orderId = Integer.parseInt(request.getParameter("id"));

        Order order = orderDAO.getOrderById(orderId);

        ProductDAO productDAO = new ProductDAO();

        request.setAttribute("order", order);
        request.setAttribute("productList", productDAO.selectAllProducts());

        RequestDispatcher dispatcher
                = request.getRequestDispatcher("/pages/order/edit-order.jsp");

        dispatcher.forward(request, response);
    }

    private void showDetails(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        int orderId = Integer.parseInt(request.getParameter("id"));
        Order order = orderDAO.getOrderById(orderId);

        request.setAttribute("order", order);

        RequestDispatcher dispatcher
                = request.getRequestDispatcher("/pages/order/order-details.jsp");

        dispatcher.forward(request, response);
    }

    private void showReport(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        List<Order> orders = orderDAO.getAllOrders();

        double totalAmount = 0;
        int pendingCount = 0;
        int completedCount = 0;

        for (Order order : orders) {
            totalAmount += order.getTotalAmount();

            if ("Pending".equalsIgnoreCase(order.getStatus())) {
                pendingCount++;
            } else if ("Completed".equalsIgnoreCase(order.getStatus())) {
                completedCount++;
            }
        }

        request.setAttribute("orders", orders);
        request.setAttribute("totalOrders", orders.size());
        request.setAttribute("totalAmount", totalAmount);
        request.setAttribute("pendingCount", pendingCount);
        request.setAttribute("completedCount", completedCount);

        RequestDispatcher dispatcher
                = request.getRequestDispatcher("/pages/order/order-report.jsp");

        dispatcher.forward(request, response);
    }

    private void insertOrder(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user.getRoleId() == 2) {
            response.sendRedirect(request.getContextPath()
                    + "/OrderServlet?action=list");
            return;
        }

        Order order = buildOrderFromRequest(request, 0);

        orderDAO.insertOrder(order);

        response.sendRedirect(request.getContextPath()
                + "/OrderServlet?action=list&success=added");
    }

    private void updateOrder(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user.getRoleId() == 2) {
            response.sendRedirect(request.getContextPath()
                    + "/OrderServlet?action=list");
            return;
        }

        int orderId = Integer.parseInt(request.getParameter("orderId"));

        // Get old order BEFORE update
        Order oldOrder = orderDAO.getOrderById(orderId);

        // Build updated order
        Order updatedOrder = buildOrderFromRequest(request, orderId);

        // Update order first
        orderDAO.updateOrder(updatedOrder);

        /*
        AUTOMATIC STOCK UPDATE
        Only add stock when:
        old status != Completed
        AND
        new status == Completed
         */
        if (!"Completed".equalsIgnoreCase(oldOrder.getStatus())
                && "Completed".equalsIgnoreCase(updatedOrder.getStatus())) {

            ProductDAO productDAO = new ProductDAO();

            for (OrderItem item : updatedOrder.getOrderItems()) {

                productDAO.increaseStockByProductId(
                        item.getProductId(),
                        item.getQuantity()
                );
            }
        }

        response.sendRedirect(request.getContextPath()
                + "/OrderServlet?action=list&success=updated");
    }

    private Order buildOrderFromRequest(HttpServletRequest request, int orderId) {

        String supplierName = request.getParameter("supplierName").trim();
        String status = request.getParameter("status");

        String[] itemNames = request.getParameterValues("itemName");
        String[] quantities = request.getParameterValues("quantity");
        String[] unitPrices = request.getParameterValues("unitPrice");

        List<OrderItem> orderItems = new ArrayList<>();

        double totalAmount = 0;
        StringBuilder itemSummary = new StringBuilder();

        for (int i = 0; i < itemNames.length; i++) {

            String itemName = itemNames[i].trim();

            if (itemName.isEmpty()) {
                continue;
            }

            int quantity = Integer.parseInt(quantities[i]);

            double unitPrice = Double.parseDouble(unitPrices[i]);

            double subtotal = quantity * unitPrice;

            totalAmount += subtotal;

            OrderItem item = new OrderItem();
            item.setOrderId(orderId);

            // no product ID yet
            item.setProductId(0);

            item.setItemName(itemName);
            item.setQuantity(quantity);
            item.setUnitPrice(unitPrice);
            item.setSubtotal(subtotal);

            orderItems.add(item);

            itemSummary.append(itemName)
                    .append(" x ")
                    .append(quantity)
                    .append(" = RM ")
                    .append(String.format("%.2f", subtotal))
                    .append("\n");
        }

        Order order = new Order(
                orderId,
                supplierName,
                itemSummary.toString(),
                totalAmount,
                null,
                status
        );

        order.setOrderItems(orderItems);

        return order;
    }

    private void deleteOrder(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {

        int orderId = Integer.parseInt(request.getParameter("id"));

        orderDAO.deleteOrder(orderId);

        response.sendRedirect(request.getContextPath()
                + "/OrderServlet?action=list&success=deleted");
    }
}
