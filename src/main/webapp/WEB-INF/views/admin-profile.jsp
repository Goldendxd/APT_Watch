<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Admin Profile | AluGhadi</title>
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet" />
  <style>
    :root {
      --bg:#f2f6f2; --white:#ffffff; --surface:#eaf0ea; --surface2:#f7faf7;
      --green:#1a6b38; --green2:#258a4a; --green-light:#e4f4eb; --green-mid:#b2d9c0;
      --accent:#3dba62; --text:#0b1c10; --text2:#1e3828; --muted:#4e6a59;
      --dim:#88a492; --border:#d4e5da; --border2:#bfd4c8;
      --gold:#c9a452; --gold-light:#f4e9cc; --gold2:#b8913a;
      --red:#d44; --amber:#c88a18;
      --blue:#2563eb; --blue-light:#eff6ff;
      --purple:#7c3aed; --purple-light:#f5f3ff;
      --ff:'Inter',-apple-system,BlinkMacSystemFont,'Segoe UI',sans-serif;
      --ease:cubic-bezier(0.16,1,0.3,1);
      --shadow:0 2px 16px rgba(10,30,15,.07);
      --shadow-md:0 6px 28px rgba(10,30,15,.10);
      --sidebar-w:260px;
    }
    *,*::before,*::after{margin:0;padding:0;box-sizing:border-box;}
    html{scroll-behavior:smooth;}
    body{font-family:var(--ff);background:var(--bg);color:var(--text);font-size:15px;line-height:1.6;-webkit-font-smoothing:antialiased;display:flex;min-height:100vh;}
    a{text-decoration:none;color:inherit;}
    button{cursor:pointer;font-family:var(--ff);}
    ::-webkit-scrollbar{width:5px;} ::-webkit-scrollbar-thumb{background:var(--green-mid);border-radius:6px;}

    /* ---- Sidebar (identical to admin.jsp) ---- */
    .adm-sidebar{width:var(--sidebar-w);min-height:100vh;background:var(--text);position:fixed;top:0;left:0;bottom:0;display:flex;flex-direction:column;z-index:200;overflow-y:auto;}
    .adm-logo{padding:1.5rem 1.4rem 1.3rem;border-bottom:1px solid rgba(255,255,255,.08);display:flex;align-items:center;gap:.7rem;}
    .adm-logo-img{height:36px;width:auto;filter:brightness(0) invert(1);}
    .adm-logo-brand{font-weight:900;font-size:1.08rem;color:#fff;letter-spacing:-.02em;line-height:1;}
    .adm-logo-sub{font-size:.6rem;font-weight:600;letter-spacing:.14em;text-transform:uppercase;color:rgba(255,255,255,.35);margin-top:.18rem;}
    .adm-nav{flex:1;padding:1rem .7rem;display:flex;flex-direction:column;gap:1px;}
    .adm-nav-label{font-size:.6rem;font-weight:700;letter-spacing:.18em;text-transform:uppercase;color:rgba(255,255,255,.28);padding:.85rem .75rem .35rem;margin-top:.5rem;}
    .adm-nav-link{display:flex;align-items:center;gap:.7rem;padding:.65rem .85rem;border-radius:10px;font-size:.82rem;font-weight:500;color:rgba(255,255,255,.52);transition:all .18s var(--ease);}
    .adm-nav-link:hover{color:#fff;background:rgba(255,255,255,.07);}
    .adm-nav-link.active{color:#fff;background:linear-gradient(135deg,var(--green) 0%,var(--accent) 100%);font-weight:700;}
    .adm-nav-link .nav-ico{width:20px;text-align:center;flex-shrink:0;display:flex;align-items:center;justify-content:center;}
    .adm-user{margin:.75rem;padding:.85rem 1rem;background:rgba(255,255,255,.06);border-radius:12px;border:1px solid rgba(255,255,255,.08);display:flex;align-items:center;gap:.65rem;}
    .adm-user-av{width:36px;height:36px;background:linear-gradient(135deg,var(--green) 0%,var(--accent) 100%);border-radius:50%;display:flex;align-items:center;justify-content:center;font-weight:800;font-size:.78rem;color:#fff;flex-shrink:0;}
    .adm-user-name{font-size:.8rem;font-weight:700;color:#fff;line-height:1.2;}
    .adm-user-role{font-size:.62rem;color:var(--accent);font-weight:600;}

    /* ---- Main area ---- */
    .adm-main{margin-left:var(--sidebar-w);flex:1;display:flex;flex-direction:column;min-height:100vh;}
    .adm-topbar{background:var(--white);border-bottom:1.5px solid var(--border);padding:0 2rem;height:68px;display:flex;align-items:center;justify-content:space-between;position:sticky;top:0;z-index:100;}
    .adm-topbar-title{font-size:1.3rem;font-weight:900;color:var(--text);letter-spacing:-.025em;}
    .adm-topbar-right{display:flex;align-items:center;gap:.75rem;}
    .adm-topbar-chip{display:inline-flex;align-items:center;gap:.38rem;background:var(--green-light);border:1.5px solid var(--green-mid);color:var(--green);padding:.3rem .85rem;border-radius:999px;font-size:.7rem;font-weight:700;}
    .adm-body{padding:2rem 2rem 5rem;flex:1;}

    /* ---- Profile layout ---- */
    .adm-profile-grid{display:grid;grid-template-columns:300px 1fr;gap:2rem;align-items:start;}

    /* Shared card */
    .ap-card{background:var(--white);border:1.5px solid var(--border);border-radius:20px;overflow:hidden;box-shadow:var(--shadow);}

    /* Avatar block */
    .ap-avatar-block{padding:2rem 1.5rem 1.5rem;text-align:center;border-bottom:1.5px solid var(--border);}
    .ap-avatar{width:84px;height:84px;border-radius:50%;background:linear-gradient(135deg,var(--green) 0%,var(--accent) 100%);display:flex;align-items:center;justify-content:center;font-size:2.1rem;font-weight:900;color:#fff;margin:0 auto 1rem;box-shadow:0 4px 20px rgba(26,107,56,.3);}
    .ap-avatar-name{font-size:1.1rem;font-weight:800;color:var(--text);margin-bottom:.2rem;letter-spacing:-.02em;}
    .ap-avatar-user{font-size:.78rem;color:var(--muted);}
    .ap-avatar-badge{display:inline-flex;align-items:center;gap:.3rem;margin-top:.65rem;padding:.25rem .75rem;background:rgba(201,164,82,.15);border:1.5px solid rgba(201,164,82,.3);color:var(--gold2);border-radius:999px;font-size:.68rem;font-weight:700;letter-spacing:.04em;}

    /* Sidebar nav */
    .ap-nav{padding:.65rem;}
    .ap-nav-item{display:flex;align-items:center;gap:.7rem;padding:.68rem .9rem;border-radius:11px;font-size:.83rem;font-weight:600;color:var(--muted);cursor:pointer;transition:all .18s;border:none;background:none;width:100%;text-align:left;font-family:var(--ff);}
    .ap-nav-item:hover{color:var(--text);background:var(--green-light);}
    .ap-nav-item.active{color:var(--green);background:var(--green-light);font-weight:700;}
    .ap-nav-ico{width:18px;display:flex;align-items:center;justify-content:center;flex-shrink:0;}

    /* Meta card */
    .ap-meta{padding:1.1rem 1.3rem;}
    .ap-meta-row{display:flex;align-items:center;justify-content:space-between;padding:.5rem 0;border-bottom:1px solid var(--border);font-size:.78rem;}
    .ap-meta-row:last-child{border-bottom:none;}
    .ap-meta-label{color:var(--muted);font-weight:500;}
    .ap-meta-val{font-weight:700;color:var(--text);}

    /* Panel */
    .ap-panel{background:var(--white);border:1.5px solid var(--border);border-radius:20px;overflow:hidden;box-shadow:var(--shadow);display:none;}
    .ap-panel.active{display:block;}
    .ap-panel-head{padding:1.4rem 1.75rem;border-bottom:1.5px solid var(--border);display:flex;align-items:center;justify-content:space-between;}
    .ap-panel-title{font-size:1.05rem;font-weight:900;color:var(--text);letter-spacing:-.02em;}
    .ap-panel-sub{font-size:.75rem;color:var(--muted);margin-top:.15rem;}
    .ap-panel-body{padding:1.75rem;}

    /* Form */
    .pf-row{display:grid;grid-template-columns:1fr 1fr;gap:1rem;margin-bottom:1rem;}
    .pf-row.single{grid-template-columns:1fr;}
    .pf-row.triple{grid-template-columns:1fr 1fr 1fr;}
    .fg{display:flex;flex-direction:column;gap:.38rem;}
    .fg label{font-size:.73rem;font-weight:700;color:var(--text);letter-spacing:.015em;}
    .fg input,.fg select{padding:.72rem .95rem;background:var(--bg);border:1.5px solid var(--border);border-radius:11px;font-family:var(--ff);font-size:.875rem;color:var(--text);outline:none;transition:all .2s var(--ease);}
    .fg input:focus,.fg select:focus{border-color:var(--green);background:var(--white);box-shadow:0 0 0 3px rgba(26,107,56,.08);}
    .fg input[readonly]{background:var(--surface);color:var(--muted);cursor:not-allowed;}
    .pf-save-row{display:flex;align-items:center;gap:.75rem;margin-top:1.5rem;padding-top:1.25rem;border-top:1.5px solid var(--border);}
    .pf-btn{padding:.72rem 1.75rem;border-radius:11px;font-family:var(--ff);font-size:.875rem;font-weight:700;cursor:pointer;transition:all .2s var(--ease);border:none;}
    .pf-btn-primary{background:linear-gradient(135deg,var(--green) 0%,var(--green2) 100%);color:#fff;box-shadow:0 3px 14px rgba(26,107,56,.28);}
    .pf-btn-primary:hover{transform:translateY(-2px);box-shadow:0 8px 26px rgba(26,107,56,.38);}

    /* Alerts */
    .pf-alert{display:flex;align-items:center;gap:.5rem;padding:.75rem 1rem;border-radius:11px;font-size:.82rem;font-weight:600;margin-bottom:1.25rem;}
    .pf-alert-success{background:var(--green-light);border:1.5px solid var(--green-mid);color:var(--green);}
    .pf-alert-error{background:#fff1f1;border:1.5px solid rgba(185,28,28,.2);color:#b91c1c;}

    /* KPI strip */
    .ap-kpi-strip{display:grid;grid-template-columns:repeat(3,1fr);gap:1rem;margin-bottom:1.5rem;}
    .ap-kpi{background:var(--white);border:1.5px solid var(--border);border-radius:16px;padding:1.25rem 1.3rem;box-shadow:var(--shadow);}
    .ap-kpi-num{font-size:1.6rem;font-weight:900;color:var(--text);letter-spacing:-.04em;margin-bottom:.18rem;}
    .ap-kpi-label{font-size:.7rem;font-weight:600;color:var(--muted);}

    @media(max-width:1000px){.adm-profile-grid{grid-template-columns:1fr;}}
    @media(max-width:900px){:root{--sidebar-w:0px;}.adm-sidebar{display:none;}.adm-main{margin-left:0;}}
    @media(max-width:640px){.pf-row,.pf-row.triple{grid-template-columns:1fr;}.ap-kpi-strip{grid-template-columns:1fr 1fr;}}
  </style>
</head>
<body>

<%-- SIDEBAR --%>
<aside class="adm-sidebar">
  <div class="adm-logo">
    <img src="${pageContext.request.contextPath}/static/images/alughadiweblogo.png" alt="AluGhadi" class="adm-logo-img" />
    <div>
      <div class="adm-logo-brand">AluGhadi</div>
      <div class="adm-logo-sub">Admin Panel</div>
    </div>
  </div>

  <nav class="adm-nav">
    <div class="adm-nav-label">Main</div>
    <a class="adm-nav-link" href="${pageContext.request.contextPath}/admin">
      <span class="nav-ico"><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/></svg></span>
      Dashboard
    </a>
    <a class="adm-nav-link" href="${pageContext.request.contextPath}/admin#products">
      <span class="nav-ico"><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><circle cx="12" cy="12" r="9"/><circle cx="12" cy="12" r="3"/><line x1="12" y1="3" x2="12" y2="9"/><line x1="12" y1="15" x2="12" y2="21"/></svg></span>
      Products
    </a>
    <div class="adm-nav-label">Account</div>
    <a class="adm-nav-link active" href="${pageContext.request.contextPath}/admin-profile">
      <span class="nav-ico"><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg></span>
      My Profile
    </a>
    <a class="adm-nav-link" href="${pageContext.request.contextPath}/logout">
      <span class="nav-ico"><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/></svg></span>
      Sign Out
    </a>
  </nav>

  <div class="adm-user">
    <div class="adm-user-av">${fn:toUpperCase(fn:substring(sessionScope.authUser,0,2))}</div>
    <div>
      <div class="adm-user-name">${sessionScope.authUser}</div>
      <div class="adm-user-role">Administrator</div>
    </div>
  </div>
</aside>

<%-- MAIN --%>
<div class="adm-main">
  <header class="adm-topbar">
    <div class="adm-topbar-title">My Profile</div>
    <div class="adm-topbar-right">
      <div class="adm-topbar-chip">
        <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/></svg>
        Admin Account
      </div>
      <a href="${pageContext.request.contextPath}/admin" class="pf-btn pf-btn-primary" style="text-decoration:none;font-size:.8rem;padding:.45rem 1.1rem;">
        &#8592; Back to Dashboard
      </a>
    </div>
  </header>

  <div class="adm-body">

    <%-- KPI strip --%>
    <div class="ap-kpi-strip">
      <div class="ap-kpi">
        <div class="ap-kpi-num">Rs <fmt:formatNumber value="${totalRevenue}" pattern="#,##0"/></div>
        <div class="ap-kpi-label">Total Revenue</div>
      </div>
      <div class="ap-kpi">
        <div class="ap-kpi-num">${totalOrders}</div>
        <div class="ap-kpi-label">Total Orders</div>
      </div>
      <div class="ap-kpi" style="border-color:var(--gold);">
        <div class="ap-kpi-num" style="color:var(--gold2);">Admin</div>
        <div class="ap-kpi-label">Account Role</div>
      </div>
    </div>

    <div class="adm-profile-grid">

      <%-- ===== SIDEBAR CARD ===== --%>
      <aside style="display:flex;flex-direction:column;gap:1rem;">

        <div class="ap-card">
          <div class="ap-avatar-block">
            <div class="ap-avatar">${fn:toUpperCase(fn:substring(profileUser.username,0,1))}</div>
            <div class="ap-avatar-name">
              <c:choose>
                <c:when test="${not empty profileUser.full_name}">${profileUser.full_name}</c:when>
                <c:otherwise>${profileUser.username}</c:otherwise>
              </c:choose>
            </div>
            <div class="ap-avatar-user">@${profileUser.username}</div>
            <div class="ap-avatar-badge">&#9733; Administrator</div>
          </div>

          <nav class="ap-nav">
            <button class="ap-nav-item active" data-target="info" onclick="switchPanel(this)">
              <span class="ap-nav-ico"><svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg></span>
              Personal Info
            </button>
            <button class="ap-nav-item" data-target="security" onclick="switchPanel(this)">
              <span class="ap-nav-ico"><svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/></svg></span>
              Password &amp; Security
            </button>
          </nav>
        </div>

        <div class="ap-card ap-meta">
          <div class="ap-meta-row">
            <span class="ap-meta-label">Member Since</span>
            <span class="ap-meta-val"><fmt:formatDate value="${profileUser.created_At}" pattern="MMM yyyy"/></span>
          </div>
          <div class="ap-meta-row">
            <span class="ap-meta-label">Role</span>
            <span class="ap-meta-val" style="color:var(--gold2);">Administrator</span>
          </div>
          <div class="ap-meta-row">
            <span class="ap-meta-label">Status</span>
            <span class="ap-meta-val" style="color:var(--green);">Active</span>
          </div>
        </div>

      </aside>

      <%-- ===== MAIN PANELS ===== --%>
      <div style="display:flex;flex-direction:column;gap:1.5rem;">

        <%-- Personal Info --%>
        <div class="ap-panel active" data-panel="info">
          <div class="ap-panel-head">
            <div>
              <div class="ap-panel-title">Personal Information</div>
              <div class="ap-panel-sub">Update your admin account details.</div>
            </div>
          </div>
          <div class="ap-panel-body">

            <c:if test="${not empty param.updated}">
              <div class="pf-alert pf-alert-success">
                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"><polyline points="20 6 9 17 4 12"/></svg>
                Profile updated successfully.
              </div>
            </c:if>
            <c:if test="${not empty profileError}">
              <div class="pf-alert pf-alert-error">
                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
                ${profileError}
              </div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/admin-profile">
              <input type="hidden" name="action" value="updateProfile" />

              <div class="pf-row">
                <div class="fg">
                  <label>Username</label>
                  <input type="text" value="${profileUser.username}" readonly />
                </div>
                <div class="fg">
                  <label>Email Address</label>
                  <input name="email" type="email" value="${profileUser.email}" placeholder="admin@example.com" />
                </div>
              </div>
              <div class="pf-row">
                <div class="fg">
                  <label>Full Name</label>
                  <input name="fullName" type="text" value="${profileUser.full_name}" placeholder="Full name" />
                </div>
                <div class="fg">
                  <label>Phone Number</label>
                  <input name="phone" type="tel" value="${profileUser.phone}" placeholder="98XXXXXXXX" />
                </div>
              </div>
              <div class="pf-row">
                <div class="fg">
                  <label>Gender</label>
                  <select name="gender">
                    <option value="">Select gender</option>
                    <option value="Male"   ${profileUser.gender == 'Male'   ? 'selected' : ''}>Male</option>
                    <option value="Female" ${profileUser.gender == 'Female' ? 'selected' : ''}>Female</option>
                    <option value="Other"  ${profileUser.gender == 'Other'  ? 'selected' : ''}>Other</option>
                  </select>
                </div>
                <div class="fg">
                  <label>City</label>
                  <input name="city" type="text" value="${profileUser.city}" placeholder="Kathmandu" />
                </div>
              </div>
              <div class="pf-save-row">
                <button type="submit" class="pf-btn pf-btn-primary">Save Changes</button>
              </div>
            </form>
          </div>
        </div>

        <%-- Password --%>
        <div class="ap-panel" data-panel="security">
          <div class="ap-panel-head">
            <div>
              <div class="ap-panel-title">Password &amp; Security</div>
              <div class="ap-panel-sub">Change your administrator password.</div>
            </div>
          </div>
          <div class="ap-panel-body">

            <c:if test="${not empty param.pwChanged}">
              <div class="pf-alert pf-alert-success">
                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"><polyline points="20 6 9 17 4 12"/></svg>
                Password changed successfully.
              </div>
            </c:if>
            <c:if test="${not empty pwError}">
              <div class="pf-alert pf-alert-error">
                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
                ${pwError}
              </div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/admin-profile" style="max-width:460px;">
              <input type="hidden" name="action" value="changePassword" />
              <div class="pf-row single">
                <div class="fg">
                  <label>Current Password</label>
                  <input name="currentPassword" type="password" placeholder="Enter current password" required />
                </div>
              </div>
              <div class="pf-row single">
                <div class="fg">
                  <label>New Password</label>
                  <input name="newPassword" type="password" placeholder="Min. 8 characters" required />
                </div>
              </div>
              <div class="pf-row single">
                <div class="fg">
                  <label>Confirm New Password</label>
                  <input name="confirmPassword" type="password" placeholder="Repeat new password" required />
                </div>
              </div>
              <div class="pf-save-row">
                <button type="submit" class="pf-btn pf-btn-primary">Change Password</button>
              </div>
            </form>
          </div>
        </div>

      </div>
    </div>
  </div>
</div>

<script>
  function switchPanel(btn) {
    document.querySelectorAll('.ap-nav-item').forEach(function(b) { b.classList.remove('active'); });
    document.querySelectorAll('.ap-panel[data-panel]').forEach(function(p) { p.classList.remove('active'); });
    btn.classList.add('active');
    var target = document.querySelector('.ap-panel[data-panel="' + btn.dataset.target + '"]');
    if (target) target.classList.add('active');
  }

  (function() {
    var params = new URLSearchParams(window.location.search);
    if (params.has('pwChanged')) {
      var btn = document.querySelector('.ap-nav-item[data-target="security"]');
      if (btn) switchPanel(btn);
    }
  })();
</script>
</body>
</html>
