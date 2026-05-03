<%@ page contentType="text/html;charset=UTF-8" language="java" %><%
  request.setAttribute("pageTitle", "About Us | AluGhadi");
  request.setAttribute("pageDesc", "Meet the team behind AluGhadi — Nepal's premium watch destination. Crafted with precision and passion by five passionate developers.");
  request.setAttribute("activeNav", "about");
  request.setAttribute("pageStyle", "about");
%>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<%-- ======== PAGE HERO ======== --%>
<section class="page-hero about-hero">
  <div class="ph-img">
    <img src="${pageContext.request.contextPath}/static/images/about_images/hero_about.png"
         alt="AluGhadi Workshop"
         style="object-position: center;" />
  </div>
  <div class="ph-ov"></div>
  <div class="ph-body">
    <span class="ph-chip">&#9654; Our Story</span>
    <h1 class="ph-h">Crafted with <span>passion</span>,<br>built for <span>precision</span>.</h1>
    <p class="ph-sub">
      AluGhadi was born from a shared love of horology and a dream to bring world-class
      timepieces to Nepal. Five minds, one vision.
    </p>
  </div>
</section>

<%-- ======== BRAND STORY SECTION ======== --%>
<section class="sec">
  <div class="sec-inner">
    <div class="split reveal">
      <div class="split-body">
        <div class="sec-tag">Our Mission</div>
        <h2 class="sec-h">More than a <em style="font-style:normal;color:var(--gold);">watch</em> store.</h2>
        <p class="sec-sub" style="max-width:480px;">
          AluGhadi is Nepal's premier destination for fine timepieces. We believe a watch is
          more than a device — it's a statement, a companion, and a legacy passed through
          generations. Our mission is to connect discerning collectors with the world's most
          celebrated horological craftsmanship, delivered with care to your doorstep.
        </p>
        <div class="about-values">
          <div class="about-val-chip">&#9657; Authentic Brands</div>
          <div class="about-val-chip">&#9657; Secured Delivery</div>
          <div class="about-val-chip">&#9657; Expert Curation</div>
          <div class="about-val-chip">&#9657; After-Sales Care</div>
        </div>
      </div>
      <div class="split-stats-grid">
        <div class="about-stat-card reveal reveal-delay-1">
          <div class="asc-n">500<span>+</span></div>
          <div class="asc-l">Premium Watches</div>
        </div>
        <div class="about-stat-card reveal reveal-delay-2">
          <div class="asc-n">50<span>+</span></div>
          <div class="asc-l">Global Brands</div>
        </div>
        <div class="about-stat-card reveal reveal-delay-3">
          <div class="asc-n">2K<span>+</span></div>
          <div class="asc-l">Happy Customers</div>
        </div>
        <div class="about-stat-card reveal reveal-delay-4">
          <div class="asc-n">3<span>yr</span></div>
          <div class="asc-l">Warranty Support</div>
        </div>
      </div>
    </div>
  </div>
</section>

<%-- ======== DIVIDER STRIP ======== --%>
<div class="about-marquee-strip">
  <div class="about-marquee-inner">
    <span>&#10022; Precision</span><span>&#10022; Heritage</span>
    <span>&#10022; Craftsmanship</span><span>&#10022; Innovation</span>
    <span>&#10022; Excellence</span><span>&#10022; Nepal</span>
    <span>&#10022; Precision</span><span>&#10022; Heritage</span>
    <span>&#10022; Craftsmanship</span><span>&#10022; Innovation</span>
    <span>&#10022; Excellence</span><span>&#10022; Nepal</span>
  </div>
</div>

<%-- ======== TEAM SECTION ======== --%>
<section class="sec sec-alt">
  <div class="sec-inner">
    <div style="text-align:center;margin-bottom:3.5rem;" class="reveal">
      <div class="sec-tag" style="justify-content:center;">Meet the Team</div>
      <h2 class="sec-h">The <em style="font-style:normal;color:var(--gold);">five</em> behind AluGhadi</h2>
      <p class="sec-sub" style="margin:0.75rem auto 0;text-align:center;">
        A group of passionate students who turned a class project into a real e-commerce vision.
        Different skills, one shared ambition.
      </p>
    </div>

    <div class="team-grid">

      <%-- Team Card: Shisir Lamsal --%>
      <div class="team-card reveal reveal-delay-1">
        <div class="team-avatar-wrap">
          <div class="team-avatar" style="background: linear-gradient(135deg, #1a6b38 0%, #3dba62 100%);">
            <span>SL</span>
          </div>
          <div class="team-avatar-ring"></div>
        </div>
        <div class="team-body">
          <div class="team-role-chip">Project Lead</div>
          <h3 class="team-name">Shisir Lamsal</h3>
          <p class="team-bio">
            Visionary project lead who architected the system and kept the team aligned.
            Passionate about full-stack development and clean code.
          </p>
          <div class="team-skills">
            <span>Java EE</span><span>MVC</span><span>Leadership</span>
          </div>
        </div>
        <div class="team-card-glow" style="background: rgba(26,107,56,0.08);"></div>
      </div>

      <%-- Team Card: Dikshita GC --%>
      <div class="team-card reveal reveal-delay-2">
        <div class="team-avatar-wrap">
          <div class="team-avatar" style="background: linear-gradient(135deg, #c9a452 0%, #b8913a 100%);">
            <span>DG</span>
          </div>
          <div class="team-avatar-ring" style="border-color: var(--gold-light);"></div>
        </div>
        <div class="team-body">
          <div class="team-role-chip" style="color:var(--gold2);background:var(--gold-light);border-color:rgba(201,164,82,0.25);">UI / UX</div>
          <h3 class="team-name">Dikshita GC</h3>
          <p class="team-bio">
            The creative force driving AluGhadi's visual identity. Expert at translating
            ideas into beautiful, accessible interfaces that users love.
          </p>
          <div class="team-skills">
            <span>CSS</span><span>Design Systems</span><span>UX</span>
          </div>
        </div>
        <div class="team-card-glow" style="background: rgba(201,164,82,0.08);"></div>
      </div>

      <%-- Team Card: Ashish Thapa --%>
      <div class="team-card reveal reveal-delay-3">
        <div class="team-avatar-wrap">
          <div class="team-avatar" style="background: linear-gradient(135deg, #1d4ed8 0%, #3b82f6 100%);">
            <span>AT</span>
          </div>
          <div class="team-avatar-ring" style="border-color: #dbeafe;"></div>
        </div>
        <div class="team-body">
          <div class="team-role-chip" style="color:#1e40af;background:#eff6ff;border-color:rgba(59,130,246,0.2);">Backend Dev</div>
          <h3 class="team-name">Ashish Thapa</h3>
          <p class="team-bio">
            Backend architect responsible for database design and servlet infrastructure.
            Builds robust, scalable systems that power the entire platform.
          </p>
          <div class="team-skills">
            <span>MySQL</span><span>Servlets</span><span>DAO</span>
          </div>
        </div>
        <div class="team-card-glow" style="background: rgba(59,130,246,0.06);"></div>
      </div>

      <%-- Team Card: Sabin Thapa --%>
      <div class="team-card reveal reveal-delay-4">
        <div class="team-avatar-wrap">
          <div class="team-avatar" style="background: linear-gradient(135deg, #7c3aed 0%, #a78bfa 100%);">
            <span>ST</span>
          </div>
          <div class="team-avatar-ring" style="border-color: #ede9fe;"></div>
        </div>
        <div class="team-body">
          <div class="team-role-chip" style="color:#6d28d9;background:#f5f3ff;border-color:rgba(124,58,237,0.2);">Frontend Dev</div>
          <h3 class="team-name">Sabin Thapa</h3>
          <p class="team-bio">
            Frontend specialist who brings designs to life with smooth interactions and
            pixel-perfect layouts. JavaScript enthusiast with an eye for detail.
          </p>
          <div class="team-skills">
            <span>JavaScript</span><span>JSP</span><span>Animations</span>
          </div>
        </div>
        <div class="team-card-glow" style="background: rgba(124,58,237,0.06);"></div>
      </div>

      <%-- Team Card: Rijan Pun --%>
      <div class="team-card reveal reveal-delay-5">
        <div class="team-avatar-wrap">
          <div class="team-avatar" style="background: linear-gradient(135deg, #d97706 0%, #f59e0b 100%);">
            <span>RP</span>
          </div>
          <div class="team-avatar-ring" style="border-color: #fde68a;"></div>
        </div>
        <div class="team-body">
          <div class="team-role-chip" style="color:#b45309;background:#fffbeb;border-color:rgba(217,119,6,0.22);">QA &amp; Testing</div>
          <h3 class="team-name">Rijan Pun</h3>
          <p class="team-bio">
            Quality guardian who ensures every feature is robust, bug-free, and
            delivers a flawless experience. Driven by precision and user empathy.
          </p>
          <div class="team-skills">
            <span>Testing</span><span>QA</span><span>Debugging</span>
          </div>
        </div>
        <div class="team-card-glow" style="background: rgba(217,119,6,0.06);"></div>
      </div>

    </div><%-- /team-grid --%>
  </div>
</section>

<%-- ======== VALUES / WHAT WE BELIEVE ======== --%>
<section class="sec">
  <div class="sec-inner">
    <div style="text-align:center;margin-bottom:3rem;" class="reveal">
      <div class="sec-tag" style="justify-content:center;">What We Stand For</div>
      <h2 class="sec-h">Built on <em style="font-style:normal;color:var(--green);">values</em> that matter</h2>
    </div>
    <div class="feat-grid">
      <div class="feat-card reveal reveal-delay-1">
        <div class="feat-card-icon icon-bg-green">&#9200;</div>
        <div class="feat-card-title">Precision First</div>
        <p class="feat-card-desc">Every watch we carry is vetted for accuracy, authenticity and craftsmanship. We never compromise on quality.</p>
      </div>
      <div class="feat-card reveal reveal-delay-2">
        <div class="feat-card-icon icon-bg-gold">&#128081;</div>
        <div class="feat-card-title">Timeless Heritage</div>
        <p class="feat-card-desc">We celebrate the art of watchmaking by connecting you with heritage brands that have stood the test of time.</p>
      </div>
      <div class="feat-card reveal reveal-delay-3">
        <div class="feat-card-icon icon-bg-blue">&#127468;&#127479;</div>
        <div class="feat-card-title">Made for Nepal</div>
        <p class="feat-card-desc">Localised experience, local prices, local support. AluGhadi is proudly rooted in Nepal's growing collector community.</p>
      </div>
    </div>
  </div>
</section>

<%-- ======== DARK CTA BAND ======== --%>
<section class="sec sec-dark" style="padding:4rem 2rem;">
  <div class="sec-inner" style="text-align:center;">
    <div class="sec-tag" style="justify-content:center;">Ready to explore?</div>
    <h2 class="sec-h" style="margin-bottom:1rem;">Find your <em style="font-style:normal;color:var(--accent);">perfect</em> timepiece</h2>
    <p class="sec-sub" style="margin:0 auto 2rem;text-align:center;">
      Browse our curated collection of luxury and everyday watches — something for every wrist.
    </p>
    <div style="display:flex;gap:1rem;justify-content:center;flex-wrap:wrap;">
      <a href="${pageContext.request.contextPath}/products" class="btn btn-g btn-lg">&#128717; Shop Collection</a>
      <a href="${pageContext.request.contextPath}/contact"  class="btn btn-o btn-lg" style="color:#fff;border-color:rgba(255,255,255,0.25);">&#9993; Get in Touch</a>
    </div>
  </div>
</section>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
