package com.alughadi.controller;

import com.alughadi.dao.CartDaoImpl;
import com.alughadi.entity.Cart;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;

/**
 * CartFragmentServlet — returns the cart modal HTML as a partial page (AJAX-style).
 *
 * URL: /cart-fragment
 *
 * GET /cart-fragment -> check if user is logged in.
 *   - Not logged in: return empty cart placeholders.
 *   - Logged in: fetch cart items from DB, build HTML rows with qty controls
 *     (minus/plus buttons, number input, delete button), and append the
 *     total price and item count spans at the bottom.
 *
 * The response is raw HTML, not a full page — JS on the front-end
 * inserts it directly into the cart modal container.
 *
 * Quantities are capped at stock_quantity; the + button is disabled at max stock.
 * If stock is 0 the item shows "Out of Stock" instead of a price.
 */
@WebServlet("/cart-fragment")
public class CartFragmentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        res.setContentType("text/html;charset=UTF-8");

        Object uid = req.getSession(false) != null ? req.getSession(false).getAttribute("authUserId") : null;
        if (uid == null) {
            res.getWriter().write("<div id=\"cart-items-inner\"></div><span id=\"cart-total-val\">0</span><span id=\"cart-count-val\">0</span>");
            return;
        }

        int userId = (Integer) uid;
        CartDaoImpl cartDao = new CartDaoImpl();
        List<Cart> items = cartDao.getCartItems(userId);
        double total = cartDao.getGrandTotal(userId);
        int count = cartDao.getCartCount(userId);

        NumberFormat nf = NumberFormat.getInstance(new Locale("en", "NP"));
        nf.setGroupingUsed(true);
        nf.setMaximumFractionDigits(0);

        PrintWriter out = res.getWriter();
        String ctx = req.getContextPath();

        out.write("<div id=\"cart-items-inner\">");
        if (items.isEmpty()) {
            out.write("<div class=\"cart-empty\"><div class=\"cart-empty-ico\">"
                + "<svg width=\"36\" height=\"36\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"1.5\" stroke-linecap=\"round\" stroke-linejoin=\"round\">"
                + "<circle cx=\"9\" cy=\"21\" r=\"1\"/><circle cx=\"20\" cy=\"21\" r=\"1\"/>"
                + "<path d=\"M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6\"/></svg></div>"
                + "<p>Your cart is empty.<br/>Start exploring our collection!</p></div>");
        } else {
            String currentPage = ctx + "/cart";
            for (Cart c : items) {
                String outOfStock = c.getStockQuantity() <= 0 ? " (out of stock)" : "";
                String priceHtml = c.getStockQuantity() <= 0
                    ? "<div style=\"color:#c33;font-size:0.78rem;font-weight:700;margin-top:0.25rem;\">Out of Stock</div>"
                    : "<div class=\"cart-prices\"><span class=\"newPrice\">Rs " + nf.format(c.getPrice()) + "</span>"
                        + (c.getOldPrice() > 0 ? "<span class=\"oldPrice\">Rs " + nf.format(c.getOldPrice()) + "</span>" : "")
                        + "</div>";

                boolean atMax = c.getStockQuantity() <= 0 || c.getQuantity() >= c.getStockQuantity();
                String minusBtn = c.getQuantity() <= 1
                    ? "<form action=\"" + ctx + "/cart\" method=\"post\" style=\"display:contents;\">"
                        + "<input type=\"hidden\" name=\"action\" value=\"remove\">"
                        + "<input type=\"hidden\" name=\"cartId\" value=\"" + c.getId() + "\">"
                        + "<input type=\"hidden\" name=\"redirectTo\" value=\"" + currentPage + "\">"
                        + "<button class=\"cart-qty-btn\" type=\"submit\" title=\"Remove item\">&#8722;</button></form>"
                    : "<form action=\"" + ctx + "/cart\" method=\"post\" style=\"display:contents;\">"
                        + "<input type=\"hidden\" name=\"action\" value=\"update\">"
                        + "<input type=\"hidden\" name=\"cartId\" value=\"" + c.getId() + "\">"
                        + "<input type=\"hidden\" name=\"quantity\" value=\"" + (c.getQuantity() - 1) + "\">"
                        + "<input type=\"hidden\" name=\"redirectTo\" value=\"" + currentPage + "\">"
                        + "<button class=\"cart-qty-btn\" type=\"submit\" title=\"Decrease quantity\">&#8722;</button></form>";

                String qtyInput = "<form action=\"" + ctx + "/cart\" method=\"post\" style=\"display:contents;\">"
                    + "<input type=\"hidden\" name=\"action\" value=\"update\">"
                    + "<input type=\"hidden\" name=\"cartId\" value=\"" + c.getId() + "\">"
                    + "<input type=\"hidden\" name=\"redirectTo\" value=\"" + currentPage + "\">"
                    + "<input class=\"cart-qty-val\" type=\"number\" name=\"quantity\" min=\"1\" max=\"" + c.getStockQuantity() + "\" value=\"" + c.getQuantity() + "\""
                    + (c.getStockQuantity() <= 0 ? " disabled" : "")
                    + " onchange=\"this.form.submit()\" style=\"width:42px;text-align:center;border:0;background:#fff;font-weight:700;\"></form>";

                String plusBtn = "<form action=\"" + ctx + "/cart\" method=\"post\" style=\"display:contents;\">"
                    + "<input type=\"hidden\" name=\"action\" value=\"update\">"
                    + "<input type=\"hidden\" name=\"cartId\" value=\"" + c.getId() + "\">"
                    + "<input type=\"hidden\" name=\"quantity\" value=\"" + (c.getQuantity() + 1) + "\">"
                    + "<input type=\"hidden\" name=\"redirectTo\" value=\"" + currentPage + "\">"
                    + (atMax
                        ? "<button class=\"cart-qty-btn\" type=\"button\" disabled title=\"Max stock\" style=\"cursor:not-allowed;opacity:.5;\">&#43;</button>"
                        : "<button class=\"cart-qty-btn\" type=\"submit\" title=\"Increase quantity\">&#43;</button>")
                    + "</form>";

                String deleteBtn = "<form action=\"" + ctx + "/cart\" method=\"post\" style=\"display:contents;\">"
                    + "<input type=\"hidden\" name=\"action\" value=\"remove\">"
                    + "<input type=\"hidden\" name=\"cartId\" value=\"" + c.getId() + "\">"
                    + "<input type=\"hidden\" name=\"redirectTo\" value=\"" + currentPage + "\">"
                    + "<button class=\"cart-delete-btn\" type=\"submit\" title=\"Remove from cart\">"
                    + "<svg width=\"14\" height=\"14\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\">"
                    + "<polyline points=\"3 6 5 6 21 6\"/><path d=\"M19 6l-1 14a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2L5 6\"/>"
                    + "<path d=\"M10 11v6\"/><path d=\"M14 11v6\"/></svg></button></form>";

                out.write("<div class=\"cart-item\">"
                    + "<img src=\"" + ctx + c.getImageUrl() + "\" alt=\"" + escHtml(c.getProductName()) + "\" class=\"cart-img\" />"
                    + "<div class=\"cart-item-main\">"
                    + "<div class=\"cartName\">" + escHtml(c.getProductName()) + "</div>"
                    + "<div class=\"cart-brand\">" + escHtml(c.getBrand()) + "</div>"
                    + priceHtml
                    + "</div>"
                    + "<div class=\"cart-item-controls\">"
                    + "<div class=\"cart-qty-row\">" + minusBtn + qtyInput + plusBtn + "</div>"
                    + deleteBtn
                    + "</div>"
                    + "</div>");
            }
        }
        out.write("</div>");
        out.write("<span id=\"cart-total-val\">" + nf.format(total) + "</span>");
        out.write("<span id=\"cart-count-val\">" + count + "</span>");
    }

    private String escHtml(String s) {
        if (s == null) return "";
        return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
    }
}
