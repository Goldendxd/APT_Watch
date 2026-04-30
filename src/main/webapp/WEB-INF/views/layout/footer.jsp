<%-- footer.jsp — shared layout footer (footer + modals + scripts)
     Adapted for AluGhadi Watches ecommerce platform
     Included at the end of every page JSP.
     Closes <body> and <html> tags opened by header.jsp.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

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
    <div class="modal" style="max-width:500px;">
      <button class="modal-close" onclick="closeModal('cart')" aria-label="Close cart">&#10005;</button>
      <div class="modal-h">&#128717; Shopping Cart</div>
      <div class="modal-sub">Your selected items</div>
      <div id="cart-items" style="max-height:320px;overflow-y:auto;margin:1rem 0;">
        <div class="cart-empty">
          <div class="cart-empty-ico">&#128717;</div>
          <p>Your cart is empty.<br/>Start exploring our collection!</p>
        </div>
      </div>
      <div style="border-top:1.5px solid var(--border);padding-top:1rem;margin-top:0.5rem;">
        <div style="display:flex;justify-content:space-between;font-weight:800;margin-bottom:1rem;font-size:1.05rem;">
          <span>Total</span>
          <span id="cart-total" style="color:var(--green);">NPR 0</span>
        </div>
        <button class="btn btn-g btn-full" onclick="closeModal('cart')">
          Proceed to Checkout &#8594;
        </button>
      </div>
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
