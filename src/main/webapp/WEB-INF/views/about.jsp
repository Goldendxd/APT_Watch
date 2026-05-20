<%--
  about.jsp — About Us page.
  Static content page — no servlet data needed. Sets its own pageTitle / activeNav inline.
  Includes header.jsp and footer.jsp.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %><%
  request.setAttribute("pageTitle", "About Us | AluGhadi");
  request.setAttribute("pageDesc", "Meet the team behind AluGhadi — Nepal's premium watch destination. Crafted with precision and passion by five passionate developers.");
  request.setAttribute("activeNav", "about");
  request.setAttribute("pageStyle", "about");
%>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />
<jsp:include page="/WEB-INF/views/layout/head.jsp" />


<%-- ======== PAGE HERO ======== --%>
<section class="page-hero about-hero">
  <div class="ph-img">
    <img src="${pageContext.request.contextPath}/static/images/about_images/hero_about.png"
         alt="AluGhadi Workshop"
         style="object-position: center;" />
  </div>
  <div class="ph-ov"></div>
  <div class="ph-body">
    <span class="ph-chip">Our Story</span>
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
          <div class="about-val-chip">Authentic Brands</div>
          <div class="about-val-chip">Secured Delivery</div>
          <div class="about-val-chip">Expert Curation</div>
          <div class="about-val-chip">After-Sales Care</div>
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

<%-- ======== DIVIDER STRIP (marquee) ======== --%>
<div class="about-marquee-strip">
  <div class="about-marquee-inner">
    <span>Heritage</span><span>Craftsmanship</span>
    <span>Innovation</span><span>Excellence</span>
    <span>Nepal</span><span>Precision</span>
    <span>Heritage</span><span>Craftsmanship</span>
    <span>Innovation</span><span>Excellence</span>
    <span>Nepal</span><span>Precision</span>
    <%-- duplicate set for seamless loop --%>
    <span>Heritage</span><span>Craftsmanship</span>
    <span>Innovation</span><span>Excellence</span>
    <span>Nepal</span><span>Precision</span>
    <span>Heritage</span><span>Craftsmanship</span>
    <span>Innovation</span><span>Excellence</span>
    <span>Nepal</span><span>Precision</span>
  </div>
</div>

<%-- ======== TEAM SECTION ======== --%>
<section class="sec sec-alt">
  <div class="sec-inner">
    <div style="text-align:center;margin-bottom:3.5rem;" class="reveal">
      <div class="sec-tag" style="justify-content:center;">Meet the Team</div>
      <h2 class="sec-h">The <em style="font-style:normal;color:var(--gold);">five</em> behind AluGhadi</h2>
      <p class="sec-sub" style="margin:0.75rem auto 0;text-align:center;">
        Five students from London Metropolitan University who built AluGhadi from the ground up —
        each owning a distinct part of the platform, united by one shared ambition.
      </p>
    </div>

    <div class="team-grid">

      <%-- Team Card: Ashish Thapa --%>
      <div class="team-card reveal reveal-delay-1">
        <div class="team-avatar-wrap">
          <div class="team-avatar" style="padding:0;overflow:hidden;">
            <img src="${pageContext.request.contextPath}/static/images/about_images/Ashish.webp" alt="Ashish Thapa" style="width:100%;height:100%;object-fit:cover;display:block;" />
          </div>
          <div class="team-avatar-ring" style="border-color: #dbeafe;"></div>
        </div>
        <div class="team-body">
          <div class="team-role-chip" style="color:#1e40af;background:#eff6ff;border-color:rgba(59,130,246,0.2);">24040801</div>
          <h3 class="team-name">Ashish Thapa</h3>
          <p class="team-bio">
            Built the cart feature, gifting page, For Him and For Her pages,
            and the image upload utility powering the entire product catalogue.
          </p>
          <div class="team-skills">
            <span>Cart</span><span>Gifting</span><span>Image Upload</span>
          </div>
        </div>
        <div class="team-card-glow" style="background: rgba(59,130,246,0.06);"></div>
      </div>

      <%-- Team Card: Dikshita GC --%>
      <div class="team-card reveal reveal-delay-2">
        <div class="team-avatar-wrap">
          <div class="team-avatar" style="padding:0;overflow:hidden;">
            <img src="${pageContext.request.contextPath}/static/images/about_images/Dikshita.webp" alt="Dikshita GC" style="width:100%;height:100%;object-fit:cover;display:block;" />
          </div>
          <div class="team-avatar-ring" style="border-color: var(--gold-light);"></div>
        </div>
        <div class="team-body">
          <div class="team-role-chip" style="color:var(--gold2);background:var(--gold-light);border-color:rgba(201,164,82,0.25);">24041428</div>
          <h3 class="team-name">Dikshita GC</h3>
          <p class="team-bio">
            Designed the entire CSS design system and built the authentication filter,
            cookie management, and the product details page.
          </p>
          <div class="team-skills">
            <span>CSS Design System</span><span>Auth Filter</span><span>Product Details</span>
          </div>
        </div>
        <div class="team-card-glow" style="background: rgba(201,164,82,0.08);"></div>
      </div>

      <%-- Team Card: Rijan Pun --%>
      <div class="team-card reveal reveal-delay-3">
        <div class="team-avatar-wrap">
          <div class="team-avatar" style="padding:0;overflow:hidden;">
            <img src="${pageContext.request.contextPath}/static/images/about_images/Rijan.webp" alt="Rijan Pun" style="width:100%;height:100%;object-fit:cover;display:block;" />
          </div>
          <div class="team-avatar-ring" style="border-color: #fde68a;"></div>
        </div>
        <div class="team-body">
          <div class="team-role-chip" style="color:#b45309;background:#fffbeb;border-color:rgba(217,119,6,0.22);">24044068</div>
          <h3 class="team-name">Rijan Pun</h3>
          <p class="team-bio">
            Designed and built the database, developed the home page, about page,
            contact page, logout functionality, and the site footer.
          </p>
          <div class="team-skills">
            <span>Database</span><span>Home &amp; About</span><span>Footer</span>
          </div>
        </div>
        <div class="team-card-glow" style="background: rgba(217,119,6,0.06);"></div>
      </div>

      <%-- Team Card: Sabin Thapa --%>
      <div class="team-card reveal reveal-delay-4">
        <div class="team-avatar-wrap">
          <div class="team-avatar" style="padding:0;overflow:hidden;">
            <img src="${pageContext.request.contextPath}/static/images/about_images/Sabin.webp" alt="Sabin Thapa" style="width:100%;height:100%;object-fit:cover;display:block;" />
          </div>
          <div class="team-avatar-ring" style="border-color: #ede9fe;"></div>
        </div>
        <div class="team-body">
          <div class="team-role-chip" style="color:#6d28d9;background:#f5f3ff;border-color:rgba(124,58,237,0.2);">24044087</div>
          <h3 class="team-name">Sabin Thapa</h3>
          <p class="team-bio">
            Implemented login, registration, input validation, BCrypt password
            encryption, product listing, and session management across the platform.
          </p>
          <div class="team-skills">
            <span>Auth</span><span>Sessions</span><span>Products</span>
          </div>
        </div>
        <div class="team-card-glow" style="background: rgba(124,58,237,0.06);"></div>
      </div>

      <%-- Team Card: Shisir Lamsal --%>
      <div class="team-card reveal reveal-delay-5">
        <div class="team-avatar-wrap">
          <div class="team-avatar" style="padding:0;overflow:hidden;">
            <img src="${pageContext.request.contextPath}/static/images/about_images/Shisir.webp" alt="Shisir Lamsal" style="width:100%;height:100%;object-fit:cover;display:block;" />
          </div>
          <div class="team-avatar-ring"></div>
        </div>
        <div class="team-body">
          <div class="team-role-chip">24044379</div>
          <h3 class="team-name">Shisir Lamsal</h3>
          <p class="team-bio">
            Owned all JavaScript, the admin dashboard, the site header, navigation,
            and the overall UI/UX direction of the platform.
          </p>
          <div class="team-skills">
            <span>JavaScript</span><span>Admin Dashboard</span><span>UI/UX</span>
          </div>
        </div>
        <div class="team-card-glow" style="background: rgba(26,107,56,0.08);"></div>
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
        <div class="feat-card-icon icon-bg-green">
          <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
        </div>
        <div class="feat-card-title">Precision First</div>
        <p class="feat-card-desc">Every watch we carry is vetted for accuracy, authenticity and craftsmanship. We never compromise on quality.</p>
      </div>
      <div class="feat-card reveal reveal-delay-2">
        <div class="feat-card-icon icon-bg-gold">
          <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="8" r="6"/><path d="M12 2v2M12 14v2M6 8H4M20 8h-2M7.05 4.93 5.64 3.51M18.36 3.51l-1.41 1.42M7.05 11.07 5.64 12.49M18.36 12.49l-1.41-1.42"/></svg>
        </div>
        <div class="feat-card-title">Timeless Heritage</div>
        <p class="feat-card-desc">We celebrate the art of watchmaking by connecting you with heritage brands that have stood the test of time.</p>
      </div>
      <div class="feat-card reveal reveal-delay-3">
        <div class="feat-card-icon icon-bg-blue">
          <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/></svg>
        </div>
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
      <a href="${pageContext.request.contextPath}/products" class="btn btn-g btn-lg">Shop Collection</a>
      <a href="${pageContext.request.contextPath}/contact"  class="btn btn-o btn-lg" style="color:#fff;border-color:rgba(255,255,255,0.25);">Get in Touch</a>
    </div>
  </div>
</section>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
