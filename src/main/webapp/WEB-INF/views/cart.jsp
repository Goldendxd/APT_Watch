<%--
  cart.jsp — Full cart page.
  Expects from CartServlet:
    cartItems   (List<Cart>) — all items in the user's cart with product details
    cartCount   (int)        — total quantity across all items
    grandTotal  (double)     — sum of price * quantity for all items
  Includes header.jsp, head.jsp, and footer.jsp.
  Qty controls post back to /cart?action=update; delete posts to /cart?action=remove.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%
    request.setAttribute("pageTitle",  "Shopping Cart | AluGhadi Watches");
    request.setAttribute("pageDesc",   "Review the watches in your cart before checkout.");
    request.setAttribute("activeNav",  "products");
    request.setAttribute("pageStyle",  "checkout");
%>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<!-- HERO -->
<div class="page-hero" style="min-height:28vh;">
  <div class="ph-img">
    <img src="${pageContext.request.contextPath}/static/images/products/hero_products.png"
         alt="Shopping Cart" style="object-position:center" />
  </div>
  <div class="ph-ov"
       style="background:linear-gradient(180deg,rgba(26,107,56,0.25) 0%,rgba(11,28,16,0.88) 100%);"></div>
  <div class="ph-body">
    <div class="ph-chip">Your Cart</div>
    <h1 class="ph-h">Shopping Cart</h1>
    <p class="ph-sub">Review your selected watches before proceeding to checkout.</p>
  </div>
</div>

<div class="pg-body checkout-page">
  <c:choose>
    <%-- ===== EMPTY CART ===== --%>
    <c:when test="${empty cartItems}">
      <div class="checkout-empty gc" style="text-align:center;padding:5rem 2rem;">
        <h2 style="margin-bottom:0.5rem;">Your cart is empty</h2>
        <p style="color:var(--muted);margin-bottom:1.75rem;">
          Looks like you haven't added any watches yet. Browse our collection to find your perfect timepiece.
        </p>
        <a href="${pageContext.request.contextPath}/products" class="btn-fill" style="text-decoration:none;padding:0.75rem 1.75rem;border-radius:12px;">
          Browse Products &#8594;
        </a>
      </div>
    </c:when>

    <%-- ===== CART WITH ITEMS ===== --%>
    <c:otherwise>
      <c:set var="currentPage" value="${pageContext.request.requestURI}" />

      <div class="checkout-layout">
        <%-- LEFT: cart items list --%>
        <div class="checkout-forms">
          <div class="gc checkout-section reveal">
            <div class="sec-tag">Cart Items</div>
            <h2 class="checkout-section-title">Your Selected Watches</h2>

            <c:forEach var="cart" items="${cartItems}">
              <div class="checkout-item" style="padding:1rem 0;border-bottom:1px solid var(--border);display:flex;gap:1rem;align-items:center;">
                <img src="${pageContext.request.contextPath}${cart.imageUrl}"
                     alt="${cart.productName}"
                     class="checkout-item-img"
                     style="width:80px;height:80px;object-fit:cover;border-radius:12px;border:1.5px solid var(--border);" />

                <div style="flex:1;min-width:0;">
                  <div style="font-weight:700;font-size:0.95rem;margin-bottom:0.15rem;">${cart.productName}</div>
                  <div style="font-size:0.78rem;color:var(--muted);margin-bottom:0.4rem;">${cart.brand}</div>
                  <div style="font-size:0.88rem;font-weight:700;color:var(--green);">
                    Rs <fmt:formatNumber value="${cart.price}" pattern="#,##0"/>
                    <c:if test="${cart.oldPrice > 0}">
                      <span style="font-weight:400;color:var(--muted);text-decoration:line-through;font-size:0.8rem;margin-left:0.4rem;">
                        Rs <fmt:formatNumber value="${cart.oldPrice}" pattern="#,##0"/>
                      </span>
                    </c:if>
                  </div>
                </div>

                <%-- Quantity controls --%>
                <div style="display:flex;align-items:center;gap:0.4rem;">
                  <c:choose>
                    <c:when test="${cart.quantity <= 1}">
                      <form action="${pageContext.request.contextPath}/cart" method="post" style="display:contents;">
                        <input type="hidden" name="action"     value="remove">
                        <input type="hidden" name="cartId"     value="${cart.id}">
                        <input type="hidden" name="redirectTo" value="${currentPage}">
                        <button class="cart-qty-btn" type="submit" title="Remove item">&#8722;</button>
                      </form>
                    </c:when>
                    <c:otherwise>
                      <form action="${pageContext.request.contextPath}/cart" method="post" style="display:contents;">
                        <input type="hidden" name="action"     value="update">
                        <input type="hidden" name="cartId"     value="${cart.id}">
                        <input type="hidden" name="quantity"   value="${cart.quantity - 1}">
                        <input type="hidden" name="redirectTo" value="${currentPage}">
                        <button class="cart-qty-btn" type="submit" title="Decrease quantity">&#8722;</button>
                      </form>
                    </c:otherwise>
                  </c:choose>

                  <span class="cart-qty-val">${cart.quantity}</span>

                  <form action="${pageContext.request.contextPath}/cart" method="post" style="display:contents;">
                    <input type="hidden" name="action"     value="update">
                    <input type="hidden" name="cartId"     value="${cart.id}">
                    <input type="hidden" name="quantity"   value="${cart.quantity + 1}">
                    <input type="hidden" name="redirectTo" value="${currentPage}">
                    <button class="cart-qty-btn" type="submit" title="Increase quantity">&#43;</button>
                  </form>
                </div>

                <%-- Line total --%>
                <div style="min-width:80px;text-align:right;font-weight:800;font-size:0.92rem;">
                  Rs <fmt:formatNumber value="${cart.totalPrice}" pattern="#,##0"/>
                </div>

                <%-- Remove button --%>
                <form action="${pageContext.request.contextPath}/cart" method="post" style="display:contents;">
                  <input type="hidden" name="action"     value="remove">
                  <input type="hidden" name="cartId"     value="${cart.id}">
                  <input type="hidden" name="redirectTo" value="${currentPage}">
                  <button class="cart-delete-btn" type="submit" title="Remove from cart">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                         stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                      <polyline points="3 6 5 6 21 6"/>
                      <path d="M19 6l-1 14a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2L5 6"/>
                      <path d="M10 11v6"/><path d="M14 11v6"/>
                    </svg>
                  </button>
                </form>
              </div>
            </c:forEach>

            <%-- Clear cart --%>
            <div style="margin-top:1rem;text-align:right;">
              <form action="${pageContext.request.contextPath}/cart" method="post" style="display:inline;">
                <input type="hidden" name="action"     value="clear">
                <input type="hidden" name="redirectTo" value="${currentPage}">
                <button type="submit"
                        style="background:none;border:none;color:var(--muted);font-size:0.78rem;cursor:pointer;text-decoration:underline;font-family:inherit;">
                  Clear all items
                </button>
              </form>
            </div>
          </div>
        </div>

        <%-- RIGHT: order summary + checkout CTA --%>
        <div class="checkout-summary gc reveal">
          <div class="sec-tag">Order Summary</div>
          <h2 class="checkout-section-title">Price Breakdown</h2>

          <div class="checkout-totals">
            <div class="checkout-total-line">
              <span>Subtotal (${cartCount} item${cartCount != 1 ? 's' : ''})</span>
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

          <c:if test="${grandTotal < 5000}">
            <div style="background:var(--green-light);border:1.5px solid var(--green-mid);border-radius:12px;padding:0.75rem 1rem;margin-bottom:1rem;font-size:0.8rem;color:var(--green);font-weight:600;">
              Add Rs <fmt:formatNumber value="${5000 - grandTotal}" pattern="#,##0"/> more for free shipping!
            </div>
          </c:if>

          <a href="${pageContext.request.contextPath}/checkout"
             class="btn-fill"
             style="display:block;text-align:center;text-decoration:none;padding:0.85rem;border-radius:12px;font-weight:700;font-size:1rem;margin-bottom:0.75rem;">
            Proceed to Checkout &#8594;
          </a>

          <a href="${pageContext.request.contextPath}/products"
             class="btn-out-nav"
             style="display:block;text-align:center;text-decoration:none;padding:0.75rem;border-radius:12px;font-weight:600;font-size:0.88rem;">
            Continue Shopping
          </a>

          <div class="checkout-secure-note" style="margin-top:1rem;">
            Secure checkout — your data is protected
          </div>
        </div>
      </div>
    </c:otherwise>
  </c:choose>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
