package com.redox.controller;

import com.redox.dao.OrderDAO;
import com.redox.model.Order;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.*;
import java.net.*;
import java.nio.charset.StandardCharsets;

public class ToyyibPayServlet extends HttpServlet {

    private static final String USER_SECRET_KEY = "wiveahs2-t8ep-275s-yrle-1afsaatvjobl";
    private static final String CATEGORY_CODE = "8jb7vzh4";

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int orderId = Integer.parseInt(
                    request.getParameter("id"));

            OrderDAO orderDAO = new OrderDAO();
            Order order = orderDAO.getOrderById(orderId);

            String billName = "Supplier Order #" + orderId;

            String billDescription
                    = "Redox RX Supplier Payment";

            int billAmount
                    = (int) (order.getTotalAmount() * 100);

            String returnUrl
                    = "http://localhost:8080/redox-rx/ToyyibPayReturnServlet?orderId="
                    + orderId;

            String callbackUrl = returnUrl;

            String params
                    = "userSecretKey=" + URLEncoder.encode(USER_SECRET_KEY, "UTF-8")
                    + "&categoryCode=" + URLEncoder.encode(CATEGORY_CODE, "UTF-8")
                    + "&billName=" + URLEncoder.encode(billName, "UTF-8")
                    + "&billDescription=" + URLEncoder.encode(billDescription, "UTF-8")
                    + "&billPriceSetting=1"
                    + "&billPayorInfo=1"
                    + "&billAmount=" + billAmount
                    + "&billReturnUrl=" + URLEncoder.encode(returnUrl, "UTF-8")
                    + "&billCallbackUrl=" + URLEncoder.encode(callbackUrl, "UTF-8")
                    + "&billExternalReferenceNo=ORDER-" + orderId
                    + "&billTo=Manager"
                    + "&billEmail=test@test.com"
                    + "&billPhone=0123456789";

            URL url = new URL(
                    "https://dev.toyyibpay.com/index.php/api/createBill");

            HttpURLConnection conn
                    = (HttpURLConnection) url.openConnection();

            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            try (OutputStream os = conn.getOutputStream()) {

                byte[] input
                        = params.getBytes(StandardCharsets.UTF_8);

                os.write(input, 0, input.length);
            }

            BufferedReader br
                    = new BufferedReader(
                            new InputStreamReader(
                                    conn.getInputStream()));

            StringBuilder result
                    = new StringBuilder();

            String line;

            while ((line = br.readLine()) != null) {
                result.append(line);
            }

            String json = result.toString();

            if (json.contains("BillCode")) {

                int start = json.indexOf("\"BillCode\":\"") + 12;
                int end = json.indexOf("\"", start);

                String billCode = json.substring(start, end);

                response.sendRedirect(
                        "https://dev.toyyibpay.com/" + billCode);

            } else {

                response.setContentType("text/plain");
                response.getWriter().println(json);
            }

        } catch (Exception ex) {

            response.setContentType("text/plain");
            ex.printStackTrace(response.getWriter());
        }
    }

}
