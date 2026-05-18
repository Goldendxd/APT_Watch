<%-- footer.jsp — shared layout footer (footer + modals + scripts)
     Adapted for AluGhadi Watches ecommerce platform
     Included at the end of every page JSP.
     Closes <body> and <html> tags opened by header.jsp.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

  <%-- ======== FOOTER ======== --%>
  <footer>
    <div class="fi">
      <div class="ft">

        <%-- Brand column --%>
        <div class="ft-brand">
          <a class="logo" href="${pageContext.request.contextPath}/" aria-label="AluGhadi home">
            <img src="${pageContext.request.contextPath}/static/images/alughadiweblogo.png" alt="AluGhadi" class="footer-logo-img" />
          </a>
          <p>Nepal's premium destination for fine watches. Timeless craftsmanship delivered with care to your doorstep.</p>
          <div class="ft-socials">
            <a class="ft-social-btn" href="#" aria-label="Facebook"  title="Facebook">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor"><path d="M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z"/></svg>
            </a>
            <a class="ft-social-btn" href="#" aria-label="Instagram" title="Instagram">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="2" width="20" height="20" rx="5" ry="5"/><path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"/><line x1="17.5" y1="6.5" x2="17.51" y2="6.5"/></svg>
            </a>
            <a class="ft-social-btn" href="#" aria-label="Twitter" title="Twitter">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor"><path d="M23 3a10.9 10.9 0 0 1-3.14 1.53 4.48 4.48 0 0 0-7.86 3v1A10.66 10.66 0 0 1 3 4s-4 9 5 13a11.64 11.64 0 0 1-7 2c9 5 20 0 20-11.5a4.5 4.5 0 0 0-.08-.83A7.72 7.72 0 0 0 23 3z"/></svg>
            </a>
          </div>
        </div>

        <%-- Shop links --%>
        <div class="ft-col">
          <h4>Shop</h4>
          <a href="${pageContext.request.contextPath}/products">All Products</a>
          <a href="${pageContext.request.contextPath}/gifting">Gifting</a>
          <a href="${pageContext.request.contextPath}/gifting">For Him</a>
          <a href="${pageContext.request.contextPath}/gifting">For Her</a>
        </div>

        <%-- Company links --%>
        <div class="ft-col">
          <h4>Company</h4>
          <a href="${pageContext.request.contextPath}/about">About Us</a>
          <a href="${pageContext.request.contextPath}/contact">Contact</a>
          <a href="#">Careers</a>
          <a href="#">Blog</a>
        </div>

        <%-- Support links --%>
        <div class="ft-col">
          <h4>Support</h4>
          <a href="mailto:support@alughadi.com">support@alughadi.com</a>
          <a href="tel:+977XXXXXXXX">+977-1-XXXX-XXXX</a>
          <a href="#">Returns &amp; Shipping</a>
          <a href="#">FAQ</a>
        </div>
      </div>

      <%-- Bottom bar --%>
      <div class="fb">
        <p>&copy; 2026 AluGhadi Watches &middot; All rights reserved</p>
        <div style="display:flex;gap:0.6rem;align-items:center;flex-wrap:wrap;">
          <span class="fb-badge">Made in Nepal</span>
          <span class="fb-badge">Secure Payments</span>
        </div>
        <p>Crafted with precision &amp; passion</p>
      </div>
    </div>
  </footer>

  <%-- ======== CART MODAL ======== --%>
  <div class="modal-ov" id="modal-cart" role="dialog" aria-modal="true" aria-label="Shopping cart">
    <div class="modal cart-modal" style="max-width:520px;">
      <button class="modal-close" onclick="closeModal('cart')" aria-label="Close cart">&#10005;</button>
      <div class="modal-h">Shopping Cart</div>
      <div class="modal-sub">Your selected items</div>
      <%-- Use the original forwarded URI so redirectTo works after a servlet forward --%>
      <c:set var="currentPage" value="${not empty requestScope['jakarta.servlet.forward.request_uri'] ? requestScope['jakarta.servlet.forward.request_uri'] : pageContext.request.requestURI}" />
      <c:set var="currentQS"   value="${not empty requestScope['jakarta.servlet.forward.query_string'] ? requestScope['jakarta.servlet.forward.query_string'] : pageContext.request.queryString}" />
      <c:if test="${not empty currentQS}">
        <c:set var="currentPage" value="${currentPage}?${currentQS}" />
      </c:if>
      <div id="cart-items" class="cart-items-wrap">
        <c:choose>
          <c:when test="${empty cartItems}">
            <div class="cart-empty">
              <div class="cart-empty-ico">
                <svg width="36" height="36" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
              </div>
              <p>Your cart is empty.<br/>Start exploring our collection!</p>
            </div>
          </c:when>

          <c:otherwise>
            <c:forEach var="cart" items="${cartItems}">
              <div class="cart-item">
                <img src="${pageContext.request.contextPath}${cart.imageUrl}" alt="${cart.productName}" class="cart-img" />

                <div class="cart-item-main">
                  <div class="cartName">${cart.productName}</div>
                  <div class="cart-brand">${cart.brand}</div>
                  <div class="cart-prices">
                    <span class="newPrice">Rs ${cart.price}</span>
                    <c:if test="${cart.oldPrice > 0}">
                      <span class="oldPrice">Rs ${cart.oldPrice}</span>
                    </c:if>
                  </div>
                </div>

                <div class="cart-item-controls">
                  <div class="cart-qty-row">
                    <c:choose>
                      <c:when test="${cart.quantity <= 1}">
                        <form action="${pageContext.request.contextPath}/cart" method="post" style="display:contents;">
                          <input type="hidden" name="action" value="remove">
                          <input type="hidden" name="cartId" value="${cart.id}">
                          <input type="hidden" name="redirectTo" value="${currentPage}">
                          <button class="cart-qty-btn" type="submit" title="Remove item">&#8722;</button>
                        </form>
                      </c:when>
                      <c:otherwise>
                        <form action="${pageContext.request.contextPath}/cart" method="post" style="display:contents;">
                          <input type="hidden" name="action" value="update">
                          <input type="hidden" name="cartId" value="${cart.id}">
                          <input type="hidden" name="quantity" value="${cart.quantity - 1}">
                          <input type="hidden" name="redirectTo" value="${currentPage}">
                          <button class="cart-qty-btn" type="submit" title="Decrease quantity">&#8722;</button>
                        </form>
                      </c:otherwise>
                    </c:choose>

                    <span class="cart-qty-val">${cart.quantity}</span>

                    <form action="${pageContext.request.contextPath}/cart" method="post" style="display:contents;">
                      <input type="hidden" name="action" value="update">
                      <input type="hidden" name="cartId" value="${cart.id}">
                      <input type="hidden" name="quantity" value="${cart.quantity + 1}">
                      <input type="hidden" name="redirectTo" value="${currentPage}">
                      <button class="cart-qty-btn" type="submit" title="Increase quantity">&#43;</button>
                    </form>
                  </div>

                  <form action="${pageContext.request.contextPath}/cart" method="post" style="display:contents;">
                    <input type="hidden" name="action" value="remove">
                    <input type="hidden" name="cartId" value="${cart.id}">
                    <input type="hidden" name="redirectTo" value="${currentPage}">
                    <button class="cart-delete-btn" type="submit" title="Remove from cart">
                      <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="3 6 5 6 21 6"/><path d="M19 6l-1 14a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2L5 6"/><path d="M10 11v6"/><path d="M14 11v6"/></svg>
                    </button>
                  </form>
                </div>
              </div>
            </c:forEach>
          </c:otherwise>
        </c:choose>
      </div>

      <c:if test="${not empty cartItems}">
        <div class="cart-total-row">
          <span>Grand Total</span>
          <strong>Rs <fmt:formatNumber value="${grandTotal}" pattern="#,##0"/></strong>
        </div>
      </c:if>

      <c:choose>
        <c:when test="${not empty cartItems}">
          <a href="${pageContext.request.contextPath}/checkout" class="btn btn-g btn-full" style="text-decoration:none;">
            Proceed to Checkout &#8594;
          </a>
        </c:when>
        <c:otherwise>
          <a href="${pageContext.request.contextPath}/products" class="btn btn-g btn-full" style="text-decoration:none;">
            Browse Products &#8594;
          </a>
        </c:otherwise>
      </c:choose>
    </div>
  </div>


  <%-- ======== TOAST CONTAINER ======== --%>
  <div class="toast-c" id="toast-container" aria-live="polite"></div>

  <%-- ======== SHARED SCRIPTS ======== --%>
  <script src="${pageContext.request.contextPath}/static/js/app.js"></script>
  <script>
    /* ---------- Toast Helper ---------- */
    function showToast(title, msg, icon) {
      var c = document.getElementById('toast-container');
      if (!c) return;
      var t = document.createElement('div');
      t.className = 'toast';
      t.innerHTML = '<div class="t-ico">' + (icon || '') + '</div>'
        + '<div><div class="t-h">' + title + '</div>'
        + (msg ? '<div class="t-p">' + msg + '</div>' : '') + '</div>';
      c.appendChild(t);
      setTimeout(function () { t.remove(); }, 4000);
    }
  </script>

</body>
</html>
