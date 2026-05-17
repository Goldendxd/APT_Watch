package com.alughadi.controller;

import com.alughadi.dao.ProductDAO;
import com.alughadi.dao.ProductDaoImpl;
import com.alughadi.entity.Product;
import com.alughadi.utils.ImageUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/admin")
@MultipartConfig
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
            if (id != null && !id.isBlank()) {
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
            int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));
            product.setStockQuantity(stockQuantity);
            product.setInStock(stockQuantity > 0);

            Part imagePart = request.getPart("imageFile");
            String imagePath = null;

            if (imagePart != null && imagePart.getSize() > 0) {
                imagePath = ImageUtil.uploadImage(imagePart, getServletContext());

                if (imagePath == null) {
                    request.setAttribute("errorMessage", "Invalid image. Please upload only JPG, JPEG, or PNG files.");
                    request.setAttribute("products", productDAO.getAllProducts());
                    request.getRequestDispatcher("/WEB-INF/views/admin.jsp").forward(request, response);
                    return;
                }
            } else {
                String imageUrl = request.getParameter("imageUrl");
                String existingImageUrl = request.getParameter("existingImageUrl");

                if (imageUrl != null && !imageUrl.isBlank()) {
                    imagePath = imageUrl;
                } else if (existingImageUrl != null && !existingImageUrl.isBlank()) {
                    imagePath = existingImageUrl;
                }
            }
            product.setImageUrl(imagePath);

            if (product.getId() > 0) {
                productDAO.updateProduct(product);
            } else {
                productDAO.addProduct(product);
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin");
    }

}
