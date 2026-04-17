<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%
request.setAttribute("pageTitle", "Gift Guide For Her | AluGhadi");
request.setAttribute("pageDesc", "Curated watch gifting picks for her.");
request.setAttribute("activeNav", ""); %>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="page-hero">
  <div class="ph-img">
    <img
      src="${pageContext.request.contextPath}/static/images/snow_leopard.png"
      alt="For Her"
    />
  </div>
  <div class="ph-ov"></div>
  <div class="ph-body">
    <div class="ph-chip">GIFT GUIDE</div>
    <h1 class="ph-h">For Her</h1>
    <p class="ph-sub">
      Curated picks focused on elegant, modern, and statement styles for her.
    </p>
  </div>
</div>

<div class="pg-body">
  <div class="tabs-wrap" style="margin-bottom: 1.3rem">
    <a class="tab active" href="#">All Picks</a>
    <a class="tab" href="#">Elegant</a>
    <a class="tab" href="#">Minimal</a>
    <a class="tab" href="#">Premium</a>
  </div>

  <div class="gift-picks-grid">
    <article class="gift-pick-card">
      <img
        src="${pageContext.request.contextPath}/static/images/snow_leopard.png"
        alt="For her elegant gift"
      />
      <div class="gift-pick-body">
        <div class="gift-pick-title">Elegant Essential</div>
        <p>Refined case and soft finish designed for daily elegance.</p>
        <div class="gift-pick-meta">Budget: 200 - 400</div>
      </div>
    </article>
    <article class="gift-pick-card">
      <img
        src="${pageContext.request.contextPath}/static/images/snow_leopard.png"
        alt="For her modern gift"
      />
      <div class="gift-pick-body">
        <div class="gift-pick-title">Modern Minimal</div>
        <p>Clean silhouette and subtle detailing for modern styling.</p>
        <div class="gift-pick-meta">Budget: 300 - 500</div>
      </div>
    </article>
    <article class="gift-pick-card">
      <img
        src="${pageContext.request.contextPath}/static/images/snow_leopard.png"
        alt="For her premium gift"
      />
      <div class="gift-pick-body">
        <div class="gift-pick-title">Premium Signature</div>
        <p>Statement gifting option for milestones and celebrations.</p>
        <div class="gift-pick-meta">Budget: 500 and above</div>
      </div>
    </article>
  </div>

  <div style="margin-top: 1.4rem; display: flex; gap: 0.75rem; flex-wrap: wrap">
    <a class="btn-fill" href="${pageContext.request.contextPath}/products"
      >Shop For Her</a
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
