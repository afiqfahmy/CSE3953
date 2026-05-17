package com.redox.controller;

import com.redox.dao.OrderDAO;
import com.redox.model.Order;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
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
                    deleteOrder(request, response);
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

        List<Order> orders = orderDAO.getAllOrders();

        request.setAttribute("orders", orders);
        request.setAttribute("totalOrders", orders.size());

        RequestDispatcher dispatcher
                = request.getRequestDispatcher("/pages/order/order-list.jsp");

        dispatcher.forward(request, response);
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RequestDispatcher dispatcher
                = request.getRequestDispatcher("/pages/order/create-order.jsp");

        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        int orderId = Integer.parseInt(request.getParameter("id"));
        Order order = orderDAO.getOrderById(orderId);

        request.setAttribute("order", order);

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
        int processingCount = 0;
        int completedCount = 0;

        for (Order order : orders) {
            totalAmount += order.getTotalAmount();

            if ("Pending".equalsIgnoreCase(order.getStatus())) {
                pendingCount++;
            } else if ("Processing".equalsIgnoreCase(order.getStatus())) {
                processingCount++;
            } else if ("Completed".equalsIgnoreCase(order.getStatus())) {
                completedCount++;
            }
        }

        request.setAttribute("orders", orders);
        request.setAttribute("totalOrders", orders.size());
        request.setAttribute("totalAmount", totalAmount);
        request.setAttribute("pendingCount", pendingCount);
        request.setAttribute("processingCount", processingCount);
        request.setAttribute("completedCount", completedCount);

        RequestDispatcher dispatcher
                = request.getRequestDispatcher("/pages/order/order-report.jsp");

        dispatcher.forward(request, response);
    }

    private void insertOrder(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {

        String supplierName = request.getParameter("supplierName").trim();
        String items = request.getParameter("items").trim();
        double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
        String status = request.getParameter("status");

        Order order = new Order(0, supplierName, items, totalAmount, null, status);

        orderDAO.insertOrder(order);

        response.sendRedirect(request.getContextPath()
                + "/OrderServlet?action=list&success=added");
    }

    private void updateOrder(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {

        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String supplierName = request.getParameter("supplierName").trim();
        String items = request.getParameter("items").trim();
        double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
        String status = request.getParameter("status");

        Order order = new Order(orderId, supplierName, items, totalAmount, null, status);

        orderDAO.updateOrder(order);

        response.sendRedirect(request.getContextPath()
                + "/OrderServlet?action=list&success=updated");
    }

    private void deleteOrder(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {

        int orderId = Integer.parseInt(request.getParameter("id"));

        orderDAO.deleteOrder(orderId);

        response.sendRedirect(request.getContextPath()
                + "/OrderServlet?action=list&success=deleted");
    }
}
