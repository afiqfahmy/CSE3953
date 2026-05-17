package com.redox.controller;

import com.redox.dao.SalesDAO;
import com.redox.model.Sale;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Date;
import java.util.UUID;

@WebServlet("/SalesServlet")
public class SalesServlet extends HttpServlet {

    private SalesDAO salesDAO;

    @Override
    public void init() {
        salesDAO = new SalesDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String cartData = request.getParameter("cartData");
            String grandTotalStr = request.getParameter("grandTotal");

            if (cartData == null || grandTotalStr == null || cartData.trim().equals("[]")) {
                response.sendRedirect(request.getContextPath() + "/pages/sales/sales.jsp?error=missing_data");
                return;
            }

            double grandTotal = Double.parseDouble(grandTotalStr);

            String saleId = "SALE-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();

            Sale sale = new Sale(saleId, new Date(), grandTotal);

            boolean success = salesDAO.processSale(sale, cartData);

            if (success) {
                request.setAttribute("saleDetails", sale);
                request.setAttribute("cartItemsJson", cartData);

                request.getRequestDispatcher("/pages/sales/receipt.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/pages/sales/sales.jsp?error=stock_failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/pages/sales/sales.jsp?error=system_error");
        }
    }
}
