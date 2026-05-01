<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Admin Dashboard | AluGhadi</title>
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet" />
  <style>
    /* ── Design Tokens ──────────────────────────────────────────── */
    :root {
      --bg:          #f2f6f2;
      --white:       #ffffff;
      --surface:     #eaf0ea;
      --surface2:    #f7faf7;
      --green:       #1a6b38;
      --green2:      #258a4a;
      --green-light: #e4f4eb;
      --green-mid:   #b2d9c0;
      --accent:      #3dba62;
      --text:        #0b1c10;
      --text2:       #1e3828;
      --muted:       #4e6a59;
      --dim:         #88a492;
      --border:      #d4e5da;
      --border2:     #bfd4c8;
      --gold:        #c9a452;
      --gold-light:  #f4e9cc;
      --gold2:       #b8913a;
      --red:         #d44;
      --amber:       #c88a18;
      --blue:        #2563eb;
      --blue-light:  #eff6ff;
      --purple:      #7c3aed;
      --purple-light:#f5f3ff;
      --ff:  'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
      --ffi: var(--ff);
      --r:    18px;
      --r-sm: 11px;
      --ease: cubic-bezier(0.16, 1, 0.3, 1);
      --shadow:    0 2px 16px rgba(10,30,15,.07);
      --shadow-md: 0 6px 28px rgba(10,30,15,.10);
      --shadow-lg: 0 14px 52px rgba(10,30,15,.14);
      --sidebar-w: 268px;
    }

    *, *::before, *::after { margin:0; padding:0; box-sizing:border-box; }
    html { scroll-behavior: smooth; }
    body {
      font-family: var(--ff);
      background:  var(--bg);
      color:       var(--text);
      font-size:   15px;
      line-height: 1.6;
      -webkit-font-smoothing: antialiased;
      display: flex;
      min-height: 100vh;
    }
    a { text-decoration: none; color: inherit; }
    img { max-width: 100%; display: block; }
    button { cursor: pointer; font-family: var(--ff); }

    ::-webkit-scrollbar       { width: 5px; height: 5px; }
    ::-webkit-scrollbar-track { background: var(--bg); }
    ::-webkit-scrollbar-thumb { background: var(--green-mid); border-radius: 6px; }
    ::-webkit-scrollbar-thumb:hover { background: var(--green); }

    /* ══════════════════════════════════════════════════════
       SIDEBAR
    ══════════════════════════════════════════════════════ */
    .adm-sidebar {
      width:      var(--sidebar-w);
      min-height: 100vh;
      background: var(--text);
      position:   fixed;
      top:0; left:0; bottom:0;
      display:        flex;
      flex-direction: column;
      z-index: 200;
      overflow-y: auto;
      overflow-x: hidden;
    }

    .adm-logo {
      padding:     1.5rem 1.4rem 1.3rem;
      border-bottom: 1px solid rgba(255,255,255,.08);
      display:     flex;
      align-items: center;
      gap:         0.7rem;
    }
    .adm-logo-mark {
      width:40px; height:40px;
      background: linear-gradient(135deg, var(--green) 0%, var(--accent) 100%);
      border-radius: 11px;
      display:flex; align-items:center; justify-content:center;
      font-family: var(--ffi); font-weight:900; font-size:1.05rem;
      color:#fff; letter-spacing:-0.02em; flex-shrink:0;
    }
    .adm-logo-brand {
      font-family:var(--ffi); font-weight:900; font-size:1.08rem;
      color:#fff; letter-spacing:-0.02em; line-height:1;
    }
    .adm-logo-sub {
      font-size:0.6rem; font-weight:600; letter-spacing:0.14em;
      text-transform:uppercase; color:rgba(255,255,255,.35); margin-top:.18rem;
    }

    .adm-nav { flex:1; padding:1rem 0.7rem; display:flex; flex-direction:column; gap:1px; }
    .adm-nav-label {
      font-size:0.6rem; font-weight:700; letter-spacing:0.18em;
      text-transform:uppercase; color:rgba(255,255,255,.28);
      padding:0.85rem 0.75rem 0.35rem; margin-top:0.5rem;
    }
    .adm-nav-item {
      display:flex; align-items:center; gap:0.7rem;
      padding:0.65rem 0.85rem; border-radius:10px;
      font-size:0.82rem; font-weight:500;
      color:rgba(255,255,255,.52);
      transition:all 0.18s var(--ease);
      cursor:pointer; border:none; background:none; width:100%;
      text-align:left;
    }
    .adm-nav-item:hover { color:#fff; background:rgba(255,255,255,.07); }
    .adm-nav-item.active {
      color:#fff;
      background:linear-gradient(135deg, var(--green) 0%, var(--accent) 100%);
      font-weight:700;
      box-shadow:0 4px 14px rgba(26,107,56,.38);
    }
    .adm-nav-item .nav-ico { font-size:0.95rem; width:20px; text-align:center; flex-shrink:0; }
    .adm-nav-item .nav-badge {
      margin-left:auto; background:var(--accent); color:#fff;
      font-size:0.58rem; font-weight:800; padding:0.12rem 0.5rem;
      border-radius:999px; letter-spacing:0.02em;
    }
    .adm-nav-link { display:flex; align-items:center; gap:0.7rem; padding:0.65rem 0.85rem; border-radius:10px; font-size:0.82rem; font-weight:500; color:rgba(255,255,255,.52); transition:all 0.18s var(--ease); }
    .adm-nav-link:hover { color:#fff; background:rgba(255,255,255,.07); }
    .adm-nav-link .nav-ico { font-size:0.95rem; width:20px; text-align:center; flex-shrink:0; }

    .adm-user {
      margin:0.75rem; padding:0.85rem 1rem;
      background:rgba(255,255,255,.06);
      border-radius:12px; border:1px solid rgba(255,255,255,.08);
      display:flex; align-items:center; gap:0.65rem;
    }
    .adm-user-av {
      width:36px; height:36px;
      background:linear-gradient(135deg, var(--green) 0%, var(--accent) 100%);
      border-radius:50%; display:flex; align-items:center; justify-content:center;
      font-weight:800; font-size:0.78rem; color:#fff; flex-shrink:0;
    }
    .adm-user-name { font-size:0.8rem; font-weight:700; color:#fff; line-height:1.2; }
    .adm-user-role { font-size:0.62rem; color:var(--accent); font-weight:600; }

    /* ══════════════════════════════════════════════════════
       MAIN CONTENT
    ══════════════════════════════════════════════════════ */
    .adm-main { margin-left:var(--sidebar-w); flex:1; display:flex; flex-direction:column; min-height:100vh; }

    .adm-topbar {
      background:var(--white); border-bottom:1.5px solid var(--border);
      padding:0 2rem; height:68px;
      display:flex; align-items:center; justify-content:space-between;
      position:sticky; top:0; z-index:100;
    }
    .adm-topbar-left { display:flex; align-items:center; gap:1rem; }
    .adm-topbar-title {
      font-family:var(--ffi); font-size:1.3rem; font-weight:900;
      color:var(--text); letter-spacing:-0.025em;
    }
    .adm-breadcrumb { font-size:0.74rem; color:var(--muted); }
    .adm-topbar-right { display:flex; align-items:center; gap:0.75rem; }
    .adm-topbar-chip {
      display:inline-flex; align-items:center; gap:0.38rem;
      background:var(--green-light); border:1.5px solid var(--green-mid);
      color:var(--green); padding:0.3rem 0.85rem; border-radius:999px;
      font-size:0.7rem; font-weight:700;
    }
    .topbar-dot {
      width:7px; height:7px; background:var(--accent); border-radius:50%;
      animation:pulse 2s ease-in-out infinite;
    }
    @keyframes pulse { 0%,100%{opacity:1;transform:scale(1)} 50%{opacity:.5;transform:scale(.78)} }

    .adm-body { padding:2rem 2rem 5rem; flex:1; }

    /* ── Section header ─────────────────────────────────── */
    .sec-head { margin-bottom:1.75rem; }
    .sec-head-title { font-family:var(--ffi); font-size:1.55rem; font-weight:900; letter-spacing:-0.03em; color:var(--text); }
    .sec-head-sub { font-size:0.82rem; color:var(--muted); margin-top:0.18rem; }

    /* ── KPI Grid ───────────────────────────────────────── */
    .kpi-grid { display:grid; grid-template-columns:repeat(4,1fr); gap:1.2rem; margin-bottom:1.85rem; }
    .kpi-card {
      background:var(--white); border:1.5px solid var(--border);
      border-radius:20px; padding:1.5rem 1.4rem;
      position:relative; overflow:hidden;
      transition:all 0.3s var(--ease);
    }
    .kpi-card:hover { transform:translateY(-4px); box-shadow:var(--shadow-lg); border-color:var(--green-mid); }
    .kpi-glow {
      position:absolute; top:-28px; right:-28px;
      width:105px; height:105px; border-radius:50%; opacity:.08;
    }
    .kpi-top { display:flex; align-items:center; justify-content:space-between; margin-bottom:1rem; }
    .kpi-ico { width:44px; height:44px; border-radius:13px; display:flex; align-items:center; justify-content:center; font-size:1.25rem; }
    .kpi-badge { font-size:0.68rem; font-weight:700; padding:0.2rem 0.58rem; border-radius:999px; }
    .kpi-num {
      font-family:var(--ffi); font-size:2rem; font-weight:900;
      letter-spacing:-0.04em; line-height:1; color:var(--text); margin-bottom:0.22rem;
    }
    .kpi-label { font-size:0.72rem; font-weight:600; color:var(--muted); letter-spacing:0.02em; }

    /* ── Mid grid: chart + side panel ──────────────────── */
    .dash-mid { display:grid; grid-template-columns:1fr 320px; gap:1.25rem; margin-bottom:1.85rem; }

    .card {
      background:var(--white); border:1.5px solid var(--border);
      border-radius:20px; overflow:hidden;
    }
    .card-head {
      padding:1.25rem 1.5rem 0;
      display:flex; align-items:center; justify-content:space-between;
      margin-bottom:1rem;
    }
    .card-head-title { font-family:var(--ffi); font-size:1rem; font-weight:900; letter-spacing:-0.02em; color:var(--text); }
    .card-head-sub { font-size:0.7rem; color:var(--muted); font-weight:500; margin-top:.1rem; }
    .card-body { padding:0 1.5rem 1.5rem; }

    .chart-wrap { height:235px; position:relative; }
    canvas#salesChart { width:100%!important; height:100%!important; }

    .chart-range-select {
      font-family:var(--ff); font-size:.73rem; padding:.3rem .65rem;
      border-radius:8px; border:1.5px solid var(--border);
      background:var(--bg); color:var(--text); cursor:pointer; outline:none;
    }

    /* Quick stats */
    .qs-list { display:flex; flex-direction:column; }
    .qs-item {
      display:flex; align-items:center; justify-content:space-between;
      padding:0.82rem 0; border-bottom:1px solid var(--border);
    }
    .qs-item:last-child { border-bottom:none; }
    .qs-left { display:flex; align-items:center; gap:0.6rem; }
    .qs-dot { width:10px; height:10px; border-radius:50%; flex-shrink:0; }
    .qs-name { font-size:0.81rem; font-weight:600; color:var(--text); }
    .qs-cat  { font-size:0.67rem; color:var(--muted); margin-top:.04rem; }
    .qs-val  { font-family:var(--ffi); font-size:0.95rem; font-weight:900; color:var(--text); letter-spacing:-0.02em; }

    /* ── Table card ─────────────────────────────────────── */
    .table-card { margin-bottom:1.85rem; }
    .table-toolbar {
      padding:1.25rem 1.5rem;
      display:flex; align-items:center; justify-content:space-between;
      gap:1rem; flex-wrap:wrap;
      border-bottom:1.5px solid var(--border);
    }
    .table-search {
      display:flex; align-items:center; gap:.5rem;
      background:var(--bg); border:1.5px solid var(--border);
      border-radius:var(--r-sm); padding:.45rem .85rem; min-width:200px;
    }
    .table-search input {
      border:none; background:transparent;
      font-family:var(--ff); font-size:.81rem; color:var(--text);
      outline:none; width:100%;
    }
    .table-search input::placeholder { color:var(--dim); }
    .table-search-ico { color:var(--dim); font-size:.88rem; flex-shrink:0; }

    table { width:100%; border-collapse:collapse; }
    thead th {
      font-size:.65rem; font-weight:700; letter-spacing:.1em; text-transform:uppercase;
      color:var(--muted); padding:.72rem 1.25rem; background:var(--surface2);
      text-align:left; border-bottom:1.5px solid var(--border);
    }
    tbody tr { border-bottom:1px solid var(--border); transition:background .15s; }
    tbody tr:last-child { border-bottom:none; }
    tbody tr:hover { background:var(--surface2); }
    tbody td { padding:.88rem 1.25rem; font-size:.81rem; font-weight:500; color:var(--text); vertical-align:middle; }

    .td-thumb {
      width:44px; height:44px; border-radius:10px; object-fit:cover;
      background:var(--surface); border:1.5px solid var(--border);
      display:flex; align-items:center; justify-content:center; font-size:1.15rem;
    }
    .td-name  { font-weight:700; color:var(--text); }
    .td-desc  { font-size:.7rem; color:var(--muted); margin-top:.06rem; }
    .td-price { font-family:var(--ffi); font-weight:900; letter-spacing:-.02em; }
    .stock-yes { display:inline-flex; align-items:center; gap:.35rem; color:var(--green); font-weight:700; font-size:.7rem; }
    .stock-no  { display:inline-flex; align-items:center; gap:.35rem; color:var(--red);   font-weight:700; font-size:.7rem; }
    .stock-yes::before, .stock-no::before { content:''; width:7px; height:7px; border-radius:50%; flex-shrink:0; }
    .stock-yes::before { background:var(--green); }
    .stock-no::before  { background:var(--red); }

    .cat-pill {
      font-size:.68rem; font-weight:700; padding:.18rem .6rem;
      border-radius:999px; background:var(--surface); border:1.5px solid var(--border); color:var(--muted);
    }

    .tbl-actions { display:flex; gap:.4rem; align-items:center; }
    .tbl-btn { border:none; border-radius:8px; padding:.35rem .65rem; font-size:.7rem; font-weight:700; font-family:var(--ff); transition:all .18s; }
    .tbl-btn-edit { background:var(--green-light); color:var(--green); }
    .tbl-btn-edit:hover { background:var(--green); color:#fff; }
    .tbl-btn-del  { background:#fff1f1; color:var(--red); }
    .tbl-btn-del:hover  { background:var(--red); color:#fff; }

    /* ── Buttons ────────────────────────────────────────── */
    .btn {
      display:inline-flex; align-items:center; gap:.45rem;
      padding:.7rem 1.45rem; border-radius:var(--r-sm);
      font-family:var(--ff); font-weight:700; font-size:.81rem;
      cursor:pointer; border:none; transition:all .22s var(--ease);
      white-space:nowrap; text-decoration:none;
    }
    .btn-g {
      background:linear-gradient(135deg, var(--green) 0%, var(--green2) 100%);
      color:#fff; box-shadow:0 3px 14px rgba(26,107,56,.28);
    }
    .btn-g:hover { transform:translateY(-2px); box-shadow:0 8px 26px rgba(26,107,56,.38); }
    .btn-o { background:var(--white); color:var(--text); border:1.5px solid var(--border2); }
    .btn-o:hover { border-color:var(--green); color:var(--green); background:var(--green-light); }
    .btn-r { background:#fff1f1; color:var(--red); border:1.5px solid rgba(200,60,60,.18); }
    .btn-r:hover { background:var(--red); color:#fff; }

    /* ── Placeholder sections ─────────────────────────── */
    .placeholder-section {
      display:flex; flex-direction:column; align-items:center; justify-content:center;
      background:var(--white); border:1.5px solid var(--border); border-radius:20px;
      padding:4rem 2rem; text-align:center; gap:.75rem;
    }
    .placeholder-ico { font-size:2.8rem; line-height:1; }
    .placeholder-title { font-family:var(--ffi); font-size:1.35rem; font-weight:900; letter-spacing:-.025em; color:var(--text); }
    .placeholder-sub { font-size:.82rem; color:var(--muted); max-width:380px; line-height:1.7; }
    .placeholder-badge {
      font-size:.68rem; font-weight:700; padding:.28rem .85rem;
      border-radius:999px; background:var(--green-light); color:var(--green);
      border:1.5px solid var(--green-mid);
    }

    /* ── Analytics section ──────────────────────────────── */
    .analytics-grid { display:grid; grid-template-columns:repeat(3,1fr); gap:1.25rem; margin-bottom:1.85rem; }
    .mini-stat {
      background:var(--white); border:1.5px solid var(--border); border-radius:16px;
      padding:1.25rem 1.35rem;
    }
    .mini-stat-label { font-size:.68rem; font-weight:700; color:var(--muted); letter-spacing:.06em; text-transform:uppercase; margin-bottom:.55rem; }
    .mini-stat-val { font-family:var(--ffi); font-size:1.65rem; font-weight:900; letter-spacing:-.04em; color:var(--text); margin-bottom:.18rem; }
    .mini-stat-sub { font-size:.7rem; color:var(--muted); }
    .mini-stat-up   { color:var(--green); font-weight:700; }
    .mini-stat-down { color:var(--red); font-weight:700; }

    /* ── Modal ──────────────────────────────────────────── */
    .modal-bg {
      position:fixed; inset:0;
      background:rgba(8,20,12,.55); backdrop-filter:blur(6px);
      z-index:400; display:none; align-items:center; justify-content:center; padding:1rem;
    }
    .modal-bg.open { display:flex; }
    .modal {
      background:var(--white); border-radius:24px;
      width:100%; max-width:560px; max-height:90vh; overflow-y:auto;
      box-shadow:0 32px 96px rgba(8,20,12,.26);
      animation:modalIn .3s var(--ease) both;
    }
    @keyframes modalIn { from{opacity:0;transform:translateY(22px) scale(.97)} to{opacity:1;transform:none} }
    .modal-head {
      padding:1.4rem 1.6rem 1rem;
      display:flex; align-items:center; justify-content:space-between;
      border-bottom:1.5px solid var(--border);
    }
    .modal-title { font-family:var(--ffi); font-size:1.2rem; font-weight:900; letter-spacing:-.025em; color:var(--text); }
    .modal-close {
      border:none; background:var(--surface); width:33px; height:33px;
      border-radius:50%; font-size:.95rem; display:flex; align-items:center; justify-content:center;
      color:var(--muted); transition:all .18s;
    }
    .modal-close:hover { background:#fff1f1; color:var(--red); }
    .modal-body { padding:1.4rem 1.6rem; }
    .modal-foot {
      padding:.95rem 1.6rem 1.4rem;
      display:flex; gap:.7rem; justify-content:flex-end;
      border-top:1.5px solid var(--border);
    }

    /* Form fields */
    .fg { margin-bottom:1.1rem; }
    .fg label { display:block; font-size:.7rem; font-weight:700; color:var(--text2); margin-bottom:.42rem; letter-spacing:.025em; }
    .fg input, .fg select, .fg textarea {
      width:100%; background:var(--bg); border:1.5px solid var(--border);
      border-radius:var(--r-sm); padding:.72rem .95rem;
      font-family:var(--ff); font-size:.83rem; color:var(--text); outline:none;
      transition:all .2s var(--ease); appearance:none;
    }
    .fg input:focus, .fg select:focus, .fg textarea:focus {
      border-color:var(--green); background:var(--white);
      box-shadow:0 0 0 3px rgba(26,107,56,.08);
    }
    .fg textarea { resize:vertical; min-height:86px; }
    .fg-row { display:grid; grid-template-columns:1fr 1fr; gap:.82rem; }

    /* Toggle */
    .toggle-wrap { display:flex; align-items:center; gap:.7rem; }
    .toggle { position:relative; width:44px; height:24px; }
    .toggle input { opacity:0; width:0; height:0; }
    .toggle-track { position:absolute; inset:0; background:var(--border2); border-radius:12px; transition:background .22s; }
    .toggle input:checked ~ .toggle-track { background:var(--green); }
    .toggle-thumb { position:absolute; top:2px; left:2px; width:20px; height:20px; background:#fff; border-radius:50%; box-shadow:0 2px 6px rgba(0,0,0,.2); transition:transform .22s var(--ease); }
    .toggle input:checked ~ .toggle-thumb { transform:translateX(20px); }
    .toggle-label { font-size:.81rem; font-weight:600; color:var(--text); }

    /* Delete confirm */
    .del-ico { width:62px; height:62px; background:#fff1f1; border-radius:50%; margin:0 auto 1rem; display:flex; align-items:center; justify-content:center; font-size:1.9rem; }

    /* ── Toast ──────────────────────────────────────────── */
    .toast-container { position:fixed; top:1.2rem; right:1.2rem; z-index:600; display:flex; flex-direction:column; gap:.5rem; pointer-events:none; }
    .toast {
      background:var(--text); color:#fff;
      padding:.82rem 1.25rem; border-radius:13px;
      font-size:.8rem; font-weight:600;
      display:flex; align-items:center; gap:.6rem;
      box-shadow:var(--shadow-lg);
      animation:toastIn .3s var(--ease) both;
      pointer-events:auto; max-width:300px;
    }
    @keyframes toastIn { from{opacity:0;transform:translateX(22px)} to{opacity:1;transform:none} }
    .toast.success { background:var(--green); }
    .toast.error   { background:var(--red);   }
    .toast-ico { font-size:.95rem; flex-shrink:0; }

    /* ── Responsive ─────────────────────────────────────── */
    @media (max-width:1200px) {
      .kpi-grid { grid-template-columns:repeat(2,1fr); }
      .dash-mid { grid-template-columns:1fr; }
      .analytics-grid { grid-template-columns:repeat(2,1fr); }
    }
    @media (max-width:900px) {
      :root { --sidebar-w: 0px; }
      .adm-sidebar { transform:translateX(-100%); transition:transform .3s var(--ease); }
      .adm-sidebar.open { transform:none; width:268px; }
      .adm-main { margin-left:0; }
      .adm-body { padding:1.5rem 1.2rem 4rem; }
      .kpi-grid { grid-template-columns:1fr 1fr; }
      .analytics-grid { grid-template-columns:1fr; }
      .fg-row { grid-template-columns:1fr; }
    }
    @media (max-width:600px) {
      .kpi-grid { grid-template-columns:1fr; }
      .table-toolbar { flex-direction:column; align-items:stretch; }
    }
  </style>
</head>
<body>

<!-- ══════════════════════════════════════════════════
     SIDEBAR
══════════════════════════════════════════════════ -->
<aside class="adm-sidebar" id="admSidebar">
  <div class="adm-logo">
    <div class="adm-logo-mark">AG</div>
    <div>
      <div class="adm-logo-brand">AluGhadi</div>
      <div class="adm-logo-sub">Admin Panel</div>
    </div>
  </div>

  <nav class="adm-nav">
    <div class="adm-nav-label">Main</div>
    <button class="adm-nav-item active" onclick="showSection('dashboard',this)">
      <span class="nav-ico">&#9778;</span> Dashboard
    </button>
    <button class="adm-nav-item" onclick="showSection('products',this)">
      <span class="nav-ico">&#128718;</span> Products
    </button>
    <button class="adm-nav-item" onclick="showSection('orders',this)">
      <span class="nav-ico">&#128230;</span> Orders
      <span class="nav-badge">12</span>
    </button>
    <button class="adm-nav-item" onclick="showSection('customers',this)">
      <span class="nav-ico">&#128100;</span> Customers
    </button>

    <div class="adm-nav-label">Analytics</div>
    <button class="adm-nav-item" onclick="showSection('sales',this)">
      <span class="nav-ico">&#128200;</span> Sales Report
    </button>
    <button class="adm-nav-item" onclick="showSection('inventory',this)">
      <span class="nav-ico">&#128373;</span> Inventory
    </button>

    <div class="adm-nav-label">System</div>
    <a class="adm-nav-link" href="${pageContext.request.contextPath}/" target="_blank">
      <span class="nav-ico">&#127760;</span> View Store
    </a>
    <a class="adm-nav-link" href="${pageContext.request.contextPath}/logout">
      <span class="nav-ico">&#128682;</span> Sign Out
    </a>
  </nav>

  <div class="adm-user">
    <div class="adm-user-av">AD</div>
    <div>
      <div class="adm-user-name">Administrator</div>
      <div class="adm-user-role">Super Admin</div>
    </div>
  </div>
</aside>

<!-- ══════════════════════════════════════════════════
     MAIN
══════════════════════════════════════════════════ -->
<div class="adm-main">

  <!-- Top bar -->
  <header class="adm-topbar">
    <div class="adm-topbar-left">
      <div class="adm-topbar-title" id="topbarTitle">Dashboard</div>
    </div>
    <div class="adm-topbar-right">
      <div class="adm-topbar-chip">
        <span class="topbar-dot"></span> Live
      </div>
      <button class="btn btn-g" onclick="openAddModal()">&#43; Add Product</button>
    </div>
  </header>

  <div class="adm-body">

    <!-- ═══════════════════════════════════════
         DASHBOARD SECTION
    ═══════════════════════════════════════ -->
    <div id="sec-dashboard">

      <div class="sec-head">
        <div class="sec-head-title">Overview</div>
        <div class="sec-head-sub">Welcome back — here's what's happening today.</div>
      </div>

      <!-- KPI Cards -->
      <div class="kpi-grid">
        <div class="kpi-card">
          <div class="kpi-glow" style="background:var(--green)"></div>
          <div class="kpi-top">
            <div class="kpi-ico" style="background:var(--green-light)">&#128178;</div>
            <span class="kpi-badge" style="background:var(--green-light);color:var(--green)">+18.4%</span>
          </div>
          <div class="kpi-num">Rs 4.28L</div>
          <div class="kpi-label">Total Revenue (Month)</div>
        </div>
        <div class="kpi-card">
          <div class="kpi-glow" style="background:var(--blue)"></div>
          <div class="kpi-top">
            <div class="kpi-ico" style="background:var(--blue-light)">&#128230;</div>
            <span class="kpi-badge" style="background:var(--blue-light);color:var(--blue)">+12.7%</span>
          </div>
          <div class="kpi-num">342</div>
          <div class="kpi-label">Orders This Month</div>
        </div>
        <div class="kpi-card">
          <div class="kpi-glow" style="background:var(--gold)"></div>
          <div class="kpi-top">
            <div class="kpi-ico" style="background:var(--gold-light)">&#128718;</div>
            <span class="kpi-badge" style="background:var(--gold-light);color:var(--gold2)" id="kpiStockBadge">In Stock</span>
          </div>
          <div class="kpi-num" id="kpiStockCount">—</div>
          <div class="kpi-label">Products in Stock</div>
        </div>
        <div class="kpi-card">
          <div class="kpi-glow" style="background:var(--purple)"></div>
          <div class="kpi-top">
            <div class="kpi-ico" style="background:var(--purple-light)">&#128100;</div>
            <span class="kpi-badge" style="background:var(--purple-light);color:var(--purple)">+6.1%</span>
          </div>
          <div class="kpi-num">1,084</div>
          <div class="kpi-label">Registered Customers</div>
        </div>
      </div>

      <!-- Chart + top products -->
      <div class="dash-mid">
        <div class="card">
          <div class="card-head">
            <div>
              <div class="card-head-title">Sales Revenue</div>
              <div class="card-head-sub">Revenue trend over selected period</div>
            </div>
            <select id="chartRange" class="chart-range-select" onchange="updateChart()">
              <option value="7">Last 7 days</option>
              <option value="14">Last 14 days</option>
              <option value="30">Last 30 days</option>
            </select>
          </div>
          <div class="card-body">
            <div class="chart-wrap"><canvas id="salesChart"></canvas></div>
          </div>
        </div>

        <div class="card">
          <div class="card-head">
            <div>
              <div class="card-head-title">Top Products</div>
              <div class="card-head-sub">By price this month</div>
            </div>
          </div>
          <div class="card-body">
            <div class="qs-list" id="topProductsList"></div>
          </div>
        </div>
      </div>

      <!-- Recent products table (dashboard preview) -->
      <div class="card table-card">
        <div class="table-toolbar">
          <div>
            <div class="card-head-title">Product Catalogue</div>
            <div class="card-head-sub" id="dashProductCount">Loading…</div>
          </div>
          <div style="display:flex;gap:.7rem;align-items:center;flex-wrap:wrap;">
            <div class="table-search">
              <span class="table-search-ico">&#128269;</span>
              <input type="text" id="dashSearch" placeholder="Search products…" oninput="filterDashTable()" />
            </div>
            <button class="btn btn-g" onclick="openAddModal()">&#43; Add Product</button>
          </div>
        </div>
        <div style="overflow-x:auto;">
          <table>
            <thead>
              <tr>
                <th>#</th><th>Product</th><th>Brand</th><th>Category</th>
                <th>Price</th><th>Stock</th><th>Rating</th><th>Actions</th>
              </tr>
            </thead>
            <tbody id="dashTbody">
              <tr><td colspan="8" style="text-align:center;padding:3rem;color:var(--muted)">Loading…</td></tr>
            </tbody>
          </table>
        </div>
      </div>

    </div><!-- /sec-dashboard -->

    <!-- ═══════════════════════════════════════
         PRODUCTS SECTION
    ═══════════════════════════════════════ -->
    <div id="sec-products" style="display:none">

      <div class="sec-head" style="display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:1rem;">
        <div>
          <div class="sec-head-title">Product Management</div>
          <div class="sec-head-sub">Add, edit, and remove products from the store catalogue.</div>
        </div>
        <button class="btn btn-g" onclick="openAddModal()">&#43; Add New Product</button>
      </div>

      <!-- Product stats row -->
      <div class="analytics-grid" style="margin-bottom:1.85rem;">
        <div class="mini-stat">
          <div class="mini-stat-label">Total Products</div>
          <div class="mini-stat-val" id="pStatTotal">—</div>
          <div class="mini-stat-sub">in catalogue</div>
        </div>
        <div class="mini-stat">
          <div class="mini-stat-label">In Stock</div>
          <div class="mini-stat-val" id="pStatInStock">—</div>
          <div class="mini-stat-sub"><span class="mini-stat-up">&#8593;</span> available</div>
        </div>
        <div class="mini-stat">
          <div class="mini-stat-label">Out of Stock</div>
          <div class="mini-stat-val" id="pStatOut">—</div>
          <div class="mini-stat-sub"><span class="mini-stat-down">&#8595;</span> need restock</div>
        </div>
      </div>

      <div class="card table-card">
        <div class="table-toolbar">
          <div>
            <div class="card-head-title">All Products</div>
            <div class="card-head-sub" id="prodMgmtCount">0 products</div>
          </div>
          <div style="display:flex;gap:.7rem;align-items:center;flex-wrap:wrap;">
            <select id="filterCat" onchange="filterProdTable()" style="font-family:var(--ff);font-size:.78rem;padding:.42rem .75rem;border-radius:var(--r-sm);border:1.5px solid var(--border);background:var(--bg);color:var(--text);outline:none;">
              <option value="">All Categories</option>
              <option value="Luxury">Luxury</option>
              <option value="Casual">Casual</option>
              <option value="Sport">Sport</option>
              <option value="Smart">Smart</option>
              <option value="Classic">Classic</option>
            </select>
            <div class="table-search">
              <span class="table-search-ico">&#128269;</span>
              <input type="text" id="prodSearch" placeholder="Search…" oninput="filterProdTable()" />
            </div>
          </div>
        </div>
        <div style="overflow-x:auto;">
          <table>
            <thead>
              <tr>
                <th>#</th><th>Product</th><th>Brand</th><th>Category</th>
                <th>Price</th><th>Old Price</th><th>Stock</th><th>Rating</th><th>Actions</th>
              </tr>
            </thead>
            <tbody id="prodMgmtTbody">
              <tr><td colspan="9" style="text-align:center;padding:3rem;color:var(--muted)">Loading…</td></tr>
            </tbody>
          </table>
        </div>
      </div>
    </div><!-- /sec-products -->

    <!-- ═══════════════════════════════════════
         ORDERS
    ═══════════════════════════════════════ -->
    <div id="sec-orders" style="display:none">
      <div class="sec-head">
        <div class="sec-head-title">Orders</div>
        <div class="sec-head-sub">Manage customer orders and fulfilment.</div>
      </div>
      <div class="placeholder-section">
        <div class="placeholder-ico">&#128230;</div>
        <div class="placeholder-title">Orders Module</div>
        <div class="placeholder-sub">Order management will be available once the orders table is connected to the database.</div>
        <span class="placeholder-badge">Backend Integration Pending</span>
      </div>
    </div>

    <!-- ═══════════════════════════════════════
         CUSTOMERS
    ═══════════════════════════════════════ -->
    <div id="sec-customers" style="display:none">
      <div class="sec-head">
        <div class="sec-head-title">Customers</div>
        <div class="sec-head-sub">Registered user accounts and customer data.</div>
      </div>
      <div class="placeholder-section">
        <div class="placeholder-ico">&#128100;</div>
        <div class="placeholder-title">Customer Accounts</div>
        <div class="placeholder-sub">Customer records will appear here once the user management backend is wired up.</div>
        <span class="placeholder-badge">Backend Integration Pending</span>
      </div>
    </div>

    <!-- ═══════════════════════════════════════
         SALES REPORT
    ═══════════════════════════════════════ -->
    <div id="sec-sales" style="display:none">
      <div class="sec-head">
        <div class="sec-head-title">Sales Report</div>
        <div class="sec-head-sub">Revenue analytics and export tools.</div>
      </div>

      <div class="analytics-grid">
        <div class="mini-stat">
          <div class="mini-stat-label">Monthly Revenue</div>
          <div class="mini-stat-val">Rs 4.28L</div>
          <div class="mini-stat-sub"><span class="mini-stat-up">&#8593; 18.4%</span> vs last month</div>
        </div>
        <div class="mini-stat">
          <div class="mini-stat-label">Avg Order Value</div>
          <div class="mini-stat-val">Rs 1,251</div>
          <div class="mini-stat-sub"><span class="mini-stat-up">&#8593; 4.2%</span> vs last month</div>
        </div>
        <div class="mini-stat">
          <div class="mini-stat-label">Conversion Rate</div>
          <div class="mini-stat-val">3.8%</div>
          <div class="mini-stat-sub"><span class="mini-stat-down">&#8595; 0.3%</span> vs last month</div>
        </div>
      </div>

      <div class="card">
        <div class="card-head">
          <div>
            <div class="card-head-title">Revenue Trend</div>
            <div class="card-head-sub">Last 30 days</div>
          </div>
          <select id="salesChartRange" class="chart-range-select" onchange="updateSalesChart()">
            <option value="7">Last 7 days</option>
            <option value="14">Last 14 days</option>
            <option value="30" selected>Last 30 days</option>
          </select>
        </div>
        <div class="card-body">
          <div class="chart-wrap"><canvas id="salesChart2"></canvas></div>
        </div>
      </div>
    </div>

    <!-- ═══════════════════════════════════════
         INVENTORY
    ═══════════════════════════════════════ -->
    <div id="sec-inventory" style="display:none">
      <div class="sec-head">
        <div class="sec-head-title">Inventory</div>
        <div class="sec-head-sub">Stock levels, reorder alerts, and inventory history.</div>
      </div>
      <div class="placeholder-section">
        <div class="placeholder-ico">&#128373;</div>
        <div class="placeholder-title">Inventory Manager</div>
        <div class="placeholder-sub">Stock tracking, reorder thresholds, and inventory history will appear here once connected.</div>
        <span class="placeholder-badge">Backend Integration Pending</span>
      </div>
    </div>

  </div><!-- /adm-body -->
</div><!-- /adm-main -->

<!-- ══════════════════════════════════════════════════
     ADD / EDIT PRODUCT MODAL
══════════════════════════════════════════════════ -->
<div class="modal-bg" id="productModal">
  <div class="modal" role="dialog" aria-modal="true" aria-labelledby="modalTitle">
    <div class="modal-head">
      <div class="modal-title" id="modalTitle">Add New Product</div>
      <button class="modal-close" onclick="closeProductModal()" aria-label="Close">&#10005;</button>
    </div>
    <div class="modal-body">
      <div class="fg-row">
        <div class="fg">
          <label for="pName">Product Name *</label>
          <input type="text" id="pName" placeholder="e.g. Casio Edifice EF-539D" />
        </div>
        <div class="fg">
          <label for="pBrand">Brand *</label>
          <input type="text" id="pBrand" placeholder="e.g. Casio" />
        </div>
      </div>
      <div class="fg-row">
        <div class="fg">
          <label for="pPrice">Price (Rs) *</label>
          <input type="number" id="pPrice" placeholder="12500" min="0" />
        </div>
        <div class="fg">
          <label for="pOldPrice">Original Price (Rs)</label>
          <input type="number" id="pOldPrice" placeholder="14000 — optional" min="0" />
        </div>
      </div>
      <div class="fg-row">
        <div class="fg">
          <label for="pCategory">Category *</label>
          <select id="pCategory">
            <option value="">— Select —</option>
            <option value="1">Luxury</option>
            <option value="2">Casual</option>
            <option value="3">Sport</option>
            <option value="4">Smart</option>
            <option value="5">Classic</option>
          </select>
        </div>
        <div class="fg">
          <label for="pRating">Rating (0–5)</label>
          <input type="number" id="pRating" placeholder="4.5" min="0" max="5" step="0.1" />
        </div>
      </div>
      <div class="fg">
        <label for="pDesc">Description</label>
        <textarea id="pDesc" placeholder="Brief product description…"></textarea>
      </div>
      <div class="fg">
        <label for="pImg">Image URL</label>
        <input type="text" id="pImg" placeholder="https://… or /static/images/watch.jpg" />
      </div>
      <div class="fg">
        <div class="toggle-wrap">
          <label class="toggle" for="pStock">
            <input type="checkbox" id="pStock" checked />
            <span class="toggle-track"></span>
            <span class="toggle-thumb"></span>
          </label>
          <span class="toggle-label">In Stock</span>
        </div>
      </div>
      <input type="hidden" id="pId" />
    </div>
    <div class="modal-foot">
      <button class="btn btn-o" onclick="closeProductModal()">Cancel</button>
      <button class="btn btn-g" id="modalSaveBtn" onclick="saveProduct()">&#10003; Save Product</button>
    </div>
  </div>
</div>

<!-- ══════════════════════════════════════════════════
     DELETE CONFIRM MODAL
══════════════════════════════════════════════════ -->
<div class="modal-bg" id="delModal">
  <div class="modal" style="max-width:420px;" role="dialog" aria-modal="true">
    <div class="modal-head">
      <div class="modal-title">Confirm Deletion</div>
      <button class="modal-close" onclick="closeDelModal()">&#10005;</button>
    </div>
    <div class="modal-body" style="text-align:center;padding:2rem 1.6rem;">
      <div class="del-ico">&#128465;</div>
      <div style="font-family:var(--ffi);font-size:1.1rem;font-weight:900;color:var(--text);margin-bottom:.5rem;">Delete this product?</div>
      <div style="font-size:.83rem;color:var(--muted);line-height:1.65;">
        "<span id="delProdName" style="font-weight:700;color:var(--text);"></span>" will be permanently removed from the catalogue.
      </div>
    </div>
    <div class="modal-foot">
      <button class="btn btn-o" onclick="closeDelModal()">Cancel</button>
      <button class="btn btn-r" id="delConfirmBtn">&#128465; Delete</button>
    </div>
  </div>
</div>

<div class="toast-container" id="toastContainer"></div>

<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.2/dist/chart.umd.min.js"></script>
<%-- Use scriptlet to output JS so JSP EL parser never sees ${...} inside template literals --%>
<%
out.print("<scr"+"ipt>");
%>
/* ─── In-memory product store ─────────────────────────────── */
let products = [
  { id:1, name:"Casio Edifice EF-539D",   brand:"Casio",    categoryId:3, categoryName:"Sport",   price:12500, oldPrice:14000, rating:4.5, inStock:true,  imageUrl:"", description:"Rugged sport chronograph." },
  { id:2, name:"Seiko Presage SRPE35",     brand:"Seiko",    categoryId:1, categoryName:"Luxury",  price:52000, oldPrice:0,     rating:4.8, inStock:true,  imageUrl:"", description:"Automatic prestige piece." },
  { id:3, name:"Citizen Eco-Drive AT2480", brand:"Citizen",  categoryId:2, categoryName:"Casual",  price:24500, oldPrice:27000, rating:4.3, inStock:false, imageUrl:"", description:"Solar-powered everyday watch." },
  { id:4, name:"Tissot PRX Powermatic",    brand:"Tissot",   categoryId:1, categoryName:"Luxury",  price:85000, oldPrice:0,     rating:4.7, inStock:true,  imageUrl:"", description:"Swiss automatic, tapisserie dial." },
  { id:5, name:"Orient Bambino V4",        brand:"Orient",   categoryId:5, categoryName:"Classic", price:18500, oldPrice:20000, rating:4.4, inStock:true,  imageUrl:"", description:"Hand-wound dress watch." },
  { id:6, name:"Fossil Gen 6 Smartwatch",  brand:"Fossil",   categoryId:4, categoryName:"Smart",   price:32000, oldPrice:36000, rating:4.0, inStock:true,  imageUrl:"", description:"Wear OS smartwatch." },
  { id:7, name:"G-Shock GA-2100",          brand:"Casio",    categoryId:3, categoryName:"Sport",   price:15000, oldPrice:0,     rating:4.6, inStock:false, imageUrl:"", description:"Ultra-thin CasiOak." },
  { id:8, name:"Hamilton Khaki Field Auto",brand:"Hamilton", categoryId:5, categoryName:"Classic", price:125000,oldPrice:0,     rating:4.9, inStock:true,  imageUrl:"", description:"Military-inspired automatic." },
];
let nextId = 9;

/* ─── Section switching ──────────────────────────────────── */
const sectionIds = ['dashboard','products','orders','customers','sales','inventory'];
const sectionTitles = {
  dashboard:'Dashboard', products:'Product Management',
  orders:'Orders', customers:'Customers', sales:'Sales Report', inventory:'Inventory'
};

function showSection(id, el) {
  sectionIds.forEach(function(s) {
    const sec = document.getElementById('sec-' + s);
    if (sec) sec.style.display = s === id ? '' : 'none';
  });
  document.querySelectorAll('.adm-nav-item').forEach(function(a) { a.classList.remove('active'); });
  if (el) el.classList.add('active');
  document.getElementById('topbarTitle').textContent = sectionTitles[id] || id;
  if (id === 'products') { renderProdMgmt(products); }
  if (id === 'sales' && !salesChart2) { buildSalesChart2(); }
}

/* ─── Escape single quotes for inline onclick attrs ─────── */
function esc(s) { return s.split("'").join("&#39;"); }

/* ─── Table row builder ──────────────────────────────────── */
function buildRow(p, cols9) {
  const imgCell = p.imageUrl
    ? '<img src="' + p.imageUrl + '" style="width:44px;height:44px;border-radius:10px;object-fit:cover;border:1.5px solid var(--border);">'
    : '<div class="td-thumb">&#8987;</div>';
  const stockCell = p.inStock
    ? '<span class="stock-yes">In Stock</span>'
    : '<span class="stock-no">Out of Stock</span>';
  const ratingCell = '<span style="color:var(--gold);font-size:.78rem;">&#9733;</span> <span style="font-size:.76rem;font-weight:700;">' + p.rating + '</span>';
  const safeNameJs = esc(p.name);
  const actions = '<div class="tbl-actions">'
    + '<button class="tbl-btn tbl-btn-edit" onclick="openEditModal(' + p.id + ')">&#9998; Edit</button>'
    + '<button class="tbl-btn tbl-btn-del" onclick="openDelModal(' + p.id + ',\'' + safeNameJs + '\')">&#128465;</button>'
    + '</div>';
  const oldPriceCell = p.oldPrice ? 'Rs ' + p.oldPrice.toLocaleString() : '&mdash;';
  const descCell = p.description ? p.description.slice(0, 36) + '&hellip;' : '&mdash;';

  if (cols9) {
    return '<tr>'
      + '<td style="color:var(--dim);font-size:.75rem;">' + p.id + '</td>'
      + '<td><div style="display:flex;align-items:center;gap:.75rem;">' + imgCell + '<div><div class="td-name">' + p.name + '</div><div class="td-desc">' + descCell + '</div></div></div></td>'
      + '<td>' + p.brand + '</td>'
      + '<td><span class="cat-pill">' + p.categoryName + '</span></td>'
      + '<td class="td-price">Rs ' + p.price.toLocaleString() + '</td>'
      + '<td style="font-size:.78rem;color:var(--muted);text-decoration:line-through;">' + oldPriceCell + '</td>'
      + '<td>' + stockCell + '</td>'
      + '<td>' + ratingCell + '</td>'
      + '<td>' + actions + '</td>'
      + '</tr>';
  } else {
    return '<tr>'
      + '<td style="color:var(--dim);font-size:.75rem;">' + p.id + '</td>'
      + '<td><div style="display:flex;align-items:center;gap:.75rem;">' + imgCell + '<div><div class="td-name">' + p.name + '</div><div class="td-desc">' + descCell + '</div></div></div></td>'
      + '<td>' + p.brand + '</td>'
      + '<td><span class="cat-pill">' + p.categoryName + '</span></td>'
      + '<td class="td-price">Rs ' + p.price.toLocaleString() + '</td>'
      + '<td>' + stockCell + '</td>'
      + '<td>' + ratingCell + '</td>'
      + '<td>' + actions + '</td>'
      + '</tr>';
  }
}

/* ─── Dashboard table ────────────────────────────────────── */
function renderDashTable(list) {
  const tbody = document.getElementById('dashTbody');
  document.getElementById('dashProductCount').textContent =
    list.length + ' product' + (list.length !== 1 ? 's' : '') + ' in catalogue';
  updateKpi();
  if (!list.length) {
    tbody.innerHTML = '<tr><td colspan="8" style="text-align:center;padding:3rem;color:var(--muted);">No products found.</td></tr>';
    return;
  }
  tbody.innerHTML = list.map(function(p) { return buildRow(p, false); }).join('');
}

function filterDashTable() {
  const q = document.getElementById('dashSearch').value.toLowerCase();
  renderDashTable(q ? products.filter(function(p) {
    return p.name.toLowerCase().indexOf(q) !== -1 || p.brand.toLowerCase().indexOf(q) !== -1 || p.categoryName.toLowerCase().indexOf(q) !== -1;
  }) : products);
}

/* ─── Products management table ─────────────────────────── */
function renderProdMgmt(list) {
  const tbody = document.getElementById('prodMgmtTbody');
  const inStock = list.filter(function(p) { return p.inStock; }).length;
  document.getElementById('prodMgmtCount').textContent = list.length + ' products';
  document.getElementById('pStatTotal').textContent   = list.length;
  document.getElementById('pStatInStock').textContent = inStock;
  document.getElementById('pStatOut').textContent     = list.length - inStock;
  if (!list.length) {
    tbody.innerHTML = '<tr><td colspan="9" style="text-align:center;padding:3rem;color:var(--muted);">No products found.</td></tr>';
    return;
  }
  tbody.innerHTML = list.map(function(p) { return buildRow(p, true); }).join('');
}

function filterProdTable() {
  const q   = document.getElementById('prodSearch').value.toLowerCase();
  const cat = document.getElementById('filterCat').value;
  let list  = products;
  if (cat) list = list.filter(function(p) { return p.categoryName === cat; });
  if (q)   list = list.filter(function(p) { return p.name.toLowerCase().indexOf(q) !== -1 || p.brand.toLowerCase().indexOf(q) !== -1; });
  renderProdMgmt(list);
}

/* ─── Top Products list ───────────────────────────────────── */
const topColors = ['var(--green)','var(--gold)','#3b82f6','#7c3aed','#d97706'];
function renderTopProducts() {
  const sorted = products.slice().sort(function(a, b) { return b.price - a.price; }).slice(0, 5);
  document.getElementById('topProductsList').innerHTML = sorted.map(function(p, i) {
    return '<div class="qs-item">'
      + '<div class="qs-left">'
      + '<div class="qs-dot" style="background:' + topColors[i] + '"></div>'
      + '<div><div class="qs-name">' + p.name + '</div><div class="qs-cat">' + p.brand + ' &middot; ' + p.categoryName + '</div></div>'
      + '</div>'
      + '<div class="qs-val">Rs ' + p.price.toLocaleString() + '</div>'
      + '</div>';
  }).join('');
}

/* ─── KPI update ─────────────────────────────────────────── */
function updateKpi() {
  const c = products.filter(function(p) { return p.inStock; }).length;
  document.getElementById('kpiStockCount').textContent = c;
}

/* ─── Add / Edit Modal ───────────────────────────────────── */
function openAddModal() {
  document.getElementById('modalTitle').textContent = 'Add New Product';
  document.getElementById('modalSaveBtn').textContent = '✓ Save Product';
  clearForm();
  document.getElementById('productModal').classList.add('open');
}

function openEditModal(id) {
  const p = products.find(function(x) { return x.id === id; });
  if (!p) return;
  document.getElementById('modalTitle').textContent = 'Edit Product';
  document.getElementById('modalSaveBtn').textContent = '✓ Update Product';
  document.getElementById('pId').value       = p.id;
  document.getElementById('pName').value     = p.name;
  document.getElementById('pBrand').value    = p.brand;
  document.getElementById('pPrice').value    = p.price;
  document.getElementById('pOldPrice').value = p.oldPrice || '';
  document.getElementById('pCategory').value = p.categoryId;
  document.getElementById('pRating').value   = p.rating;
  document.getElementById('pDesc').value     = p.description;
  document.getElementById('pImg').value      = p.imageUrl;
  document.getElementById('pStock').checked  = p.inStock;
  document.getElementById('productModal').classList.add('open');
}

function closeProductModal() { document.getElementById('productModal').classList.remove('open'); }

function clearForm() {
  ['pId','pName','pBrand','pPrice','pOldPrice','pDesc','pImg','pRating'].forEach(function(id) { document.getElementById(id).value = ''; });
  document.getElementById('pCategory').value = '';
  document.getElementById('pStock').checked  = true;
}

const catNames = {'1':'Luxury','2':'Casual','3':'Sport','4':'Smart','5':'Classic'};

function saveProduct() {
  const name  = document.getElementById('pName').value.trim();
  const brand = document.getElementById('pBrand').value.trim();
  const price = parseFloat(document.getElementById('pPrice').value);
  const catId = document.getElementById('pCategory').value;
  if (!name || !brand || isNaN(price) || !catId) {
    showToast('Please fill all required fields.', 'error'); return;
  }
  const id     = document.getElementById('pId').value;
  const isEdit = !!id;
  const obj = {
    id:           isEdit ? parseInt(id) : nextId++,
    name: name, brand: brand,
    categoryId:   parseInt(catId),
    categoryName: catNames[catId] || catId,
    price:        price,
    oldPrice:     parseFloat(document.getElementById('pOldPrice').value) || 0,
    rating:       parseFloat(document.getElementById('pRating').value) || 0,
    description:  document.getElementById('pDesc').value.trim(),
    imageUrl:     document.getElementById('pImg').value.trim(),
    inStock:      document.getElementById('pStock').checked,
  };
  if (isEdit) {
    const idx = products.findIndex(function(x) { return x.id === obj.id; });
    if (idx !== -1) products[idx] = obj;
    showToast('Product updated successfully!', 'success');
  } else {
    products.push(obj);
    showToast('Product added successfully!', 'success');
  }
  closeProductModal();
  renderDashTable(products);
  renderTopProducts();
  renderProdMgmt(products);
}

/* ─── Delete Modal ───────────────────────────────────────── */
let deletingId = null;
function openDelModal(id, name) {
  deletingId = id;
  document.getElementById('delProdName').textContent = name;
  document.getElementById('delModal').classList.add('open');
  document.getElementById('delConfirmBtn').onclick = confirmDelete;
}
function closeDelModal() { document.getElementById('delModal').classList.remove('open'); deletingId = null; }
function confirmDelete() {
  if (!deletingId) return;
  products = products.filter(function(p) { return p.id !== deletingId; });
  closeDelModal();
  renderDashTable(products);
  renderTopProducts();
  renderProdMgmt(products);
  showToast('Product deleted.', 'error');
}

/* ─── Toast ──────────────────────────────────────────────── */
function showToast(msg, type) {
  type = type || '';
  const c = document.getElementById('toastContainer');
  const t = document.createElement('div');
  t.className = 'toast ' + type;
  const ico = type === 'success' ? '✓' : type === 'error' ? '✕' : 'ℹ';
  t.innerHTML = '<span class="toast-ico">' + ico + '</span> ' + msg;
  c.appendChild(t);
  setTimeout(function() {
    t.style.opacity = '0'; t.style.transform = 'translateX(22px)'; t.style.transition = 'all .3s';
    setTimeout(function() { t.remove(); }, 320);
  }, 2800);
}

/* ─── Chart utils ────────────────────────────────────────── */
const rand = function(a, b) { return Math.floor(Math.random() * (b - a + 1)) + a; };
const genData = function(n) { return Array.from({length: n}, function() { return rand(8000, 55000); }); };
const labels7  = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
const labels14 = Array.from({length:14}, function(_, i) { return 'Day ' + (i+1); });
const labels30 = Array.from({length:30}, function(_, i) { return 'Day ' + (i+1); });
const getLabels = function(n) { return n === 7 ? labels7 : n === 14 ? labels14 : labels30; };

function chartConfig(n) {
  return {
    type: 'line',
    data: {
      labels: getLabels(n),
      datasets: [{
        label: 'Revenue (Rs)',
        data: genData(n),
        borderColor: '#1a6b38',
        backgroundColor: 'rgba(26,107,56,0.08)',
        fill: true, tension: 0.42,
        pointRadius: 4, pointBackgroundColor: '#1a6b38',
        pointBorderColor: '#fff', pointBorderWidth: 2, pointHoverRadius: 6,
      }]
    },
    options: {
      responsive: true, maintainAspectRatio: false,
      interaction: { mode: 'index', intersect: false },
      plugins: {
        legend: { display: false },
        tooltip: {
          backgroundColor: '#0b1c10',
          titleFont: { family: "'Inter',sans-serif", weight: '700', size: 11 },
          bodyFont:  { family: "'Inter',sans-serif", size: 11 },
          padding: 11, cornerRadius: 10,
          callbacks: { label: function(ctx) { return ' Rs ' + ctx.raw.toLocaleString(); } }
        }
      },
      scales: {
        x: { grid: { display: false }, ticks: { font: { family:"'Inter',sans-serif", size:10 }, color:'#4e6a59' } },
        y: {
          grid: { color: 'rgba(0,0,0,0.04)' },
          ticks: { font: { family:"'Inter',sans-serif", size:10 }, color:'#4e6a59',
            callback: function(v) { return 'Rs ' + (v/1000).toFixed(0) + 'k'; }
          }
        }
      }
    }
  };
}

let salesChart, salesChart2;

function buildChart() {
  salesChart = new Chart(document.getElementById('salesChart').getContext('2d'), chartConfig(7));
}
function updateChart() {
  const n = parseInt(document.getElementById('chartRange').value);
  salesChart.data.labels = getLabels(n);
  salesChart.data.datasets[0].data = genData(n);
  salesChart.update('active');
}
function buildSalesChart2() {
  salesChart2 = new Chart(document.getElementById('salesChart2').getContext('2d'), chartConfig(30));
}
function updateSalesChart() {
  const n = parseInt(document.getElementById('salesChartRange').value);
  salesChart2.data.labels = getLabels(n);
  salesChart2.data.datasets[0].data = genData(n);
  salesChart2.update('active');
}

/* Live ticker */
setInterval(function() {
  if (!salesChart) return;
  const ds = salesChart.data.datasets[0].data;
  ds.push(rand(8000, 55000)); ds.shift();
  salesChart.update('none');
}, 5000);

/* ─── Backdrop close ─────────────────────────────────────── */
document.getElementById('productModal').addEventListener('click', function(e) { if (e.target === e.currentTarget) closeProductModal(); });
document.getElementById('delModal').addEventListener('click', function(e) { if (e.target === e.currentTarget) closeDelModal(); });

/* ─── Init ───────────────────────────────────────────────── */
document.addEventListener('DOMContentLoaded', function() {
  renderDashTable(products);
  renderTopProducts();
  updateKpi();
  buildChart();
});
<%
out.print("</scr"+"ipt>");
%>
</body>
</html>
