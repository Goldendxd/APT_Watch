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

function updateCartDisplay() {
  try {
    var cartData = localStorage.getItem("alughadi_cart");
    var cart = cartData ? JSON.parse(cartData) : [];
    var countEl = document.getElementById("nav-cart-count");
    if (countEl) {
      countEl.textContent = "(" + cart.length + ")";
    }
  } catch (e) {
    console.error("Error updating cart:", e);
  }
}

// Initialize cart display on page load
updateCartDisplay();

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
