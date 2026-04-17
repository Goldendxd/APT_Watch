<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  request.setAttribute("pageTitle", "Gift Guide | AluGhadi Watches");
  request.setAttribute("pageDesc", "Find the perfect watch gift for him or her. Curated top picks from AluGhadi.");
  request.setAttribute("activeNav", "gifting");
%>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<%-- ===== HERO — minimal, video-ready ===== --%>
<section class="gift-hero">
  <%-- Placeholder: swap this div for a <video> tag later --%>
  <div class="gift-hero-bg"></div>
  <div class="gift-hero-overlay"></div>

  <div class="gift-hero-content">
    <p class="gift-hero-eyebrow">&#127873; AluGhadi Gift Guide</p>
    <h1 class="gift-hero-title">Find the Perfect<br/>Watch Gift</h1>
    <p class="gift-hero-sub">
      Premium timepieces for every milestone — curated by style,
      budget, and the person who matters most.
    </p>

    <div class="gift-hero-btns">
      <a href="${pageContext.request.contextPath}/for-him" class="gift-hbtn gift-hbtn-him">
        <span class="gift-hbtn-icon">&#9794;</span>
        <span class="gift-hbtn-inner">
          <span class="gift-hbtn-label">Gifts</span>
          <span class="gift-hbtn-name">For Him</span>
        </span>
        <span class="gift-hbtn-arr">&#8594;</span>
      </a>
      <a href="${pageContext.request.contextPath}/for-her" class="gift-hbtn gift-hbtn-her">
        <span class="gift-hbtn-icon">&#9792;</span>
        <span class="gift-hbtn-inner">
          <span class="gift-hbtn-label">Gifts</span>
          <span class="gift-hbtn-name">For Her</span>
        </span>
        <span class="gift-hbtn-arr">&#8594;</span>
      </a>
    </div>
  </div>
</section>

<%-- ===== OUR TOP PICKS ===== --%>
<section class="gift-picks-sec">
  <div class="gift-picks-inner">

    <div class="gift-picks-header">
      <div class="sec-tag">Curated For You</div>
      <h2 class="gift-picks-title">Our Top Picks</h2>
      <p class="gift-picks-sub">Handpicked timepieces that make unforgettable gifts.</p>
    </div>

    <div class="gift-picks-grid">

      <article class="gift-pick">
        <div class="gift-pick-img">
          <img src="${pageContext.request.contextPath}/static/images/snow_leopard.png" alt="Executive Classic" />
          <span class="gift-pick-badge">For Him</span>
        </div>
        <div class="gift-pick-info">
          <div class="gift-pick-brand">Classic Collection</div>
          <div class="gift-pick-name">Executive Classic</div>
          <div class="gift-pick-price">From NPR 8,000</div>
          <a href="${pageContext.request.contextPath}/products" class="gift-pick-link">Shop Now &#8594;</a>
        </div>
      </article>

      <article class="gift-pick">
        <div class="gift-pick-img">
          <img src="${pageContext.request.contextPath}/static/images/snow_leopard.png" alt="Elegant Rose" />
          <span class="gift-pick-badge gift-pick-badge-her">For Her</span>
        </div>
        <div class="gift-pick-info">
          <div class="gift-pick-brand">Elegant Series</div>
          <div class="gift-pick-name">Rose Gold Elegance</div>
          <div class="gift-pick-price">From NPR 6,500</div>
          <a href="${pageContext.request.contextPath}/products" class="gift-pick-link">Shop Now &#8594;</a>
        </div>
      </article>

      <article class="gift-pick">
        <div class="gift-pick-img">
          <img src="${pageContext.request.contextPath}/static/images/snow_leopard.png" alt="Sport Pro" />
          <span class="gift-pick-badge">For Him</span>
        </div>
        <div class="gift-pick-info">
          <div class="gift-pick-brand">Sport Collection</div>
          <div class="gift-pick-name">Active Sport Pro</div>
          <div class="gift-pick-price">From NPR 5,500</div>
          <a href="${pageContext.request.contextPath}/products" class="gift-pick-link">Shop Now &#8594;</a>
        </div>
      </article>

      <article class="gift-pick">
        <div class="gift-pick-img">
          <img src="${pageContext.request.contextPath}/static/images/snow_leopard.png" alt="Prestige Jewelled" />
          <span class="gift-pick-badge gift-pick-badge-her">For Her</span>
        </div>
        <div class="gift-pick-info">
          <div class="gift-pick-brand">Prestige Series</div>
          <div class="gift-pick-name">Jewelled Prestige</div>
          <div class="gift-pick-price">From NPR 35,000</div>
          <a href="${pageContext.request.contextPath}/products" class="gift-pick-link">Shop Now &#8594;</a>
        </div>
      </article>

      <article class="gift-pick">
        <div class="gift-pick-img">
          <img src="${pageContext.request.contextPath}/static/images/snow_leopard.png" alt="Minimal Slim" />
          <span class="gift-pick-badge">For Him</span>
        </div>
        <div class="gift-pick-info">
          <div class="gift-pick-brand">Minimal Collection</div>
          <div class="gift-pick-name">Slim Minimal</div>
          <div class="gift-pick-price">From NPR 7,000</div>
          <a href="${pageContext.request.contextPath}/products" class="gift-pick-link">Shop Now &#8594;</a>
        </div>
      </article>

      <article class="gift-pick">
        <div class="gift-pick-img">
          <img src="${pageContext.request.contextPath}/static/images/snow_leopard.png" alt="Everyday Chic" />
          <span class="gift-pick-badge gift-pick-badge-her">For Her</span>
        </div>
        <div class="gift-pick-info">
          <div class="gift-pick-brand">Chic Series</div>
          <div class="gift-pick-name">Everyday Chic</div>
          <div class="gift-pick-price">From NPR 4,500</div>
          <a href="${pageContext.request.contextPath}/products" class="gift-pick-link">Shop Now &#8594;</a>
        </div>
      </article>

    </div>

    <div class="gift-picks-footer">
      <a href="${pageContext.request.contextPath}/products" class="btn-fill">Browse All Watches &#8594;</a>
    </div>

  </div>
</section>

<style>

/* =====================================================
   GIFT HERO
   ===================================================== */
.gift-hero {
  position:        relative;
  min-height:      88vh;
  display:         flex;
  align-items:     center;
  justify-content: center;
  text-align:      center;
  margin-top:      80px;
  overflow:        hidden;
  padding:         3rem 2rem;
}

/* Swap this for <video autoplay muted loop> later */
.gift-hero-bg {
  position:   absolute;
  inset:      0;
  background: linear-gradient(160deg, #071410 0%, #0d2318 40%, #1a4d2e 75%, #1a6b38 100%);
}

.gift-hero-overlay {
  position:   absolute;
  inset:      0;
  background-image:
    radial-gradient(ellipse 80% 60% at 15% 70%, rgba(61,186,98,0.12) 0%, transparent 65%),
    radial-gradient(ellipse 55% 55% at 85% 25%, rgba(201,164,82,0.09) 0%, transparent 60%);
}

.gift-hero-content {
  position:   relative;
  z-index:    2;
  max-width:  640px;
}

.gift-hero-eyebrow {
  display:       inline-block;
  font-size:     0.72rem;
  font-weight:   700;
  letter-spacing: 0.18em;
  text-transform: uppercase;
  color:         rgba(201,164,82,0.9);
  background:    rgba(201,164,82,0.1);
  border:        1px solid rgba(201,164,82,0.25);
  padding:       0.35rem 1rem;
  border-radius: 999px;
  margin-bottom: 1.4rem;
}

.gift-hero-title {
  font-size:      clamp(2.8rem, 6vw, 5rem);
  font-weight:    900;
  color:          #fff;
  line-height:    1.08;
  letter-spacing: -0.03em;
  margin-bottom:  1rem;
}

.gift-hero-sub {
  font-size:     0.95rem;
  color:         rgba(255,255,255,0.55);
  line-height:   1.75;
  margin-bottom: 2.5rem;
  max-width:     480px;
  margin-left:   auto;
  margin-right:  auto;
}

/* ---- For Him / For Her buttons ---- */
.gift-hero-btns {
  display:         flex;
  gap:             0.85rem;
  justify-content: center;
  flex-wrap:       wrap;
}

.gift-hbtn {
  display:         inline-flex;
  align-items:     center;
  gap:             0.75rem;
  padding:         0.85rem 1.65rem;
  border-radius:   14px;
  text-decoration: none;
  color:           #fff;
  min-width:       170px;
  border:          1.5px solid rgba(255,255,255,0.14);
  backdrop-filter: blur(14px);
  transition:      all 0.26s var(--ease, cubic-bezier(0.16,1,0.3,1));
}
.gift-hbtn:hover {
  transform:  translateY(-3px);
  box-shadow: 0 14px 36px rgba(0,0,0,0.32);
}

.gift-hbtn-him {
  background:   linear-gradient(135deg, rgba(26,107,56,0.72) 0%, rgba(10,30,16,0.88) 100%);
  border-color: rgba(61,186,98,0.32);
}
.gift-hbtn-him:hover {
  background:   linear-gradient(135deg, rgba(37,138,74,0.88) 0%, rgba(26,107,56,0.96) 100%);
  border-color: rgba(61,186,98,0.55);
}

.gift-hbtn-her {
  background:   linear-gradient(135deg, rgba(130,60,160,0.68) 0%, rgba(28,8,38,0.88) 100%);
  border-color: rgba(201,164,82,0.3);
}
.gift-hbtn-her:hover {
  background:   linear-gradient(135deg, rgba(155,80,185,0.88) 0%, rgba(90,25,110,0.96) 100%);
  border-color: rgba(201,164,82,0.55);
}

.gift-hbtn-icon {
  font-size:   1.35rem;
  flex-shrink: 0;
  line-height: 1;
}

.gift-hbtn-inner {
  display:        flex;
  flex-direction: column;
  align-items:    flex-start;
  flex:           1;
}
.gift-hbtn-label {
  font-size:      0.6rem;
  font-weight:    700;
  letter-spacing: 0.18em;
  text-transform: uppercase;
  color:          rgba(255,255,255,0.45);
  line-height:    1;
  margin-bottom:  0.2rem;
}
.gift-hbtn-name {
  font-size:      1.1rem;
  font-weight:    900;
  letter-spacing: -0.02em;
  line-height:    1;
}

.gift-hbtn-arr {
  font-size:  1rem;
  opacity:    0.5;
  transition: all 0.22s;
}
.gift-hbtn:hover .gift-hbtn-arr { opacity: 1; transform: translateX(4px); }

/* =====================================================
   TOP PICKS SECTION
   ===================================================== */
.gift-picks-sec {
  padding: 5rem 2rem 6rem;
  background: var(--bg, #f2f6f2);
}
.gift-picks-inner {
  max-width: 1280px;
  margin:    0 auto;
}

.gift-picks-header {
  text-align:    center;
  margin-bottom: 3rem;
}
.gift-picks-title {
  font-size:      clamp(1.8rem, 3.5vw, 2.8rem);
  font-weight:    900;
  letter-spacing: -0.025em;
  margin-bottom:  0.5rem;
}
.gift-picks-sub {
  font-size:   0.9rem;
  color:       var(--muted, #4e6a59);
  line-height: 1.65;
}

/* 3-column grid */
.gift-picks-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap:     1.5rem;
  margin-bottom: 3rem;
}

/* Individual pick card */
.gift-pick {
  background:     var(--white, #fff);
  border:         1.5px solid var(--border, #d4e5da);
  border-radius:  18px;
  overflow:       hidden;
  transition:     all 0.28s cubic-bezier(0.16,1,0.3,1);
}
.gift-pick:hover {
  transform:    translateY(-5px);
  box-shadow:   0 14px 40px rgba(10,30,15,0.12);
  border-color: var(--green-mid, #b2d9c0);
}

.gift-pick-img {
  position: relative;
  width:    100%;
  height:   220px;
  overflow: hidden;
  background: var(--surface, #eaf0ea);
}
.gift-pick-img img {
  width:      100%;
  height:     100%;
  object-fit: cover;
  transition: transform 0.45s cubic-bezier(0.16,1,0.3,1);
}
.gift-pick:hover .gift-pick-img img { transform: scale(1.06); }

/* Him / Her badge */
.gift-pick-badge {
  position:      absolute;
  top:           0.85rem;
  left:          0.85rem;
  font-size:     0.66rem;
  font-weight:   700;
  letter-spacing: 0.08em;
  text-transform: uppercase;
  background:    var(--green, #1a6b38);
  color:         #fff;
  padding:       0.28rem 0.7rem;
  border-radius: 999px;
}
.gift-pick-badge-her { background: #9b4ab2; }

.gift-pick-info {
  padding: 1.2rem 1.3rem 1.4rem;
}
.gift-pick-brand {
  font-size:      0.65rem;
  font-weight:    700;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  color:          var(--green, #1a6b38);
  margin-bottom:  0.35rem;
}
.gift-pick-name {
  font-size:   1.05rem;
  font-weight: 800;
  letter-spacing: -0.015em;
  margin-bottom: 0.3rem;
}
.gift-pick-price {
  font-size:   0.82rem;
  color:       var(--muted, #4e6a59);
  margin-bottom: 0.9rem;
}
.gift-pick-link {
  font-size:       0.8rem;
  font-weight:     700;
  color:           var(--green, #1a6b38);
  text-decoration: none;
  transition:      color 0.18s;
  display:         inline-flex;
  align-items:     center;
  gap:             0.3rem;
}
.gift-pick-link:hover { color: var(--green2, #258a4a); }

.gift-picks-footer {
  text-align: center;
  margin-top: 1rem;
}

/* =====================================================
   RESPONSIVE
   ===================================================== */
@media (max-width: 1024px) {
  .gift-picks-grid { grid-template-columns: repeat(2, 1fr); }
}
@media (max-width: 640px) {
  .gift-picks-grid { grid-template-columns: 1fr; }
  .gift-hero        { min-height: 75vh; }
  .gift-hbtn        { min-width: 140px; }
}
</style>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
