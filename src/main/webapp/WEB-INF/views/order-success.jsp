<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="pg-body order-success-page">
  <div class="gc order-success-card reveal">

    <div class="os-icon">&#10003;</div>

    <div class="sec-tag" style="text-align:center;">Order Placed</div>
    <h1 class="os-title">Thank you for your order!</h1>
    <p class="os-sub">Your order has been received and is being processed. We'll get it ready for you shortly.</p>

    <div class="os-details">
      <div class="os-detail-row">
        <span class="os-detail-label">Order ID</span>
        <span class="os-detail-value">${orderId}</span>
      </div>
      <div class="os-detail-row">
        <span class="os-detail-label">Payment Method</span>
        <span class="os-detail-value">
          <c:choose>
            <c:when test="${paymentMethod == 'esewa'}">eSewa</c:when>
            <c:otherwise>Cash on Delivery</c:otherwise>
          </c:choose>
        </span>
      </div>
      <div class="os-detail-row os-total-row">
        <span class="os-detail-label">Total Paid</span>
        <span class="os-detail-value os-total-val">Rs <fmt:formatNumber value="${orderTotal}" pattern="#,##0"/></span>
      </div>
    </div>

    <div class="os-actions">
      <a href="${pageContext.request.contextPath}/products" class="btn-fill"
         style="text-decoration:none;padding:0.8rem 2rem;border-radius:12px;font-weight:700;">
        Continue Shopping
      </a>
      <a href="${pageContext.request.contextPath}/profile" class="btn-ghost"
         style="text-decoration:none;padding:0.8rem 2rem;border-radius:12px;font-weight:700;">
        View My Orders
      </a>
    </div>

    <div class="checkout-secure-note" style="justify-content:center;margin-top:1.5rem;">
      <span>&#128274;</span> Your order details are saved to your account
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
