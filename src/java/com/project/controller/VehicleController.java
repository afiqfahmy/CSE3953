package com.project.controller;

import com.project.dao.VehicleDAO;
import com.project.model.Vehicle;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/VehicleController")
public class VehicleController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String status = request.getParameter("status");
        String keyword = request.getParameter("keyword");

        VehicleDAO dao = new VehicleDAO();

        // ✅ LIST + SEARCH + FILTER
        if (action == null || action.equals("list")) {

            List<Vehicle> list;

            if (keyword != null && !keyword.isEmpty()) {
                list = dao.searchVehicles(keyword);
            } else if (status != null && !status.isEmpty()) {
                list = dao.getVehiclesByStatus(status);
            } else {
                list = dao.getAllVehicles();
            }

            request.setAttribute("vehicles", list);
            request.getRequestDispatcher("/pages/staff/fleetList.jsp").forward(request, response);
        } // ✅ EDIT PAGE
        else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            request.setAttribute("vehicle", dao.getVehicleById(id));
            request.getRequestDispatcher("/pages/staff/editVehicle.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        VehicleDAO dao = new VehicleDAO();
        boolean success = false;

        // ✅ CREATE
        if ("create".equals(action)) {
            String plate = request.getParameter("licensePlate");
            String type = request.getParameter("type");
            int cap = Integer.parseInt(request.getParameter("capacity"));
            String status = request.getParameter("status");

            success = dao.addVehicle(new Vehicle(plate, type, cap, status));
        } // ✅ UPDATE
        else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String plate = request.getParameter("licensePlate");
            String type = request.getParameter("type");
            int cap = Integer.parseInt(request.getParameter("capacity"));
            String status = request.getParameter("status");

            success = dao.updateVehicle(new Vehicle(id, plate, type, cap, status));
        } // ✅ DELETE (moved to POST — correct practice)
        else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            success = dao.deleteVehicle(id);
        }

        // ✅ REDIRECT HANDLING
        if (success) {
            response.sendRedirect("VehicleController?action=list&success=1");
        } else {
            response.sendRedirect("VehicleController?action=list&error=1");
        }
    }
}
