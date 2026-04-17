<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
  request.setAttribute("pageTitle", "Shop - Premium Watches | AluGhadi");
  request.setAttribute("pageDesc", "Browse our complete collection of premium watches. Find the perfect timepiece.");
  request.setAttribute("activeNav", "products");
%>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<!-- HERO -->
<div class="page-hero">
  <div class="ph-img">
    <img
      src="${pageContext.request.contextPath}/static/images/snow_leopard.png"
      alt="Watch Collection"
      style="object-position: center"
    />
  </div>
  <div
    class="ph-ov"
    style="
      background: linear-gradient(
        180deg,
        rgba(26, 107, 56, 0.2) 0%,
        rgba(26, 107, 56, 0.8) 100%
      );
    "
  ></div>
  <div class="ph-body">
    <div class="ph-chip">Premium Collection</div>
    <h1 class="ph-h">Shop Our Complete<br />Watch Collection</h1>
    <p class="ph-sub">
      Discover timeless elegance and precision craftsmanship from leading
      international brands.
    </p>
  </div>
</div>

<!-- INVENTORY STATUS STRIP -->
<div class="season-strip">
  <div class="season-inner">
    <div class="ss-item">
      <span class="ss-dot ss-closed" style="background: var(--green)"></span
      >Total Products: <strong>156 in stock</strong>
    </div>
    <div class="ss-item">
      Popular Categories: <strong>Luxury, Sports, Classic</strong>
    </div>
    <div class="ss-item">Average Rating: <strong>4.8/5 Star</strong></div>
    <div class="ss-item">Free Shipping: <strong>Orders over $100</strong></div>
    <div class="ss-item">Last Updated: <strong>Today</strong></div>
  </div>
</div>

<div class="pg-body">
  <!-- FILTER BAR -->
  <div
    class="reveal"
    style="
      display: flex;
      gap: 0.65rem;
      flex-wrap: wrap;
      margin-bottom: 2rem;
      align-items: center;
    "
  >
    <span style="font-size: 0.78rem; font-weight: 700; color: var(--muted)"
      >Filter:</span
    >
    <button
      class="tab active"
      style="padding: 0.4rem 1rem"
      onclick="filterProducts('all', this)"
    >
      All
    </button>
    <button
      class="tab"
      style="padding: 0.4rem 1rem"
      onclick="filterProducts('luxury', this)"
    >
      Luxury
    </button>
    <button
      class="tab"
      style="padding: 0.4rem 1rem"
      onclick="filterProducts('sports', this)"
    >
      Sports
    </button>
    <button
      class="tab"
      style="padding: 0.4rem 1rem"
      onclick="filterProducts('classic', this)"
    >
      Classic
    </button>
    <button
      class="tab"
      style="padding: 0.4rem 1rem"
      onclick="filterProducts('smart', this)"
    >
      Smart
    </button>
    <button
      class="tab"
      style="padding: 0.4rem 1rem"
      onclick="filterProducts('womens', this)"
    >
      Women's
    </button>
    <button
      class="tab"
      id="fav-tab"
      style="padding: 0.4rem 1rem"
      onclick="filterProducts('wishlist', this)"
    >
      Wishlist
      <span
        id="fav-count"
        style="
          display: none;
          background: var(--green);
          color: #fff;
          font-size: 0.6rem;
          padding: 0.1rem 0.4rem;
          border-radius: 99px;
          margin-left: 0.3rem;
        "
      ></span>
    </button>
  </div>

  <!-- PRODUCTS GRID HEADER -->
  <div class="reveal" style="margin-bottom: 1.45rem">
    <div class="sec-tag">Featured Products</div>
    <div class="sec-h" style="margin-bottom: 1.5rem">
      Premium Watch Selection
    </div>
  </div>

  <!-- Empty wishlist state -->
  <div
    id="fav-empty"
    style="
      display: none;
      text-align: center;
      padding: 3rem 1rem;
      background: var(--white);
      border: 1.5px dashed var(--border);
      border-radius: 16px;
      margin-bottom: 2rem;
    "
  >
    <div style="font-size: 2.5rem; margin-bottom: 0.75rem">Saved</div>
    <div style="font-size: 1rem; font-weight: 800; margin-bottom: 0.4rem">
      No Items in Wishlist
    </div>
    <div style="font-size: 0.82rem; color: var(--muted)">
      Click the Save button on any watch to add it to your wishlist.
    </div>
  </div>

  <!-- PRODUCT CARDS SECTION (Similar to quota bar structure) -->
  <div class="reveal" style="margin-bottom: 2rem">
    <div
      style="
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
        gap: 1.5rem;
      "
    >
      <!-- PRODUCT 1 - Using Snow Leopard as placeholder image -->
      <div class="product-card" data-cat="luxury" data-id="premium-chronograph">
        <div class="prod-img-container">
          <img
            src="${pageContext.request.contextPath}/static/images/snow_leopard.png"
            alt="Premium Chronograph"
            class="prod-img"
          />
          <div class="prod-chip">Featured</div>
          <button
            class="prod-save"
            onclick="toggleWishlist(this)"
            title="Add to Wishlist"
          >
            Save
          </button>
        </div>
        <div class="prod-body">
          <div class="prod-brand">Premium Luxury</div>
          <div class="prod-h">Premium Chronograph Watch</div>
          <div
            class="prod-desc"
            style="font-size: 0.8rem; color: var(--muted); margin: 0.4rem 0"
          >
            Precision Swiss movement, leather strap, water resistant
          </div>
          <div class="prod-bot">
            <div class="prod-price">
              <div
                style="font-weight: 900; font-size: 1.1rem; color: var(--green)"
              >
                $499
              </div>
              <div
                style="
                  font-size: 0.75rem;
                  color: var(--muted);
                  text-decoration: line-through;
                "
              >
                $699
              </div>
            </div>
            <div class="prod-rating">Rating 4.9 (128)</div>
          </div>
          <button
            class="btn-fill"
            style="width: 100%; margin-top: 0.75rem; padding: 0.6rem"
            onclick="addToCart('Premium Chronograph', 499)"
          >
            Add to Cart
          </button>
        </div>
      </div>

      <!-- PRODUCT 2 -->
      <div class="product-card" data-cat="sports" data-id="sports-dive">
        <div class="prod-img-container">
          <img
            src="${pageContext.request.contextPath}/static/images/snow_leopard.png"
            alt="Sports Dive Watch"
            class="prod-img"
          />
          <div class="prod-chip">Sports</div>
          <button
            class="prod-save"
            onclick="toggleWishlist(this)"
            title="Add to Wishlist"
          >
            Save
          </button>
        </div>
        <div class="prod-body">
          <div class="prod-brand">Sports Collection</div>
          <div class="prod-h">Sports Dive Master</div>
          <div
            class="prod-desc"
            style="font-size: 0.8rem; color: var(--muted); margin: 0.4rem 0"
          >
            300m water resistance, titanium case, digital compass
          </div>
          <div class="prod-bot">
            <div class="prod-price">
              <div
                style="font-weight: 900; font-size: 1.1rem; color: var(--green)"
              >
                $349
              </div>
              <div
                style="
                  font-size: 0.75rem;
                  color: var(--muted);
                  text-decoration: line-through;
                "
              >
                $449
              </div>
            </div>
            <div class="prod-rating">Rating 4.7 (96)</div>
          </div>
          <button
            class="btn-fill"
            style="width: 100%; margin-top: 0.75rem; padding: 0.6rem"
            onclick="addToCart('Sports Dive Master', 349)"
          >
            Add to Cart
          </button>
        </div>
      </div>

      <!-- PRODUCT 3 -->
      <div class="product-card" data-cat="classic" data-id="vintage-dress">
        <div class="prod-img-container">
          <img
            src="${pageContext.request.contextPath}/static/images/snow_leopard.png"
            alt="Vintage Dress Watch"
            class="prod-img"
          />
          <div class="prod-chip">Classic</div>
          <button
            class="prod-save"
            onclick="toggleWishlist(this)"
            title="Add to Wishlist"
          >
            Save
          </button>
        </div>
        <div class="prod-body">
          <div class="prod-brand">Classic Collection</div>
          <div class="prod-h">Vintage Dress Watch</div>
          <div
            class="prod-desc"
            style="font-size: 0.8rem; color: var(--muted); margin: 0.4rem 0"
          >
            Minimalist design, leather band, sapphire crystal
          </div>
          <div class="prod-bot">
            <div class="prod-price">
              <div
                style="font-weight: 900; font-size: 1.1rem; color: var(--green)"
              >
                $299
              </div>
              <div
                style="
                  font-size: 0.75rem;
                  color: var(--muted);
                  text-decoration: line-through;
                "
              >
                $399
              </div>
            </div>
            <div class="prod-rating">Rating 4.8 (153)</div>
          </div>
          <button
            class="btn-fill"
            style="width: 100%; margin-top: 0.75rem; padding: 0.6rem"
            onclick="addToCart('Vintage Dress Watch', 299)"
          >
            Add to Cart
          </button>
        </div>
      </div>

      <!-- PRODUCT 4 -->
      <div class="product-card" data-cat="smart" data-id="smart-connect">
        <div class="prod-img-container">
          <img
            src="${pageContext.request.contextPath}/static/images/snow_leopard.png"
            alt="Smart Connected"
            class="prod-img"
          />
          <div class="prod-chip">Smart</div>
          <button
            class="prod-save"
            onclick="toggleWishlist(this)"
            title="Add to Wishlist"
          >
            Save
          </button>
        </div>
        <div class="prod-body">
          <div class="prod-brand">Smart Tech</div>
          <div class="prod-h">Smart Connected Watch</div>
          <div
            class="prod-desc"
            style="font-size: 0.8rem; color: var(--muted); margin: 0.4rem 0"
          >
            Fitness tracking, notifications, 7-day battery
          </div>
          <div class="prod-bot">
            <div class="prod-price">
              <div
                style="font-weight: 900; font-size: 1.1rem; color: var(--green)"
              >
                $199
              </div>
              <div
                style="
                  font-size: 0.75rem;
                  color: var(--muted);
                  text-decoration: line-through;
                "
              >
                $299
              </div>
            </div>
            <div class="prod-rating">Rating 4.6 (87)</div>
          </div>
          <button
            class="btn-fill"
            style="width: 100%; margin-top: 0.75rem; padding: 0.6rem"
            onclick="addToCart('Smart Connected Watch', 199)"
          >
            Add to Cart
          </button>
        </div>
      </div>

      <!-- PRODUCT 5 -->
      <div class="product-card" data-cat="womens" data-id="womens-elegant">
        <div class="prod-img-container">
          <img
            src="${pageContext.request.contextPath}/static/images/snow_leopard.png"
            alt="Women's Elegant"
            class="prod-img"
          />
          <div class="prod-chip">Elegant</div>
          <button
            class="prod-save"
            onclick="toggleWishlist(this)"
            title="Add to Wishlist"
          >
            Save
          </button>
        </div>
        <div class="prod-body">
          <div class="prod-brand">Women's Collection</div>
          <div class="prod-h">Elegant Dress Watch</div>
          <div
            class="prod-desc"
            style="font-size: 0.8rem; color: var(--muted); margin: 0.4rem 0"
          >
            Diamond bezel, stainless steel, elegant strap
          </div>
          <div class="prod-bot">
            <div class="prod-price">
              <div
                style="font-weight: 900; font-size: 1.1rem; color: var(--green)"
              >
                $399
              </div>
              <div
                style="
                  font-size: 0.75rem;
                  color: var(--muted);
                  text-decoration: line-through;
                "
              >
                $549
              </div>
            </div>
            <div class="prod-rating">Rating 4.9 (142)</div>
          </div>
          <button
            class="btn-fill"
            style="width: 100%; margin-top: 0.75rem; padding: 0.6rem"
            onclick="addToCart('Elegant Dress Watch', 399)"
          >
            Add to Cart
          </button>
        </div>
      </div>

      <!-- PRODUCT 6 -->
      <div class="product-card" data-cat="luxury" data-id="luxury-skeleton">
        <div class="prod-img-container">
          <img
            src="${pageContext.request.contextPath}/static/images/snow_leopard.png"
            alt="Skeleton Watch"
            class="prod-img"
          />
          <div class="prod-chip">Premium</div>
          <button
            class="prod-save"
            onclick="toggleWishlist(this)"
            title="Add to Wishlist"
          >
            Save
          </button>
        </div>
        <div class="prod-body">
          <div class="prod-brand">Luxury Premium</div>
          <div class="prod-h">Skeleton Movement Watch</div>
          <div
            class="prod-desc"
            style="font-size: 0.8rem; color: var(--muted); margin: 0.4rem 0"
          >
            Visible movement, sapphire glass, mechanical
          </div>
          <div class="prod-bot">
            <div class="prod-price">
              <div
                style="font-weight: 900; font-size: 1.1rem; color: var(--green)"
              >
                $599
              </div>
              <div
                style="
                  font-size: 0.75rem;
                  color: var(--muted);
                  text-decoration: line-through;
                "
              >
                $799
              </div>
            </div>
            <div class="prod-rating">Rating 4.9 (176)</div>
          </div>
          <button
            class="btn-fill"
            style="width: 100%; margin-top: 0.75rem; padding: 0.6rem"
            onclick="addToCart('Skeleton Movement Watch', 599)"
          >
            Add to Cart
          </button>
        </div>
      </div>
    </div>
  </div>

  <!-- PRODUCT INFO SECTION -->
  <div style="margin: 4rem 0 0" class="reveal">
    <div class="sec-tag">Watch Guide</div>
    <div class="sec-h" style="margin-bottom: 1.75rem">
      Choosing Your Perfect Watch
    </div>
    <div
      style="
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 1rem;
      "
    >
      <div
        style="
          background: var(--white);
          border: 1.5px solid var(--border);
          border-radius: 16px;
          padding: 1.25rem;
        "
      >
        <div style="font-size: 1.5rem; margin-bottom: 0.5rem">Budget</div>
        <div style="font-weight: 800; margin-bottom: 0.35rem">
          Budget-Friendly
        </div>
        <p style="font-size: 0.78rem; color: var(--muted); line-height: 1.65">
          Quality watches starting from $150. Perfect for everyday wear without
          breaking the bank. Great value for money.
        </p>
        <div
          class="badge b-g"
          style="margin-top: 0.75rem; display: inline-flex"
        >
          $150-$300
        </div>
      </div>
      <div
        style="
          background: var(--white);
          border: 1.5px solid var(--border);
          border-radius: 16px;
          padding: 1.25rem;
        "
      >
        <div style="font-size: 1.5rem; margin-bottom: 0.5rem">Top</div>
        <div style="font-weight: 800; margin-bottom: 0.35rem">Mid-Range</div>
        <p style="font-size: 0.78rem; color: var(--muted); line-height: 1.65">
          Premium brands and proven durability. Ideal for professionals and
          collectors. Excellent craftsmanship at reasonable prices.
        </p>
        <div
          class="badge b-a"
          style="margin-top: 0.75rem; display: inline-flex"
        >
          $300-$600
        </div>
      </div>
      <div
        style="
          background: var(--white);
          border: 1.5px solid var(--border);
          border-radius: 16px;
          padding: 1.25rem;
        "
      >
        <div style="font-size: 1.5rem; margin-bottom: 0.5rem">Luxury</div>
        <div style="font-weight: 800; margin-bottom: 0.35rem">Luxury</div>
        <p style="font-size: 0.78rem; color: var(--muted); line-height: 1.65">
          Prestigious watchmakers and investment pieces. Limited editions and
          timeless heirlooms for true enthusiasts.
        </p>
        <div
          class="badge b-g"
          style="margin-top: 0.75rem; display: inline-flex"
        >
          $600+
        </div>
      </div>
      <div
        style="
          background: var(--white);
          border: 1.5px solid var(--border);
          border-radius: 16px;
          padding: 1.25rem;
        "
      >
        <div style="font-size: 1.5rem; margin-bottom: 0.5rem">Purpose</div>
        <div style="font-weight: 800; margin-bottom: 0.35rem">By Purpose</div>
        <p style="font-size: 0.78rem; color: var(--muted); line-height: 1.65">
          Dress watches, sports watches, diving watches, and smart watches.
          Choose based on your lifestyle and needs.
        </p>
        <div
          class="badge b-g"
          style="margin-top: 0.75rem; display: inline-flex"
        >
          Shop by Type
        </div>
      </div>
    </div>
  </div>
</div>
<!-- /pg-body -->

<script>
  var WISH_KEY = "alughadi_wishlist";
  var CART_KEY = "alughadi_cart";
  var _currentFilter = "all";

  function getWishlist() {
    try {
      return JSON.parse(localStorage.getItem(WISH_KEY) || "[]");
    } catch (e) {
      return [];
    }
  }
  function saveWishlist(arr) {
    localStorage.setItem(WISH_KEY, JSON.stringify(arr));
  }

  function getCart() {
    try {
      return JSON.parse(localStorage.getItem(CART_KEY) || "[]");
    } catch (e) {
      return [];
    }
  }
  function saveCart(arr) {
    localStorage.setItem(CART_KEY, JSON.stringify(arr));
  }

  function updateWishlistCount() {
    var wish = getWishlist();
    var cnt = document.getElementById("fav-count");
    var tab = document.getElementById("fav-tab");
    if (!cnt) return;
    if (wish.length > 0) {
      cnt.textContent = wish.length;
      cnt.style.display = "inline";
      tab.innerHTML =
        'Saved Wishlist <span id="fav-count" style="background:var(--green);color:#fff;font-size:0.6rem;padding:0.1rem 0.4rem;border-radius:99px;margin-left:0.3rem;">' +
        wish.length +
        "</span>";
    } else {
      tab.innerHTML = "Wishlist";
    }
  }

  function toggleWishlist(btn) {
    var card = btn.closest(".product-card");
    var id = card.getAttribute("data-id");
    var wish = getWishlist();
    var idx = wish.indexOf(id);

    if (idx === -1) {
      wish.push(id);
      btn.textContent = "Saved";
    } else {
      wish.splice(idx, 1);
      btn.textContent = "Save";
    }
    saveWishlist(wish);
    updateWishlistCount();
  }

  function filterProducts(cat, btn) {
    _currentFilter = cat;
    document
      .querySelectorAll(".tab")
      .forEach((t) => t.classList.remove("active"));
    btn.classList.add("active");

    var cards = document.querySelectorAll(".product-card");
    var empty = document.getElementById("fav-empty");
    var visibleCount = 0;

    if (cat === "wishlist") {
      var wish = getWishlist();
      cards.forEach((card) => {
        var id = card.getAttribute("data-id");
        if (wish.includes(id)) {
          card.style.display = "";
          visibleCount++;
        } else {
          card.style.display = "none";
        }
      });
      if (wish.length === 0) {
        empty.style.display = "block";
      } else {
        empty.style.display = "none";
      }
    } else {
      empty.style.display = "none";
      cards.forEach((card) => {
        var cardCat = card.getAttribute("data-cat");
        if (cat === "all" || cardCat === cat) {
          card.style.display = "";
          visibleCount++;
        } else {
          card.style.display = "none";
        }
      });
    }
  }

  function addToCart(name, price) {
    var cart = getCart();
    var item = { name: name, price: price, qty: 1, id: Date.now() };
    cart.push(item);
    saveCart(cart);
    alert("Added: " + name + " added to cart!");
    updateCartButton();
  }

  function updateCartButton() {
    var cart = getCart();
    var btn = document.getElementById("cart-btn");
    if (btn) btn.textContent = "Cart (" + cart.length + ")";
  }

  // Initialize
  updateWishlistCount();
  updateCartButton();
</script>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
