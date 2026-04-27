package com.redox.controller;

import com.redox.dao.UserDAO;
import com.redox.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

public class ProfileController extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login/login.jsp");
            return;
        }

        User currentUser = (User) session.getAttribute("user");

        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String newPassword = request.getParameter("newPassword");

        User updatedUser = new User(
                currentUser.getUserId(),
                name,
                currentUser.getEmail(),
                phone,
                newPassword,
                currentUser.getRoleId()
        );

        try {
            boolean success = userDAO.updateProfile(updatedUser);

            if (success) {
                currentUser.setName(name);
                currentUser.setPhone(phone);

                if (newPassword != null && !newPassword.trim().isEmpty()) {
                    currentUser.setPassword(newPassword);
                }

                session.setAttribute("user", currentUser);
                response.sendRedirect(request.getContextPath() + "/pages/login/profile.jsp?success=1");
            } else {
                response.sendRedirect(request.getContextPath() + "/pages/login/profile.jsp?error=1");
            }

        } catch (SQLException e) {
            throw new ServletException("Profile update failed", e);
        }
    }
}
