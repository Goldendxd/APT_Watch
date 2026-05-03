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
            <a class="ft-social-btn" href="#" aria-label="Facebook"  title="Facebook">&#128526;</a>
            <a class="ft-social-btn" href="#" aria-label="Instagram" title="Instagram">&#128247;</a>
            <a class="ft-social-btn" href="#" aria-label="Twitter"   title="Twitter">&#128038;</a>
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
          <span class="fb-badge">&#127473;&#127477; Made in Nepal</span>
          <span class="fb-badge">&#128274; Secure Payments</span>
        </div>
        <p>Crafted with precision &amp; passion</p>
      </div>
    </div>
  </footer>

  <%-- ======== CART MODAL ======== --%>
  <div class="modal-ov" id="modal-cart" role="dialog" aria-modal="true" aria-label="Shopping cart">
    <div class="modal cart-modal" style="max-width:520px;">
      <button class="modal-close" onclick="closeModal('cart')" aria-label="Close cart">&#10005;</button>
      <div class="modal-h">&#128717; Shopping Cart</div>
      <div class="modal-sub">Your selected items</div>
      <div id="cart-items" class="cart-items-wrap">
        <c:choose>
          <c:when test="${empty cartItems}">
            <div class="cart-empty">
              <div class="cart-empty-ico">&#128717;</div>
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
                          <button class="cart-qty-btn" type="submit" title="Remove item">&#8722;</button>
                        </form>
                      </c:when>
                      <c:otherwise>
                        <form action="${pageContext.request.contextPath}/cart" method="post" style="display:contents;">
                          <input type="hidden" name="action" value="update">
                          <input type="hidden" name="cartId" value="${cart.id}">
                          <input type="hidden" name="quantity" value="${cart.quantity - 1}">
                          <button class="cart-qty-btn" type="submit" title="Decrease quantity">&#8722;</button>
                        </form>
                      </c:otherwise>
                    </c:choose>

                    <span class="cart-qty-val">${cart.quantity}</span>

                    <form action="${pageContext.request.contextPath}/cart" method="post" style="display:contents;">
                      <input type="hidden" name="action" value="update">
                      <input type="hidden" name="cartId" value="${cart.id}">
                      <input type="hidden" name="quantity" value="${cart.quantity + 1}">
                      <button class="cart-qty-btn" type="submit" title="Increase quantity">&#43;</button>
                    </form>
                  </div>

                  <form action="${pageContext.request.contextPath}/cart" method="post" style="display:contents;">
                    <input type="hidden" name="action" value="remove">
                    <input type="hidden" name="cartId" value="${cart.id}">
                    <button class="cart-delete-btn" type="submit" title="Remove from cart">&#128465;</button>
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
      t.innerHTML = '<div class="t-ico">' + (icon || '&#10024;') + '</div>'
        + '<div><div class="t-h">' + title + '</div>'
        + (msg ? '<div class="t-p">' + msg + '</div>' : '') + '</div>';
      c.appendChild(t);
      setTimeout(function () { t.remove(); }, 4000);
    }
  </script>

</body>
</html>
