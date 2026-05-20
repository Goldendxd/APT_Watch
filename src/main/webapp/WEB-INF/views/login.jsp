<%--
  login.jsp — Login page.
  Standalone page (does NOT use header.jsp — has its own full <html> structure).
  Shows loginError attribute if credentials were wrong (set by LoginServlet on failed POST).
  Shows a success notice when ?registered=1 is in the URL (after sign-up redirect).
  POSTs to /login with username and password.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Sign In | AluGhadi</title>
  <%-- Favicon so the browser tab shows the AluGhadi logo --%>
  <link rel="icon" type="image/png" href="<%=request.getContextPath()%>/static/images/alughadiweblogo.png" />
  <link rel="shortcut icon" type="image/png" href="<%=request.getContextPath()%>/static/images/alughadiweblogo.png" />
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
      <a href="${pageContext.request.contextPath}/login"    class="auth-tab active">Sign In</a>
      <a href="${pageContext.request.contextPath}/register" class="auth-tab">Register</a>
    </div>

    <h1 class="auth-title">Welcome back</h1>
    <p class="auth-sub">Sign in to your AluGhadi account to continue.</p>

    <c:if test="${not empty loginError}">
      <div class="auth-alert auth-alert-error">
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
        ${loginError}
      </div>
    </c:if>
    <c:if test="${not empty param.registered}">
      <div class="auth-alert auth-alert-success">
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"><polyline points="20 6 9 17 4 12"/></svg>
        Account created! Please sign in.
      </div>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/login">
      <div class="fg">
        <label for="username">Username</label>
        <div class="input-wrap">
          <input id="username" name="username" type="text" placeholder="Enter your username"
                 autocomplete="username" required value="<c:out value='${param.username}' default='' />" />
          <span class="input-icon">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
          </span>
        </div>
      </div>

      <div class="fg">
        <label for="password">Password</label>
        <div class="input-wrap">
          <input id="password" name="password" type="password" placeholder="Enter your password"
                 autocomplete="current-password" required />
          <span class="input-icon" id="pw-toggle" onclick="togglePw()" role="button" aria-label="Toggle password">
            <svg id="pw-icon-hide" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
            <svg id="pw-icon-show" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" style="display:none;"><path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"/><line x1="1" y1="1" x2="23" y2="23"/></svg>
          </span>
        </div>
      </div>

      <div class="auth-row">
        <label class="auth-check">
          <input type="checkbox" name="remember" /> Remember me
        </label>
        <a href="#" class="auth-forgot">Forgot password?</a>
      </div>

      <button type="submit" class="auth-btn">Sign In</button>
    </form>

    <div class="auth-switch">
      Don't have an account? <a href="${pageContext.request.contextPath}/register">Create one</a>
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
