// AluGhadi Watches — Main Application Script

/* ================================================================
   PAGE LOADER
   ================================================================ */
window.addEventListener('load', function () {
  var loader = document.getElementById('page-loader');
  if (loader) {
    loader.style.opacity = '0';
    setTimeout(function () { loader.style.display = 'none'; }, 400);
  }
});

/* ================================================================
   NAVBAR SCROLL EFFECT
   ================================================================ */
window.addEventListener('scroll', function () {
  var nav = document.getElementById('nav');
  if (nav) {
    nav.classList.toggle('scrolled', window.scrollY > 10);
  }
});

/* ================================================================
   REVEAL ANIMATIONS
   ================================================================ */
function initRevealAnimations() {
  var observer = new IntersectionObserver(function (entries) {
    entries.forEach(function (entry) {
      if (entry.isIntersecting) {
        entry.target.classList.add('vis');
        observer.unobserve(entry.target);
      }
    });
  }, { threshold: 0.1 });
  document.querySelectorAll('.reveal').forEach(function (el) { observer.observe(el); });
}
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', initRevealAnimations);
} else {
  initRevealAnimations();
}

/* ================================================================
   MOBILE SIDEBAR
   ================================================================ */
function toggleSidebar() {
  var sidebar = document.getElementById('sidebar');
  var overlay = document.getElementById('sidebar-overlay');
  if (sidebar) sidebar.classList.toggle('active');
  if (overlay) overlay.classList.toggle('active');
}
function closeSidebar() {
  var sidebar = document.getElementById('sidebar');
  var overlay = document.getElementById('sidebar-overlay');
  if (sidebar) sidebar.classList.remove('active');
  if (overlay) overlay.classList.remove('active');
}

/* ================================================================
   MODAL MANAGEMENT
   ================================================================ */
function showModal(modalId) {
  var modal = document.getElementById('modal-' + modalId);
  if (modal) { modal.classList.add('active'); document.body.style.overflow = 'hidden'; }
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


// Smooth scroll to anchor links
document.querySelectorAll('a[href^="#"]').forEach(function (anchor) {
  anchor.addEventListener('click', function (e) {
    e.preventDefault();
    var target = document.querySelector(this.getAttribute("href"));
    if (target) {
      target.scrollIntoView({ behavior: "smooth" });
    }
  });
});

// Log app ready
console.log("AluGhadi Watches - Ready to serve premium timepieces ⌚");
