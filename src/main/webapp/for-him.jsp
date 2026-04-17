<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  request.setAttribute("pageTitle", "Gifts For Him | AluGhadi Watches");
  request.setAttribute("pageDesc", "Curated watch gifts for him — bold, precise, and built to impress. Browse our men's gift collection.");
  request.setAttribute("activeNav", "gifting");
%>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<%-- ===== HERO ===== --%>
<div class="page-hero forhim-hero">
  <div class="ph-img">
    <img src="${pageContext.request.contextPath}/static/images/snow_leopard.png" alt="For Him — Men's Watch Collection" />
  </div>
  <div class="ph-ov"></div>
  <div class="ph-ov-side"></div>
  <div class="ph-body">
    <div class="ph-chip">&#9794; Gift Guide</div>
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
      <button class="tab active" onclick="filterCards('all', this)">All Styles</button>
      <button class="tab" onclick="filterCards('classic', this)">Classic</button>
      <button class="tab" onclick="filterCards('sport', this)">Sport</button>
      <button class="tab" onclick="filterCards('minimal', this)">Minimal</button>
      <button class="tab" onclick="filterCards('luxury', this)">Luxury</button>
    </div>
  </div>

  <%-- Cards grid --%>
  <div class="forhim-grid" id="forhim-grid">

    <article class="gift-pick-card reveal" data-category="classic">
      <img src="${pageContext.request.contextPath}/static/images/snow_leopard.png" alt="Executive Classic" />
      <div class="gift-pick-body">
        <div class="gift-pick-style-tag">Classic</div>
        <div class="gift-pick-title">Executive Classic</div>
        <p>Clean dial and leather strap. Made for boardrooms, formal dinners, and daily elegance.</p>
        <div class="forhim-card-footer">
          <div class="gift-pick-meta">NPR 8,000 – 15,000</div>
          <a href="${pageContext.request.contextPath}/products" class="forhim-card-btn">View &#8594;</a>
        </div>
      </div>
    </article>

    <article class="gift-pick-card reveal reveal-delay-1" data-category="sport">
      <img src="${pageContext.request.contextPath}/static/images/snow_leopard.png" alt="Active Sport" />
      <div class="gift-pick-body">
        <div class="gift-pick-style-tag gift-pick-style-sport">Sport</div>
        <div class="gift-pick-title">Active Sport</div>
        <p>Built tough for every adventure. Water-resistant with a bold, energetic design.</p>
        <div class="forhim-card-footer">
          <div class="gift-pick-meta">NPR 5,000 – 12,000</div>
          <a href="${pageContext.request.contextPath}/products" class="forhim-card-btn">View &#8594;</a>
        </div>
      </div>
    </article>

    <article class="gift-pick-card reveal reveal-delay-2" data-category="minimal">
      <img src="${pageContext.request.contextPath}/static/images/snow_leopard.png" alt="Slim Minimal" />
      <div class="gift-pick-body">
        <div class="gift-pick-style-tag gift-pick-style-minimal">Minimal</div>
        <div class="gift-pick-title">Slim Minimal</div>
        <p>Understated elegance. Thin profile and a clean face that lets the craft speak for itself.</p>
        <div class="forhim-card-footer">
          <div class="gift-pick-meta">NPR 6,500 – 14,000</div>
          <a href="${pageContext.request.contextPath}/products" class="forhim-card-btn">View &#8594;</a>
        </div>
      </div>
    </article>

    <article class="gift-pick-card reveal reveal-delay-3" data-category="luxury">
      <img src="${pageContext.request.contextPath}/static/images/snow_leopard.png" alt="Premium Signature" />
      <div class="gift-pick-body">
        <div class="gift-pick-style-tag gift-pick-style-luxury">Luxury</div>
        <div class="gift-pick-title">Premium Signature</div>
        <p>A statement piece for milestone moments. Elevated materials and precision engineering.</p>
        <div class="forhim-card-footer">
          <div class="gift-pick-meta">NPR 40,000+</div>
          <a href="${pageContext.request.contextPath}/products" class="forhim-card-btn">View &#8594;</a>
        </div>
      </div>
    </article>

    <article class="gift-pick-card reveal" data-category="classic sport">
      <img src="${pageContext.request.contextPath}/static/images/snow_leopard.png" alt="Chronograph Pro" />
      <div class="gift-pick-body">
        <div class="gift-pick-style-tag">Classic</div>
        <div class="gift-pick-title">Chronograph Pro</div>
        <p>Multi-function dial with stopwatch. The perfect balance of sport function and classic design.</p>
        <div class="forhim-card-footer">
          <div class="gift-pick-meta">NPR 12,000 – 25,000</div>
          <a href="${pageContext.request.contextPath}/products" class="forhim-card-btn">View &#8594;</a>
        </div>
      </div>
    </article>

    <article class="gift-pick-card reveal reveal-delay-1" data-category="luxury minimal">
      <img src="${pageContext.request.contextPath}/static/images/snow_leopard.png" alt="Dress Watch" />
      <div class="gift-pick-body">
        <div class="gift-pick-style-tag gift-pick-style-luxury">Luxury</div>
        <div class="gift-pick-title">Dress Watch</div>
        <p>Ultra-thin with sapphire crystal. The ultimate dress watch for every formal occasion.</p>
        <div class="forhim-card-footer">
          <div class="gift-pick-meta">NPR 35,000 – 60,000</div>
          <a href="${pageContext.request.contextPath}/products" class="forhim-card-btn">View &#8594;</a>
        </div>
      </div>
    </article>

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

<script>
function filterCards(cat, btn) {
  document.querySelectorAll('.tabs-wrap .tab').forEach(function(t){ t.classList.remove('active'); });
  btn.classList.add('active');
  document.querySelectorAll('#forhim-grid .gift-pick-card').forEach(function(card){
    if (cat === 'all' || (card.dataset.category && card.dataset.category.indexOf(cat) !== -1)) {
      card.classList.remove('hidden');
    } else {
      card.classList.add('hidden');
    }
  });
}
</script>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
