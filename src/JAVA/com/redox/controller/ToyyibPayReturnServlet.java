package com.redox.controller;

import com.redox.dao.OrderDAO;
import java.io.IOException;
import javax.servlet.http.*;

public class ToyyibPayReturnServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        try {

            int orderId
                    = Integer.parseInt(
                            request.getParameter("orderId"));

            String statusId
                    = request.getParameter("status_id");

            if ("1".equals(statusId)) {

                OrderDAO dao
                        = new OrderDAO();

                dao.markAsPaid(orderId);

                response.sendRedirect(
                        request.getContextPath()
                        + "/OrderServlet?action=report&success=paid");

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/OrderServlet?action=report&error=payment");
            }

        } catch (Exception ex) {

            ex.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/OrderServlet?action=report");
        }
    }
}
