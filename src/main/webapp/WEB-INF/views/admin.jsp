<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Admin Dashboard | AluGhadi</title>
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet" />
  <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
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
      --r:18px; --r-sm:11px;
      --ease:cubic-bezier(0.16,1,0.3,1);
      --shadow:0 2px 16px rgba(10,30,15,.07);
      --shadow-md:0 6px 28px rgba(10,30,15,.10);
      --shadow-lg:0 14px 52px rgba(10,30,15,.14);
      --sidebar-w:260px;
    }
    *,*::before,*::after{margin:0;padding:0;box-sizing:border-box;}
    html{scroll-behavior:smooth;}
    body{font-family:var(--ff);background:var(--bg);color:var(--text);font-size:15px;line-height:1.6;-webkit-font-smoothing:antialiased;display:flex;min-height:100vh;}
    a{text-decoration:none;color:inherit;}
    img{max-width:100%;display:block;}
    button{cursor:pointer;font-family:var(--ff);}
    ::-webkit-scrollbar{width:5px;height:5px;}
    ::-webkit-scrollbar-track{background:var(--bg);}
    ::-webkit-scrollbar-thumb{background:var(--green-mid);border-radius:6px;}
    ::-webkit-scrollbar-thumb:hover{background:var(--green);}

    /* SIDEBAR */
    .adm-sidebar{width:var(--sidebar-w);min-height:100vh;background:var(--text);position:fixed;top:0;left:0;bottom:0;display:flex;flex-direction:column;z-index:200;overflow-y:auto;overflow-x:hidden;}
    .adm-logo{padding:1.5rem 1.4rem 1.3rem;border-bottom:1px solid rgba(255,255,255,.08);display:flex;align-items:center;gap:.7rem;}
    .adm-logo-img{height:36px;width:auto;display:block;filter:brightness(0) invert(1);flex-shrink:0;}
    .adm-logo-brand{font-weight:900;font-size:1.08rem;color:#fff;letter-spacing:-.02em;line-height:1;}
    .adm-logo-sub{font-size:.6rem;font-weight:600;letter-spacing:.14em;text-transform:uppercase;color:rgba(255,255,255,.35);margin-top:.18rem;}
    .adm-nav{flex:1;padding:1rem .7rem;display:flex;flex-direction:column;gap:1px;}
    .adm-nav-label{font-size:.6rem;font-weight:700;letter-spacing:.18em;text-transform:uppercase;color:rgba(255,255,255,.28);padding:.85rem .75rem .35rem;margin-top:.5rem;}
    .adm-nav-item{display:flex;align-items:center;gap:.7rem;padding:.65rem .85rem;border-radius:10px;font-size:.82rem;font-weight:500;color:rgba(255,255,255,.52);transition:all .18s var(--ease);cursor:pointer;border:none;background:none;width:100%;text-align:left;}
    .adm-nav-item:hover{color:#fff;background:rgba(255,255,255,.07);}
    .adm-nav-item.active{color:#fff;background:linear-gradient(135deg,var(--green) 0%,var(--accent) 100%);font-weight:700;box-shadow:0 4px 14px rgba(26,107,56,.38);}
    .adm-nav-item .nav-ico{width:20px;text-align:center;flex-shrink:0;display:flex;align-items:center;justify-content:center;}
    .adm-nav-link{display:flex;align-items:center;gap:.7rem;padding:.65rem .85rem;border-radius:10px;font-size:.82rem;font-weight:500;color:rgba(255,255,255,.52);transition:all .18s var(--ease);}
    .adm-nav-link:hover{color:#fff;background:rgba(255,255,255,.07);}
    .adm-nav-link .nav-ico{width:20px;text-align:center;flex-shrink:0;display:flex;align-items:center;justify-content:center;}
    .adm-user{margin:.75rem;padding:.85rem 1rem;background:rgba(255,255,255,.06);border-radius:12px;border:1px solid rgba(255,255,255,.08);display:flex;align-items:center;gap:.65rem;}
    .adm-user-av{width:36px;height:36px;background:linear-gradient(135deg,var(--green) 0%,var(--accent) 100%);border-radius:50%;display:flex;align-items:center;justify-content:center;font-weight:800;font-size:.78rem;color:#fff;flex-shrink:0;}
    .adm-user-name{font-size:.8rem;font-weight:700;color:#fff;line-height:1.2;}
    .adm-user-role{font-size:.62rem;color:var(--accent);font-weight:600;}

    /* MAIN */
    .adm-main{margin-left:var(--sidebar-w);flex:1;display:flex;flex-direction:column;min-height:100vh;}
    .adm-topbar{background:var(--white);border-bottom:1.5px solid var(--border);padding:0 2rem;height:68px;display:flex;align-items:center;justify-content:space-between;position:sticky;top:0;z-index:100;}
    .adm-topbar-title{font-size:1.3rem;font-weight:900;color:var(--text);letter-spacing:-.025em;}
    .adm-topbar-right{display:flex;align-items:center;gap:.75rem;}
    .adm-topbar-chip{display:inline-flex;align-items:center;gap:.38rem;background:var(--green-light);border:1.5px solid var(--green-mid);color:var(--green);padding:.3rem .85rem;border-radius:999px;font-size:.7rem;font-weight:700;}
    .topbar-dot{width:7px;height:7px;background:var(--accent);border-radius:50%;animation:pulse 2s ease-in-out infinite;}
    @keyframes pulse{0%,100%{opacity:1;transform:scale(1)}50%{opacity:.5;transform:scale(.78)}}
    .adm-body{padding:2rem 2rem 5rem;flex:1;}

    .sec-head{margin-bottom:1.75rem;}
    .sec-head-title{font-size:1.55rem;font-weight:900;letter-spacing:-.03em;color:var(--text);}
    .sec-head-sub{font-size:.82rem;color:var(--muted);margin-top:.18rem;}

    /* KPI */
    .kpi-grid{display:grid;grid-template-columns:repeat(4,1fr);gap:1.2rem;margin-bottom:1.85rem;}
    .kpi-card{background:var(--white);border:1.5px solid var(--border);border-radius:20px;padding:1.5rem 1.4rem;position:relative;overflow:hidden;transition:all .3s var(--ease);}
    .kpi-card:hover{transform:translateY(-4px);box-shadow:var(--shadow-lg);border-color:var(--green-mid);}
    .kpi-glow{position:absolute;top:-28px;right:-28px;width:105px;height:105px;border-radius:50%;opacity:.08;}
    .kpi-top{display:flex;align-items:center;justify-content:space-between;margin-bottom:1rem;}
    .kpi-ico{width:44px;height:44px;border-radius:13px;display:flex;align-items:center;justify-content:center;}
    .kpi-badge{font-size:.68rem;font-weight:700;padding:.2rem .58rem;border-radius:999px;}
    .kpi-num{font-size:2rem;font-weight:900;letter-spacing:-.04em;line-height:1;color:var(--text);margin-bottom:.22rem;}
    .kpi-label{font-size:.72rem;font-weight:600;color:var(--muted);letter-spacing:.02em;}

    /* Charts grid */
    .dash-mid{display:grid;grid-template-columns:1fr 320px;gap:1.25rem;margin-bottom:1.85rem;}
    .card{background:var(--white);border:1.5px solid var(--border);border-radius:20px;overflow:hidden;}
    .card-head{padding:1.25rem 1.5rem 0;display:flex;align-items:center;justify-content:space-between;margin-bottom:1rem;}
    .card-head-title{font-size:1rem;font-weight:900;letter-spacing:-.02em;color:var(--text);}
    .card-head-sub{font-size:.7rem;color:var(--muted);font-weight:500;margin-top:.1rem;}
    .card-body{padding:0 1.5rem 1.5rem;}
    .chart-wrap{height:235px;position:relative;}
    .chart-range-select{font-family:var(--ff);font-size:.73rem;padding:.3rem .65rem;border-radius:8px;border:1.5px solid var(--border);background:var(--bg);color:var(--text);cursor:pointer;outline:none;}

    .qs-list{display:flex;flex-direction:column;}
    .qs-item{display:flex;align-items:center;justify-content:space-between;padding:.82rem 0;border-bottom:1px solid var(--border);}
    .qs-item:last-child{border-bottom:none;}
    .qs-left{display:flex;align-items:center;gap:.6rem;}
    .qs-dot{width:10px;height:10px;border-radius:50%;flex-shrink:0;}
    .qs-name{font-size:.81rem;font-weight:600;color:var(--text);}
    .qs-cat{font-size:.67rem;color:var(--muted);margin-top:.04rem;}
    .qs-val{font-size:.95rem;font-weight:900;color:var(--text);letter-spacing:-.02em;}

    /* Table */
    .table-card{margin-bottom:1.85rem;}
    .table-toolbar{padding:1.25rem 1.5rem;display:flex;align-items:center;justify-content:space-between;gap:1rem;flex-wrap:wrap;border-bottom:1.5px solid var(--border);}
    .table-search{display:flex;align-items:center;gap:.5rem;background:var(--bg);border:1.5px solid var(--border);border-radius:var(--r-sm);padding:.45rem .85rem;min-width:200px;}
    .table-search input{border:none;background:transparent;font-family:var(--ff);font-size:.81rem;color:var(--text);outline:none;width:100%;}
    .table-search input::placeholder{color:var(--dim);}
    table{width:100%;border-collapse:collapse;}
    thead th{font-size:.65rem;font-weight:700;letter-spacing:.1em;text-transform:uppercase;color:var(--muted);padding:.72rem 1.25rem;background:var(--surface2);text-align:left;border-bottom:1.5px solid var(--border);}
    tbody tr{border-bottom:1px solid var(--border);transition:background .15s;}
    tbody tr:last-child{border-bottom:none;}
    tbody tr:hover{background:var(--surface2);}
    tbody td{padding:.88rem 1.25rem;font-size:.81rem;font-weight:500;color:var(--text);vertical-align:middle;}
    .td-thumb{width:44px;height:44px;border-radius:10px;background:var(--surface);border:1.5px solid var(--border);display:flex;align-items:center;justify-content:center;}
    .td-name{font-weight:700;color:var(--text);}
    .td-desc{font-size:.7rem;color:var(--muted);margin-top:.06rem;}
    .td-price{font-weight:900;letter-spacing:-.02em;}
    .stock-yes{display:inline-flex;align-items:center;gap:.35rem;color:var(--green);font-weight:700;font-size:.7rem;}
    .stock-no{display:inline-flex;align-items:center;gap:.35rem;color:var(--red);font-weight:700;font-size:.7rem;}
    .stock-yes::before,.stock-no::before{content:'';width:7px;height:7px;border-radius:50%;flex-shrink:0;}
    .stock-yes::before{background:var(--green);}
    .stock-no::before{background:var(--red);}
    .cat-pill{font-size:.68rem;font-weight:700;padding:.18rem .6rem;border-radius:999px;background:var(--surface);border:1.5px solid var(--border);color:var(--muted);}
    .tbl-actions{display:flex;gap:.4rem;align-items:center;}
    .tbl-btn{border:none;border-radius:8px;padding:.35rem .65rem;font-size:.7rem;font-weight:700;font-family:var(--ff);transition:all .18s;}
    .tbl-btn-edit{background:var(--green-light);color:var(--green);}
    .tbl-btn-edit:hover{background:var(--green);color:#fff;}
    .tbl-btn-del{background:#fff1f1;color:var(--red);}
    .tbl-btn-del:hover{background:var(--red);color:#fff;}

    /* Buttons */
    .btn{display:inline-flex;align-items:center;gap:.45rem;padding:.7rem 1.45rem;border-radius:var(--r-sm);font-family:var(--ff);font-weight:700;font-size:.81rem;cursor:pointer;border:none;transition:all .22s var(--ease);white-space:nowrap;text-decoration:none;}
    .btn-g{background:linear-gradient(135deg,var(--green) 0%,var(--green2) 100%);color:#fff;box-shadow:0 3px 14px rgba(26,107,56,.28);}
    .btn-g:hover{transform:translateY(-2px);box-shadow:0 8px 26px rgba(26,107,56,.38);}
    .btn-o{background:var(--white);color:var(--text);border:1.5px solid var(--border2);}
    .btn-o:hover{border-color:var(--green);color:var(--green);background:var(--green-light);}
    .btn-r{background:#fff1f1;color:var(--red);border:1.5px solid rgba(200,60,60,.18);}
    .btn-r:hover{background:var(--red);color:#fff;}

    /* Analytics */
    .analytics-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:1.25rem;margin-bottom:1.85rem;}
    .mini-stat{background:var(--white);border:1.5px solid var(--border);border-radius:16px;padding:1.25rem 1.35rem;}
    .mini-stat-label{font-size:.68rem;font-weight:700;color:var(--muted);letter-spacing:.06em;text-transform:uppercase;margin-bottom:.55rem;}
    .mini-stat-val{font-size:1.65rem;font-weight:900;letter-spacing:-.04em;color:var(--text);margin-bottom:.18rem;}
    .mini-stat-sub{font-size:.7rem;color:var(--muted);}
    .mini-stat-up{color:var(--green);font-weight:700;}
    .mini-stat-down{color:var(--red);font-weight:700;}

    /* Customers section */
    .cust-grid{display:grid;grid-template-columns:repeat(2,1fr);gap:1.25rem;margin-bottom:1.85rem;}

    /* Modal */
    .modal-bg{position:fixed;inset:0;background:rgba(8,20,12,.55);backdrop-filter:blur(6px);z-index:400;display:none;align-items:center;justify-content:center;padding:1rem;}
    .modal-bg.open{display:flex;}
    .modal{background:var(--white);border-radius:24px;width:100%;max-width:560px;max-height:90vh;overflow-y:auto;box-shadow:0 32px 96px rgba(8,20,12,.26);animation:modalIn .3s var(--ease) both;}
    @keyframes modalIn{from{opacity:0;transform:translateY(22px) scale(.97)}to{opacity:1;transform:none}}
    .modal-head{padding:1.4rem 1.6rem 1rem;display:flex;align-items:center;justify-content:space-between;border-bottom:1.5px solid var(--border);}
    .modal-title{font-size:1.2rem;font-weight:900;letter-spacing:-.025em;color:var(--text);}
    .modal-close{border:none;background:var(--surface);width:33px;height:33px;border-radius:50%;font-size:.95rem;display:flex;align-items:center;justify-content:center;color:var(--muted);transition:all .18s;}
    .modal-close:hover{background:#fff1f1;color:var(--red);}
    .modal-body{padding:1.4rem 1.6rem;}
    .modal-foot{padding:.95rem 1.6rem 1.4rem;display:flex;gap:.7rem;justify-content:flex-end;border-top:1.5px solid var(--border);}
    .fg{margin-bottom:1.1rem;}
    .fg label{display:block;font-size:.7rem;font-weight:700;color:var(--text2);margin-bottom:.42rem;letter-spacing:.025em;}
    .fg input,.fg select,.fg textarea{width:100%;background:var(--bg);border:1.5px solid var(--border);border-radius:var(--r-sm);padding:.72rem .95rem;font-family:var(--ff);font-size:.83rem;color:var(--text);outline:none;transition:all .2s var(--ease);appearance:none;}
    .fg input:focus,.fg select:focus,.fg textarea:focus{border-color:var(--green);background:var(--white);box-shadow:0 0 0 3px rgba(26,107,56,.08);}
    .fg textarea{resize:vertical;min-height:86px;}
    .fg-row{display:grid;grid-template-columns:1fr 1fr;gap:.82rem;}
    .toggle-wrap{display:flex;align-items:center;gap:.7rem;}
    .toggle{position:relative;width:44px;height:24px;}
    .toggle input{opacity:0;width:0;height:0;}
    .toggle-track{position:absolute;inset:0;background:var(--border2);border-radius:12px;transition:background .22s;}
    .toggle input:checked~.toggle-track{background:var(--green);}
    .toggle-thumb{position:absolute;top:2px;left:2px;width:20px;height:20px;background:#fff;border-radius:50%;box-shadow:0 2px 6px rgba(0,0,0,.2);transition:transform .22s var(--ease);}
    .toggle input:checked~.toggle-thumb{transform:translateX(20px);}
    .toggle-label{font-size:.81rem;font-weight:600;color:var(--text);}
    .del-ico{width:62px;height:62px;background:#fff1f1;border-radius:50%;margin:0 auto 1rem;display:flex;align-items:center;justify-content:center;}
    .toast-container{position:fixed;top:1.2rem;right:1.2rem;z-index:600;display:flex;flex-direction:column;gap:.5rem;pointer-events:none;}
    .toast{background:var(--text);color:#fff;padding:.82rem 1.25rem;border-radius:13px;font-size:.8rem;font-weight:600;display:flex;align-items:center;gap:.6rem;box-shadow:var(--shadow-lg);animation:toastIn .3s var(--ease) both;pointer-events:auto;max-width:300px;}
    @keyframes toastIn{from{opacity:0;transform:translateX(22px)}to{opacity:1;transform:none}}
    .toast.success{background:var(--green);}
    .toast.error{background:var(--red);}

    @media(max-width:1200px){.kpi-grid{grid-template-columns:repeat(2,1fr);}.dash-mid{grid-template-columns:1fr;}.analytics-grid{grid-template-columns:repeat(2,1fr);}.cust-grid{grid-template-columns:1fr;}}
    @media(max-width:900px){:root{--sidebar-w:0px;}.adm-sidebar{transform:translateX(-100%);transition:transform .3s var(--ease);}.adm-sidebar.open{transform:none;width:260px;}.adm-main{margin-left:0;}.adm-body{padding:1.5rem 1.2rem 4rem;}.analytics-grid{grid-template-columns:1fr;}.fg-row{grid-template-columns:1fr;}}
    @media(max-width:600px){.kpi-grid{grid-template-columns:1fr;}.table-toolbar{flex-direction:column;align-items:stretch;}}
  </style>
</head>
<body>

<c:if test="${not empty errorMessage}">
  <div style="background:#ffe5e5;color:#9b1c1c;padding:12px 16px;border-radius:6px;margin:16px;font-weight:700;">${errorMessage}</div>
</c:if>

<!-- SIDEBAR -->
<aside class="adm-sidebar" id="admSidebar">
  <div class="adm-logo">
    <img src="${pageContext.request.contextPath}/static/images/alughadiweblogo.png" alt="AluGhadi" class="adm-logo-img" />
    <div>
      <div class="adm-logo-brand">AluGhadi</div>
      <div class="adm-logo-sub">Admin Panel</div>
    </div>
  </div>

  <nav class="adm-nav">
    <div class="adm-nav-label">Main</div>
    <button class="adm-nav-item active" onclick="showSection('dashboard',this)">
      <span class="nav-ico">
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/></svg>
      </span> Dashboard
    </button>
    <button class="adm-nav-item" onclick="showSection('products',this)">
      <span class="nav-ico">
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="9"/><circle cx="12" cy="12" r="3"/><line x1="12" y1="3" x2="12" y2="9"/><line x1="12" y1="15" x2="12" y2="21"/></svg>
      </span> Products
    </button>
    <button class="adm-nav-item" onclick="showSection('customers',this)">
      <span class="nav-ico">
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
      </span> Customers
    </button>
    <div class="adm-nav-label">Analytics</div>
    <button class="adm-nav-item" onclick="showSection('analytics',this)">
      <span class="nav-ico">
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="20" x2="18" y2="10"/><line x1="12" y1="20" x2="12" y2="4"/><line x1="6" y1="20" x2="6" y2="14"/></svg>
      </span> Analytics
    </button>
    <div class="adm-nav-label">Account</div>
    <a class="adm-nav-link" href="${pageContext.request.contextPath}/logout">
      <span class="nav-ico">
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/></svg>
      </span> Sign Out
    </a>
  </nav>

  <div class="adm-user">
    <div class="adm-user-av"><c:choose><c:when test="${not empty sessionScope.authUser}">${fn:toUpperCase(fn:substring(sessionScope.authUser,0,2))}</c:when><c:otherwise>AD</c:otherwise></c:choose></div>
    <div>
      <div class="adm-user-name">${not empty sessionScope.authUser ? sessionScope.authUser : 'Administrator'}</div>
      <div class="adm-user-role">Administrator</div>
    </div>
  </div>
</aside>

<!-- MAIN -->
<div class="adm-main">
  <header class="adm-topbar">
    <div class="adm-topbar-title" id="topbarTitle">Dashboard</div>
    <div class="adm-topbar-right">
      <div class="adm-topbar-chip">
        <span class="topbar-dot"></span> Live
      </div>
      <button class="btn btn-g" onclick="openAddModal()">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
        Add Product
      </button>
    </div>
  </header>

  <div class="adm-body">

    <!-- DASHBOARD SECTION -->
    <div id="sec-dashboard">
      <div class="sec-head">
        <div class="sec-head-title">Overview</div>
        <div class="sec-head-sub">Welcome back — here is what is happening today.</div>
      </div>

      <!-- KPI Cards -->
      <div class="kpi-grid">
        <div class="kpi-card">
          <div class="kpi-glow" style="background:var(--green)"></div>
          <div class="kpi-top">
            <div class="kpi-ico" style="background:var(--green-light);color:var(--green);">
              <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="9"/><circle cx="12" cy="12" r="3"/><line x1="12" y1="3" x2="12" y2="9"/><line x1="12" y1="15" x2="12" y2="21"/></svg>
            </div>
            <span class="kpi-badge" style="background:var(--gold-light);color:var(--gold2);">Catalogue</span>
          </div>
          <div class="kpi-num">${productCount}</div>
          <div class="kpi-label">Total Products</div>
        </div>
        <div class="kpi-card">
          <div class="kpi-glow" style="background:var(--green)"></div>
          <div class="kpi-top">
            <div class="kpi-ico" style="background:var(--green-light);color:var(--green);">
              <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="9 11 12 14 22 4"/><path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11"/></svg>
            </div>
            <span class="kpi-badge" style="background:var(--green-light);color:var(--green);">Available</span>
          </div>
          <div class="kpi-num">${inStockCount}</div>
          <div class="kpi-label">Products In Stock</div>
        </div>
        <div class="kpi-card">
          <div class="kpi-glow" style="background:var(--red)"></div>
          <div class="kpi-top">
            <div class="kpi-ico" style="background:#fff1f1;color:var(--red);">
              <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><line x1="15" y1="9" x2="9" y2="15"/><line x1="9" y1="9" x2="15" y2="15"/></svg>
            </div>
            <span class="kpi-badge" style="background:#fff1f1;color:var(--red);">Low</span>
          </div>
          <div class="kpi-num">${outOfStockCount}</div>
          <div class="kpi-label">Out of Stock</div>
        </div>
        <div class="kpi-card">
          <div class="kpi-glow" style="background:var(--blue)"></div>
          <div class="kpi-top">
            <div class="kpi-ico" style="background:var(--blue-light);color:var(--blue);">
              <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
            </div>
            <span class="kpi-badge" style="background:var(--blue-light);color:var(--blue);">Registered</span>
          </div>
          <div class="kpi-num">${customerCount}</div>
          <div class="kpi-label">Customers</div>
        </div>
      </div>

      <!-- Charts -->
      <div class="dash-mid">
        <div class="card">
          <div class="card-head">
            <div>
              <div class="card-head-title">Products by Category</div>
              <div class="card-head-sub">Distribution across all categories</div>
            </div>
          </div>
          <div class="card-body">
            <div class="chart-wrap"><canvas id="categoryChart"></canvas></div>
          </div>
        </div>
        <div class="card">
          <div class="card-head">
            <div>
              <div class="card-head-title">Stock Overview</div>
              <div class="card-head-sub">In stock vs out of stock</div>
            </div>
          </div>
          <div class="card-body" style="display:flex;align-items:center;justify-content:center;padding-top:1rem;">
            <div style="width:200px;height:200px;"><canvas id="stockChart"></canvas></div>
          </div>
        </div>
      </div>

      <!-- Product table -->
      <div class="card table-card">
        <div class="table-toolbar">
          <div>
            <div class="card-head-title">Product Catalogue</div>
            <div class="card-head-sub" id="dashProductCount">Loading...</div>
          </div>
          <div style="display:flex;gap:.7rem;align-items:center;flex-wrap:wrap;">
            <div class="table-search">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
              <input type="text" id="dashSearch" placeholder="Search products..." oninput="filterDashTable()" />
            </div>
            <button class="btn btn-g" onclick="openAddModal()">
              <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
              Add Product
            </button>
          </div>
        </div>
        <div style="overflow-x:auto;">
          <table>
            <thead>
              <tr><th>#</th><th>Product</th><th>Brand</th><th>Category</th><th>Price</th><th>Stock</th><th>Rating</th><th>Actions</th></tr>
            </thead>
            <tbody id="dashTbody">
              <c:forEach var="p" items="${products}">
                <tr data-id="${p.id}" data-name="<c:out value='${p.name}'/>" data-brand="<c:out value='${p.brand}'/>"
                    data-category-name="<c:out value='${p.categoryName}'/>" data-category-id="${p.categoryId}"
                    data-price="${p.price}" data-oldprice="${empty p.oldPrice ? 0 : p.oldPrice}"
                    data-rating="${p.rating}" data-in-stock="${p.inStock}" data-stock-quantity="${p.stockQuantity}"
                    data-description="<c:out value='${p.description}'/>" data-image-url="<c:out value='${p.imageUrl}'/>">
                  <td style="color:var(--dim);font-size:.75rem;">${p.id}</td>
                  <td>
                    <div style="display:flex;align-items:center;gap:.75rem;">
                      <c:choose>
                        <c:when test="${not empty p.imageUrl}">
                          <img src="${pageContext.request.contextPath}${p.imageUrl}" style="width:44px;height:44px;border-radius:10px;object-fit:cover;border:1.5px solid var(--border);" alt="<c:out value='${p.name}'/>" />
                        </c:when>
                        <c:otherwise><div class="td-thumb"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5"><rect x="3" y="3" width="18" height="18" rx="2"/><circle cx="8.5" cy="8.5" r="1.5"/><polyline points="21 15 16 10 5 21"/></svg></div></c:otherwise>
                      </c:choose>
                      <div>
                        <div class="td-name"><c:out value="${p.name}" /></div>
                        <div class="td-desc"><c:out value="${p.brand}" /></div>
                      </div>
                    </div>
                  </td>
                  <td><c:out value="${p.brand}" /></td>
                  <td><span class="cat-pill"><c:out value="${p.categoryName}" /></span></td>
                  <td class="td-price">Rs <fmt:formatNumber value="${p.price}" pattern="#,##0" /></td>
                  <td><span class="${p.stockQuantity > 0 ? 'stock-yes' : 'stock-no'}">${p.stockQuantity > 0 ? 'In Stock' : 'Out of Stock'}</span></td>
                  <td><span style="color:var(--gold);font-size:.78rem;">&#9733;</span> <span style="font-size:.76rem;font-weight:700;">${p.rating}</span></td>
                  <td>
                    <div class="tbl-actions">
                      <button class="tbl-btn tbl-btn-edit" type="button" onclick="openEditModal(this.closest('tr'))">Edit</button>
                      <button class="tbl-btn tbl-btn-del"  type="button" onclick="openDelModal(this.closest('tr'))">Delete</button>
                    </div>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
    </div><!-- /sec-dashboard -->

    <!-- PRODUCTS SECTION -->
    <div id="sec-products" style="display:none">
      <div class="sec-head" style="display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:1rem;">
        <div>
          <div class="sec-head-title">Product Management</div>
          <div class="sec-head-sub">Add, edit, and remove products from the store catalogue.</div>
        </div>
        <button class="btn btn-g" onclick="openAddModal()">
          <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
          Add New Product
        </button>
      </div>

      <div class="analytics-grid" style="margin-bottom:1.85rem;">
        <div class="mini-stat">
          <div class="mini-stat-label">Total Products</div>
          <div class="mini-stat-val" id="pStatTotal">${productCount}</div>
          <div class="mini-stat-sub">in catalogue</div>
        </div>
        <div class="mini-stat">
          <div class="mini-stat-label">In Stock</div>
          <div class="mini-stat-val" id="pStatInStock">${inStockCount}</div>
          <div class="mini-stat-sub"><span class="mini-stat-up">&#8593;</span> available</div>
        </div>
        <div class="mini-stat">
          <div class="mini-stat-label">Out of Stock</div>
          <div class="mini-stat-val" id="pStatOut">${outOfStockCount}</div>
          <div class="mini-stat-sub"><span class="mini-stat-down">&#8595;</span> need restock</div>
        </div>
      </div>

      <div class="card table-card">
        <div class="table-toolbar">
          <div>
            <div class="card-head-title">All Products</div>
            <div class="card-head-sub" id="prodMgmtCount">${productCount} products</div>
          </div>
          <div style="display:flex;gap:.7rem;align-items:center;flex-wrap:wrap;">
            <select id="filterCat" onchange="filterProdTable()" style="font-family:var(--ff);font-size:.78rem;padding:.42rem .75rem;border-radius:var(--r-sm);border:1.5px solid var(--border);background:var(--bg);color:var(--text);outline:none;">
              <option value="">All Categories</option>
              <option value="Luxury">Luxury</option>
              <option value="Sports">Sports</option>
              <option value="Smart">Smart</option>
              <option value="Classic">Classic</option>
              <option value="Womens">Womens</option>
            </select>
            <div class="table-search">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
              <input type="text" id="prodSearch" placeholder="Search..." oninput="filterProdTable()" />
            </div>
          </div>
        </div>
        <div style="overflow-x:auto;">
          <table>
            <thead>
              <tr><th>#</th><th>Product</th><th>Brand</th><th>Category</th><th>Price</th><th>Old Price</th><th>Stock</th><th>Rating</th><th>Actions</th></tr>
            </thead>
            <tbody id="prodMgmtTbody">
              <c:forEach var="p" items="${products}">
                <tr data-id="${p.id}" data-name="<c:out value='${p.name}'/>" data-brand="<c:out value='${p.brand}'/>"
                    data-category-name="<c:out value='${p.categoryName}'/>" data-category-id="${p.categoryId}"
                    data-price="${p.price}" data-oldprice="${empty p.oldPrice ? 0 : p.oldPrice}"
                    data-stock-quantity="${p.stockQuantity}" data-rating="${p.rating}" data-in-stock="${p.inStock}"
                    data-description="<c:out value='${p.description}'/>" data-image-url="<c:out value='${p.imageUrl}'/>">
                  <td style="color:var(--dim);font-size:.75rem;">${p.id}</td>
                  <td>
                    <div style="display:flex;align-items:center;gap:.75rem;">
                      <c:choose>
                        <c:when test="${not empty p.imageUrl}">
                          <img src="${pageContext.request.contextPath}${p.imageUrl}" style="width:44px;height:44px;border-radius:10px;object-fit:cover;border:1.5px solid var(--border);" alt="<c:out value='${p.name}'/>" />
                        </c:when>
                        <c:otherwise><div class="td-thumb"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5"><rect x="3" y="3" width="18" height="18" rx="2"/><circle cx="8.5" cy="8.5" r="1.5"/><polyline points="21 15 16 10 5 21"/></svg></div></c:otherwise>
                      </c:choose>
                      <div>
                        <div class="td-name"><c:out value="${p.name}" /></div>
                        <div class="td-desc"><c:out value="${p.brand}" /></div>
                      </div>
                    </div>
                  </td>
                  <td><c:out value="${p.brand}" /></td>
                  <td><span class="cat-pill"><c:out value="${p.categoryName}" /></span></td>
                  <td class="td-price">Rs <fmt:formatNumber value="${p.price}" pattern="#,##0" /></td>
                  <td><c:choose><c:when test="${not empty p.oldPrice}">Rs <fmt:formatNumber value="${p.oldPrice}" pattern="#,##0" /></c:when><c:otherwise>&mdash;</c:otherwise></c:choose></td>
                  <td><span class="${p.stockQuantity > 0 ? 'stock-yes' : 'stock-no'}">${p.stockQuantity > 0 ? 'In Stock' : 'Out of Stock'}</span></td>
                  <td><span style="color:var(--gold);font-size:.78rem;">&#9733;</span> <span style="font-size:.76rem;font-weight:700;">${p.rating}</span></td>
                  <td>
                    <div class="tbl-actions">
                      <button class="tbl-btn tbl-btn-edit" type="button" onclick="openEditModal(this.closest('tr'))">Edit</button>
                      <button class="tbl-btn tbl-btn-del"  type="button" onclick="openDelModal(this.closest('tr'))">Delete</button>
                    </div>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
    </div><!-- /sec-products -->

    <!-- CUSTOMERS SECTION -->
    <div id="sec-customers" style="display:none">
      <div class="sec-head">
        <div class="sec-head-title">Customers</div>
        <div class="sec-head-sub">Registered customer accounts.</div>
      </div>
      <div class="cust-grid">
        <div class="mini-stat">
          <div class="mini-stat-label">Total Customers</div>
          <div class="mini-stat-val">${customerCount}</div>
          <div class="mini-stat-sub">registered accounts</div>
        </div>
        <div class="mini-stat">
          <div class="mini-stat-label">Total Products</div>
          <div class="mini-stat-val">${productCount}</div>
          <div class="mini-stat-sub">in catalogue</div>
        </div>
      </div>
      <div class="card">
        <div class="card-head">
          <div>
            <div class="card-head-title">Customer Growth</div>
            <div class="card-head-sub">Registrations over time (demo data)</div>
          </div>
        </div>
        <div class="card-body">
          <div class="chart-wrap"><canvas id="customerChart"></canvas></div>
        </div>
      </div>
    </div><!-- /sec-customers -->

    <!-- ANALYTICS SECTION -->
    <div id="sec-analytics" style="display:none">
      <div class="sec-head">
        <div class="sec-head-title">Analytics</div>
        <div class="sec-head-sub">Product and inventory overview.</div>
      </div>
      <div class="analytics-grid">
        <div class="mini-stat">
          <div class="mini-stat-label">Total Products</div>
          <div class="mini-stat-val">${productCount}</div>
          <div class="mini-stat-sub">in catalogue</div>
        </div>
        <div class="mini-stat">
          <div class="mini-stat-label">In Stock</div>
          <div class="mini-stat-val">${inStockCount}</div>
          <div class="mini-stat-sub"><span class="mini-stat-up">&#8593;</span> available now</div>
        </div>
        <div class="mini-stat">
          <div class="mini-stat-label">Out of Stock</div>
          <div class="mini-stat-val">${outOfStockCount}</div>
          <div class="mini-stat-sub"><span class="mini-stat-down">&#8595;</span> need restock</div>
        </div>
      </div>
      <div class="card">
        <div class="card-head">
          <div>
            <div class="card-head-title">Price Range Distribution</div>
            <div class="card-head-sub">Products by price bracket</div>
          </div>
        </div>
        <div class="card-body">
          <div class="chart-wrap"><canvas id="priceChart"></canvas></div>
        </div>
      </div>
    </div><!-- /sec-analytics -->

  </div><!-- /adm-body -->
</div><!-- /adm-main -->

<!-- ADD/EDIT MODAL -->
<div class="modal-bg" id="productModal">
  <div class="modal" role="dialog" aria-modal="true" aria-labelledby="modalTitle">
    <div class="modal-head">
      <div class="modal-title" id="modalTitle">Add New Product</div>
      <button class="modal-close" onclick="closeProductModal()" aria-label="Close">&#10005;</button>
    </div>
    <div class="modal-body">
      <form id="productForm" action="${pageContext.request.contextPath}/admin" method="post" enctype="multipart/form-data">
        <input type="hidden" name="action" value="save" />
        <input type="hidden" name="id" id="pId" value="" />
        <input type="hidden" name="existingImageUrl" id="existingImageUrl" value="" />
        <div class="fg-row">
          <div class="fg"><label for="pName">Product Name *</label><input type="text" id="pName" name="name" placeholder="e.g. Casio Edifice" /></div>
          <div class="fg"><label for="pBrand">Brand *</label><input type="text" id="pBrand" name="brand" placeholder="e.g. Casio" /></div>
        </div>
        <div class="fg-row">
          <div class="fg"><label for="pPrice">Price (Rs) *</label><input type="number" id="pPrice" name="price" placeholder="12500" min="0" /></div>
          <div class="fg"><label for="pOldPrice">Original Price (Rs)</label><input type="number" id="pOldPrice" name="oldPrice" placeholder="Optional" min="0" /></div>
        </div>
        <div class="fg-row">
          <div class="fg">
            <label for="pCategory">Category *</label>
            <select id="pCategory" name="categoryId">
              <option value="">Select...</option>
              <option value="1">Luxury</option>
              <option value="2">Sports</option>
              <option value="3">Classic</option>
              <option value="4">Smart</option>
              <option value="5">Womens</option>
            </select>
          </div>
          <div class="fg"><label for="pRating">Rating (0-5)</label><input type="number" id="pRating" name="rating" placeholder="4.5" min="0" max="5" step="0.1" /></div>
        </div>
        <div class="fg"><label for="pDesc">Description</label><textarea id="pDesc" name="description" placeholder="Product description..."></textarea></div>
        <div class="fg"><label for="pImageFile">Product Image</label><input type="file" id="pImageFile" name="imageFile" accept="image/*" /></div>
        <div class="fg"><label for="pImg">Image URL (optional)</label><input type="text" id="pImg" name="imageUrl" placeholder="Or enter an image URL" /></div>
        <div class="fg">
          <label for="pStockQuantity">Stock Quantity *</label>
          <input type="number" id="pStockQuantity" name="stockQuantity" min="0" value="10" />
          <input type="hidden" id="pStock" name="inStock" value="true" />
        </div>
      </form>
    </div>
    <div class="modal-foot">
      <button class="btn btn-o" type="button" onclick="closeProductModal()">Cancel</button>
      <button class="btn btn-g" type="button" id="modalSaveBtn" onclick="saveProduct()">Save Product</button>
    </div>
  </div>
</div>

<!-- DELETE MODAL -->
<div class="modal-bg" id="delModal">
  <div class="modal" style="max-width:420px;" role="dialog" aria-modal="true">
    <div class="modal-head">
      <div class="modal-title">Confirm Deletion</div>
      <button class="modal-close" onclick="closeDelModal()">&#10005;</button>
    </div>
    <div class="modal-body" style="text-align:center;padding:2rem 1.6rem;">
      <div class="del-ico">
        <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="var(--red)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="3 6 5 6 21 6"/><path d="M19 6l-1 14a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2L5 6"/><path d="M10 11v6"/><path d="M14 11v6"/><path d="M9 6V4a1 1 0 0 1 1-1h4a1 1 0 0 1 1 1v2"/></svg>
      </div>
      <div style="font-size:1.1rem;font-weight:900;color:var(--text);margin-bottom:.5rem;">Delete this product?</div>
      <div style="font-size:.83rem;color:var(--muted);line-height:1.65;">"<span id="delProdName" style="font-weight:700;color:var(--text);"></span>" will be permanently removed.</div>
    </div>
    <div class="modal-foot">
      <button class="btn btn-o" onclick="closeDelModal()">Cancel</button>
      <button class="btn btn-r" id="delConfirmBtn">Delete</button>
    </div>
  </div>
</div>

<form id="deleteForm" action="${pageContext.request.contextPath}/admin" method="post">
  <input type="hidden" name="action" value="delete" />
  <input type="hidden" name="id" id="deleteId" />
</form>
<div class="toast-container" id="toastContainer"></div>

<%-- Pass product data to JS for charts --%>
<script>
var PRODUCT_DATA = [
  <c:forEach var="p" items="${products}" varStatus="st">
    {id:${p.id},name:"<c:out value='${p.name}'/>",category:"<c:out value='${p.categoryName}'/>",price:${p.price},stock:${p.stockQuantity}}<c:if test="${!st.last}">,</c:if>
  </c:forEach>
];
var TOTAL_PRODUCTS  = ${productCount};
var IN_STOCK_COUNT  = ${inStockCount};
var OUT_STOCK_COUNT = ${outOfStockCount};
</script>

<script>
/* ---- Section switching ---- */
function showSection(id, el) {
  ['dashboard','products','customers','analytics'].forEach(function(s){
    var sec = document.getElementById('sec-'+s);
    if (sec) sec.style.display = s === id ? 'block' : 'none';
  });
  document.querySelectorAll('.adm-nav-item').forEach(function(b){ b.classList.remove('active'); });
  if (el) el.classList.add('active');
  var titles = {dashboard:'Dashboard',products:'Product Management',customers:'Customers',analytics:'Analytics'};
  document.getElementById('topbarTitle').textContent = titles[id] || id;
  if (id === 'dashboard') updateDashboardCounts();
  if (id === 'products')  updateProductCounts();
}

/* ---- Counts ---- */
function getDataRows(bodyId) {
  return Array.from(document.querySelectorAll('#'+bodyId+' tr[data-id]'));
}
function updateDashboardCounts() {
  var rows = getDataRows('dashTbody');
  document.getElementById('dashProductCount').textContent = rows.length + ' product' + (rows.length !== 1 ? 's' : '') + ' in catalogue';
}
function updateProductCounts() {
  var rows = getDataRows('prodMgmtTbody').filter(function(r){ return r.style.display !== 'none'; });
  document.getElementById('prodMgmtCount').textContent = rows.length + ' products';
  document.getElementById('pStatTotal').textContent = rows.length;
  var inS = rows.filter(function(r){ return parseInt(r.dataset.stockQuantity||'0') > 0; }).length;
  document.getElementById('pStatInStock').textContent = inS;
  document.getElementById('pStatOut').textContent = rows.length - inS;
}

/* ---- Filter ---- */
function filterDashTable() {
  var q = document.getElementById('dashSearch').value.toLowerCase();
  getDataRows('dashTbody').forEach(function(r){
    var show = !q || r.dataset.name.toLowerCase().includes(q) || r.dataset.brand.toLowerCase().includes(q) || r.dataset.categoryName.toLowerCase().includes(q);
    r.style.display = show ? '' : 'none';
  });
}
function filterProdTable() {
  var q = document.getElementById('prodSearch').value.toLowerCase();
  var cat = document.getElementById('filterCat').value;
  getDataRows('prodMgmtTbody').forEach(function(r){
    var textMatch = !q || r.dataset.name.toLowerCase().includes(q) || r.dataset.brand.toLowerCase().includes(q);
    var catMatch = !cat || r.dataset.categoryName === cat;
    r.style.display = textMatch && catMatch ? '' : 'none';
  });
  updateProductCounts();
}

/* ---- Modals ---- */
function openAddModal() {
  document.getElementById('modalTitle').textContent = 'Add New Product';
  document.getElementById('modalSaveBtn').textContent = 'Save Product';
  resetForm();
  document.getElementById('productModal').classList.add('open');
}
function openEditModal(row) {
  if (!row || row.tagName !== 'TR') row = row.closest('tr');
  if (!row) return;
  document.getElementById('modalTitle').textContent = 'Edit Product';
  document.getElementById('modalSaveBtn').textContent = 'Update Product';
  document.getElementById('pId').value = row.dataset.id;
  document.getElementById('pName').value = row.dataset.name;
  document.getElementById('pBrand').value = row.dataset.brand;
  document.getElementById('pPrice').value = row.dataset.price;
  document.getElementById('pOldPrice').value = row.dataset.oldprice || '';
  document.getElementById('pCategory').value = row.dataset.categoryId;
  document.getElementById('pRating').value = row.dataset.rating;
  document.getElementById('pDesc').value = row.dataset.description;
  document.getElementById('existingImageUrl').value = row.dataset.imageUrl || '';
  document.getElementById('pImg').value = row.dataset.imageUrl || '';
  document.getElementById('pImageFile').value = '';
  document.getElementById('pStockQuantity').value = row.dataset.stockQuantity || 0;
  document.getElementById('productModal').classList.add('open');
}
function closeProductModal() { document.getElementById('productModal').classList.remove('open'); }
function resetForm() {
  ['pId','pName','pBrand','pPrice','pOldPrice','pRating','pDesc','pImg','existingImageUrl'].forEach(function(id){ document.getElementById(id).value=''; });
  document.getElementById('pCategory').value = '';
  document.getElementById('pImageFile').value = '';
  document.getElementById('pStockQuantity').value = 10;
}
function saveProduct() {
  var form = document.getElementById('productForm');
  if (!form.name.value.trim() || !form.brand.value.trim() || !parseFloat(form.price.value) || !form.categoryId.value) {
    showToast('Please fill all required fields.', 'error'); return;
  }
  form.submit();
}
var deletingId = null;
function openDelModal(row) {
  if (!row || row.tagName !== 'TR') row = row.closest('tr');
  if (!row) return;
  deletingId = row.dataset.id;
  document.getElementById('delProdName').textContent = row.dataset.name;
  document.getElementById('delModal').classList.add('open');
  document.getElementById('delConfirmBtn').onclick = confirmDelete;
}
function closeDelModal() { document.getElementById('delModal').classList.remove('open'); deletingId = null; }
function confirmDelete() {
  if (!deletingId) return;
  document.getElementById('deleteId').value = deletingId;
  document.getElementById('deleteForm').submit();
}
function showToast(message, type) {
  var c = document.getElementById('toastContainer');
  var t = document.createElement('div');
  t.className = 'toast ' + (type || '');
  t.textContent = message;
  c.appendChild(t);
  setTimeout(function(){ t.remove(); }, 2800);
}
document.getElementById('productModal').addEventListener('click', function(e){ if(e.target===e.currentTarget) closeProductModal(); });
document.getElementById('delModal').addEventListener('click', function(e){ if(e.target===e.currentTarget) closeDelModal(); });

/* ---- Charts ---- */
function buildCharts() {
  var cats = {};
  var budget=0, mid=0, luxury=0;
  PRODUCT_DATA.forEach(function(p){
    cats[p.category] = (cats[p.category]||0) + 1;
    if (p.price <= 15000) budget++;
    else if (p.price <= 75000) mid++;
    else luxury++;
  });

  /* Category bar chart */
  var catCtx = document.getElementById('categoryChart');
  if (catCtx) {
    new Chart(catCtx, {
      type:'bar',
      data:{
        labels:Object.keys(cats),
        datasets:[{
          label:'Products',
          data:Object.values(cats),
          backgroundColor:['#1a6b38','#258a4a','#3dba62','#c9a452','#b8913a'],
          borderRadius:8,
          borderSkipped:false
        }]
      },
      options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false}},scales:{y:{beginAtZero:true,ticks:{stepSize:1},grid:{color:'#d4e5da'}},x:{grid:{display:false}}}}
    });
  }

  /* Stock doughnut */
  var stockCtx = document.getElementById('stockChart');
  if (stockCtx) {
    new Chart(stockCtx, {
      type:'doughnut',
      data:{
        labels:['In Stock','Out of Stock'],
        datasets:[{data:[IN_STOCK_COUNT, OUT_STOCK_COUNT],backgroundColor:['#1a6b38','#dd4444'],borderWidth:0,hoverOffset:6}]
      },
      options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{position:'bottom',labels:{font:{size:11},padding:14}}},cutout:'68%'}
    });
  }

  /* Customer growth line (demo) */
  var custCtx = document.getElementById('customerChart');
  if (custCtx) {
    new Chart(custCtx, {
      type:'line',
      data:{
        labels:['Jan','Feb','Mar','Apr','May','Jun'],
        datasets:[{label:'Customers',data:[2,3,4,5,6,7],fill:true,backgroundColor:'rgba(26,107,56,0.08)',borderColor:'#1a6b38',tension:0.4,pointRadius:4,pointBackgroundColor:'#1a6b38'}]
      },
      options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false}},scales:{y:{beginAtZero:true,ticks:{stepSize:1},grid:{color:'#d4e5da'}},x:{grid:{display:false}}}}
    });
  }

  /* Price range bar */
  var priceCtx = document.getElementById('priceChart');
  if (priceCtx) {
    new Chart(priceCtx, {
      type:'bar',
      data:{
        labels:['Budget (up to Rs 15K)','Mid-Range (Rs 15K-75K)','Luxury (Rs 75K+)'],
        datasets:[{label:'Products',data:[budget,mid,luxury],backgroundColor:['#3dba62','#c9a452','#1a6b38'],borderRadius:8,borderSkipped:false}]
      },
      options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false}},scales:{y:{beginAtZero:true,ticks:{stepSize:1},grid:{color:'#d4e5da'}},x:{grid:{display:false}}}}
    });
  }
}

document.addEventListener('DOMContentLoaded', function(){
  showSection('dashboard');
  buildCharts();
});
</script>
</body>
</html>
