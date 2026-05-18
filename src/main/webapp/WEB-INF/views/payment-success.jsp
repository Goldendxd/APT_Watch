<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%
    request.setAttribute("pageTitle",  "Payment Successful | AluGhadi Watches");
    request.setAttribute("pageStyle",  "checkout");
    request.setAttribute("activeNav",  "products");
%>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<main class="error-shell">
  <section class="error-card" style="max-width:520px;">

    <div class="error-icon" style="background:#e8f5ee;border-color:rgba(26,107,56,0.25);color:var(--green);width:88px;height:88px;font-size:2rem;">
      &#10003;
    </div>

    <div style="font-size:clamp(1.6rem,4vw,2.2rem);font-weight:900;color:var(--green);margin-bottom:0.5rem;">
      Payment Successful!
    </div>

    <p style="color:var(--muted);font-size:0.92rem;line-height:1.75;max-width:400px;margin:0 auto 1.5rem;">
      Your Khalti payment has been verified. Thank you for shopping with AluGhadi Watches —
      your order is confirmed and will be processed shortly.
    </p>

    <div style="background:var(--green-light);border:1.5px solid var(--green-mid);border-radius:14px;padding:1rem 1.25rem;margin-bottom:1.5rem;text-align:left;">
      <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:0.5rem;">
        <span style="font-size:0.78rem;font-weight:700;color:var(--green);text-transform:uppercase;letter-spacing:0.08em;">Transaction ID</span>
        <span style="font-size:0.88rem;font-weight:800;color:var(--text);">${transactionId}</span>
      </div>
      <div style="display:flex;justify-content:space-between;align-items:center;">
        <span style="font-size:0.78rem;font-weight:700;color:var(--green);text-transform:uppercase;letter-spacing:0.08em;">Amount Paid</span>
        <span style="font-size:0.88rem;font-weight:800;color:var(--text);">
          Rs <fmt:formatNumber value="${totalAmount}" pattern="#,##0.##"/>
        </span>
      </div>
    </div>

    <div style="display:flex;gap:0.75rem;justify-content:center;flex-wrap:wrap;">
      <a href="${pageContext.request.contextPath}/products"
         class="btn-fill"
         style="text-decoration:none;padding:0.75rem 1.5rem;border-radius:12px;font-weight:700;">
        Continue Shopping
      </a>
      <a href="${pageContext.request.contextPath}/home"
         class="btn-out-nav"
         style="text-decoration:none;padding:0.75rem 1.5rem;border-radius:12px;font-weight:700;">
        Go Home
      </a>
    </div>

  </section>
</main>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
