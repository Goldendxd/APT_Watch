package com.alughadi.controller;

import com.alughadi.dao.ProductDAO;
import com.alughadi.dao.ProductDaoImpl;
import com.alughadi.entity.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    private final ProductDAO productDAO = new ProductDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Product> products = productDAO.getAllProducts();
        request.setAttribute("products", products);
        request.getRequestDispatcher("/WEB-INF/views/admin.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equals(action)){
            int id = Integer.parseInt(request.getParameter("id"));
            productDAO.deleteProduct(id);
        }
        if ("save".equals(action)) {
            Product product = new Product();

            String id = request.getParameter("id");
            if (id != null && id.isBlank()) {
                product.setId(Integer.parseInt(id));
            }
            product.setName(request.getParameter("name"));
            product.setBrand(request.getParameter("brand"));
            product.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
            product.setDescription(request.getParameter("description"));
            product.setPrice(new BigDecimal(request.getParameter("price")));

            String oldPrice = request.getParameter("oldPrice");
            if (oldPrice != null && !oldPrice.isBlank()) {
                product.setOldPrice(new BigDecimal(oldPrice));
            }

            String rating = request.getParameter("rating");
            if (rating != null && !rating.isBlank()) {
                product.setRating(Double.parseDouble(rating));
            }
            product.setInStock("on".equals(request.getParameter("inStock")));

            if (product.getId() > 0) {
                productDAO.updateProduct(product);
            } else {
                productDAO.addProduct(product);
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin");
    }

}
