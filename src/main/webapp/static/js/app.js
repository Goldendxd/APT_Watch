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

function filterProducts(cat, tabBtn) {
  document.querySelectorAll('.tab').forEach(function (t) { t.classList.remove('active'); });
  tabBtn.classList.add('active');
  var wish  = getWishlist();
  var shown = 0;
  var empty = document.getElementById('fav-empty');
  document.querySelectorAll('.product-card').forEach(function (card) {
    var id = card.getAttribute('data-id');
    if (wish.indexOf(id) !== -1) { card.style.display = ''; shown++; }
    else { card.style.display = 'none'; }
  });
  if (empty) empty.style.display = shown === 0 ? 'block' : 'none';
}

/* Init wishlist UI if on products page */
document.addEventListener('DOMContentLoaded', function () {
  if (document.querySelector('.product-card')) {
    syncHearts();
    updateWishlistCount();
  }
});

console.log('AluGhadi Watches — Ready ⌚');
