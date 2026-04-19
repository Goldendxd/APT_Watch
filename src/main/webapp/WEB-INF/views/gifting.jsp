<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  request.setAttribute("pageTitle", "Gift Guide | AluGhadi Watches");
  request.setAttribute("pageDesc", "Find the perfect watch gift for him or her. Curated top picks from AluGhadi.");
  request.setAttribute("activeNav", "gifting");
%>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<%-- ===== HERO — video background, minimal copy ===== --%>
<section class="gift-hero">
  <video class="gift-hero-video" autoplay muted loop playsinline preload="auto">
    <source
      src="${pageContext.request.contextPath}/static/video/water1.mp4"
      type="video/mp4"
    />
  </video>
  <div class="gift-hero-overlay"></div>

  <div class="gift-hero-content">
    <div class="gift-hero-copy">
      <p class="gift-hero-quote">
        "A gift should feel as timeless as the moment."
      </p>
    </div>

    <div class="gift-hero-actions">
      <a
        href="${pageContext.request.contextPath}/for-him"
        class="gift-hbtn gift-hbtn-him"
        >For Him</a
      >
      <a
        href="${pageContext.request.contextPath}/for-her"
        class="gift-hbtn gift-hbtn-her"
        >For Her</a
      >
    </div>
  </div>
</section>

<%-- ===== OUR TOP PICKS ===== --%>
<section class="gift-picks-sec">
  <div class="gift-picks-inner">
    <div class="gift-picks-header">
      <div class="sec-tag">Curated For You</div>
      <h2 class="gift-picks-title">Our Top Picks</h2>
      <p class="gift-picks-sub">
        Handpicked timepieces that make unforgettable gifts.
      </p>
    </div>

    <div class="gift-picks-grid">
      <article class="gift-pick">
        <div class="gift-pick-img">
          <img
            src="${pageContext.request.contextPath}/static/images/snow_leopard.png"
            alt="Executive Classic"
          />
          <span class="gift-pick-badge">For Him</span>
        </div>
        <div class="gift-pick-info">
          <div class="gift-pick-brand">Classic Collection</div>
          <div class="gift-pick-name">Executive Classic</div>
          <div class="gift-pick-price">From NPR 8,000</div>
          <a
            href="${pageContext.request.contextPath}/products"
            class="gift-pick-link"
            >Shop Now &#8594;</a
          >
        </div>
      </article>

      <article class="gift-pick">
        <div class="gift-pick-img">
          <img
            src="${pageContext.request.contextPath}/static/images/snow_leopard.png"
            alt="Elegant Rose"
          />
          <span class="gift-pick-badge gift-pick-badge-her">For Her</span>
        </div>
        <div class="gift-pick-info">
          <div class="gift-pick-brand">Elegant Series</div>
          <div class="gift-pick-name">Rose Gold Elegance</div>
          <div class="gift-pick-price">From NPR 6,500</div>
          <a
            href="${pageContext.request.contextPath}/products"
            class="gift-pick-link"
            >Shop Now &#8594;</a
          >
        </div>
      </article>

      <article class="gift-pick">
        <div class="gift-pick-img">
          <img
            src="${pageContext.request.contextPath}/static/images/snow_leopard.png"
            alt="Sport Pro"
          />
          <span class="gift-pick-badge">For Him</span>
        </div>
        <div class="gift-pick-info">
          <div class="gift-pick-brand">Sport Collection</div>
          <div class="gift-pick-name">Active Sport Pro</div>
          <div class="gift-pick-price">From NPR 5,500</div>
          <a
            href="${pageContext.request.contextPath}/products"
            class="gift-pick-link"
            >Shop Now &#8594;</a
          >
        </div>
      </article>

      <article class="gift-pick">
        <div class="gift-pick-img">
          <img
            src="${pageContext.request.contextPath}/static/images/snow_leopard.png"
            alt="Prestige Jewelled"
          />
          <span class="gift-pick-badge gift-pick-badge-her">For Her</span>
        </div>
        <div class="gift-pick-info">
          <div class="gift-pick-brand">Prestige Series</div>
          <div class="gift-pick-name">Jewelled Prestige</div>
          <div class="gift-pick-price">From NPR 35,000</div>
          <a
            href="${pageContext.request.contextPath}/products"
            class="gift-pick-link"
            >Shop Now &#8594;</a
          >
        </div>
      </article>

      <article class="gift-pick">
        <div class="gift-pick-img">
          <img
            src="${pageContext.request.contextPath}/static/images/snow_leopard.png"
            alt="Minimal Slim"
          />
          <span class="gift-pick-badge">For Him</span>
        </div>
        <div class="gift-pick-info">
          <div class="gift-pick-brand">Minimal Collection</div>
          <div class="gift-pick-name">Slim Minimal</div>
          <div class="gift-pick-price">From NPR 7,000</div>
          <a
            href="${pageContext.request.contextPath}/products"
            class="gift-pick-link"
            >Shop Now &#8594;</a
          >
        </div>
      </article>

      <article class="gift-pick">
        <div class="gift-pick-img">
          <img
            src="${pageContext.request.contextPath}/static/images/snow_leopard.png"
            alt="Everyday Chic"
          />
          <span class="gift-pick-badge gift-pick-badge-her">For Her</span>
        </div>
        <div class="gift-pick-info">
          <div class="gift-pick-brand">Chic Series</div>
          <div class="gift-pick-name">Everyday Chic</div>
          <div class="gift-pick-price">From NPR 4,500</div>
          <a
            href="${pageContext.request.contextPath}/products"
            class="gift-pick-link"
            >Shop Now &#8594;</a
          >
        </div>
      </article>
    </div>

    <div class="gift-picks-footer">
      <a href="${pageContext.request.contextPath}/products" class="btn-fill"
        >Browse All Watches &#8594;</a
      >
    </div>
  </div>
</section>

<style>
  /* =====================================================
       GIFT HERO
       ===================================================== */
  .gift-hero {
    position: relative;
    min-height: 88vh;
    display: flex;
    align-items: flex-end;
    justify-content: flex-start;
    margin-top: 80px;
    overflow: hidden;
    padding: 3rem 4.5vw 4.5rem;
  }

  .gift-hero-video {
    position: absolute;
    inset: 0;
    width: 100%;
    height: 100%;
    object-fit: cover;
  }

  .gift-hero-overlay {
    position: absolute;
    inset: 0;
    background: linear-gradient(
      90deg,
      rgba(6, 18, 10, 0.86) 0%,
      rgba(6, 18, 10, 0.56) 34%,
      rgba(6, 18, 10, 0.18) 68%,
      rgba(6, 18, 10, 0.32) 100%
    );
  }

  .gift-hero-content {
    position: relative;
    z-index: 2;
    width: 100%;
    max-width: 1240px;
    margin: 0 auto;
    display: flex;
    align-items: flex-end;
    justify-content: space-between;
    gap: 2rem;
  }

  .gift-hero-copy {
    max-width: 320px;
  }

  .gift-hero-quote {
    color: rgba(255, 255, 255, 0.88);
    font-size: clamp(0.95rem, 1.35vw, 1.1rem);
    line-height: 1.8;
    font-weight: 500;
    letter-spacing: 0.01em;
    margin: 0;
    padding-left: 1rem;
    border-left: 2px solid rgba(201, 164, 82, 0.75);
    text-align: left;
    text-shadow: 0 2px 12px rgba(0, 0, 0, 0.36);
  }

  .gift-hero-actions {
    display: flex;
    gap: 0.9rem;
    justify-content: flex-end;
    flex-wrap: wrap;
    margin-left: auto;
  }

  .gift-hbtn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    min-width: 160px;
    padding: 0.95rem 1.7rem;
    border-radius: 14px;
    text-decoration: none;
    color: #fff;
    font-size: 0.92rem;
    font-weight: 800;
    letter-spacing: 0.04em;
    text-transform: uppercase;
    border: 1px solid rgba(255, 255, 255, 0.16);
    backdrop-filter: blur(14px);
    transition: all 0.26s var(--ease, cubic-bezier(0.16, 1, 0.3, 1));
    box-shadow: 0 10px 28px rgba(0, 0, 0, 0.18);
  }
  .gift-hbtn:hover {
    transform: translateY(-3px);
    box-shadow: 0 14px 36px rgba(0, 0, 0, 0.34);
  }

  .gift-hbtn-him {
    background: linear-gradient(
      135deg,
      rgba(26, 107, 56, 0.92) 0%,
      rgba(9, 27, 14, 0.96) 100%
    );
    border-color: rgba(61, 186, 98, 0.35);
  }
  .gift-hbtn-him:hover {
    background: linear-gradient(
      135deg,
      rgba(37, 138, 74, 0.98) 0%,
      rgba(26, 107, 56, 0.98) 100%
    );
    border-color: rgba(61, 186, 98, 0.58);
  }

  .gift-hbtn-her {
    background: linear-gradient(
      135deg,
      rgba(107, 48, 137, 0.92) 0%,
      rgba(28, 8, 38, 0.96) 100%
    );
    border-color: rgba(201, 164, 82, 0.32);
  }
  .gift-hbtn-her:hover {
    background: linear-gradient(
      135deg,
      rgba(155, 80, 185, 0.98) 0%,
      rgba(90, 25, 110, 0.98) 100%
    );
    border-color: rgba(201, 164, 82, 0.58);
  }

  /* =====================================================
       TOP PICKS SECTION
       ===================================================== */
  .gift-picks-sec {
    padding: 5rem 2rem 6rem;
    background: var(--bg, #f2f6f2);
  }
  .gift-picks-inner {
    max-width: 1280px;
    margin: 0 auto;
  }

  .gift-picks-header {
    text-align: center;
    margin-bottom: 3rem;
  }
  .gift-picks-title {
    font-size: clamp(1.8rem, 3.5vw, 2.8rem);
    font-weight: 900;
    letter-spacing: -0.025em;
    margin-bottom: 0.5rem;
  }
  .gift-picks-sub {
    font-size: 0.9rem;
    color: var(--muted, #4e6a59);
    line-height: 1.65;
  }

  .gift-picks-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 1.5rem;
    margin-bottom: 3rem;
  }

  .gift-pick {
    background: var(--white, #fff);
    border: 1.5px solid var(--border, #d4e5da);
    border-radius: 18px;
    overflow: hidden;
    transition: all 0.28s cubic-bezier(0.16, 1, 0.3, 1);
  }
  .gift-pick:hover {
    transform: translateY(-5px);
    box-shadow: 0 14px 40px rgba(10, 30, 15, 0.12);
    border-color: var(--green-mid, #b2d9c0);
  }

  .gift-pick-img {
    position: relative;
    width: 100%;
    height: 220px;
    overflow: hidden;
    background: var(--surface, #eaf0ea);
  }
  .gift-pick-img img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.45s cubic-bezier(0.16, 1, 0.3, 1);
  }
  .gift-pick:hover .gift-pick-img img {
    transform: scale(1.06);
  }

  .gift-pick-badge {
    position: absolute;
    top: 0.85rem;
    left: 0.85rem;
    font-size: 0.66rem;
    font-weight: 700;
    letter-spacing: 0.08em;
    text-transform: uppercase;
    background: var(--green, #1a6b38);
    color: #fff;
    padding: 0.28rem 0.7rem;
    border-radius: 999px;
  }
  .gift-pick-badge-her {
    background: #9b4ab2;
  }

  .gift-pick-info {
    padding: 1.2rem 1.3rem 1.4rem;
  }
  .gift-pick-brand {
    font-size: 0.65rem;
    font-weight: 700;
    letter-spacing: 0.12em;
    text-transform: uppercase;
    color: var(--green, #1a6b38);
    margin-bottom: 0.35rem;
  }
  .gift-pick-name {
    font-size: 1.05rem;
    font-weight: 800;
    letter-spacing: -0.015em;
    margin-bottom: 0.3rem;
  }
  .gift-pick-price {
    font-size: 0.82rem;
    color: var(--muted, #4e6a59);
    margin-bottom: 0.9rem;
  }
  .gift-pick-link {
    font-size: 0.8rem;
    font-weight: 700;
    color: var(--green, #1a6b38);
    text-decoration: none;
    transition: color 0.18s;
    display: inline-flex;
    align-items: center;
    gap: 0.3rem;
  }
  .gift-pick-link:hover {
    color: var(--green2, #258a4a);
  }

  .gift-picks-footer {
    text-align: center;
    margin-top: 1rem;
  }

  @media (max-width: 1024px) {
    .gift-hero {
      padding: 3rem 2.5rem 4rem;
    }

    .gift-hero-content {
      flex-direction: column;
      align-items: flex-start;
    }

    .gift-hero-actions {
      margin-left: 0;
      justify-content: flex-start;
    }

    .gift-hero-copy {
      max-width: 420px;
    }

    .gift-picks-grid {
      grid-template-columns: repeat(2, 1fr);
    }
  }

  @media (max-width: 640px) {
    .gift-hero {
      min-height: 76vh;
      padding: 2.5rem 1.25rem 3rem;
    }

    .gift-hero-actions {
      width: 100%;
    }

    .gift-hbtn {
      width: 100%;
      min-width: 0;
    }

    .gift-hero-copy {
      max-width: 100%;
    }

    .gift-hero-quote {
      font-size: 0.95rem;
      padding-left: 0.85rem;
    }

    .gift-picks-grid {
      grid-template-columns: 1fr;
    }
  }
</style>
<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
