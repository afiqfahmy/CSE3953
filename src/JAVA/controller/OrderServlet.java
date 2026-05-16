/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;
import model.OrderDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import model.Order;

@WebServlet("/orders")
public class OrderServlet extends HttpServlet {
    
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        // Instantiate the Data Access Object when the servlet turns on
        orderDAO = new OrderDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "create-form":
                request.getRequestDispatcher("create-order.jsp").forward(request, response);
                break;
                
            case "details":
                int detailsId = Integer.parseInt(request.getParameter("id"));
                // Pulling directly from MySQL database matching the row ID
                request.setAttribute("order", orderDAO.getOrderById(detailsId));
                request.getRequestDispatcher("order-details.jsp").forward(request, response);
                break;
                
            case "report":
                List<Order> reportOrders = orderDAO.getAllOrders();
                double totalRevenue = 0;
                int pendingCount = 0;
                int completedCount = 0;
                
                for(Order o : reportOrders) {
                    totalRevenue += o.getTotalAmount();
                    if("Pending".equalsIgnoreCase(o.getStatus())) pendingCount++;
                    if("Completed".equalsIgnoreCase(o.getStatus())) completedCount++;
                }
                
                request.setAttribute("totalRevenue", totalRevenue);
                request.setAttribute("totalOrders", reportOrders.size());
                request.setAttribute("pendingCount", pendingCount);
                request.setAttribute("completedCount", completedCount);
                request.setAttribute("orders", reportOrders);
                request.getRequestDispatcher("order-report.jsp").forward(request, response);
                break;

            case "list":
            default:
                // Pulling a dynamic List representation directly out of MySQL
                request.setAttribute("orders", orderDAO.getAllOrders());
                request.getRequestDispatcher("order-list.jsp").forward(request, response);
                break;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 1. Get the form parameters safely
            String customerName = request.getParameter("supplierName"); // Matches your JSP name="supplierName"
            String items = request.getParameter("items");
            String rawAmount = request.getParameter("amount");

            // 2. Validate inputs so it doesn't crash on empty fields
            if (customerName == null || items == null || rawAmount == null) {
                response.sendRedirect("orders?action=create-form");
                return;
            }

            double amount = Double.parseDouble(rawAmount);

            // 3. Generate standard date format
            java.time.format.DateTimeFormatter dtf = java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");  
            String currentDate = dtf.format(java.time.LocalDateTime.now());

            // 4. Create object (0 is fine here because MySQL ignores it and increments on its own)
            model.Order newOrder = new model.Order(0, customerName, items, amount, currentDate, "Pending");

            // 5. Push data directly into phpMyAdmin
            orderDAO.insertOrder(newOrder);

            // 6. SAFE REDIRECT: Go straight back to the main summary list
            response.sendRedirect("orders?action=list");

        } catch (Exception e) {
            // If anything fails, it will print the exact reason to your IDE console log
            response.setContentType("text/html");
            java.io.PrintWriter out = response.getWriter();
            out.println("<h2>❌ Critical Submission Error Found:</h2>");
            out.println("<pre style='color:red;'>");
            e.printStackTrace(out); // This prints the entire internal error stack trace
            out.println("</pre>");
        }
    }
}