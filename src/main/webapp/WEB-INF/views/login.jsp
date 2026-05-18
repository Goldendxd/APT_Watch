<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Sign In | AluGhadi</title>
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet" />
  <style>
    :root {
      --green:#1a6b38; --green2:#258a4a; --green-light:#e4f4eb; --green-mid:#b2d9c0;
      --accent:#3dba62; --text:#0b1c10; --muted:#4e6a59; --border:#d4e5da;
      --bg:#f2f6f2; --white:#ffffff;
      --ff:'Inter',-apple-system,BlinkMacSystemFont,'Segoe UI',sans-serif;
      --ease:cubic-bezier(0.16,1,0.3,1);
    }
    *,*::before,*::after{margin:0;padding:0;box-sizing:border-box;}
    body{font-family:var(--ff);background:var(--bg);color:var(--text);min-height:100vh;display:flex;align-items:center;justify-content:center;padding:1.5rem;}
    a{text-decoration:none;color:inherit;}

    .auth-wrap {
      width:100%;
      max-width:440px;
    }

    .auth-logo-row {
      display:flex;
      align-items:center;
      justify-content:center;
      margin-bottom:2rem;
    }
    .auth-logo-img { height:52px; width:auto; display:block; }

    .auth-card {
      background:var(--white);
      border:1.5px solid var(--border);
      border-radius:20px;
      padding:2.5rem 2rem;
      box-shadow:0 4px 32px rgba(10,30,15,.07);
    }

    .auth-tabs {
      display:flex;
      gap:.4rem;
      background:var(--bg);
      border:1.5px solid var(--border);
      border-radius:12px;
      padding:.3rem;
      margin-bottom:2rem;
    }
    .auth-tab {
      flex:1;text-align:center;
      padding:.55rem 1rem;
      border-radius:9px;
      font-size:.84rem;font-weight:600;
      color:var(--muted);
      transition:all .2s var(--ease);
    }
    .auth-tab.active {
      background:var(--white);
      color:var(--text);
      font-weight:700;
      box-shadow:0 1px 6px rgba(0,0,0,.08);
    }
    .auth-tab:hover:not(.active){color:var(--text);}

    .auth-title {font-size:1.4rem;font-weight:900;letter-spacing:-.025em;margin-bottom:.35rem;}
    .auth-sub {font-size:.84rem;color:var(--muted);margin-bottom:1.75rem;line-height:1.6;}

    .auth-alert {
      padding:.75rem 1rem;border-radius:10px;font-size:.82rem;font-weight:600;margin-bottom:1.2rem;display:flex;align-items:center;gap:.5rem;
    }
    .auth-alert-error {background:#fff1f1;color:#b91c1c;border:1.5px solid rgba(185,28,28,.15);}
    .auth-alert-success{background:var(--green-light);color:var(--green);border:1.5px solid var(--green-mid);}

    .fg {margin-bottom:1.2rem;}
    .fg label {display:block;font-size:.75rem;font-weight:700;color:var(--text);margin-bottom:.42rem;letter-spacing:.015em;}
    .input-wrap {position:relative;}
    .input-wrap input {
      width:100%;padding:.75rem 2.6rem .75rem .95rem;
      background:var(--bg);border:1.5px solid var(--border);border-radius:11px;
      font-family:var(--ff);font-size:.875rem;color:var(--text);outline:none;
      transition:all .2s var(--ease);
    }
    .input-wrap input:focus {border-color:var(--green);background:var(--white);box-shadow:0 0 0 3px rgba(26,107,56,.08);}
    .input-wrap input::placeholder{color:#88a492;}
    .input-icon {
      position:absolute;right:.8rem;top:50%;transform:translateY(-50%);
      color:#88a492;display:flex;align-items:center;cursor:pointer;
    }

    .auth-row {display:flex;align-items:center;justify-content:space-between;margin-bottom:1.5rem;}
    .auth-check {display:flex;align-items:center;gap:.45rem;font-size:.8rem;color:var(--muted);cursor:pointer;}
    .auth-check input{accent-color:var(--green);}
    .auth-forgot {font-size:.8rem;color:var(--green);font-weight:600;}
    .auth-forgot:hover{text-decoration:underline;}

    .auth-btn {
      width:100%;padding:.85rem;
      background:linear-gradient(135deg,var(--green) 0%,var(--green2) 100%);
      color:#fff;border:none;border-radius:12px;
      font-family:var(--ff);font-size:.9rem;font-weight:700;
      cursor:pointer;transition:all .22s var(--ease);
      box-shadow:0 3px 14px rgba(26,107,56,.28);
    }
    .auth-btn:hover{transform:translateY(-2px);box-shadow:0 8px 26px rgba(26,107,56,.38);}
    .auth-btn:active{transform:none;}

    .auth-switch {text-align:center;margin-top:1.5rem;font-size:.82rem;color:var(--muted);}
    .auth-switch a {color:var(--green);font-weight:700;}
    .auth-switch a:hover{text-decoration:underline;}

    .auth-back {text-align:center;margin-top:1rem;}
    .auth-back a {font-size:.78rem;color:var(--muted);display:inline-flex;align-items:center;gap:.3rem;}
    .auth-back a:hover{color:var(--green);}
  </style>
</head>
<body>

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

<script>
  function togglePw() {
    var inp  = document.getElementById('password');
    var hide = document.getElementById('pw-icon-hide');
    var show = document.getElementById('pw-icon-show');
    if (inp.type === 'password') {
      inp.type = 'text';
      hide.style.display = 'none';
      show.style.display = 'block';
    } else {
      inp.type = 'password';
      hide.style.display = 'block';
      show.style.display = 'none';
    }
  }
</script>
</body>
</html>
