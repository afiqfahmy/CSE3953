package com.redox.controller;

import com.redox.dao.UserDAO;
import com.redox.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

public class LoginController extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            User user = userDAO.login(email, password);

            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);

                response.sendRedirect(request.getContextPath() + "/ProductController?action=list");
            } else {
                response.sendRedirect(request.getContextPath() + "/pages/login/login.jsp?error=1");
            }

        } catch (SQLException e) {
            throw new ServletException("Login failed", e);
        }
    }
}
