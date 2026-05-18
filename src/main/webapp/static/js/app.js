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

function setCartOpenUrl() {
  var url = new URL(window.location.href);
  url.searchParams.set("cart", "open");
  window.history.replaceState({}, "", url.pathname + url.search + url.hash);
}

function removeCartOpenUrl() {
  var url = new URL(window.location.href);
  url.searchParams.delete("cart");
  window.history.replaceState({}, "", url.pathname + url.search + url.hash);
}

function closeModal(modalId) {
  var modal = document.getElementById("modal-" + modalId);
  if (modal) {
    modal.classList.remove("active");
    document.body.style.overflow = "";
  }
  if (modalId === "cart") {
    removeCartOpenUrl();
  }
}

// Close modals when clicking outside
document.addEventListener("click", function (e) {
  if (e.target.classList.contains("modal-ov")) {
    var isCartModal = e.target.id === "modal-cart";
    e.target.classList.remove("active");
    document.body.style.overflow = "";
    if (isCartModal) {
      removeCartOpenUrl();
    }
  }
});

// Cart functionality
function openCart() {
  showModal("cart");
  setCartOpenUrl();
}

document.addEventListener("DOMContentLoaded", function () {
  if (window.location.search.indexOf("cart=open") !== -1) {
    showModal("cart");
  }
});


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

function updateSelectedCartTotal() {
  var total = 0;
  var checkboxes = document.querySelectorAll(".cart-select");

  checkboxes.forEach(function (checkbox) {
    if (checkbox.checked && !checkbox.disabled) {
      var item = checkbox.closest(".cart-item");
      var lineTotal = Number(item.dataset.lineTotal || 0);
      total += lineTotal;
    }
  });

  var totalBox = document.getElementById("selected-cart-total");
  if (totalBox) {
    totalBox.textContent = total.toLocaleString("en-IN");
  }
}

document.addEventListener("DOMContentLoaded", function () {
  updateSelectedCartTotal();

  document.querySelectorAll(".cart-select").forEach(function (checkbox) {
    checkbox.addEventListener("change", updateSelectedCartTotal);
  });
});

// Log app ready
console.log("AluGhadi Watches - Ready to serve premium timepieces ⌚");
