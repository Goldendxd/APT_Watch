<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
  String method = request.getMethod();
  String regError = null;

  if ("POST".equalsIgnoreCase(method)) {
    String username  = request.getParameter("username");
    String email     = request.getParameter("email");
    String password  = request.getParameter("password");
    String cpassword = request.getParameter("cpassword");

    if (username == null || username.trim().isEmpty()
        || email == null || email.trim().isEmpty()
        || password == null || password.isEmpty()) {
      regError = "All fields are required.";
    } else if (!password.equals(cpassword)) {
      regError = "Passwords do not match. Please try again.";
    } else if (password.length() < 6) {
      regError = "Password must be at least 6 characters.";
    } else {
      /* ---- Placeholder: save to DB when backend is ready ---- */
      response.sendRedirect(request.getContextPath() + "/login?registered=1");
      return;
    }
    request.setAttribute("regError", regError);
  }

  String regError2 = (String) request.getAttribute("regError");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Create Account — AluGhadi Watches</title>
  <meta name="description" content="Join AluGhadi Watches and discover Nepal's finest premium watch collections." />
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&family=Playfair+Display:ital,wght@0,700;0,900;1,700&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/styles/pages/auth.css" />
</head>
<body>

<div class="auth-page">

  <!-- ===== LEFT: BRAND PANEL ===== -->
  <div class="auth-left">
    <div class="auth-left-bg"></div>
    <div class="auth-left-pattern"></div>
    <div class="auth-ring auth-ring-1"></div>
    <div class="auth-ring auth-ring-2"></div>
    <div class="auth-ring auth-ring-3"></div>

    <div class="auth-left-content">

      <a href="${pageContext.request.contextPath}/" class="auth-logo">
        <img src="${pageContext.request.contextPath}/static/images/alughadiweblogo.png" alt="AluGhadi" class="auth-logo-img" />
      </a>

      <div class="auth-brand-center">
        <div class="auth-brand-eyebrow">&#9651; Nepal's Premier Watch Destination</div>
        <div class="auth-watch-ring">
          <div class="auth-watch-face">AG</div>
        </div>
        <h2 class="auth-brand-title">Join the<br/><span>Collector's Circle</span></h2>
        <p class="auth-brand-sub">
          Create your account and unlock exclusive access to Nepal's finest
          watch collections, early sales, and member-only deals.
        </p>
        <div class="auth-stats">
          <div class="auth-stat">
            <div class="auth-stat-n">500+</div>
            <div class="auth-stat-l">Watch Styles</div>
          </div>
          <div class="auth-stat">
            <div class="auth-stat-n">12K+</div>
            <div class="auth-stat-l">Happy Clients</div>
          </div>
          <div class="auth-stat">
            <div class="auth-stat-n">50+</div>
            <div class="auth-stat-l">Top Brands</div>
          </div>
        </div>
      </div>

      <div class="auth-testimonial">
        <p class="auth-quote">
          Joining AluGhadi was the best decision. Exclusive member prices, early access
          to new arrivals, and amazing service from day one.
        </p>
        <div class="auth-quote-author">
          <div class="auth-avatar">SP</div>
          <div>
            <div class="auth-author-name">Sita Pradhan</div>
            <div class="auth-author-role">Premium Member &bull; Pokhara</div>
          </div>
        </div>
      </div>

    </div>
  </div>

  <!-- ===== RIGHT: FORM PANEL ===== -->
  <div class="auth-right">
    <div class="auth-form-box">

      <!-- Tab Switcher -->
      <div class="auth-tabs">
        <a href="${pageContext.request.contextPath}/login"     class="auth-tab">Sign In</a>
        <a href="${pageContext.request.contextPath}/register"  class="auth-tab active">Register</a>
      </div>

      <h1 class="auth-form-title">Create account</h1>
      <p class="auth-form-sub">
        Join AluGhadi Watches and step into a world of precision, elegance, and timeless style.
      </p>

      <!-- Error Message -->
      <% if (regError2 != null) { %>
        <div class="auth-error">&#9888; <%= regError2 %></div>
      <% } %>

      <!-- Register Form -->
      <form id="register-form" method="post" action="${pageContext.request.contextPath}/register" novalidate>

        <div class="auth-fg">
          <label for="reg-username">Username</label>
          <div class="auth-input-wrap">
            <input
              id="reg-username"
              name="username"
              type="text"
              placeholder="Choose a username"
              autocomplete="username"
              required
              value="<c:out value='${param.username}' default='' />"
            />
            <span class="auth-input-icon" title="Username">&#128100;</span>
          </div>
        </div>

        <div class="auth-fg">
          <label for="reg-email">Email Address</label>
          <div class="auth-input-wrap">
            <input
              id="reg-email"
              name="email"
              type="email"
              placeholder="you@example.com"
              autocomplete="email"
              required
              value="<c:out value='${param.email}' default='' />"
            />
            <span class="auth-input-icon" title="Email">&#9993;</span>
          </div>
        </div>

        <div class="auth-fg">
          <label for="reg-password">Password</label>
          <div class="auth-input-wrap">
            <input
              id="reg-password"
              name="password"
              type="password"
              placeholder="Create a strong password"
              autocomplete="new-password"
              required
              oninput="checkStrength(this.value)"
            />
            <span
              class="auth-input-icon"
              id="pw-reg-toggle"
              onclick="togglePw('reg-password','pw-reg-toggle')"
              title="Show / hide password"
              role="button"
            >&#128065;</span>
          </div>
          <!-- Strength bar -->
          <div class="pass-strength">
            <div class="pass-strength-bar" id="strength-bar"></div>
          </div>
        </div>

        <div class="auth-fg">
          <label for="reg-cpassword">Confirm Password</label>
          <div class="auth-input-wrap">
            <input
              id="reg-cpassword"
              name="cpassword"
              type="password"
              placeholder="Repeat your password"
              autocomplete="new-password"
              required
            />
            <span
              class="auth-input-icon"
              id="pw-cpw-toggle"
              onclick="togglePw('reg-cpassword','pw-cpw-toggle')"
              title="Show / hide password"
              role="button"
            >&#128065;</span>
          </div>
        </div>

        <button type="submit" class="auth-btn" id="register-submit-btn">
          Create Account &#8594;
        </button>

        <p class="auth-terms">
          By creating an account, you agree to our
          <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a>.
        </p>

      </form>

      <div class="auth-switch">
        Already have an account?
        <a href="${pageContext.request.contextPath}/login">Sign in</a>
      </div>

      <div class="auth-back-home">
        <a href="${pageContext.request.contextPath}/">&#8592; Back to AluGhadi Home</a>
      </div>

    </div>
  </div>

</div><!-- /auth-page -->

<script>
  function togglePw(inputId, iconId) {
    var inp  = document.getElementById(inputId);
    var icon = document.getElementById(iconId);
    if (!inp || !icon) return;
    if (inp.type === 'password') {
      inp.type = 'text';
      icon.textContent = '\uD83D\uDE48';
    } else {
      inp.type = 'password';
      icon.innerHTML = '&#128065;';
    }
  }

  function checkStrength(val) {
    var bar = document.getElementById('strength-bar');
    if (!bar) return;
    bar.className = 'pass-strength-bar';
    if (!val) { bar.style.width = '0'; return; }
    var score = 0;
    if (val.length >= 8)              score++;
    if (/[A-Z]/.test(val))            score++;
    if (/[0-9]/.test(val))            score++;
    if (/[^A-Za-z0-9]/.test(val))    score++;
    if (val.length < 6) {
      bar.classList.add('s-weak');
    } else if (score <= 1) {
      bar.classList.add('s-weak');
    } else if (score === 2) {
      bar.classList.add('s-fair');
    } else if (score === 3) {
      bar.classList.add('s-good');
    } else {
      bar.classList.add('s-strong');
    }
  }
</script>

</body>
</html>
