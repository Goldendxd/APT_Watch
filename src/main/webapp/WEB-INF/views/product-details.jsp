<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<!-- Hero removed per request; header shows back link to products -->

<section class="product-details-main pg-body">
  <div class="product-details-crumb gc reveal" aria-label="Breadcrumb">
    <a href="${pageContext.request.contextPath}/">Home</a>
    <span class="crumb-sep" aria-hidden="true">/</span>
    <a href="${pageContext.request.contextPath}/products">Products</a>
    <span class="crumb-sep" aria-hidden="true">/</span>
    <span class="crumb-current" aria-current="page">Royal Prestige Automatic</span>
  </div>

  <div class="product-details-layout">
    <div class="product-details-gallery gc reveal">
      <div class="product-details-gallery-main single-image">
        <img src="${pageContext.request.contextPath}/static/images/products/watch_luxury/watch_luxury_1.webp" alt="Royal Prestige Automatic watch" />
        <div class="product-details-gallery-badge">Editor's Pick</div>
      </div>
    </div>

    <aside class="product-details-summary gc reveal reveal-delay-1">
      <div class="product-details-brand-row">
        <span class="product-details-brand">Rolex</span>
        <span class="product-details-stock">In Stock</span>
      </div>
      <h2 class="product-details-title">Royal Prestige Automatic</h2>
      <div class="product-details-meta-row">
        <span class="product-details-rating">&#9733; 4.9/5</span>
        <span class="product-details-meta-dot"></span>
        <span>128 verified ratings</span>
      </div>

      <div class="product-details-price-box">
        <div class="product-details-price">Rs 285,000</div>
        <div class="product-details-old-price">Rs 310,000</div>
        <div class="product-details-save">Save Rs 25,000</div>
      </div>

      <p class="product-details-lead">
        Swiss-made automatic movement with a sapphire crystal, 18K gold bezel, and 100m
        water resistance. Designed to balance heritage styling with modern durability.
      </p>

      <div class="product-details-chip-row">
        <span class="product-details-chip">Automatic</span>
        <span class="product-details-chip">Sapphire Crystal</span>
        <span class="product-details-chip">100m Water Resistance</span>
        <span class="product-details-chip">72h Reserve</span>
      </div>

      <div class="product-details-action-row">
        <a class="btn-fill product-details-primary-btn" href="#">Buy Now</a>
        <button class="btn-out-nav product-details-secondary-btn" type="button">Add to Wishlist</button>
      </div>

      <div class="product-details-note">
        Front-end only for now. Backend can later inject live product, stock, and cart data.
      </div>
    </aside>
  </div>

  <div class="product-details-grid">
    <div class="product-details-copy gc reveal">
      <div class="sec-tag">Product Details</div>
      <h2 class="sec-h">Built to feel timeless on the wrist.</h2>
      <p class="sec-sub">
        The Royal Prestige Automatic is the type of watch that works in every setting: boardroom,
        formal event, or weekend dinner. The case proportions stay balanced, the dial stays clean,
        and the movement gives it the tactile feel collectors expect from a premium automatic.
      </p>

      <div class="product-details-feature-list">
        <div class="product-details-feature-item">
          <strong>Movement</strong>
          <span>Swiss automatic with smooth sweep second hand</span>
        </div>
        <div class="product-details-feature-item">
          <strong>Crystal</strong>
          <span>Scratch-resistant sapphire with anti-reflective finish</span>
        </div>
        <div class="product-details-feature-item">
          <strong>Case</strong>
          <span>Stainless steel with 18K gold bezel accent</span>
        </div>
        <div class="product-details-feature-item">
          <strong>Water Resistance</strong>
          <span>Rated to 100 meters for everyday confidence</span>
        </div>
      </div>
    </div>

    <div class="product-details-specs gc reveal reveal-delay-1">
      <div class="sec-tag">Quick Specs</div>
      <h2 class="sec-h">At a glance</h2>
      <div class="product-details-spec-grid">
        <div class="product-details-spec">
          <span>Brand</span>
          <strong>Rolex</strong>
        </div>
        <div class="product-details-spec">
          <span>Category</span>
          <strong>Luxury</strong>
        </div>
        <div class="product-details-spec">
          <span>Dial</span>
          <strong>Black Sunray</strong>
        </div>
        <div class="product-details-spec">
          <span>Case Size</span>
          <strong>41 mm</strong>
        </div>
        <div class="product-details-spec">
          <span>Strap</span>
          <strong>Premium Steel</strong>
        </div>
        <div class="product-details-spec">
          <span>Warranty</span>
          <strong>2 Years</strong>
        </div>
      </div>

      <div class="product-details-ship-box">
        <div class="product-details-ship-title">Delivery & care</div>
        <ul class="product-details-ship-list">
          <li>Free delivery on eligible orders</li>
          <li>Secure packaging and careful handling</li>
          <li>Warranty support and after-sales guidance</li>
        </ul>
      </div>
    </div>
  </div>

  <section class="product-details-story gc reveal">
    <div class="sec-tag">Why it stands out</div>
    <div class="product-details-story-grid">
      <div>
        <h2 class="sec-h">A clear, confident luxury profile.</h2>
      </div>
      <p class="sec-sub">
        This layout is intentionally built for later backend integration. Product name, pricing,
        stock, thumbnails, and feature content can all be replaced server-side without changing the
        structure of the page.
      </p>
    </div>
  </section>

  <section class="product-details-reviews gc reveal">
    <div class="sec-tag">Customer Reviews</div>
    <h2 class="sec-h">What our customers say</h2>

    <div class="reviews-grid">
      <div class="review-item">
        <div class="review-head">
          <strong>Sabin Thapa</strong>
          <span class="review-stars" aria-label="5 out of 5 stars">
            <span class="star is-filled">&#9733;</span><span class="star is-filled">&#9733;</span><span class="star is-filled">&#9733;</span><span class="star is-filled">&#9733;</span><span class="star is-filled">&#9733;</span>
          </span>
        </div>
        <p class="review-body">Beautiful finish and excellent build quality. Happy with the purchase.</p>
      </div>

      <div class="review-item">
        <div class="review-head">
          <strong>Ashish Thapa</strong>
          <span class="review-stars" aria-label="4 out of 5 stars">
            <span class="star is-filled">&#9733;</span><span class="star is-filled">&#9733;</span><span class="star is-filled">&#9733;</span><span class="star is-filled">&#9733;</span><span class="star">&#9733;</span>
          </span>
        </div>
        <p class="review-body">Great watch; service was prompt and delivery was well packed.</p>
      </div>

      <div class="review-item">
        <div class="review-head">
          <strong>Dikshita GC</strong>
          <span class="review-stars" aria-label="5 out of 5 stars">
            <span class="star is-filled">&#9733;</span><span class="star is-filled">&#9733;</span><span class="star is-filled">&#9733;</span><span class="star is-filled">&#9733;</span><span class="star is-filled">&#9733;</span>
          </span>
        </div>
        <p class="review-body">Stylish and comfortable — looks even better in person.</p>
      </div>

      <div class="review-item">
        <div class="review-head">
          <strong>Rijan Pun</strong>
          <span class="review-stars" aria-label="4 out of 5 stars">
            <span class="star is-filled">&#9733;</span><span class="star is-filled">&#9733;</span><span class="star is-filled">&#9733;</span><span class="star is-filled">&#9733;</span><span class="star">&#9733;</span>
          </span>
        </div>
        <p class="review-body">Worth the price. The strap feels premium and sturdy.</p>
      </div>

      <div class="review-item">
        <div class="review-head">
          <strong>Shisir Lamsal</strong>
          <span class="review-stars" aria-label="5 out of 5 stars">
            <span class="star is-filled">&#9733;</span><span class="star is-filled">&#9733;</span><span class="star is-filled">&#9733;</span><span class="star is-filled">&#9733;</span><span class="star is-filled">&#9733;</span>
          </span>
        </div>
        <p class="review-body">Amazing craftsmanship. Would recommend to friends and family.</p>
      </div>

    </div>
  </section>

  <section class="product-details-related reveal">
    <div class="sec-tag">Related Watches</div>
    <h2 class="sec-h">More pieces in the same collection</h2>

    <div class="product-details-related-grid">
      <div class="product-card">
        <div class="prod-img-container">
          <img src="${pageContext.request.contextPath}/static/images/products/watch_luxury/watch_luxury_2.webp" alt="Submariner Heritage" class="prod-img" />
          <div class="prod-chip">Luxury</div>
        </div>
        <div class="prod-body">
          <div class="prod-brand">Omega</div>
          <div class="prod-h">Submariner Heritage</div>
          <div class="prod-desc">Iconic diver watch with ceramic bezel and Co-Axial movement.</div>
          <div class="prod-bot">
            <div class="prod-price">
              <div class="prod-price-now">Rs 195,000</div>
            </div>
            <div class="prod-rating"><span class="prod-stars">&#9733;</span> 4.8</div>
          </div>
        </div>
      </div>

      <div class="product-card">
        <div class="prod-img-container">
          <img src="${pageContext.request.contextPath}/static/images/products/watch_luxury/watch_luxury_4.webp" alt="Pilot Chronograph Elite" class="prod-img" />
          <div class="prod-chip">Classic</div>
        </div>
        <div class="prod-body">
          <div class="prod-brand">IWC</div>
          <div class="prod-h">Pilot Chronograph Elite</div>
          <div class="prod-desc">Aviation-inspired chronograph with titanium case and flyback function.</div>
          <div class="prod-bot">
            <div class="prod-price">
              <div class="prod-price-now">Rs 165,000</div>
            </div>
            <div class="prod-rating"><span class="prod-stars">&#9733;</span> 4.7</div>
          </div>
        </div>
      </div>

      <div class="product-card">
        <div class="prod-img-container">
          <img src="${pageContext.request.contextPath}/static/images/products/watch_classic/watch_classic_1.webp" alt="Dress Slim Automatic" class="prod-img" />
          <div class="prod-chip">Classic</div>
        </div>
        <div class="prod-body">
          <div class="prod-brand">Tissot</div>
          <div class="prod-h">Dress Slim Automatic</div>
          <div class="prod-desc">Elegant thin automatic with sapphire crystal and leather strap.</div>
          <div class="prod-bot">
            <div class="prod-price">
              <div class="prod-price-now">Rs 12,500</div>
            </div>
            <div class="prod-rating"><span class="prod-stars">&#9733;</span> 4.5</div>
          </div>
        </div>
      </div>
    </div>
  </section>
</section>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />