<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%-- Load cart data via scriptlet since this JSP is mapped directly in web.xml --%>
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
    double total = cartDao.getGrandTotal(userId);
    int count = cartDao.getCartCount(userId);
    request.setAttribute("cartItems", items);
    request.setAttribute("grandTotal", total);
    request.setAttribute("cartCount", count);
    request.setAttribute("pageTitle", "Checkout | AluGhadi Watches");
    request.setAttribute("pageDesc", "Complete your order with eSewa, Khalti, or Cash on Delivery.");
    request.setAttribute("activeNav", "products");
    request.setAttribute("pageStyle", "checkout");
%>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<!-- HERO -->
<div class="page-hero" style="min-height:28vh;">
  <div class="ph-img">
    <img
      src="${pageContext.request.contextPath}/static/images/products/hero_products.png"
      alt="Checkout"
      style="object-position: center"
    />
  </div>
  <div
    class="ph-ov"
    style="background: linear-gradient(180deg, rgba(26,107,56,0.25) 0%, rgba(11,28,16,0.88) 100%);"
  ></div>
  <div class="ph-body">
    <div class="ph-chip">Secure Checkout</div>
    <h1 class="ph-h">Complete Your Order</h1>
    <p class="ph-sub">Review your items, enter shipping details, and choose your payment method.</p>
  </div>
</div>

<div class="pg-body checkout-page">
  <c:choose>
    <c:when test="${empty cartItems}">
      <div class="checkout-empty gc">
        <div style="font-size:3rem;margin-bottom:1rem;opacity:0.5;">&#128717;</div>
        <h2 style="margin-bottom:0.5rem;">Your cart is empty</h2>
        <p style="color:var(--muted);margin-bottom:1.5rem;">Add some watches to your cart before checking out.</p>
        <a href="${pageContext.request.contextPath}/products" class="btn btn-g">Browse Products &#8594;</a>
      </div>
    </c:when>
    <c:otherwise>
      <div class="checkout-layout">
        <!-- LEFT: Shipping + Payment -->
        <div class="checkout-forms">
          <!-- Shipping Info -->
          <div class="gc checkout-section reveal">
            <div class="sec-tag">Shipping Information</div>
            <h2 class="checkout-section-title">Delivery Details</h2>

            <div class="fg-row">
              <div class="fg">
                <label for="ship-fname">Full Name</label>
                <input type="text" id="ship-fname" placeholder="e.g. Ram Bahadur" required />
              </div>
              <div class="fg">
                <label for="ship-phone">Phone Number</label>
                <input type="tel" id="ship-phone" placeholder="98XXXXXXXX" required />
              </div>
            </div>
            <div class="fg">
              <label for="ship-email">Email Address</label>
              <input type="email" id="ship-email" placeholder="you@example.com" />
            </div>
            <div class="fg">
              <label for="ship-address">Street Address</label>
              <input type="text" id="ship-address" placeholder="e.g. Thamel, Kathmandu" required />
            </div>
            <div class="fg-row">
              <div class="fg">
                <label for="ship-city">City</label>
                <input type="text" id="ship-city" placeholder="e.g. Kathmandu" required />
              </div>
              <div class="fg">
                <label for="ship-zip">Postal Code</label>
                <input type="text" id="ship-zip" placeholder="e.g. 44600" />
              </div>
            </div>
          </div>

          <!-- Payment Method -->
          <div class="gc checkout-section reveal">
            <div class="sec-tag">Payment Method</div>
            <h2 class="checkout-section-title">Choose how to pay</h2>

            <div class="payment-options">
              <label class="payment-option" for="pay-esewa">
                <input type="radio" name="paymentMethod" id="pay-esewa" value="esewa" checked />
                <div class="payment-option-card">
                  <div class="payment-option-icon" style="background:#60BB46;">
                    <span style="font-weight:900;color:#fff;font-size:1.1rem;">e</span>
                  </div>
                  <div class="payment-option-info">
                    <div class="payment-option-name">eSewa</div>
                    <div class="payment-option-desc">Pay with your eSewa digital wallet</div>
                  </div>
                  <div class="payment-option-check">&#10003;</div>
                </div>
              </label>

              <label class="payment-option" for="pay-khalti">
                <input type="radio" name="paymentMethod" id="pay-khalti" value="khalti" />
                <div class="payment-option-card">
                  <div class="payment-option-icon" style="background:#5C2D91;">
                    <span style="font-weight:900;color:#fff;font-size:1.1rem;">K</span>
                  </div>
                  <div class="payment-option-info">
                    <div class="payment-option-name">Khalti</div>
                    <div class="payment-option-desc">Pay with Khalti digital wallet</div>
                  </div>
                  <div class="payment-option-check">&#10003;</div>
                </div>
              </label>

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

        <!-- RIGHT: Order Summary -->
        <div class="checkout-summary gc reveal">
          <div class="sec-tag">Order Summary</div>
          <h2 class="checkout-section-title">Your Items</h2>

          <div class="checkout-items">
            <c:forEach var="cart" items="${cartItems}">
              <div class="checkout-item">
                <img src="${pageContext.request.contextPath}${cart.imageUrl}" alt="${cart.productName}" class="checkout-item-img" />
                <div class="checkout-item-info">
                  <div class="checkout-item-name">${cart.productName}</div>
                  <div class="checkout-item-brand">${cart.brand}</div>
                  <div class="checkout-item-price">Rs <fmt:formatNumber value="${cart.price}" pattern="#,##0"/> &times; ${cart.quantity}</div>
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
                <c:when test="${grandTotal >= 5000}">
                  <span style="color:var(--green);font-weight:700;">Free</span>
                </c:when>
                <c:otherwise>
                  <span>Rs 200</span>
                </c:otherwise>
              </c:choose>
            </div>
            <div class="checkout-total-line checkout-grand-total">
              <span>Grand Total</span>
              <c:choose>
                <c:when test="${grandTotal >= 5000}">
                  <strong>Rs <fmt:formatNumber value="${grandTotal}" pattern="#,##0"/></strong>
                </c:when>
                <c:otherwise>
                  <strong>Rs <fmt:formatNumber value="${grandTotal + 200}" pattern="#,##0"/></strong>
                </c:otherwise>
              </c:choose>
            </div>
          </div>

          <button class="btn btn-g btn-full btn-lg" id="place-order-btn" type="button" onclick="placeOrder()">
            Place Order &#8594;
          </button>

          <div class="checkout-secure-note">
            <span>&#128274;</span> Your payment information is secure and encrypted
          </div>
        </div>
      </div>
    </c:otherwise>
  </c:choose>
</div>

<!-- Order Success Modal -->
<div class="modal-ov" id="modal-order-success" role="dialog" aria-modal="true">
  <div class="modal" style="max-width:440px;text-align:center;">
    <div style="font-size:3.5rem;margin-bottom:0.75rem;">&#10003;</div>
    <div class="modal-h" style="color:var(--green);">Order Placed Successfully!</div>
    <div class="modal-sub" style="margin-bottom:0.5rem;">
      Thank you for shopping with AluGhadi Watches.<br/>
      Your order has been confirmed and will be processed shortly.
    </div>
    <div style="background:var(--green-light);border:1.5px solid var(--green-mid);border-radius:12px;padding:0.85rem;margin-bottom:1.25rem;">
      <div style="font-size:0.72rem;font-weight:700;color:var(--green);text-transform:uppercase;letter-spacing:0.1em;margin-bottom:0.3rem;">Order ID</div>
      <div style="font-size:1.1rem;font-weight:900;color:var(--text);" id="order-id-display">AG-000000</div>
    </div>
    <a href="${pageContext.request.contextPath}/products" class="btn btn-g btn-full" style="text-decoration:none;">
      Continue Shopping &#8594;
    </a>
  </div>
</div>

<script>
  function placeOrder() {
    var fname = document.getElementById('ship-fname');
    var phone = document.getElementById('ship-phone');
    var addr  = document.getElementById('ship-address');
    var city  = document.getElementById('ship-city');

    if (!fname.value.trim() || !phone.value.trim() || !addr.value.trim() || !city.value.trim()) {
      if (typeof showToast === 'function') {
        showToast('Missing Information', 'Please fill in all required shipping fields.', '&#9888;');
      } else {
        alert('Please fill in all required shipping fields.');
      }
      return;
    }

    var orderId = 'AG-' + Math.floor(100000 + Math.random() * 900000);
    document.getElementById('order-id-display').textContent = orderId;

    var modal = document.getElementById('modal-order-success');
    if (modal) {
      modal.classList.add('active');
      document.body.style.overflow = 'hidden';
    }
  }
</script>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
