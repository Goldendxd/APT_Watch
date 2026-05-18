<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%@ page import="com.alughadi.dao.CartDaoImpl" %>
<%@ page import="com.alughadi.entity.Cart" %>
<%@ page import="java.util.List" %>
<%
    Object uid = session.getAttribute("authUserId");
    if (uid == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    int userId = (Integer) uid;
    CartDaoImpl cartDao = new CartDaoImpl();
    List<Cart> items = cartDao.getCartItems(userId);
    double total     = cartDao.getGrandTotal(userId);
    int    count     = cartDao.getCartCount(userId);
    double shipping  = total >= 5000 ? 0 : 200;
    double grandTotal = total + shipping;
    long   amountPaisa = Math.round(grandTotal * 100);

    request.setAttribute("cartItems",   items);
    request.setAttribute("grandTotal",  total);
    request.setAttribute("shipping",    shipping);
    request.setAttribute("finalTotal",  grandTotal);
    request.setAttribute("amountPaisa", amountPaisa);
    request.setAttribute("cartCount",   count);
    request.setAttribute("pageTitle",   "Checkout | AluGhadi Watches");
    request.setAttribute("pageDesc",    "Complete your order with Khalti or Cash on Delivery.");
    request.setAttribute("activeNav",   "products");
    request.setAttribute("pageStyle",   "checkout");
%>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<!-- HERO -->
<div class="page-hero" style="min-height:28vh;">
  <div class="ph-img">
    <img src="${pageContext.request.contextPath}/static/images/products/hero_products.png"
         alt="Checkout" style="object-position:center" />
  </div>
  <div class="ph-ov"
       style="background:linear-gradient(180deg,rgba(26,107,56,0.25) 0%,rgba(11,28,16,0.88) 100%);"></div>
  <div class="ph-body">
    <div class="ph-chip">Secure Checkout</div>
    <h1 class="ph-h">Complete Your Order</h1>
    <p class="ph-sub">Review your items, enter shipping details, and choose your payment method.</p>
  </div>
</div>

<div class="pg-body checkout-page">

  <c:if test="${not empty payError}">
    <div style="background:#fff1f1;border:1.5px solid rgba(200,60,60,0.3);border-radius:12px;padding:0.85rem 1.1rem;margin-bottom:1.5rem;color:#c33;font-weight:600;font-size:0.88rem;">
      &#9888; ${payError}
    </div>
  </c:if>

  <c:choose>
    <c:when test="${empty cartItems}">
      <div class="checkout-empty gc" style="text-align:center;padding:5rem 2rem;">
        <div style="font-size:3rem;margin-bottom:1rem;opacity:0.5;">&#128717;</div>
        <h2 style="margin-bottom:0.5rem;">Your cart is empty</h2>
        <p style="color:var(--muted);margin-bottom:1.5rem;">Add some watches to your cart before checking out.</p>
        <a href="${pageContext.request.contextPath}/products" class="btn-fill" style="text-decoration:none;padding:0.75rem 1.75rem;border-radius:12px;">Browse Products &#8594;</a>
      </div>
    </c:when>

    <c:otherwise>
      <div class="checkout-layout">

        <%-- LEFT: shipping info + payment choice --%>
        <div class="checkout-forms">

          <%-- Shipping --%>
          <div class="gc checkout-section reveal">
            <div class="sec-tag">Shipping Information</div>
            <h2 class="checkout-section-title">Delivery Details</h2>

            <div class="fg-row">
              <div class="fg">
                <label for="ship-fname">Full Name *</label>
                <input type="text" id="ship-fname" placeholder="e.g. Ram Bahadur" required />
              </div>
              <div class="fg">
                <label for="ship-phone">Phone Number *</label>
                <input type="tel" id="ship-phone" placeholder="98XXXXXXXX" required />
              </div>
            </div>
            <div class="fg">
              <label for="ship-email">Email Address</label>
              <input type="email" id="ship-email" placeholder="you@example.com" />
            </div>
            <div class="fg">
              <label for="ship-address">Street Address *</label>
              <input type="text" id="ship-address" placeholder="e.g. Thamel, Kathmandu" required />
            </div>
            <div class="fg-row">
              <div class="fg">
                <label for="ship-city">City *</label>
                <input type="text" id="ship-city" placeholder="e.g. Kathmandu" required />
              </div>
              <div class="fg">
                <label for="ship-zip">Postal Code</label>
                <input type="text" id="ship-zip" placeholder="e.g. 44600" />
              </div>
            </div>
          </div>

          <%-- Payment Method --%>
          <div class="gc checkout-section reveal">
            <div class="sec-tag">Payment Method</div>
            <h2 class="checkout-section-title">Choose how to pay</h2>

            <div class="payment-options">

              <%-- Khalti --%>
              <label class="payment-option" for="pay-khalti">
                <input type="radio" name="paymentMethod" id="pay-khalti" value="khalti" checked />
                <div class="payment-option-card">
                  <div class="payment-option-icon" style="background:#5C2D91;">
                    <span style="font-weight:900;color:#fff;font-size:1.1rem;">K</span>
                  </div>
                  <div class="payment-option-info">
                    <div class="payment-option-name">Khalti</div>
                    <div class="payment-option-desc">Pay securely with Khalti digital wallet</div>
                  </div>
                  <div class="payment-option-check">&#10003;</div>
                </div>
              </label>

              <%-- Cash on Delivery --%>
              <label class="payment-option" for="pay-cod">
                <input type="radio" name="paymentMethod" id="pay-cod" value="cod" />
                <div class="payment-option-card">
                  <div class="payment-option-icon" style="background:var(--green);">
                    <span style="font-size:1.2rem;">&#128181;</span>
                  </div>
                  <div class="payment-option-info">
                    <div class="payment-option-name">Cash on Delivery</div>
                    <div class="payment-option-desc">Pay when your order arrives</div>
                  </div>
                  <div class="payment-option-check">&#10003;</div>
                </div>
              </label>
            </div>
          </div>
        </div>

        <%-- RIGHT: order summary + place order --%>
        <div class="checkout-summary gc reveal">
          <div class="sec-tag">Order Summary</div>
          <h2 class="checkout-section-title">Your Items</h2>

          <div class="checkout-items">
            <c:forEach var="cart" items="${cartItems}">
              <div class="checkout-item">
                <img src="${pageContext.request.contextPath}${cart.imageUrl}"
                     alt="${cart.productName}" class="checkout-item-img" />
                <div class="checkout-item-info">
                  <div class="checkout-item-name">${cart.productName}</div>
                  <div class="checkout-item-brand">${cart.brand}</div>
                  <div class="checkout-item-price">
                    Rs <fmt:formatNumber value="${cart.price}" pattern="#,##0"/> &times; ${cart.quantity}
                  </div>
                </div>
                <div class="checkout-item-total">
                  Rs <fmt:formatNumber value="${cart.totalPrice}" pattern="#,##0"/>
                </div>
              </div>
            </c:forEach>
          </div>

          <div class="checkout-totals">
            <div class="checkout-total-line">
              <span>Subtotal</span>
              <span>Rs <fmt:formatNumber value="${grandTotal}" pattern="#,##0"/></span>
            </div>
            <div class="checkout-total-line">
              <span>Shipping</span>
              <c:choose>
                <c:when test="${shipping == 0}">
                  <span style="color:var(--green);font-weight:700;">Free</span>
                </c:when>
                <c:otherwise><span>Rs 200</span></c:otherwise>
              </c:choose>
            </div>
            <div class="checkout-total-line checkout-grand-total">
              <span>Grand Total</span>
              <strong>Rs <fmt:formatNumber value="${finalTotal}" pattern="#,##0"/></strong>
            </div>
          </div>

          <%-- Hidden Khalti form — submitted by JS --%>
          <form id="khalti-form" action="${pageContext.request.contextPath}/khalti-pay" method="post" style="display:none;">
            <input type="hidden" name="fullName"    id="hid-name" />
            <input type="hidden" name="phone"       id="hid-phone" />
            <input type="hidden" name="email"       id="hid-email" />
            <input type="hidden" name="amountPaisa" value="${amountPaisa}" />
          </form>

          <button class="btn-fill" id="place-order-btn" type="button"
                  onclick="placeOrder()"
                  style="display:block;width:100%;text-align:center;padding:0.85rem;border-radius:12px;font-weight:700;font-size:1rem;margin-bottom:0.75rem;border:none;cursor:pointer;">
            Place Order &#8594;
          </button>

          <div class="checkout-secure-note">
            <span>&#128274;</span> Payments are processed securely
          </div>
        </div>
      </div>
    </c:otherwise>
  </c:choose>
</div>

<%-- COD success modal --%>
<div class="modal-ov" id="modal-order-success" role="dialog" aria-modal="true">
  <div class="modal" style="max-width:440px;text-align:center;">
    <div style="font-size:3.5rem;margin-bottom:0.75rem;">&#10003;</div>
    <div class="modal-h" style="color:var(--green);">Order Placed!</div>
    <div class="modal-sub" style="margin-bottom:0.75rem;">
      Thank you for shopping with AluGhadi Watches.<br/>
      Our team will contact you to confirm delivery.
    </div>
    <div style="background:var(--green-light);border:1.5px solid var(--green-mid);border-radius:12px;padding:0.85rem;margin-bottom:1.25rem;">
      <div style="font-size:0.72rem;font-weight:700;color:var(--green);text-transform:uppercase;letter-spacing:0.1em;margin-bottom:0.3rem;">Order ID</div>
      <div style="font-size:1.1rem;font-weight:900;color:var(--text);" id="order-id-display">AG-000000</div>
    </div>
    <a href="${pageContext.request.contextPath}/products" class="btn-fill"
       style="display:block;text-decoration:none;padding:0.75rem;border-radius:12px;font-weight:700;text-align:center;">
      Continue Shopping &#8594;
    </a>
  </div>
</div>

<script>
  function placeOrder() {
    var fname   = document.getElementById('ship-fname').value.trim();
    var phone   = document.getElementById('ship-phone').value.trim();
    var addr    = document.getElementById('ship-address').value.trim();
    var city    = document.getElementById('ship-city').value.trim();
    var method  = document.querySelector('input[name="paymentMethod"]:checked').value;

    if (!fname || !phone || !addr || !city) {
      if (typeof showToast === 'function') {
        showToast('Missing Information', 'Please fill in all required shipping fields.', '&#9888;');
      } else {
        alert('Please fill in all required shipping fields.');
      }
      return;
    }

    if (method === 'khalti') {
      document.getElementById('hid-name').value  = fname;
      document.getElementById('hid-phone').value = phone;
      document.getElementById('hid-email').value = document.getElementById('ship-email').value.trim();
      document.getElementById('khalti-form').submit();
    } else {
      // Cash on Delivery — show confirmation modal
      var orderId = 'AG-' + Math.floor(100000 + Math.random() * 900000);
      document.getElementById('order-id-display').textContent = orderId;
      var modal = document.getElementById('modal-order-success');
      if (modal) { modal.classList.add('active'); document.body.style.overflow = 'hidden'; }
    }
  }

  // Highlight selected payment card
  document.querySelectorAll('input[name="paymentMethod"]').forEach(function(radio) {
    radio.addEventListener('change', function() {
      document.querySelectorAll('.payment-option-card').forEach(function(card) {
        card.style.borderColor = '';
        card.style.background  = '';
      });
      var card = this.closest('.payment-option').querySelector('.payment-option-card');
      card.style.borderColor = 'var(--green)';
      card.style.background  = 'var(--green-light)';
    });
  });
</script>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
