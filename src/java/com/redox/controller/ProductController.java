package com.redox.controller;

import com.redox.dao.ProductDAO;
import com.redox.model.Product;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ProductController")
public class ProductController extends HttpServlet {

    private ProductDAO productDAO;

    public void init() {
        productDAO = new ProductDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {

                case "add":   // ✅ NEW (SHOW ADD FORM)
                    showAddForm(request, response);
                    break;

                case "insert":
                    insertProduct(request, response);
                    break;

                case "delete":
                    deleteProduct(request, response);
                    break;

                case "edit":
                    showEditForm(request, response);
                    break;

                case "update":
                    updateProduct(request, response);
                    break;

                case "view":
                    viewProduct(request, response);
                    break;

                default:
                    listProducts(request, response);
                    break;
            }

        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    // ✅ SHOW ADD PRODUCT PAGE
    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RequestDispatcher dispatcher
                = request.getRequestDispatcher("/pages/staff/addProduct.jsp");

        dispatcher.forward(request, response);
    }

    // ✅ LIST PRODUCTS
    private void listProducts(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {

        List<Product> listProduct = productDAO.selectAllProducts();
        request.setAttribute("productList", listProduct);

        RequestDispatcher dispatcher
                = request.getRequestDispatcher("/pages/staff/manageProduct.jsp");

        dispatcher.forward(request, response);
    }

    // ✅ SHOW EDIT FORM
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        Product existingProduct = productDAO.selectProduct(id);
        request.setAttribute("product", existingProduct);

        RequestDispatcher dispatcher
                = request.getRequestDispatcher("/pages/staff/editProduct.jsp");

        dispatcher.forward(request, response);
    }

    // ✅ INSERT PRODUCT
    private void insertProduct(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {

        String name = request.getParameter("productName");
        String category = request.getParameter("category");
        double price = Double.parseDouble(request.getParameter("unitPrice"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        int threshold = Integer.parseInt(request.getParameter("threshold"));

        Product newProduct = new Product(0, name, category, price, quantity, threshold);
        productDAO.insertProduct(newProduct);

        response.sendRedirect(request.getContextPath() + "/ProductController?action=list");
    }

    // ✅ UPDATE PRODUCT
    private void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {

        int id = Integer.parseInt(request.getParameter("productId"));
        String name = request.getParameter("productName");
        String category = request.getParameter("category");
        double price = Double.parseDouble(request.getParameter("unitPrice"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        int threshold = Integer.parseInt(request.getParameter("threshold"));

        Product product = new Product(id, name, category, price, quantity, threshold);
        productDAO.updateProduct(product);

        response.sendRedirect(request.getContextPath() + "/ProductController?action=list");
    }

    // ✅ DELETE PRODUCT
    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        productDAO.deleteProduct(id);

        response.sendRedirect(request.getContextPath() + "/ProductController?action=list");
    }

    // ✅ VIEW PRODUCT DETAILS
    private void viewProduct(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        Product product = productDAO.selectProduct(id);
        request.setAttribute("product", product);

        RequestDispatcher dispatcher
                = request.getRequestDispatcher("/pages/staff/productDetails.jsp");

        dispatcher.forward(request, response);
    }
}
