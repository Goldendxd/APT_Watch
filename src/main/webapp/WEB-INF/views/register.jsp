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

    .auth-wrap{width:100%;max-width:440px;}
    .auth-logo-row{display:flex;align-items:center;justify-content:center;gap:.6rem;margin-bottom:2rem;}
    .auth-logo-img{height:52px;width:auto;display:block;}

    .auth-card{background:var(--white);border:1.5px solid var(--border);border-radius:20px;padding:2.5rem 2rem;box-shadow:0 4px 32px rgba(10,30,15,.07);}
    .auth-tabs{display:flex;gap:.4rem;background:var(--bg);border:1.5px solid var(--border);border-radius:12px;padding:.3rem;margin-bottom:2rem;}
    .auth-tab{flex:1;text-align:center;padding:.55rem 1rem;border-radius:9px;font-size:.84rem;font-weight:600;color:var(--muted);transition:all .2s var(--ease);}
    .auth-tab.active{background:var(--white);color:var(--text);font-weight:700;box-shadow:0 1px 6px rgba(0,0,0,.08);}
    .auth-tab:hover:not(.active){color:var(--text);}

    .auth-title{font-size:1.4rem;font-weight:900;letter-spacing:-.025em;margin-bottom:.35rem;}
    .auth-sub{font-size:.84rem;color:var(--muted);margin-bottom:1.75rem;line-height:1.6;}

    .auth-alert{padding:.75rem 1rem;border-radius:10px;font-size:.82rem;font-weight:600;margin-bottom:1.2rem;display:flex;align-items:center;gap:.5rem;}
    .auth-alert-error{background:#fff1f1;color:#b91c1c;border:1.5px solid rgba(185,28,28,.15);}

    .fg{margin-bottom:1.2rem;}
    .fg label{display:block;font-size:.75rem;font-weight:700;color:var(--text);margin-bottom:.42rem;letter-spacing:.015em;}
    .input-wrap{position:relative;}
    .input-wrap input{width:100%;padding:.75rem 2.6rem .75rem .95rem;background:var(--bg);border:1.5px solid var(--border);border-radius:11px;font-family:var(--ff);font-size:.875rem;color:var(--text);outline:none;transition:all .2s var(--ease);}
    .input-wrap input:focus{border-color:var(--green);background:var(--white);box-shadow:0 0 0 3px rgba(26,107,56,.08);}
    .input-wrap input::placeholder{color:#88a492;}
    .input-icon{position:absolute;right:.8rem;top:50%;transform:translateY(-50%);color:#88a492;display:flex;align-items:center;cursor:pointer;}

    .pass-bar-wrap{margin-top:.5rem;height:4px;background:var(--border);border-radius:4px;overflow:hidden;}
    .pass-bar{height:100%;border-radius:4px;width:0;transition:width .3s,background .3s;}

    .auth-terms{font-size:.76rem;color:var(--muted);margin-bottom:1.5rem;line-height:1.6;}
    .auth-terms a{color:var(--green);font-weight:600;}

    .auth-btn{width:100%;padding:.85rem;background:linear-gradient(135deg,var(--green) 0%,var(--green2) 100%);color:#fff;border:none;border-radius:12px;font-family:var(--ff);font-size:.9rem;font-weight:700;cursor:pointer;transition:all .22s var(--ease);box-shadow:0 3px 14px rgba(26,107,56,.28);}
    .auth-btn:hover{transform:translateY(-2px);box-shadow:0 8px 26px rgba(26,107,56,.38);}

    .auth-switch{text-align:center;margin-top:1.5rem;font-size:.82rem;color:var(--muted);}
    .auth-switch a{color:var(--green);font-weight:700;}
    .auth-switch a:hover{text-decoration:underline;}
    .auth-back{text-align:center;margin-top:1rem;}
    .auth-back a{font-size:.78rem;color:var(--muted);display:inline-flex;align-items:center;gap:.3rem;}
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

<script>
  function togglePw() {
    var inp  = document.getElementById('reg-password');
    var hide = document.getElementById('pw-icon-hide');
    var show = document.getElementById('pw-icon-show');
    if (inp.type === 'password') {
      inp.type = 'text'; hide.style.display='none'; show.style.display='block';
    } else {
      inp.type = 'password'; hide.style.display='block'; show.style.display='none';
    }
  }

  function checkStrength(val) {
    var bar = document.getElementById('pass-bar');
    var score = 0;
    if (val.length >= 8) score++;
    if (/[A-Z]/.test(val)) score++;
    if (/[0-9]/.test(val)) score++;
    if (/[^A-Za-z0-9]/.test(val)) score++;
    var widths = ['0%','25%','50%','75%','100%'];
    var colors = ['#dd4444','#dd4444','#c88a18','#3dba62','#1a6b38'];
    bar.style.width  = widths[score];
    bar.style.background = colors[score];
  }
</script>
</body>
</html>
