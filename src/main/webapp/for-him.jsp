<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%
request.setAttribute("pageTitle", "Gift Guide For Him | AluGhadi");
request.setAttribute("pageDesc", "Curated watch gifting picks for him.");
request.setAttribute("activeNav", ""); %>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="page-hero">
  <div class="ph-img">
    <img
      src="${pageContext.request.contextPath}/static/images/snow_leopard.png"
      alt="For Him"
    />
  </div>
  <div class="ph-ov"></div>
  <div class="ph-body">
    <div class="ph-chip">GIFT GUIDE</div>
    <h1 class="ph-h">For Him</h1>
    <p class="ph-sub">
      Curated picks focused on versatile, bold, and timeless styles for him.
    </p>
  </div>
</div>

<div class="pg-body">
  <div class="tabs-wrap" style="margin-bottom: 1.3rem">
    <a class="tab active" href="#">All Picks</a>
    <a class="tab" href="#">Classic</a>
    <a class="tab" href="#">Sport</a>
    <a class="tab" href="#">Minimal</a>
  </div>

  <div class="gift-picks-grid">
    <article class="gift-pick-card">
      <img
        src="${pageContext.request.contextPath}/static/images/snow_leopard.png"
        alt="For him classic gift"
      />
      <div class="gift-pick-body">
        <div class="gift-pick-title">Executive Classic</div>
        <p>Clean dial and formal strap for daily office wear and events.</p>
        <div class="gift-pick-meta">Budget: 200 - 400</div>
      </div>
    </article>
    <article class="gift-pick-card">
      <img
        src="${pageContext.request.contextPath}/static/images/snow_leopard.png"
        alt="For him sport gift"
      />
      <div class="gift-pick-body">
        <div class="gift-pick-title">Active Sport</div>
        <p>
          Durable build and bold profile suitable for travel and outdoor days.
        </p>
        <div class="gift-pick-meta">Budget: 300 - 500</div>
      </div>
    </article>
    <article class="gift-pick-card">
      <img
        src="${pageContext.request.contextPath}/static/images/snow_leopard.png"
        alt="For him premium gift"
      />
      <div class="gift-pick-body">
        <div class="gift-pick-title">Premium Signature</div>
        <p>Statement piece with elevated details for milestone gifting.</p>
        <div class="gift-pick-meta">Budget: 500 and above</div>
      </div>
    </article>
  </div>

  <div style="margin-top: 1.4rem; display: flex; gap: 0.75rem; flex-wrap: wrap">
    <a class="btn-fill" href="${pageContext.request.contextPath}/products"
      >Shop For Him</a
    >
    <a
      class="btn-out-nav"
      href="${pageContext.request.contextPath}/gifting"
      style="text-decoration: none; display: inline-flex; align-items: center"
      >Back to Gifting</a
    >
  </div>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
