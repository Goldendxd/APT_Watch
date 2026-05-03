// AluGhadi Watches - Main Application Script

// Fade out loading screen when page fully loads
window.addEventListener("load", function () {
  var loader = document.getElementById("page-loader");
  if (loader) {
    loader.style.opacity = "0";
    setTimeout(function () {
      loader.style.display = "none";
    }, 400);
  }
});

// Navbar scroll effect
window.addEventListener("scroll", function () {
  var nav = document.getElementById("nav");
  if (nav) {
    if (window.scrollY > 10) {
      nav.classList.add("scrolled");
    } else {
      nav.classList.remove("scrolled");
    }
  }
});

// Reveal animation observer
function initRevealAnimations() {
  var observer = new IntersectionObserver(
    function (entries) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting) {
          entry.target.classList.add("vis");
          observer.unobserve(entry.target);
        }
      });
    },
    { threshold: 0.1 },
  );

  document.querySelectorAll(".reveal").forEach(function (el) {
    observer.observe(el);
  });
}

// Initialize on DOM ready
if (document.readyState === "loading") {
  document.addEventListener("DOMContentLoaded", initRevealAnimations);
} else {
  initRevealAnimations();
}

// Mobile menu toggle
function toggleSidebar() {
  var sidebar = document.getElementById("sidebar");
  var overlay = document.getElementById("sidebar-overlay");
  if (sidebar) {
    sidebar.classList.toggle("active");
  }
  if (overlay) {
    overlay.classList.toggle("active");
  }
}

function closeSidebar() {
  var sidebar = document.getElementById("sidebar");
  var overlay = document.getElementById("sidebar-overlay");
  if (sidebar) {
    sidebar.classList.remove("active");
  }
  if (overlay) {
    overlay.classList.remove("active");
  }
}

// Modal management
function showModal(modalId) {
  var modal = document.getElementById("modal-" + modalId);
  if (modal) {
    modal.classList.add("active");
    document.body.style.overflow = "hidden";
  }
}

function closeModal(modalId) {
  var modal = document.getElementById("modal-" + modalId);
  if (modal) {
    modal.classList.remove("active");
    document.body.style.overflow = "";
  }
}

// Close modals when clicking outside
document.addEventListener("click", function (e) {
  if (e.target.classList.contains("modal-ov")) {
    e.target.classList.remove("active");
    document.body.style.overflow = "";
  }
});

// Cart functionality
function openCart() {
  showModal("cart");
}

/* ================================================================
   AJAX CART HELPERS — no page refresh
   ================================================================ */
var CTX_PATH = document.querySelector('meta[name="ctx"]')
  ? document.querySelector('meta[name="ctx"]').getAttribute('content')
  : '';

function _cartPost(params) {
  return fetch(CTX_PATH + '/cart', {
    method:   'POST',
    headers:  { 'Content-Type': 'application/x-www-form-urlencoded' },
    body:     params.toString(),
    redirect: 'manual'
  });
}

/* Add to cart from any page */
function ajaxAddToCart(productId, btn) {
  var params = new URLSearchParams();
  params.append('action', 'add');
  params.append('productId', productId);
  params.append('quantity', '1');

  if (btn) {
    btn.disabled = true;
    if (btn.classList.contains('prod-cart-btn')) {
      /* Product card button */
      btn.classList.add('added');
      btn.innerHTML = 'Added &#10003;';
      btn.style.background = '#1a6b38';
      btn.style.borderColor = '#1a6b38';
      btn.style.color = '#fff';
      btn.style.cursor = 'default';
    } else {
      /* Full text button on product details page */
      btn.style.background = '#1a6b38';
      btn.style.borderColor = '#1a6b38';
      btn.style.color = '#fff';
      btn.style.opacity = '0.85';
      btn.innerHTML = 'Added to Cart &#10003;';
    }
  }

  _cartPost(params).then(function() {
    _refreshCartBadge();
    if (typeof showToast === 'function')
      showToast('Added to Cart', 'Item has been added.', '&#128717;');
  });
}

/* Update quantity in cart modal */
function ajaxUpdateQty(cartId, newQty) {
  var params = new URLSearchParams();
  if (newQty <= 0) {
    params.append('action', 'remove');
    params.append('cartId', cartId);
  } else {
    params.append('action', 'update');
    params.append('cartId', cartId);
    params.append('quantity', newQty);
  }
  _cartPost(params).then(function() { _refreshCartModal(); });
}

/* Remove from cart modal */
function ajaxRemoveFromCart(cartId) {
  var params = new URLSearchParams();
  params.append('action', 'remove');
  params.append('cartId', cartId);
  _cartPost(params).then(function() { _refreshCartModal(); });
}

/* Refresh just the cart badge count in nav */
function _refreshCartBadge() {
  fetch(window.location.href)
    .then(function(r) { return r.text(); })
    .then(function(html) {
      var parser = new DOMParser();
      var doc    = parser.parseFromString(html, 'text/html');
      var badge  = doc.getElementById('nav-cart-count');
      if (badge) {
        var el = document.getElementById('nav-cart-count');
        if (el) el.textContent = badge.textContent;
      }
    }).catch(function(){});
}

/* Refresh the cart modal contents + badge without page reload */
function _refreshCartModal() {
  /* Fetch the current page to get fresh cart HTML */
  fetch(window.location.href)
    .then(function(r) { return r.text(); })
    .then(function(html) {
      var parser  = new DOMParser();
      var doc     = parser.parseFromString(html, 'text/html');

      /* Update cart modal content */
      var newModal = doc.getElementById('modal-cart');
      var oldModal = document.getElementById('modal-cart');
      if (newModal && oldModal) {
        var newInner = newModal.querySelector('.cart-modal');
        var oldInner = oldModal.querySelector('.cart-modal');
        if (newInner && oldInner) {
          oldInner.innerHTML = newInner.innerHTML;
        }
      }

      /* Update cart badge */
      var newBadge = doc.getElementById('nav-cart-count');
      var oldBadge = document.getElementById('nav-cart-count');
      if (newBadge && oldBadge) oldBadge.textContent = newBadge.textContent;
    }).catch(function(){});
}

// Smooth scroll to anchor links
document.querySelectorAll('a[href^="#"]').forEach(function (anchor) {
  anchor.addEventListener("click", function (e) {
    e.preventDefault();
    var target = document.querySelector(this.getAttribute("href"));
    if (target) {
      target.scrollIntoView({ behavior: "smooth" });
    }
  });
});

// Log app ready
console.log("AluGhadi Watches - Ready to serve premium timepieces ⌚");
