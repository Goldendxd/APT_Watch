package com.alughadi.controller;

import com.alughadi.dao.CartDao;
import com.alughadi.dao.CartDaoImpl;
import com.alughadi.dao.ProductDAO;
import com.alughadi.dao.ProductDaoImpl;
import com.alughadi.entity.Product;
import com.alughadi.utils.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductDAO productDAO = new ProductDaoImpl();
        List<Product> productList = productDAO.getAllProducts();
        request.setAttribute("productList", productList);
        request.setAttribute("pageTitle", "Shop - Premium Watches | AluGhadi");
        request.setAttribute("pageDesc", "Browse our complete collection of premium watches. Find the perfect timepiece.");
        request.setAttribute("activeNav", "products");
        Object userIdObj = SessionUtil.getAttribute(request, "authUserId");
        if (userIdObj != null) {
            CartDao cartDao = new CartDaoImpl();
            List<Integer> cartProductIds = cartDao.getCartProductIds((Integer) userIdObj);

            request.setAttribute("cartProductIds", cartProductIds);
        }

//        HttpSession session = request.getSession(false);
//        if (session != null){
//            Integer justAddedId = (Integer) session.getAttribute("JustAddedProductId");
//            if (justAddedId != null){
//                request.setAttribute("justAddedId", justAddedId);
//                session.removeAttribute("justAddedProductId");
//            }
//        }
        request.getRequestDispatcher("/WEB-INF/views/products.jsp").forward(request, response);
    }
}
