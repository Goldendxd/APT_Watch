<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%
  request.setAttribute("pageTitle", "Gifts For Him | AluGhadi Watches");
  request.setAttribute("pageDesc", "Curated watch gifts for him — bold, precise, and built to impress. Browse our men's gift collection.");
  request.setAttribute("activeNav", "gifting");
%>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />
<jsp:include page="/WEB-INF/views/layout/head.jsp" />

<%-- ===== HERO ===== --%>
<div class="page-hero forhim-hero">
  <div class="ph-img">
    <img src="${pageContext.request.contextPath}/static/images/for-him/him-1.webp" alt="For Him — Men's Watch Collection" />
  </div>
  <div class="ph-ov"></div>
  <div class="ph-ov-side"></div>
  <div class="ph-body">
    <div class="ph-chip">Gift Guide</div>
    <h1 class="ph-h">For Him</h1>
    <p class="ph-sub">Bold. Precise. Timeless. The watches every man deserves to wear.</p>
    <div style="margin-top:1.5rem;display:flex;gap:0.8rem;flex-wrap:wrap;">
      <a href="${pageContext.request.contextPath}/products" class="btn-fill">Shop Men's Watches</a>
      <a href="${pageContext.request.contextPath}/for-her" class="forhim-switch-btn">Switch to For Her &#8594;</a>
    </div>
  </div>
</div>

<div class="pg-body">

  <%-- Breadcrumb --%>
  <div class="forhim-breadcrumb">
    <a href="${pageContext.request.contextPath}/">Home</a>
    <span>&#8250;</span>
    <a href="${pageContext.request.contextPath}/gifting">Gift Guide</a>
    <span>&#8250;</span>
    <span>For Him</span>
  </div>

  <%-- Style filter tabs --%>
  <div class="forhim-filter-row">
    <div class="forhim-filter-label">Filter by style:</div>
    <div class="tabs-wrap" style="margin-bottom:0;">
      <a class="tab ${empty activeCategory or activeCategory == 'all' ? 'active' : ''}" href="${pageContext.request.contextPath}/for-him" style="text-decoration:none;">All</a>
      <a class="tab ${activeCategory == 'luxury' ? 'active' : ''}" href="${pageContext.request.contextPath}/for-him?category=luxury" style="text-decoration:none;">Luxury</a>
      <a class="tab ${activeCategory == 'sports' ? 'active' : ''}" href="${pageContext.request.contextPath}/for-him?category=sports" style="text-decoration:none;">Sports</a>
      <a class="tab ${activeCategory == 'classic' ? 'active' : ''}" href="${pageContext.request.contextPath}/for-him?category=classic" style="text-decoration:none;">Classic</a>
      <a class="tab ${activeCategory == 'smart' ? 'active' : ''}" href="${pageContext.request.contextPath}/for-him?category=smart" style="text-decoration:none;">Smart</a>
    </div>
  </div>

  <%-- Cards grid --%>
  <div class="forhim-grid" id="forhim-grid">
    <c:choose>
      <c:when test="${empty productList}">
        <div style="grid-column:1/-1;text-align:center;padding:4rem 2rem;color:var(--muted);">
          <div style="font-weight:800;margin-bottom:0.4rem;">No watches found</div>
          <a href="${pageContext.request.contextPath}/for-him" style="color:var(--green);font-weight:700;text-decoration:none;">View all styles</a>
        </div>
      </c:when>
      <c:otherwise>
        <c:forEach var="product" items="${productList}">
          <article class="gift-pick-card reveal">
            <img src="${pageContext.request.contextPath}${product.imageUrl}" alt="${product.name}" />
            <div class="gift-pick-body">
              <div class="gift-pick-style-tag">${product.categoryName}</div>
              <div class="gift-pick-title">${product.name}</div>
              <p>${product.description}</p>
              <div class="forhim-card-footer">
                <div class="gift-pick-meta">NPR <fmt:formatNumber value="${product.price}" pattern="#,##0"/></div>
                <div class="gift-card-actions">
                  <button class="forhim-cart-btn" type="button"
                          data-product-id="${product.id}"
                          onclick="addToCart(this, this.dataset.productId, 1)"
                          title="Add to cart">+</button>
                  <a href="${pageContext.request.contextPath}/product-details?id=${product.id}" class="forhim-card-btn">View &#8594;</a>
                </div>
              </div>
            </div>
          </article>
        </c:forEach>
      </c:otherwise>
    </c:choose>
  </div>


  <%-- Back nav --%>
  <div class="forhim-back-row">
    <a href="${pageContext.request.contextPath}/gifting" class="forhim-back-link">
      &#8592; Back to Gift Guide
    </a>
    <a href="${pageContext.request.contextPath}/for-her" class="forhim-switch-link">
      Switch to For Her &#8594;
    </a>
  </div>

</div>

<style>
.forhim-hero { min-height: 60vh; }
.forhim-switch-btn {
  display:     inline-flex;
  align-items: center;
  gap:         0.4rem;
  padding:     0.88rem 1.6rem;
  background:  rgba(255,255,255,0.14);
  border:      1px solid rgba(255,255,255,0.28);
  border-radius: 12px;
  color:       #fff;
  text-decoration: none;
  font-weight: 700;
  font-size:   0.9rem;
  backdrop-filter: blur(8px);
  transition:  all 0.22s;
}
.forhim-switch-btn:hover { background: rgba(255,255,255,0.25); }

.forhim-breadcrumb {
  display:     flex;
  align-items: center;
  gap:         0.5rem;
  font-size:   0.78rem;
  color:       var(--muted);
  margin-bottom: 2rem;
}
.forhim-breadcrumb a { color: var(--green); text-decoration: none; font-weight: 600; }
.forhim-breadcrumb a:hover { text-decoration: underline; }
.forhim-breadcrumb span { color: var(--dim); }

.forhim-filter-row {
  display:     flex;
  align-items: center;
  gap:         1.5rem;
  margin-bottom: 2rem;
  flex-wrap:   wrap;
}
.forhim-filter-label {
  font-size:   0.78rem;
  font-weight: 700;
  color:       var(--muted);
  flex-shrink: 0;
}

.forhim-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap:     1.5rem;
  margin-bottom: 3rem;
}

/* Style tags */
.gift-pick-style-tag {
  display:       inline-flex;
  align-items:   center;
  padding:       0.25rem 0.75rem;
  border-radius: 999px;
  font-size:     0.66rem;
  font-weight:   700;
  letter-spacing: 0.08em;
  text-transform: uppercase;
  background:    var(--green-light);
  color:         var(--green);
  margin-bottom: 0.55rem;
}
.gift-pick-style-sport   { background: #e0f0ff; color: #1a6aaa; }
.gift-pick-style-minimal { background: var(--surface); color: var(--muted); }
.gift-pick-style-luxury  { background: var(--gold-light); color: var(--gold2); }

.forhim-card-footer {
  display:         flex;
  justify-content: space-between;
  align-items:     center;
  margin-top:      0.75rem;
  padding-top:     0.75rem;
  border-top:      1px solid var(--border);
}
.forhim-card-btn {
  font-size:   0.78rem;
  font-weight: 700;
  color:       var(--green);
  text-decoration: none;
  transition:  color 0.18s;
}
.forhim-card-btn:hover { color: var(--green2); }

.gift-card-actions {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}
.forhim-cart-btn, .forher-cart-btn {
  width: 32px;
  height: 32px;
  border: 1.5px solid var(--border);
  border-radius: 8px;
  background: var(--surface);
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 0.85rem;
  transition: all 0.18s;
  padding: 0;
}
.forhim-cart-btn:hover, .forher-cart-btn:hover {
  background: var(--green-light);
  border-color: var(--green-mid);
  transform: scale(1.08);
}

.forhim-back-row {
  display:         flex;
  justify-content: space-between;
  align-items:     center;
  padding-top:     2rem;
  border-top:      1px solid var(--border);
  flex-wrap:       wrap;
  gap:             1rem;
}
.forhim-back-link, .forhim-switch-link {
  font-size:   0.84rem;
  font-weight: 700;
  color:       var(--green);
  text-decoration: none;
}
.forhim-back-link:hover, .forhim-switch-link:hover { text-decoration: underline; }

.forhim-grid .gift-pick-card { transition: all 0.28s var(--ease); }
.forhim-grid .gift-pick-card.hidden { display: none; }

@media (max-width: 900px)  { .forhim-grid { grid-template-columns: repeat(2, 1fr); } }
@media (max-width: 600px)  {
  .forhim-grid { grid-template-columns: 1fr; }
  .forhim-filter-row { flex-direction: column; align-items: flex-start; }
}
</style>


<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
