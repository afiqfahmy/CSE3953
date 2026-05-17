/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package servlet;

/**
 *
 * @author AIZAT
 */


import dao.SalesDAO;
import model.Sale;
import java.io.IOException;
import java.util.Date;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SalesServlet")
public class SalesServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String cartData = request.getParameter("cartData");
            String grandTotalStr = request.getParameter("grandTotal");
            
            if (cartData == null || grandTotalStr == null || cartData.trim().equals("[]")) {
                response.sendRedirect("pages/sales/sales.jsp?error=missing_data");
                return;
            }
            
            double grandTotal = Double.parseDouble(grandTotalStr);
            
            // Generate unique sale ID
            String saleId = "SALE-" + UUID.randomUUID().toString().substring(0, 8);
            Sale newSale = new Sale(saleId, new Date(), grandTotal);
            
            // Process database transaction
            SalesDAO salesDAO = new SalesDAO();
            boolean success = salesDAO.processMultipleSalesManual(newSale, cartData);
            
            if (success) {
                // Pass both the sale summary AND the cart items to the receipt page
                request.setAttribute("saleDetails", newSale);
                request.setAttribute("cartItemsJson", cartData); 
                
                request.getRequestDispatcher("/pages/sales/receipt.jsp").forward(request, response);
            } else {
                response.sendRedirect("pages/sales/sales.jsp?error=db_failed");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("pages/sales/sales.jsp?error=system_error");
        }
    }
}