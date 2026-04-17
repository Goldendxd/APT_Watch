<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="jakarta.tags.core" %> <% request.setAttribute("pageTitle",
"AluGhadi Watches - Premium Watch Collection"); request.setAttribute("pageDesc",
"Discover premium watches with timeless design and exceptional quality.");
request.setAttribute("activeNav", "home"); %>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<!-- HERO -->
<section class="home-hero">
  <div class="hh-img">
    <img
      src="${pageContext.request.contextPath}/static/images/snow_leopard.png"
      alt="Premium Watches"
    />
    <div class="hh-fade"></div>
  </div>
  <div class="hh-left" style="animation: mIn 0.9s 0.1s both">
    <div class="hero-chip">&#8986; Timeless Elegance</div>
    <h1 class="hero-h">Discover Premium<br /><span>Watch Collections</span></h1>
    <p class="hero-p">
      Handpicked watch collections featuring timeless designs, exceptional
      craftsmanship, and unmatched quality. From classic to contemporary, find
      the perfect timepiece for every occasion.
    </p>
    <div class="hero-btns">
      <a class="hbtn hbtn-f" href="${pageContext.request.contextPath}/products"
        >Shop Now</a
      >
      <a class="hbtn hbtn-o" href="${pageContext.request.contextPath}/gifting"
        >Explore Gifting &rarr;</a
      >
    </div>
    <div class="hero-stats">
      <div class="hs">
        <span class="hs-n">500+</span><span class="hs-l">Watch Models</span>
      </div>
      <div class="hs">
        <span class="hs-n">50+</span
        ><span class="hs-l">International Brands</span>
      </div>
      <div class="hs">
        <span class="hs-n">99%</span
        ><span class="hs-l">Customer Satisfaction</span>
      </div>
    </div>
  </div>
</section>

<!-- FEATURED COLLECTIONS -->
<section class="sec" style="background: var(--white)">
  <div class="sec-inner">
    <div
      class="reveal"
      style="
        display: flex;
        align-items: flex-end;
        justify-content: space-between;
        flex-wrap: wrap;
        gap: 1.5rem;
        margin-bottom: 0;
      "
    >
      <div>
        <div class="sec-tag">Featured Collections</div>
        <h2 class="sec-h">Curated Watch<br />Collections</h2>
      </div>
      <p class="sec-sub">
        From elegant classics to modern sports watches &mdash; each collection
        represents the pinnacle of watchmaking.
      </p>
    </div>
    <div class="dest-scroll reveal">
      <a
        class="dest-card"
        href="${pageContext.request.contextPath}/gifting"
        style="text-decoration: none"
      >
        <div class="dc-img">
          <img
            src="${pageContext.request.contextPath}/static/images/snow_leopard.png"
            alt="Luxury"
          />
        </div>
        <div class="dc-ov"></div>
        <div class="dc-chip">Premium</div>
        <div class="dc-body">
          <div class="dc-tag">High-End Collection</div>
          <div class="dc-h">Luxury Watches</div>
          <div class="dc-m">Timeless elegance and precision</div>
        </div>
      </a>
      <a
        class="dest-card"
        href="${pageContext.request.contextPath}/gifting"
        style="text-decoration: none"
      >
        <div class="dc-img">
          <img
            src="${pageContext.request.contextPath}/static/images/snow_leopard.png"
            alt="Sports"
          />
        </div>
        <div class="dc-ov"></div>
        <div class="dc-chip">Active</div>
        <div class="dc-body">
          <div class="dc-tag">Sports & Adventure</div>
          <div class="dc-h">Sports Watches</div>
          <div class="dc-m">Built for performance and durability</div>
        </div>
      </a>
      <a
        class="dest-card"
        href="${pageContext.request.contextPath}/gifting"
        style="text-decoration: none"
      >
        <div class="dc-img">
          <img
            src="${pageContext.request.contextPath}/static/images/snow_leopard.png"
            alt="Classic"
          />
        </div>
        <div class="dc-ov"></div>
        <div class="dc-chip">Timeless</div>
        <div class="dc-body">
          <div class="dc-tag">Classic Designs</div>
          <div class="dc-h">Classic Watches</div>
          <div class="dc-m">Sophisticated style for every moment</div>
        </div>
      </a>
      <a
        class="dest-card"
        href="${pageContext.request.contextPath}/gifting"
        style="text-decoration: none"
      >
        <div class="dc-img">
          <img
            src="${pageContext.request.contextPath}/static/images/snow_leopard.png"
            alt="Smart"
          />
        </div>
        <div class="dc-ov"></div>
        <div class="dc-chip">Tech-Inspired</div>
        <div class="dc-body">
          <div class="dc-tag">Modern Technology</div>
          <div class="dc-h">Smart Watches</div>
          <div class="dc-m">Connected lifestyle features</div>
        </div>
      </a>
      <a
        class="dest-card"
        href="${pageContext.request.contextPath}/gifting"
        style="text-decoration: none"
      >
        <div class="dc-img">
          <img
            src="${pageContext.request.contextPath}/static/images/snow_leopard.png"
            alt="Womens"
          />
        </div>
        <div class="dc-ov"></div>
        <div class="dc-chip">Elegant</div>
        <div class="dc-body">
          <div class="dc-tag">For Her</div>
          <div class="dc-h">Women's Collection</div>
          <div class="dc-m">Elegant designs crafted for women</div>
        </div>
      </a>
    </div>
  </div>
</section>

<!-- FEATURES -->
<section class="sec">
  <div class="sec-inner">
    <div
      class="reveal"
      style="
        display: flex;
        align-items: flex-end;
        justify-content: space-between;
        flex-wrap: wrap;
        gap: 1.5rem;
        margin-bottom: 0;
      "
    >
      <div>
        <div class="sec-tag">Why Choose Us</div>
        <h2 class="sec-h">Everything You Expect<br />from AluGhadi</h2>
      </div>
      <p class="sec-sub">
        We're committed to providing premium quality, exceptional service, and
        value for money.
      </p>
    </div>
    <div class="feat-grid reveal">
      <a class="feat-card" href="${pageContext.request.contextPath}/products"
        ><div class="fc-ico ico-g">&#8986;</div>
        <div class="fc-h">Premium Selection</div>
        <p class="fc-p">
          Handpicked watches from renowned international brands. Quality assured
          with authentic certifications.
        </p>
        <div class="fc-arr">Browse collection &rarr;</div></a
      >
      <a class="feat-card" href="${pageContext.request.contextPath}/"
        ><div class="fc-ico ico-a">&#10004;</div>
        <div class="fc-h">100% Authentic</div>
        <p class="fc-p">
          Every watch is verified authentic. We work directly with authorized
          distributors and manufacturers.
        </p>
        <div class="fc-arr">Learn more &rarr;</div></a
      >
      <a class="feat-card" href="${pageContext.request.contextPath}/"
        ><div class="fc-ico ico-r">&#128230;</div>
        <div class="fc-h">Free Shipping</div>
        <p class="fc-p">
          Free shipping on orders above $100. Safe, insured delivery to your
          doorstep with tracking.
        </p>
        <div class="fc-arr">View policy &rarr;</div></a
      >
      <a class="feat-card" href="${pageContext.request.contextPath}/"
        ><div class="fc-ico ico-b">&#128260;</div>
        <div class="fc-h">Easy Returns</div>
        <p class="fc-p">
          30-day return policy. Change your mind? Full refund, no questions
          asked. Hassle-free process.
        </p>
        <div class="fc-arr">Details &rarr;</div></a
      >
      <a class="feat-card" href="${pageContext.request.contextPath}/"
        ><div class="fc-ico ico-g">&#128142;</div>
        <div class="fc-h">Expert Support</div>
        <p class="fc-p">
          Our watch experts are here 24/7. Expert advice on sizing, features,
          and watch care.
        </p>
        <div class="fc-arr">Contact us &rarr;</div></a
      >
      <a
        class="feat-card"
        href="${pageContext.request.contextPath}/"
        onclick="
          showModal('warranty');
          return false;
        "
        ><div class="fc-ico ico-r">&#128737;</div>
        <div class="fc-h">Warranty Coverage</div>
        <p class="fc-p">
          All watches backed by manufacturer warranty. Extended warranty options
          available for peace of mind.
        </p>
        <div class="fc-arr">View warranty &rarr;</div></a
      >
    </div>
  </div>
</section>

<!-- SPLIT SECTION -->
<section class="sec" style="background: var(--white)">
  <div class="sec-inner">
    <div class="split reveal">
      <div class="split-img">
        <img
          src="${pageContext.request.contextPath}/static/images/snow_leopard.png"
          alt="Watch Craftsmanship"
          style="object-position: center top"
        />
        <div class="split-badge">
          <div class="sb-ico">&#8986;</div>
          <div>
            <div class="sb-v">150+</div>
            <div class="sb-l">Years Experience</div>
          </div>
        </div>
      </div>
      <div>
        <div class="sec-tag">Craftsmanship</div>
        <h2 class="sec-h" style="margin-bottom: 1rem">
          The Art of<br />Perfect Timekeeping
        </h2>
        <p
          style="
            font-size: 0.88rem;
            color: var(--muted);
            line-height: 1.78;
            margin-bottom: 1rem;
          "
        >
          Each watch in our collection represents decades of horological
          excellence. From Swiss precision to Japanese engineering, we showcase
          the world's most respected watchmaking traditions.
        </p>
        <p
          style="
            font-size: 0.88rem;
            color: var(--muted);
            line-height: 1.78;
            margin-bottom: 1.75rem;
          "
        >
          Whether you're looking for a statement luxury piece, a reliable
          everyday companion, or a cutting-edge smartwatch, AluGhadi offers
          something special for every wrist and every moment.
        </p>
        <a href="${pageContext.request.contextPath}/about" class="btn-fill"
          >Learn Our Story &rarr;</a
        >
      </div>
    </div>
  </div>
</section>

<!-- NEWSLETTER SECTION -->
<section
  class="sec"
  style="
    background: linear-gradient(135deg, var(--green) 0%, var(--green2) 100%);
    color: #fff;
  "
>
  <div class="sec-inner">
    <div
      class="reveal"
      style="max-width: 600px; margin: 0 auto; text-align: center"
    >
      <div
        class="sec-tag"
        style="
          color: rgba(255, 255, 255, 0.8);
          border-color: rgba(255, 255, 255, 0.3);
        "
      >
        Newsletter
      </div>
      <h2 class="sec-h" style="color: #fff; margin-bottom: 1rem">
        Get 10% Off Your First Order
      </h2>
      <p
        style="
          font-size: 0.88rem;
          color: rgba(255, 255, 255, 0.9);
          margin-bottom: 1.5rem;
        "
      >
        Subscribe to our newsletter and receive exclusive offers, new arrivals,
        and watch care tips directly in your inbox.
      </p>
      <form style="display: flex; gap: 0.5rem; margin-bottom: 1rem">
        <input
          type="email"
          placeholder="Enter your email"
          style="
            flex: 1;
            padding: 0.75rem 1rem;
            border: none;
            border-radius: 12px;
            font-size: 0.9rem;
          "
          required
        />
        <button
          type="submit"
          class="btn-fill"
          style="background: #fff; color: var(--green)"
        >
          Subscribe
        </button>
      </form>
      <p style="font-size: 0.7rem; color: rgba(255, 255, 255, 0.7)">
        We respect your privacy. Unsubscribe at any time.
      </p>
    </div>
  </div>
</section>

<script>
  function showModal(modalId) {
    alert("This feature will be implemented with backend integration.");
  }
</script>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
