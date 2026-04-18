<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
  String method = request.getMethod();
  if ("POST".equalsIgnoreCase(method)) {
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    if (username != null && !username.trim().isEmpty()
        && password != null && !password.trim().isEmpty()) {
      session.setAttribute("authUser", username.trim());
      session.setAttribute("authRole", "user");
      response.sendRedirect(request.getContextPath() + "/");
      return;
    } else {
      request.setAttribute("loginError", "Please enter both username and password.");
    }
  }
  String loginError = (String) request.getAttribute("loginError");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Login — AluGhadi Watches</title>
  <meta name="description" content="Sign in to your AluGhadi account to explore premium watch collections in Nepal." />
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&family=Playfair+Display:ital,wght@0,700;0,900;1,700&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/pages/auth.css" />
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

      <!-- Logo -->
      <a href="${pageContext.request.contextPath}/" class="auth-logo">
        <img src="${pageContext.request.contextPath}/static/images/alughadiweblogo.png" alt="AluGhadi" class="auth-logo-img" />
      </a>

      <!-- Central Brand Block -->
      <div class="auth-brand-center">
        <div class="auth-brand-eyebrow">&#9651; Nepal's Premier Watch Destination</div>
        <div class="auth-watch-ring">
          <div class="auth-watch-face">AG</div>
        </div>
        <h2 class="auth-brand-title">The Finest Watches<br/><span>In Nepal</span></h2>
        <p class="auth-brand-sub">
          Curated timepieces from the world's leading brands —
          crafted for precision, worn with pride.
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

      <!-- Testimonial -->
      <div class="auth-testimonial">
        <p class="auth-quote">
          AluGhadi is my go-to for premium watches in Nepal. The collection is
          exceptional and the delivery was absolutely flawless.
        </p>
        <div class="auth-quote-author">
          <div class="auth-avatar">RK</div>
          <div>
            <div class="auth-author-name">Rajesh Kumar</div>
            <div class="auth-author-role">Verified Customer &bull; Kathmandu</div>
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
        <a href="${pageContext.request.contextPath}/login"     class="auth-tab active">Sign In</a>
        <a href="${pageContext.request.contextPath}/register"  class="auth-tab">Register</a>
      </div>

      <h1 class="auth-form-title">Welcome back</h1>
      <p class="auth-form-sub">
        Sign in to your AluGhadi account to access orders, wishlist, and exclusive offers.
      </p>

      <!-- Error Message -->
      <% if (loginError != null) { %>
        <div class="auth-error">&#9888; <%= loginError %></div>
      <% } %>

      <!-- Registered success flash -->
      <c:if test="${not empty param.registered}">
        <div class="auth-success">&#10003; Account created successfully! Please sign in.</div>
      </c:if>

      <!-- Login Form -->
      <form id="login-form" method="post" action="${pageContext.request.contextPath}/login" novalidate>

        <div class="auth-fg">
          <label for="username">Username</label>
          <div class="auth-input-wrap">
            <input
              id="username"
              name="username"
              type="text"
              placeholder="Enter your username"
              autocomplete="username"
              required
              value="<c:out value='${param.username}' default='' />"
            />
            <span class="auth-input-icon" title="Username">&#128100;</span>
          </div>
        </div>

        <div class="auth-fg">
          <label for="password">Password</label>
          <div class="auth-input-wrap">
            <input
              id="password"
              name="password"
              type="password"
              placeholder="Enter your password"
              autocomplete="current-password"
              required
            />
            <span
              class="auth-input-icon"
              id="pw-toggle"
              onclick="togglePw('password','pw-toggle')"
              title="Show / hide password"
              role="button"
              aria-label="Toggle password visibility"
            >&#128065;</span>
          </div>
        </div>

        <div class="auth-row">
          <label class="auth-check">
            <input type="checkbox" name="remember" id="remember-me" />
            Remember me
          </label>
          <a href="#" class="auth-forgot">Forgot password?</a>
        </div>

        <button type="submit" class="auth-btn" id="login-submit-btn">
          Sign In &#8594;
        </button>

      </form>

      <div class="auth-switch">
        Don't have an account?
        <a href="${pageContext.request.contextPath}/register">Create one now</a>
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
      icon.textContent = '\uD83D\uDE48'; /* 🙈 */
    } else {
      inp.type = 'password';
      icon.innerHTML = '&#128065;'; /* 👁 */
    }
  }
</script>

</body>
</html>
