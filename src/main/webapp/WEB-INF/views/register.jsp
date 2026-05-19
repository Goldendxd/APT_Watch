<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Register | AluGhadi</title>
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/pages/auth.css" />
</head>
<body class="auth-standalone">

<div class="auth-wrap">
  <div class="auth-logo-row">
    <a href="<%=request.getContextPath()%>/">
      <img src="<%=request.getContextPath()%>/static/images/alughadiweblogo.png" alt="AluGhadi" class="auth-logo-img" />
    </a>
  </div>

  <div class="auth-card">
    <div class="auth-tabs">
      <a href="${pageContext.request.contextPath}/login"    class="auth-tab">Sign In</a>
      <a href="${pageContext.request.contextPath}/register" class="auth-tab active">Register</a>
    </div>

    <h1 class="auth-title">Create account</h1>
    <p class="auth-sub">Join AluGhadi and access Nepal's finest watch collection.</p>

    <c:if test="${not empty registerError}">
      <div class="auth-alert auth-alert-error">
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
        <c:out value="${registerError}" />
      </div>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/register">
      <div class="fg">
        <label for="reg-username">Username</label>
        <div class="input-wrap">
          <input id="reg-username" name="username" type="text" placeholder="Choose a username"
                 autocomplete="username" required value="<c:out value='${param.username}' default='' />" />
          <span class="input-icon">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
          </span>
        </div>
      </div>

      <div class="fg">
        <label for="reg-email">Email Address</label>
        <div class="input-wrap">
          <input id="reg-email" name="email" type="email" placeholder="you@example.com"
                 autocomplete="email" required value="<c:out value='${param.email}' default='' />" />
          <span class="input-icon">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22,6 12,13 2,6"/></svg>
          </span>
        </div>
      </div>

      <div class="fg">
        <label for="reg-password">Password</label>
        <div class="input-wrap">
          <input id="reg-password" name="password" type="password" placeholder="Create a strong password"
                 autocomplete="new-password" required oninput="checkStrength(this.value)" />
          <span class="input-icon" id="pw-toggle" onclick="togglePw()" role="button" aria-label="Toggle password">
            <svg id="pw-icon-hide" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
            <svg id="pw-icon-show" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" style="display:none;"><path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"/><line x1="1" y1="1" x2="23" y2="23"/></svg>
          </span>
        </div>
        <div class="pass-bar-wrap"><div class="pass-bar" id="pass-bar"></div></div>
      </div>

      <div class="fg">
        <label for="reg-confirm">Confirm Password</label>
        <div class="input-wrap">
          <input id="reg-confirm" name="confirmPassword" type="password" placeholder="Repeat your password"
                 autocomplete="new-password" required />
          <span class="input-icon">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/></svg>
          </span>
        </div>
      </div>

      <p class="auth-terms">
        By creating an account you agree to our <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a>.
      </p>

      <button type="submit" class="auth-btn">Create Account</button>
    </form>

    <div class="auth-switch">
      Already have an account? <a href="${pageContext.request.contextPath}/login">Sign in</a>
    </div>
  </div>

  <div class="auth-back">
    <a href="${pageContext.request.contextPath}/">
      <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"><polyline points="15 18 9 12 15 6"/></svg>
      Back to AluGhadi
    </a>
  </div>
</div>

<script src="<%=request.getContextPath()%>/static/js/app.js"></script>
</body>
</html>
