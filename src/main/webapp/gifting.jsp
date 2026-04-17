<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%
request.setAttribute("pageTitle", "Gift Guide | AluGhadi");
request.setAttribute("pageDesc", "Gift guide for him and her with curated watch picks.");
request.setAttribute("activeNav", "gifting");
%>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="page-hero gift-hero-xl">
  <div class="ph-img">
    <img
      src="${pageContext.request.contextPath}/static/images/snow_leopard.png"
      alt="Gift Guide"
      style="object-position: center"
    />
  </div>
  <div class="ph-ov"></div>
  <div class="ph-body gift-hero-body">
    <div class="gift-hero-copy">
      <div class="ph-chip">ALUGHADI GIFT GUIDE</div>
      <h1 class="ph-h">Find the Right Gift<br />For Him and For Her</h1>
      <p class="ph-sub">
        Shop by recipient, style, and budget. Every section is ready for your
        backend products later.
      </p>
    </div>

    <div class="gift-hero-cta-wrap">
      <a
        class="btn-fill gift-hero-cta"
        href="${pageContext.request.contextPath}/products"
        >Start Gift Experience</a
      >
    </div>
  </div>
</div>

<div class="pg-body">
  <div class="info-banner" style="margin-bottom: 1.6rem">
    <div class="ib-ico">Guide</div>
    <div class="ib-body">
      <div class="ib-h">Start with who you are gifting</div>
      <div class="ib-p">
        Pick a recipient first, then browse by occasion and budget. This layout
        mirrors a modern gift-guide shopping flow.
      </div>
    </div>
  </div>

  <section class="gift-section">
    <div class="sec-tag">Occasion</div>
    <h2 class="sec-h" style="margin-bottom: 1rem">Shop by Occasion</h2>
    <div class="gift-occasion-grid">
      <a
        class="gift-occasion"
        href="${pageContext.request.contextPath}/products"
      >
        <img
          src="${pageContext.request.contextPath}/static/images/snow_leopard.png"
          alt="Birthday gifts"
        />
        <div class="gift-occasion-label">Birthday</div>
      </a>
      <a
        class="gift-occasion"
        href="${pageContext.request.contextPath}/products"
      >
        <img
          src="${pageContext.request.contextPath}/static/images/snow_leopard.png"
          alt="Anniversary gifts"
        />
        <div class="gift-occasion-label">Anniversary</div>
      </a>
      <a
        class="gift-occasion"
        href="${pageContext.request.contextPath}/products"
      >
        <img
          src="${pageContext.request.contextPath}/static/images/snow_leopard.png"
          alt="Graduation gifts"
        />
        <div class="gift-occasion-label">Graduation</div>
      </a>
      <a
        class="gift-occasion"
        href="${pageContext.request.contextPath}/products"
      >
        <img
          src="${pageContext.request.contextPath}/static/images/snow_leopard.png"
          alt="Festive gifts"
        />
        <div class="gift-occasion-label">Festive</div>
      </a>
    </div>
  </section>

  <section class="gift-section">
    <div class="sec-tag">Budget</div>
    <h2 class="sec-h" style="margin-bottom: 1rem">Gift Picks by Budget</h2>
    <div class="gift-budget-grid">
      <a class="gift-budget" href="${pageContext.request.contextPath}/products"
        >Under 200</a
      >
      <a class="gift-budget" href="${pageContext.request.contextPath}/products"
        >200 - 400</a
      >
      <a class="gift-budget" href="${pageContext.request.contextPath}/products"
        >400 - 700</a
      >
      <a class="gift-budget" href="${pageContext.request.contextPath}/products"
        >700 and above</a
      >
    </div>
  </section>

  <section class="gift-section">
    <div class="gift-banner">
      <div>
        <div class="sec-tag">Need Help</div>
        <h3 style="font-size: 1.4rem; font-weight: 800; margin-bottom: 0.35rem">
          Not sure what to pick?
        </h3>
        <p class="sec-sub" style="max-width: 620px">
          Use this guide as a frontend template for your future recommendation
          logic. You can plug recipient preferences, price filters, and stock
          data into this exact flow.
        </p>
      </div>
      <a class="btn-fill" href="${pageContext.request.contextPath}/products"
        >Browse All Gifts</a
      >
    </div>
  </section>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
