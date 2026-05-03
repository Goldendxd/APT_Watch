<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<section class="product-details-main pg-body">
  <div class="product-details-crumb gc reveal" aria-label="Breadcrumb">
    <a href="${pageContext.request.contextPath}/">Home</a>
    <span class="crumb-sep" aria-hidden="true">/</span>
    <a href="${pageContext.request.contextPath}/products">Products</a>
    <span class="crumb-sep" aria-hidden="true">/</span>
    <span class="crumb-current" aria-current="page">${product.name}</span>
  </div>

  <div class="product-details-layout">
    <div class="product-details-gallery gc reveal">
      <div class="product-details-gallery-main single-image">
        <img src="${pageContext.request.contextPath}${product.imageUrl}" alt="${product.name}" />
        <div class="product-details-gallery-badge">${product.categoryName}</div>
      </div>
    </div>

    <aside class="product-details-summary gc reveal reveal-delay-1">
      <div class="product-details-brand-row">
        <span class="product-details-brand">${product.brand}</span>
        <c:choose>
          <c:when test="${product.inStock}">
            <span class="product-details-stock">In Stock</span>
          </c:when>
          <c:otherwise>
            <span class="product-details-stock" style="background:#fff1f1;color:var(--red);border-color:rgba(200,60,60,0.2);">Out of Stock</span>
          </c:otherwise>
        </c:choose>
      </div>
      <h2 class="product-details-title">${product.name}</h2>
      <div class="product-details-meta-row">
        <span class="product-details-rating">&#9733; ${product.rating}/5</span>
        <span class="product-details-meta-dot"></span>
        <span>Verified ratings</span>
      </div>

      <div class="product-details-price-box">
        <div class="product-details-price">Rs <fmt:formatNumber value="${product.price}" pattern="#,##0"/></div>
        <c:if test="${not empty product.oldPrice and product.oldPrice gt 0}">
          <div class="product-details-old-price">Rs <fmt:formatNumber value="${product.oldPrice}" pattern="#,##0"/></div>
          <div class="product-details-save">Save Rs <fmt:formatNumber value="${product.oldPrice - product.price}" pattern="#,##0"/></div>
        </c:if>
      </div>

      <p class="product-details-lead">${product.description}</p>

      <div class="product-details-chip-row">
        <span class="product-details-chip">${product.categoryName}</span>
        <span class="product-details-chip">${product.brand}</span>
        <c:if test="${product.inStock}">
          <span class="product-details-chip">Ready to Ship</span>
        </c:if>
      </div>

      <div class="product-details-action-row">
        <form action="${pageContext.request.contextPath}/cart" method="post" style="display:contents;">
          <input type="hidden" name="action" value="add">
          <input type="hidden" name="productId" value="${product.id}">
          <input type="hidden" name="quantity" value="1">
          <button class="btn-fill product-details-primary-btn" type="submit">Add to Cart &#128717;</button>
        </form>
        <form action="${pageContext.request.contextPath}/cart" method="post" style="display:contents;">
          <input type="hidden" name="action" value="add">
          <input type="hidden" name="productId" value="${product.id}">
          <input type="hidden" name="quantity" value="1">
          <input type="hidden" name="buyNow" value="true">
          <button class="btn-out-nav product-details-secondary-btn" type="submit">Buy Now</button>
        </form>
      </div>
    </aside>
  </div>

  <div class="product-details-grid">
    <div class="product-details-copy gc reveal">
      <div class="sec-tag">Product Details</div>
      <h2 class="sec-h">Crafted for excellence.</h2>
      <p class="sec-sub">${product.description}</p>

      <div class="product-details-feature-list">
        <div class="product-details-feature-item">
          <strong>Brand</strong>
          <span>${product.brand}</span>
        </div>
        <div class="product-details-feature-item">
          <strong>Category</strong>
          <span>${product.categoryName}</span>
        </div>
        <div class="product-details-feature-item">
          <strong>Rating</strong>
          <span>${product.rating} out of 5 stars</span>
        </div>
        <div class="product-details-feature-item">
          <strong>Availability</strong>
          <span>${product.inStock ? 'In Stock — Ready to ship' : 'Currently unavailable'}</span>
        </div>
      </div>
    </div>

    <div class="product-details-specs gc reveal reveal-delay-1">
      <div class="sec-tag">Quick Specs</div>
      <h2 class="sec-h">At a glance</h2>
      <div class="product-details-spec-grid">
        <div class="product-details-spec">
          <span>Brand</span>
          <strong>${product.brand}</strong>
        </div>
        <div class="product-details-spec">
          <span>Category</span>
          <strong>${product.categoryName}</strong>
        </div>
        <div class="product-details-spec">
          <span>Price</span>
          <strong>Rs <fmt:formatNumber value="${product.price}" pattern="#,##0"/></strong>
        </div>
        <div class="product-details-spec">
          <span>Rating</span>
          <strong>&#9733; ${product.rating}</strong>
        </div>
      </div>

      <div class="product-details-ship-box">
        <div class="product-details-ship-title">Delivery &amp; care</div>
        <ul class="product-details-ship-list">
          <li>Free delivery on orders over Rs 5,000</li>
          <li>Secure packaging and careful handling</li>
          <li>Warranty support and after-sales guidance</li>
        </ul>
      </div>
    </div>
  </div>

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
        <p class="review-body">Amazing ${product.categoryName} watch! The ${product.brand} quality really shows. Happy with the purchase.</p>
      </div>

      <div class="review-item">
        <div class="review-head">
          <strong>Ashish Thapa</strong>
          <span class="review-stars" aria-label="4 out of 5 stars">
            <span class="star is-filled">&#9733;</span><span class="star is-filled">&#9733;</span><span class="star is-filled">&#9733;</span><span class="star is-filled">&#9733;</span><span class="star">&#9733;</span>
          </span>
        </div>
        <p class="review-body">Great watch for the price. Service was prompt and delivery was well packed.</p>
      </div>

      <div class="review-item">
        <div class="review-head">
          <strong>Dikshita GC</strong>
          <span class="review-stars" aria-label="5 out of 5 stars">
            <span class="star is-filled">&#9733;</span><span class="star is-filled">&#9733;</span><span class="star is-filled">&#9733;</span><span class="star is-filled">&#9733;</span><span class="star is-filled">&#9733;</span>
          </span>
        </div>
        <p class="review-body">Stylish and comfortable — looks even better in person. Love the ${product.brand} craftsmanship.</p>
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
</section>



<jsp:include page="/WEB-INF/views/layout/footer.jsp" />