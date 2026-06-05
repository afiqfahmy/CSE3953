package com.redox.controller;

import com.redox.dao.ProductDAO;
import com.redox.model.Product;
import com.redox.model.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class ProductController extends HttpServlet {

    private ProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if ("insert".equals(action)) {

                if (!canManageProduct(request)) {
                    response.sendRedirect(request.getContextPath()
                            + "/ProductController?action=list&error=unauthorized");
                    return;
                }

                insertProduct(request, response);

            } else if ("update".equals(action)) {

                if (!canManageProduct(request)) {
                    response.sendRedirect(request.getContextPath()
                            + "/ProductController?action=list&error=unauthorized");
                    return;
                }

                updateProduct(request, response);

            } else if ("delete".equals(action)) {

                if (!canDeleteProduct(request)) {
                    response.sendRedirect(request.getContextPath()
                            + "/ProductController?action=list&error=unauthorized");
                    return;
                }

                deleteProduct(request, response);

            } else {
                response.sendRedirect(request.getContextPath()
                        + "/ProductController?action=list");
            }

        } catch (SQLException | NumberFormatException ex) {
            throw new ServletException("Product operation failed: " + ex.getMessage(), ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null || action.trim().isEmpty()) {
            action = "list";
        }

        try {
            switch (action) {
                case "add":
                    if (!canManageProduct(request)) {
                        response.sendRedirect(request.getContextPath()
                                + "/ProductController?action=list&error=unauthorized");
                        return;
                    }
                    showAddForm(request, response);
                    break;

                case "edit":
                    if (!canManageProduct(request)) {
                        response.sendRedirect(request.getContextPath()
                                + "/ProductController?action=list&error=unauthorized");
                        return;
                    }
                    showEditForm(request, response);
                    break;

                case "view":
                    viewProduct(request, response);
                    break;

                case "list":
                default:
                    listProducts(request, response);
                    break;
            }

        } catch (SQLException | NumberFormatException ex) {
            throw new ServletException("Unable to process product request: " + ex.getMessage(), ex);
        }
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        String keyword = request.getParameter("keyword");
        String category = request.getParameter("category");

        List<Product> productList;

        boolean hasKeyword = keyword != null && !keyword.trim().isEmpty();

        boolean hasCategory = category != null
                && !category.trim().isEmpty()
                && !"ALL".equalsIgnoreCase(category);

        if (hasKeyword || hasCategory) {
            productList = productDAO.searchProducts(keyword, category);
        } else {
            productList = productDAO.selectAllProducts();
        }

        int totalProducts = productList.size();
        int lowStockCount = 0;
        int totalQuantity = 0;

        for (Product product : productList) {
            totalQuantity += product.getQuantity();

            if (product.isLowStock()) {
                lowStockCount++;
            }
        }

        request.setAttribute("productList", productList);
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("lowStockCount", lowStockCount);
        request.setAttribute("totalQuantity", totalQuantity);
        request.setAttribute("keyword", keyword);
        request.setAttribute("category", category);

        RequestDispatcher dispatcher
                = request.getRequestDispatcher("/pages/staff/manageProduct.jsp");

        dispatcher.forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        request.setAttribute("orderedItemList", productDAO.getCompletedOrderItemsForProduct());

        RequestDispatcher dispatcher
                = request.getRequestDispatcher("/pages/staff/addProduct.jsp");

        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        int productId = Integer.parseInt(request.getParameter("id"));

        Product product = productDAO.selectProduct(productId);

        request.setAttribute("product", product);
        request.setAttribute("supplierList", productDAO.getSupplierNames());

        RequestDispatcher dispatcher
                = request.getRequestDispatcher("/pages/staff/editProduct.jsp");

        dispatcher.forward(request, response);
    }

    private void viewProduct(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        int productId = Integer.parseInt(request.getParameter("id"));

        Product product = productDAO.selectProduct(productId);

        request.setAttribute("product", product);

        RequestDispatcher dispatcher
                = request.getRequestDispatcher("/pages/staff/productDetails.jsp");

        dispatcher.forward(request, response);
    }

    private void insertProduct(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {

        Product product = extractProductFromRequest(request, 0);

        productDAO.insertProduct(product);

        response.sendRedirect(request.getContextPath()
                + "/ProductController?action=list&success=added");
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {

        int productId = Integer.parseInt(request.getParameter("productId"));

        Product product = extractProductFromRequest(request, productId);

        productDAO.updateProduct(product);

        response.sendRedirect(request.getContextPath()
                + "/ProductController?action=list&success=updated");
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {

        int productId = Integer.parseInt(request.getParameter("id"));

        productDAO.deleteProduct(productId);

        response.sendRedirect(request.getContextPath()
                + "/ProductController?action=list&success=deleted");
    }

    private Product extractProductFromRequest(HttpServletRequest request, int productId) {

        String productName = request.getParameter("productName").trim();
        String category = request.getParameter("category").trim();

        double unitPrice = Double.parseDouble(request.getParameter("unitPrice"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        int threshold = Integer.parseInt(request.getParameter("threshold"));

        String expiryDate = request.getParameter("expiryDate");
        String supplierName = request.getParameter("supplierName");

        if (expiryDate != null) {
            expiryDate = expiryDate.trim();
        }

        if (supplierName != null) {
            supplierName = supplierName.trim();
        }

        return new Product(
                productId,
                productName,
                category,
                unitPrice,
                quantity,
                threshold,
                expiryDate,
                supplierName
        );
    }

    private boolean canManageProduct(HttpServletRequest request) {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            return false;
        }

        User user = (User) session.getAttribute("user");

        return user.getRoleId() == 1 || user.getRoleId() == 2;
    }

    private boolean canDeleteProduct(HttpServletRequest request) {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            return false;
        }

        User user = (User) session.getAttribute("user");

        return user.getRoleId() == 2;
    }
}
