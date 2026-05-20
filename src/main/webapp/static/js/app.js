// AluGhadi Watches — Main Application Script

/* ================================================================
   SHARED FORM VALIDATION HELPERS
   These functions are used on all forms that have email or phone fields.
   ================================================================ */

/**
 * Check if an email looks valid — must have a local part, @, and a domain.
 * Example: "you@gmail.com" → true, "notanemail" → false
 */
function isValidEmail(email) {
  return /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/.test(email.trim());
}

/**
 * Check if a phone number is exactly 10 digits (digits only, no spaces/dashes).
 * Nepali numbers like 9841234567 pass; +977... or short numbers fail.
 */
function isValidPhone(phone) {
  return /^\d{10}$/.test(phone.trim());
}

/**
 * Show a red error message below an input field.
 * Creates a small <span> element tagged with data-err so we can clear it later.
 */
function showFieldError(input, message) {
  clearFieldError(input);
  var err = document.createElement('span');
  err.setAttribute('data-err', '1');
  err.style.cssText = 'display:block;font-size:0.72rem;color:#c33;margin-top:0.25rem;font-weight:600;';
  err.textContent = message;
  input.parentNode.appendChild(err);
  input.style.borderColor = '#c33';
}

/**
 * Remove any error message shown below an input field.
 */
function clearFieldError(input) {
  var old = input.parentNode.querySelector('[data-err]');
  if (old) old.remove();
  input.style.borderColor = '';
}

/**
 * Validate a single email input in-place.
 * Returns true if valid, false + shows error if not.
 */
function validateEmailField(input) {
  if (!input) return true;
  var val = input.value.trim();
  if (!val) return true; // Empty is OK if the field isn't required; required attr handles that
  if (!isValidEmail(val)) {
    showFieldError(input, 'Please enter a valid email address (e.g. you@example.com)');
    return false;
  }
  clearFieldError(input);
  return true;
}

/**
 * Validate a single phone input in-place.
 * Returns true if valid, false + shows error if not.
 * Only validates when the field has a value (phone is often optional).
 */
function validatePhoneField(input) {
  if (!input) return true;
  var val = input.value.trim();
  if (!val) return true; // Empty is fine for optional phone fields
  if (!isValidPhone(val)) {
    showFieldError(input, 'Phone must be exactly 10 digits (e.g. 9841234567)');
    return false;
  }
  clearFieldError(input);
  return true;
}

/**
 * Wire up live validation on all email/phone inputs on the page.
 * Runs on blur (when the user tabs out of the field) so it's not annoying while typing.
 */
function initFormValidation() {
  // Find every email input on the page and validate on blur
  document.querySelectorAll('input[type="email"]').forEach(function(input) {
    input.addEventListener('blur', function() { validateEmailField(this); });
    input.addEventListener('input', function() { clearFieldError(this); });
  });

  // Find every phone/tel input and validate on blur
  document.querySelectorAll('input[type="tel"]').forEach(function(input) {
    input.addEventListener('blur', function() { validatePhoneField(this); });
    input.addEventListener('input', function() {
      // Only allow digit characters while typing
      this.value = this.value.replace(/[^\d]/g, '');
      clearFieldError(this);
    });
  });
}

// Run as soon as the DOM is ready
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', initFormValidation);
} else {
  initFormValidation();
}

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
  var modal = document.getElementById('modal-' + modalId);
  if (modal) { modal.classList.remove('active'); document.body.style.overflow = ''; }
}
document.addEventListener('click', function (e) {
  if (e.target.classList.contains('modal-ov')) {
    e.target.classList.remove('active');
    document.body.style.overflow = '';
  }
});

/* ================================================================
   CART
   ================================================================ */
function openCart() { showModal('cart'); }

/* Add to cart via fetch — no page reload */
function addToCart(btn, productId, quantity) {
  btn.disabled = true;
  var ctx = document.querySelector('meta[name="ctx"]');
  var base = ctx ? ctx.content : '';
  var body = new URLSearchParams({ action: 'add', productId: productId, quantity: quantity || 1 });
  fetch(base + '/cart', { method: 'POST', body: body })
    .then(function (res) {
      /* If servlet redirected to login page, navigate there */
      if (res.url && res.url.indexOf('/login') !== -1) {
        window.location.href = base + '/login';
        return;
      }
      return refreshCartModal().then(function () {
        showToast('Added to Cart', 'Item added to your cart.', '🛒');
      });
    })
    .catch(function () {})
    .finally(function () { btn.disabled = false; });
}

/* Refresh cart modal HTML via fetch — returns a Promise */
function refreshCartModal() {
  var ctx = document.querySelector('meta[name="ctx"]');
  var base = ctx ? ctx.content : '';
  return fetch(base + '/cart-fragment')
    .then(function (r) { return r.text(); })
    .then(function (html) {
      var parser = new DOMParser();
      var doc = parser.parseFromString(html, 'text/html');
      var newItems = doc.getElementById('cart-items-inner');
      var newTotal = doc.getElementById('cart-total-val');
      var newCount = doc.getElementById('cart-count-val');
      var wrap = document.getElementById('cart-items-inner');
      var totalEl = document.getElementById('selected-cart-total');
      if (wrap && newItems) wrap.innerHTML = newItems.innerHTML;
      if (totalEl && newTotal) totalEl.textContent = newTotal.textContent;
      var navCount = document.getElementById('nav-cart-count');
      if (navCount && newCount) navCount.textContent = '(' + newCount.textContent + ')';
    });
}

/* Cart quantity/remove forms inside the modal — intercept with fetch */
document.addEventListener('submit', function (e) {
  var form = e.target;
  if (!form.closest('#modal-cart')) return;
  e.preventDefault();
  var ctx = document.querySelector('meta[name="ctx"]');
  var base = ctx ? ctx.content : '';
  fetch(base + '/cart', { method: 'POST', body: new URLSearchParams(new FormData(form)) })
    .then(function () { return refreshCartModal(); })
    .catch(function () {});
});

/* ================================================================
   SMOOTH SCROLL
   ================================================================ */
document.querySelectorAll('a[href^="#"]').forEach(function (anchor) {
  anchor.addEventListener('click', function (e) {
    e.preventDefault();
    var target = document.querySelector(this.getAttribute('href'));
    if (target) target.scrollIntoView({ behavior: 'smooth' });
  });
});

/* ================================================================
   TOAST NOTIFICATIONS
   ================================================================ */
function showToast(title, msg, icon) {
  var c = document.getElementById('toast-container');
  if (!c) return;
  var t = document.createElement('div');
  t.className = 'toast';
  t.innerHTML = '<div class="t-ico">' + (icon || '') + '</div>'
    + '<div><div class="t-h">' + title + '</div>'
    + (msg ? '<div class="t-p">' + msg + '</div>' : '') + '</div>';
  c.appendChild(t);
  setTimeout(function () { t.remove(); }, 4000);
}

/* ================================================================
   AUTH — PASSWORD TOGGLE & STRENGTH METER
   ================================================================ */
function togglePw() {
  var inp  = document.getElementById('password') || document.getElementById('reg-password');
  var hide = document.getElementById('pw-icon-hide');
  var show = document.getElementById('pw-icon-show');
  if (!inp) return;
  if (inp.type === 'password') {
    inp.type = 'text';
    if (hide) hide.style.display = 'none';
    if (show) show.style.display = 'block';
  } else {
    inp.type = 'password';
    if (hide) hide.style.display = 'block';
    if (show) show.style.display = 'none';
  }
}

function checkStrength(val) {
  var bar = document.getElementById('pass-bar');
  if (!bar) return;
  var score = 0;
  if (val.length >= 8)          score++;
  if (/[A-Z]/.test(val))        score++;
  if (/[0-9]/.test(val))        score++;
  if (/[^A-Za-z0-9]/.test(val)) score++;
  var widths = ['0%', '25%', '50%', '75%', '100%'];
  var colors = ['#dd4444', '#dd4444', '#c88a18', '#3dba62', '#1a6b38'];
  bar.style.width      = widths[score];
  bar.style.background = colors[score];
}

/* ================================================================
   WISHLIST  (products page)
   ================================================================ */
var WISH_KEY = 'alughadi_wishlist';

function getWishlist() {
  try { return JSON.parse(localStorage.getItem(WISH_KEY) || '[]'); }
  catch (e) { return []; }
}
function saveWishlist(arr) { localStorage.setItem(WISH_KEY, JSON.stringify(arr)); }

function syncHearts() {
  var wish = getWishlist();
  document.querySelectorAll('.product-card').forEach(function (card) {
    var id  = card.getAttribute('data-id');
    var btn = card.querySelector('.prod-save');
    var tip = btn ? btn.querySelector('.wish-tip') : null;
    if (!btn) return;
    if (wish.indexOf(id) !== -1) {
      btn.classList.add('saved');
      btn.querySelector('.wish-heart').innerHTML = '&#9829;';
      if (tip) tip.textContent = 'Saved!';
    } else {
      btn.classList.remove('saved');
      btn.querySelector('.wish-heart').innerHTML = '&#9825;';
      if (tip) tip.textContent = 'Wishlist';
    }
  });
}

function updateWishlistCount() {
  var wish  = getWishlist();
  var count = document.getElementById('fav-count');
  var empty = document.getElementById('fav-empty');
  if (count) {
    count.style.display = wish.length > 0 ? 'inline-flex' : 'none';
    count.textContent   = wish.length > 0 ? wish.length : '';
  }
  if (empty) empty.style.display = wish.length === 0 ? 'block' : 'none';
}

function toggleWishlist(btn) {
  var card  = btn.closest('.product-card');
  var id    = card.getAttribute('data-id');
  var wish  = getWishlist();
  var idx   = wish.indexOf(id);
  var heart = btn.querySelector('.wish-heart');
  var tip   = btn.querySelector('.wish-tip');
  if (idx === -1) {
    wish.push(id);
    btn.classList.add('saved');
    heart.innerHTML = '&#9829;';
    if (tip) tip.textContent = 'Saved!';
    showToast('Added to Wishlist', 'Tap ♥ again to remove.', '♥️');
  } else {
    wish.splice(idx, 1);
    btn.classList.remove('saved');
    heart.innerHTML = '&#9825;';
    if (tip) tip.textContent = 'Wishlist';
    showToast('Removed from Wishlist', '', '♡');
  }
  saveWishlist(wish);
  updateWishlistCount();
}

/* Init wishlist UI if on products page */
document.addEventListener('DOMContentLoaded', function () {
  if (document.querySelector('.product-card')) {
    syncHearts();
    updateWishlistCount();
  }
});

