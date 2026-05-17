<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  request.setAttribute("pageTitle", "Gifts For Her | AluGhadi Watches");
  request.setAttribute("pageDesc", "Curated watch gifts for her — elegant, expressive, and made to be treasured. Browse our women's gift collection.");
  request.setAttribute("activeNav", "gifting");
%>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />
<jsp:include page="/WEB-INF/views/layout/head.jsp" />

<%-- ===== HERO ===== --%>
<div class="page-hero forher-hero">
  <div class="ph-img">
    <img src="${pageContext.request.contextPath}/static/images/for-her/her-1.webp" alt="For Her — Women's Watch Collection" />
  </div>
  <div class="ph-ov" style="background:linear-gradient(170deg,rgba(30,10,30,0.22) 0%,rgba(20,8,25,0.90) 100%);"></div>
  <div class="ph-ov-side"></div>
  <div class="ph-body">
    <div class="ph-chip">&#9792; Gift Guide</div>
    <h1 class="ph-h">For Her</h1>
    <p class="ph-sub">Elegant, expressive, and crafted to be treasured. Timepieces she'll reach for every day.</p>
    <div style="margin-top:1.5rem;display:flex;gap:0.8rem;flex-wrap:wrap;">
      <a href="${pageContext.request.contextPath}/products" class="btn-fill" style="background:linear-gradient(135deg,#8b4a9e,#c9689a);">Shop Women's Watches</a>
      <a href="${pageContext.request.contextPath}/for-him" class="forher-switch-btn">Switch to For Him &#8594;</a>
    </div>
  </div>
</div>

<div class="pg-body">

  <%-- Breadcrumb --%>
  <div class="forher-breadcrumb">
    <a href="${pageContext.request.contextPath}/">Home</a>
    <span>&#8250;</span>
    <a href="${pageContext.request.contextPath}/gifting">Gift Guide</a>
    <span>&#8250;</span>
    <span>For Her</span>
  </div>

  <%-- Style filter tabs --%>
  <div class="forher-filter-row">
    <div class="forher-filter-label">Filter by style:</div>
    <div class="tabs-wrap" style="margin-bottom:0;">
      <button class="tab active" onclick="filterCards('all', this)">All Styles</button>
      <button class="tab" onclick="filterCards('elegant', this)">Elegant</button>
      <button class="tab" onclick="filterCards('minimal', this)">Minimal</button>
      <button class="tab" onclick="filterCards('bold', this)">Bold</button>
      <button class="tab" onclick="filterCards('luxury', this)">Luxury</button>
    </div>
  </div>

  <%-- Cards grid --%>
  <div class="forher-grid" id="forher-grid">

    <article class="gift-pick-card reveal" data-category="elegant">
      <img src="${pageContext.request.contextPath}/static/images/for-her/her-1.webp" alt="Elegant Essential" />
      <div class="gift-pick-body">
        <div class="gift-pick-style-tag gift-pick-style-forher-elegant">Elegant</div>
        <div class="gift-pick-title">Elegant Essential</div>
        <p>Refined rose gold case with a delicate mesh band. Designed for every occasion, every day.</p>
        <div class="forher-card-footer">
          <div class="gift-pick-meta">NPR 6,500 – 12,000</div>
          <div class="gift-card-actions">
            <form action="${pageContext.request.contextPath}/cart" method="post" style="display:contents;">
              <input type="hidden" name="action" value="add">
              <input type="hidden" name="productId" value="17">
              <input type="hidden" name="quantity" value="1">
              <button class="forher-cart-btn" type="submit" title="Add to cart">&#128717;</button>
            </form>
            <a href="${pageContext.request.contextPath}/product-details?id=17" class="forher-card-btn">View &#8594;</a>
          </div>
        </div>
      </div>
    </article>

    <article class="gift-pick-card reveal reveal-delay-1" data-category="minimal">
      <img src="${pageContext.request.contextPath}/static/images/for-her/her-2.webp" alt="Modern Minimal" />
      <div class="gift-pick-body">
        <div class="gift-pick-style-tag gift-pick-style-minimal">Minimal</div>
        <div class="gift-pick-title">Modern Minimal</div>
        <p>Clean white dial with a slim profile. Understated style that complements any outfit effortlessly.</p>
        <div class="forher-card-footer">
          <div class="gift-pick-meta">NPR 5,000 – 10,000</div>
          <div class="gift-card-actions">
            <form action="${pageContext.request.contextPath}/cart" method="post" style="display:contents;">
              <input type="hidden" name="action" value="add">
              <input type="hidden" name="productId" value="20">
              <input type="hidden" name="quantity" value="1">
              <button class="forher-cart-btn" type="submit" title="Add to cart">&#128717;</button>
            </form>
            <a href="${pageContext.request.contextPath}/product-details?id=20" class="forher-card-btn">View &#8594;</a>
          </div>
        </div>
      </div>
    </article>

    <article class="gift-pick-card reveal reveal-delay-2" data-category="bold">
      <img src="${pageContext.request.contextPath}/static/images/for-her/her-3.webp" alt="Statement Bold" />
      <div class="gift-pick-body">
        <div class="gift-pick-style-tag gift-pick-style-forher-bold">Bold</div>
        <div class="gift-pick-title">Statement Bold</div>
        <p>Oversized dial with diamant&eacute;-cut accents. A bold statement for the woman who owns the room.</p>
        <div class="forher-card-footer">
          <div class="gift-pick-meta">NPR 10,000 – 20,000</div>
          <div class="gift-card-actions">
            <form action="${pageContext.request.contextPath}/cart" method="post" style="display:contents;">
              <input type="hidden" name="action" value="add">
              <input type="hidden" name="productId" value="19">
              <input type="hidden" name="quantity" value="1">
              <button class="forher-cart-btn" type="submit" title="Add to cart">&#128717;</button>
            </form>
            <a href="${pageContext.request.contextPath}/product-details?id=19" class="forher-card-btn">View &#8594;</a>
          </div>
        </div>
      </div>
    </article>

    <article class="gift-pick-card reveal reveal-delay-3" data-category="luxury elegant">
      <img src="${pageContext.request.contextPath}/static/images/for-her/her-4.webp" alt="Luxury Jewelled" />
      <div class="gift-pick-body">
        <div class="gift-pick-style-tag gift-pick-style-luxury">Luxury</div>
        <div class="gift-pick-title">Jewelled Luxury</div>
        <p>Crystal-set bezel with mother-of-pearl dial. The pinnacle of feminine watchmaking.</p>
        <div class="forher-card-footer">
          <div class="gift-pick-meta">NPR 35,000+</div>
          <div class="gift-card-actions">
            <form action="${pageContext.request.contextPath}/cart" method="post" style="display:contents;">
              <input type="hidden" name="action" value="add">
              <input type="hidden" name="productId" value="18">
              <input type="hidden" name="quantity" value="1">
              <button class="forher-cart-btn" type="submit" title="Add to cart">&#128717;</button>
            </form>
            <a href="${pageContext.request.contextPath}/product-details?id=18" class="forher-card-btn">View &#8594;</a>
          </div>
        </div>
      </div>
    </article>

    <article class="gift-pick-card reveal" data-category="elegant minimal">
      <img src="${pageContext.request.contextPath}/static/images/for-her/her-5.webp" alt="Everyday Chic" />
      <div class="gift-pick-body">
        <div class="gift-pick-style-tag gift-pick-style-forher-elegant">Elegant</div>
        <div class="gift-pick-title">Everyday Chic</div>
        <p>Versatile silicone straps in pastel tones. Light, sporty, and effortlessly stylish.</p>
        <div class="forher-card-footer">
          <div class="gift-pick-meta">NPR 4,500 – 8,000</div>
          <div class="gift-card-actions">
            <form action="${pageContext.request.contextPath}/cart" method="post" style="display:contents;">
              <input type="hidden" name="action" value="add">
              <input type="hidden" name="productId" value="20">
              <input type="hidden" name="quantity" value="1">
              <button class="forher-cart-btn" type="submit" title="Add to cart">&#128717;</button>
            </form>
            <a href="${pageContext.request.contextPath}/product-details?id=20" class="forher-card-btn">View &#8594;</a>
          </div>
        </div>
      </div>
    </article>

    <article class="gift-pick-card reveal reveal-delay-1" data-category="luxury bold">
      <img src="${pageContext.request.contextPath}/static/images/for-her/her-6.webp" alt="Prestige Series" />
      <div class="gift-pick-body">
        <div class="gift-pick-style-tag gift-pick-style-luxury">Luxury</div>
        <div class="gift-pick-title">Prestige Series</div>
        <p>Swiss movement, gold-plated case. For milestones, anniversaries, and once-in-a-lifetime moments.</p>
        <div class="forher-card-footer">
          <div class="gift-pick-meta">NPR 50,000+</div>
          <div class="gift-card-actions">
            <form action="${pageContext.request.contextPath}/cart" method="post" style="display:contents;">
              <input type="hidden" name="action" value="add">
              <input type="hidden" name="productId" value="17">
              <input type="hidden" name="quantity" value="1">
              <button class="forher-cart-btn" type="submit" title="Add to cart">&#128717;</button>
            </form>
            <a href="${pageContext.request.contextPath}/product-details?id=17" class="forher-card-btn">View &#8594;</a>
          </div>
        </div>
      </div>
    </article>

  </div>

  <%-- Back nav --%>
  <div class="forher-back-row">
    <a href="${pageContext.request.contextPath}/gifting" class="forher-back-link">
      &#8592; Back to Gift Guide
    </a>
    <a href="${pageContext.request.contextPath}/for-him" class="forher-switch-link">
      Switch to For Him &#8594;
    </a>
  </div>

</div>

<style>
.forher-hero { min-height: 60vh; }
.forher-switch-btn {
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
.forher-switch-btn:hover { background: rgba(255,255,255,0.25); }

/* For Her style-specific tags */
.gift-pick-style-forher-elegant {
  background: #fff0f8;
  color:      #b8468a;
}
.gift-pick-style-forher-bold {
  background: #fff4e0;
  color:      #c87a20;
}
.forher-card-btn { font-size: 0.78rem; font-weight: 700; color: #b8468a; text-decoration: none; }
.forher-card-btn:hover { color: #8b2a6e; }

.gift-card-actions {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}
.forher-cart-btn {
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
.forher-cart-btn:hover {
  background: #fff0f8;
  border-color: #e0a0c0;
  transform: scale(1.08);
}

.forher-breadcrumb {
  display:     flex;
  align-items: center;
  gap:         0.5rem;
  font-size:   0.78rem;
  color:       var(--muted);
  margin-bottom: 2rem;
}
.forher-breadcrumb a { color: var(--green); text-decoration: none; font-weight: 600; }
.forher-breadcrumb span { color: var(--dim); }
.forher-filter-row {
  display:     flex;
  align-items: center;
  gap:         1.5rem;
  margin-bottom: 2rem;
  flex-wrap:   wrap;
}
.forher-filter-label { font-size: 0.78rem; font-weight: 700; color: var(--muted); }
.forher-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 1.5rem; margin-bottom: 3rem; }
.gift-pick-style-tag {
  display:    inline-flex;
  padding:    0.25rem 0.75rem;
  border-radius: 999px;
  font-size:  0.66rem;
  font-weight: 700;
  letter-spacing: 0.08em;
  text-transform: uppercase;
  background: var(--green-light);
  color:      var(--green);
  margin-bottom: 0.55rem;
}
.gift-pick-style-minimal { background: var(--surface); color: var(--muted); }
.gift-pick-style-luxury  { background: var(--gold-light); color: var(--gold2); }
.forher-card-footer { display: flex; justify-content: space-between; align-items: center; margin-top: 0.75rem; padding-top: 0.75rem; border-top: 1px solid var(--border); }
.forher-back-row { display: flex; justify-content: space-between; align-items: center; padding-top: 2rem; border-top: 1px solid var(--border); flex-wrap: wrap; gap: 1rem; }
.forher-back-link, .forher-switch-link { font-size: 0.84rem; font-weight: 700; color: var(--green); text-decoration: none; }
.forher-grid .gift-pick-card.hidden { display: none; }

@media (max-width: 900px)  { .forher-grid { grid-template-columns: repeat(2, 1fr); } }
@media (max-width: 600px)  { .forher-grid { grid-template-columns: 1fr; } }
</style>

<script>
function filterCards(cat, btn) {
  document.querySelectorAll('.tabs-wrap .tab').forEach(function(t){ t.classList.remove('active'); });
  btn.classList.add('active');
  document.querySelectorAll('.forher-grid .gift-pick-card').forEach(function(card){
    if (cat === 'all' || (card.dataset.category && card.dataset.category.indexOf(cat) !== -1)) {
      card.classList.remove('hidden');
    } else {
      card.classList.add('hidden');
    }
  });
}
</script>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
