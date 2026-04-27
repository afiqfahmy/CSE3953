package com.redox.controller;

import com.redox.dao.UserDAO;
import com.redox.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

public class RegisterController extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        int roleId = Integer.parseInt(request.getParameter("roleId"));

        User user = new User(0, name, email, phone, password, roleId);

        try {
            boolean success = userDAO.register(user);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/pages/login/login.jsp?registered=1");
            } else {
                response.sendRedirect(request.getContextPath() + "/pages/login/register.jsp?error=1");
            }

        } catch (SQLException e) {
            response.sendRedirect(request.getContextPath() + "/pages/login/register.jsp?error=1");
        }
    }
}
