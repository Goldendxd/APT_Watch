<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<!-- HERO -->
<div class="page-hero">
  <div class="ph-img">
    <img
      src="${pageContext.request.contextPath}/static/images/products/hero_products.png"
      alt="AluGhadi Watch Collection"
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
    <div class="strip-item">
      <span class="strip-dot ss-open"></span
      >Total Products: <strong>${fn:length(productList)} in stock</strong>
    </div>
    <div class="strip-item">
      Popular Categories: <strong>Luxury, Sports, Classic</strong>
    </div>
    <div class="strip-item">Average Rating: <strong>4.8/5 Star</strong></div>
    <div class="strip-item">Free Shipping: <strong>Orders over Rs 5,000</strong></div>
    <div class="strip-item">Last Updated: <strong>Today</strong></div>
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
    <a
      class="tab ${activeCategory == 'all' ? 'active' : ''}"
      style="padding: 0.4rem 1rem"
      href="${pageContext.request.contextPath}/products"
    >
      All
    </a>
    <a
      class="tab ${activeCategory == 'luxury' ? 'active' : ''}"
      style="padding: 0.4rem 1rem"
      href="${pageContext.request.contextPath}/products?category=luxury"
    >
      Luxury
    </a>
    <a
      class="tab ${activeCategory == 'sports' ? 'active' : ''}"
      style="padding: 0.4rem 1rem"
      href="${pageContext.request.contextPath}/products?category=sports"
    >
      Sports
    </a>
    <a
      class="tab ${activeCategory == 'classic' ? 'active' : ''}"
      style="padding: 0.4rem 1rem"
      href="${pageContext.request.contextPath}/products?category=classic"
    >
      Classic
    </a>
    <a
      class="tab ${activeCategory == 'smart' ? 'active' : ''}"
      style="padding: 0.4rem 1rem"
      href="${pageContext.request.contextPath}/products?category=smart"
    >
      Smart
    </a>
    <a
      class="tab ${activeCategory == 'womens' ? 'active' : ''}"
      style="padding: 0.4rem 1rem"
      href="${pageContext.request.contextPath}/products?category=womens"
    >
      Women's
    </a>
    <button
      class="tab"
      id="fav-tab"
      style="padding: 0.4rem 1rem"
      type="button"
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
    <div style="font-size: 2.5rem; margin-bottom: 0.75rem">&#9825;</div>
    <div style="font-size: 1rem; font-weight: 800; margin-bottom: 0.4rem">
      Your Wishlist is Empty
    </div>
    <div style="font-size: 0.82rem; color: var(--muted)">
      Click the &#9825; heart on any watch to save it to your wishlist.
    </div>
  </div>



  <!-- PRODUCT CARDS SECTION (Similar to quota bar structure) -->
  <div class="reveal" style="margin-bottom: 2rem">
    <c:if test="${empty productList}">
      <div style="text-align:center;padding:5rem 2rem;background:var(--white);border:1.5px dashed var(--border);border-radius:20px;margin-bottom:2rem;">
        <div style="margin:0 auto 1.25rem;width:64px;height:64px;background:var(--surface);border-radius:50%;display:flex;align-items:center;justify-content:center;">
          <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="var(--muted)" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="9"/><circle cx="12" cy="12" r="3"/><line x1="12" y1="3" x2="12" y2="9"/><line x1="12" y1="15" x2="12" y2="21"/></svg>
        </div>
        <div style="font-size:1.25rem;font-weight:800;color:var(--text);margin-bottom:.5rem;">Sorry, we are out of products</div>
        <p style="font-size:.88rem;color:var(--muted);max-width:380px;margin:0 auto 1.5rem;line-height:1.7;">
          We are currently restocking our collection. Please check back soon — new watches arrive regularly.
        </p>
        <a href="${pageContext.request.contextPath}/products" style="display:inline-flex;align-items:center;gap:.4rem;padding:.65rem 1.4rem;background:var(--green);color:#fff;border-radius:10px;font-weight:700;font-size:.84rem;text-decoration:none;">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"><polyline points="1 4 1 10 7 10"/><path d="M3.51 15a9 9 0 1 0 .49-3.76"/></svg>
          View All Collections
        </a>
      </div>
    </c:if>
    <div
      style="
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
        gap: 1.5rem;
        align-items: stretch;
      "
    >
      <c:forEach var="product" items="${productList}">
        <div class="product-card" data-category="${fn:toLowerCase(product.categoryName)}" data-id="prod-${product.id}" style="display:flex;flex-direction:column;height:100%;">
          <a href="${pageContext.request.contextPath}/product-details?id=${product.id}" class="prod-img-container">
            <img src="${pageContext.request.contextPath}${product.imageUrl}" alt="${product.name}" class="prod-img">
            <button class="prod-save" type="button" onclick="event.preventDefault();event.stopPropagation();toggleWishlist(this)">
              <span class="wish-heart">&#9825;</span>
              <span class="wish-tip">Wishlist</span>
            </button>
            <div class="prod-chip">${product.categoryName}</div>
          </a>
          <div class="prod-body" style="padding:1.2rem;flex:1;display:flex;flex-direction:column;">
            <div class="prod-brand">${product.brand}</div>
            <div class="prod-h">${product.name}</div>

            <div class="prod-bot" style="margin-top:auto;padding-top:0.8rem;border-top:1px solid #d4e5da;display:flex;justify-content:space-between;align-items:flex-end;">
              <div class="prod-price">
                <div class="prod-price-now">Rs <fmt:formatNumber value="${product.price}" pattern="#,##0"/></div>
                <c:if test="${not empty product.oldPrice and product.oldPrice gt 0}">
                  <div class="prod-price-was">Rs <fmt:formatNumber value="${product.oldPrice}" pattern="#,##0"/></div>
                </c:if>
              </div>
              <div class="prod-rating"><span class="prod-stars">&#9733;</span> ${product.rating}</div>
            </div>
            <div style="display:flex;gap:0.45rem;margin-top:0.65rem;">
              <form action="${pageContext.request.contextPath}/cart" method="post" style="flex:1;display:flex;">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="productId" value="${product.id}">
                <input type="hidden" name="quantity" value="1">
                <input type="hidden" name="buyNow" value="true">
                <c:choose>
                  <c:when test="${product.stockQuantity > 0}">
                    <button class="btn-fill prod-buy-btn" type="submit" style="flex:1;padding:0.55rem 0.4rem;font-size:0.78rem;font-weight:700;border-radius:10px;text-align:center;">Buy Now</button>
                  </c:when>
                  <c:otherwise>
                    <button class="btn-fill prod-buy-btn" type="button" disabled style="flex:1;padding:0.55rem 0.4rem;font-size:0.78rem;font-weight:700;border-radius:10px;text-align:center;background:#999;cursor:not-allowed;">Out of Stock</button>
                  </c:otherwise>
                </c:choose>
              </form>
              <form action="${pageContext.request.contextPath}/cart" method="post" style="flex:1;display:flex;">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="productId" value="${product.id}">
                <input type="hidden" name="quantity" value="1">
                <c:choose>
                  <c:when test="${product.stockQuantity <= 0}">
                    <button type="button" disabled style="flex:1;padding:0.55rem 0.4rem;border-radius:10px;font-size:0.78rem;font-weight:700;background:#ddd;color:#777;border:1.5px solid #ccc;cursor:not-allowed;font-family:inherit;text-align:center;">Out of Stock</button>
                  </c:when>
                  <c:when test="${cartProductIds.contains(product.id)}">
                    <button type="submit" disabled style="flex:1;padding:0.55rem 0.4rem;border-radius:10px;font-size:0.78rem;font-weight:700;background:#1a6b38;color:#fff;border:1.5px solid #1a6b38;cursor:default;font-family:inherit;text-align:center;">Added &#10003;</button>
                  </c:when>
                  <c:otherwise>
                    <button type="submit" style="flex:1;padding:0.55rem 0.4rem;border:1.5px solid #1a6b38;border-radius:10px;background:transparent;color:#1a6b38;font-size:0.78rem;font-weight:700;cursor:pointer;font-family:inherit;text-align:center;">Add to Cart</button>
                  </c:otherwise>
                </c:choose>
              </form>
            </div>
          </div>
        </div>
<%--            <div class="prod-chip">${product.name}</div>--%>
<%--          </div>--%>
<%--          <div class="prod-body">--%>
<%--            <div class="prod-brand">${product.brand}</div>--%>
<%--          </div>--%>

<%--        <li class="product-card">--%>
<%--          <a href="${pageContext.request.contentPath}/cart?productid= ${product.id}" class="prod-img-container"> <c:out value = "${product.image.url}" /></a>--%>
<%--          <a href="${pageContext.request.contentPath}/cart?productid= ${product.id}" class="prod-h"> <c:out value = "${product.name}" /></a>--%>
<%--        </li>--%>


      </c:forEach>
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
          Quality watches starting from Rs 5,000. Perfect for everyday wear without
          breaking the bank. Great value for money.
        </p>
        <div
          class="badge b-g"
          style="margin-top: 0.75rem; display: inline-flex"
        >
          Rs 5,000–15,000
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
          Rs 15,000–50,000
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
          Rs 50,000+
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

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
