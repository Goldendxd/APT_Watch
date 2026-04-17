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
        <div class="ft-brand">
          <a class="logo" href="${pageContext.request.contextPath}/">
            <div style="font-size:1.8rem;font-weight:900;">AG</div>
            <span class="logo-brand" style="font-weight:900;">AluGhadi</span>
          </a>
          <p>Premium watches for every moment. Timeless style, exceptional quality.</p>
        </div>
        <div class="ft-col">
          <h4>Shop</h4>
          <a href="${pageContext.request.contextPath}/products">Products</a>
          <a href="${pageContext.request.contextPath}/gifting">Gifting</a>
          <a href="${pageContext.request.contextPath}/sale">Sale</a>
        </div>
        <div class="ft-col">
          <h4>Company</h4>
          <a href="${pageContext.request.contextPath}/about">About Us</a>
          <a href="${pageContext.request.contextPath}/contact">Contact</a>
          <a href="${pageContext.request.contextPath}/faq">FAQ</a>
        </div>
        <div class="ft-col">
          <h4>Support</h4>
          <a>Email: support@alughadi.com</a>
          <a>Phone: +977-1-XXXX-XXXX</a>
          <a href="${pageContext.request.contextPath}/returns">Returns &amp; Shipping</a>
        </div>
      </div>
      <div class="fb">
        <p>© 2026 AluGhadi Watches · All rights reserved</p>
        <p>Crafted with precision and passion</p>
      </div>
    </div>
  </footer>

  <%-- ======== FLOATING CART BUTTON ======== --%>
  <button id="cart-btn" type="button" onclick="openCart()">Cart (0)</button>

  <%-- ======== CART MODAL ======== --%>
  <div class="modal-ov" id="modal-cart">
    <div class="modal" style="max-width:500px;">
      <button class="modal-close" onclick="closeModal('cart')">✕</button>
      <div class="modal-h">Shopping Cart</div>
      <div class="modal-sub">Items in your cart</div>
      <div id="cart-items" style="max-height:300px;overflow-y:auto;margin:1rem 0;">
        <div style="text-align:center;padding:2rem;color:var(--muted);">
          <div style="font-size:2rem;margin-bottom:0.5rem;">Cart</div>
          <div style="font-size:0.9rem;">Your cart is empty</div>
        </div>
      </div>
      <div style="border-top:1.5px solid var(--border);padding-top:1rem;margin-top:1rem;">
        <div style="display:flex;justify-content:space-between;font-weight:700;margin-bottom:1rem;">
          <span>Total:</span>
          <span id="cart-total">$0.00</span>
        </div>
        <button class="btn-fill" style="width:100%;">Proceed to Checkout</button>
      </div>
    </div>
  </div>

  <%-- ======== SHARED SCRIPTS ======== --%>
  <script src="${pageContext.request.contextPath}/static/app.js"></script>
  <script>
    // Hide loading screen when page loads
    window.addEventListener('load', function() {
      var loader = document.getElementById('page-loader');
      if (loader) {
        loader.style.opacity = '0';
        setTimeout(function() { loader.style.display = 'none'; }, 300);
      }
    });

    // Navigation and UI functions
    function toggleSidebar() {
      var sidebar = document.getElementById('sidebar');
      var overlay = document.getElementById('sidebar-overlay');
      sidebar.classList.toggle('active');
      overlay.classList.toggle('active');
    }

    function closeSidebar() {
      var sidebar = document.getElementById('sidebar');
      var overlay = document.getElementById('sidebar-overlay');
      sidebar.classList.remove('active');
      overlay.classList.remove('active');
    }

    function showModal(modalId) {
      var modal = document.getElementById('modal-' + modalId);
      if (modal) modal.classList.add('active');
    }

    function closeModal(modalId) {
      var modal = document.getElementById('modal-' + modalId);
      if (modal) modal.classList.remove('active');
    }

    function openCart() {
      showModal('cart');
    }

    // Smooth scroll behavior
    document.querySelectorAll('a[href^="#"]').forEach(function(anchor) {
      anchor.addEventListener('click', function (e) {
        e.preventDefault();
        var target = document.querySelector(this.getAttribute('href'));
        if (target) target.scrollIntoView({ behavior: 'smooth' });
      });
    });
  </script>

</body>
</html>
