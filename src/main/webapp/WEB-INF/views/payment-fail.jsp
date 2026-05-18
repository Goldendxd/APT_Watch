<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%
    request.setAttribute("pageTitle", "Payment Failed | AluGhadi Watches");
    request.setAttribute("pageStyle", "checkout");
    request.setAttribute("activeNav", "products");
%>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<main class="error-shell">
  <section class="error-card" style="max-width:520px;">

    <div class="error-icon" style="background:#fff1f1;border-color:rgba(200,60,60,0.2);color:#c33;width:88px;height:88px;font-size:2rem;">
      &#10005;
    </div>

    <div style="font-size:clamp(1.6rem,4vw,2.2rem);font-weight:900;color:#c33;margin-bottom:0.5rem;">
      Payment Failed
    </div>

    <p style="color:var(--muted);font-size:0.92rem;line-height:1.75;max-width:400px;margin:0 auto 1rem;">
      Your payment could not be completed. No amount has been charged.
    </p>

    <c:if test="${not empty failReason}">
      <div style="background:#fff1f1;border:1.5px solid rgba(200,60,60,0.2);border-radius:12px;padding:0.75rem 1rem;margin-bottom:1.5rem;font-size:0.82rem;color:#a33;">
        ${failReason}
      </div>
    </c:if>

    <div style="display:flex;gap:0.75rem;justify-content:center;flex-wrap:wrap;">
      <a href="${pageContext.request.contextPath}/checkout"
         class="btn-fill"
         style="text-decoration:none;padding:0.75rem 1.5rem;border-radius:12px;font-weight:700;">
        Try Again
      </a>
      <a href="${pageContext.request.contextPath}/products"
         class="btn-out-nav"
         style="text-decoration:none;padding:0.75rem 1.5rem;border-radius:12px;font-weight:700;">
        Browse Products
      </a>
    </div>

  </section>
</main>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
