<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Admin Dashboard | AluGhadi</title>
  <meta name="description" content="AluGhadi admin panel – manage products, view sales and monitor inventory." />
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&family=Playfair+Display:ital,wght@0,700;0,900;1,700&display=swap" rel="stylesheet" />
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
      --ff:  'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
      --ffi: 'Playfair Display', Georgia, serif;
      --r:    18px;
      --r-sm: 11px;
      --ease: cubic-bezier(0.16, 1, 0.3, 1);
      --shadow:    0 2px 16px rgba(10,30,15,.07);
      --shadow-md: 0 6px 28px rgba(10,30,15,.10);
      --shadow-lg: 0 14px 52px rgba(10,30,15,.14);
      --sidebar-w: 260px;
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

    /* ── Scrollbar ─────────────────────────────────────────────── */
    ::-webkit-scrollbar       { width: 5px; height: 5px; }
    ::-webkit-scrollbar-track { background: var(--bg); }
    ::-webkit-scrollbar-thumb { background: var(--green-mid); border-radius: 6px; }
    ::-webkit-scrollbar-thumb:hover { background: var(--green); }

    /* ══════════════════════════════════════════════════════════════
       SIDEBAR
    ══════════════════════════════════════════════════════════════ */
    .adm-sidebar {
      width:      var(--sidebar-w);
      min-height: 100vh;
      background: var(--text);
      position:   fixed;
      top: 0; left: 0; bottom: 0;
      display:        flex;
      flex-direction: column;
      z-index: 200;
      overflow-y: auto;
    }

    /* Logo strip */
    .adm-logo {
      padding:     1.6rem 1.5rem 1.4rem;
      border-bottom: 1px solid rgba(255,255,255,.08);
      display:     flex;
      align-items: center;
      gap:         0.7rem;
    }
    .adm-logo-mark {
      width:           40px; height: 40px;
      background:      linear-gradient(135deg, var(--green) 0%, var(--accent) 100%);
      border-radius:   11px;
      display:         flex;
      align-items:     center;
      justify-content: center;
      font-family:     var(--ffi);
      font-weight:     900;
      font-size:       1.1rem;
      color:           #fff;
      letter-spacing:  -0.02em;
      flex-shrink:     0;
    }
    .adm-logo-txt { flex: 1; }
    .adm-logo-brand {
      font-family:    var(--ffi);
      font-weight:    900;
      font-size:      1.1rem;
      color:          #fff;
      letter-spacing: -0.02em;
      line-height:    1;
    }
    .adm-logo-sub {
      font-size:   0.62rem;
      font-weight: 600;
      letter-spacing: 0.14em;
      text-transform: uppercase;
      color:       rgba(255,255,255,.38);
      margin-top:  0.18rem;
    }

    /* Nav */
    .adm-nav { flex: 1; padding: 1.1rem 0.75rem; display: flex; flex-direction: column; gap: 2px; }
    .adm-nav-label {
      font-size:      0.6rem;
      font-weight:    700;
      letter-spacing: 0.18em;
      text-transform: uppercase;
      color:          rgba(255,255,255,.28);
      padding:        0.8rem 0.75rem 0.38rem;
      margin-top:     0.6rem;
    }
    .adm-nav a {
      display:     flex;
      align-items: center;
      gap:         0.7rem;
      padding:     0.68rem 0.85rem;
      border-radius: 10px;
      font-size:   0.83rem;
      font-weight: 500;
      color:       rgba(255,255,255,.55);
      transition:  all 0.18s var(--ease);
    }
    .adm-nav a:hover  { color: #fff; background: rgba(255,255,255,.07); }
    .adm-nav a.active { color: #fff; background: linear-gradient(135deg, var(--green) 0%, var(--accent) 100%); font-weight: 700; box-shadow: 0 4px 14px rgba(26,107,56,.4); }
    .adm-nav a .nav-ico { font-size: 1rem; width: 20px; text-align: center; flex-shrink: 0; }

    /* User mini */
    .adm-user {
      margin: 0.75rem;
      padding: 0.9rem 1rem;
      background: rgba(255,255,255,.06);
      border-radius: 12px;
      border: 1px solid rgba(255,255,255,.08);
      display: flex;
      align-items: center;
      gap: 0.65rem;
    }
    .adm-user-av {
      width:           36px; height: 36px;
      background:      linear-gradient(135deg, var(--green) 0%, var(--accent) 100%);
      border-radius:   50%;
      display:         flex;
      align-items:     center;
      justify-content: center;
      font-weight:     800;
      font-size:       0.78rem;
      color:           #fff;
      flex-shrink:     0;
    }
    .adm-user-name  { font-size: 0.8rem; font-weight: 700; color: #fff; line-height: 1.2; }
    .adm-user-role  { font-size: 0.65rem; color: var(--accent); font-weight: 600; }

    /* ══════════════════════════════════════════════════════════════
       MAIN CONTENT
    ══════════════════════════════════════════════════════════════ */
    .adm-main {
      margin-left: var(--sidebar-w);
      flex: 1;
      display: flex;
      flex-direction: column;
      min-height: 100vh;
    }

    /* Top bar */
    .adm-topbar {
      background:    var(--white);
      border-bottom: 1.5px solid var(--border);
      padding:       0 2rem;
      height:        68px;
      display:       flex;
      align-items:   center;
      justify-content: space-between;
      position:      sticky;
      top:           0;
      z-index:       100;
    }
    .adm-topbar-title {
      font-family:    var(--ffi);
      font-size:      1.35rem;
      font-weight:    900;
      color:          var(--text);
      letter-spacing: -0.025em;
    }
    .adm-topbar-right { display: flex; align-items: center; gap: 0.8rem; }
    .adm-topbar-chip {
      display:       inline-flex;
      align-items:   center;
      gap:           0.4rem;
      background:    var(--green-light);
      border:        1.5px solid var(--green-mid);
      color:         var(--green);
      padding:       0.32rem 0.9rem;
      border-radius: 999px;
      font-size:     0.72rem;
      font-weight:   700;
    }
    .topbar-dot {
      width:         7px; height: 7px;
      background:    var(--accent);
      border-radius: 50%;
      animation:     pulse 2s ease-in-out infinite;
    }
    @keyframes pulse { 0%,100%{opacity:1;transform:scale(1)} 50%{opacity:.55;transform:scale(.8)} }

    /* Page body */
    .adm-body { padding: 2.25rem 2rem 4rem; flex: 1; }

    /* ── KPI Cards ────────────────────────────────────────────── */
    .kpi-grid {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 1.25rem;
      margin-bottom: 2rem;
    }
    .kpi-card {
      background:     var(--white);
      border:         1.5px solid var(--border);
      border-radius:  20px;
      padding:        1.65rem 1.5rem;
      position:       relative;
      overflow:       hidden;
      transition:     all 0.3s var(--ease);
    }
    .kpi-card:hover { transform: translateY(-4px); box-shadow: var(--shadow-lg); border-color: var(--green-mid); }
    .kpi-card-glow {
      position:   absolute;
      top: -30px; right: -30px;
      width:      110px; height: 110px;
      border-radius: 50%;
      opacity:    0.08;
    }
    .kpi-top { display: flex; align-items: center; justify-content: space-between; margin-bottom: 1rem; }
    .kpi-ico {
      width:           44px; height: 44px;
      border-radius:   13px;
      display:         flex;
      align-items:     center;
      justify-content: center;
      font-size:       1.3rem;
    }
    .kpi-badge {
      font-size:   0.7rem;
      font-weight: 700;
      padding:     0.2rem 0.6rem;
      border-radius: 999px;
    }
    .kpi-num {
      font-family:    var(--ffi);
      font-size:      2.1rem;
      font-weight:    900;
      letter-spacing: -0.04em;
      line-height:    1;
      color:          var(--text);
      margin-bottom:  0.25rem;
    }
    .kpi-label {
      font-size:   0.73rem;
      font-weight: 600;
      color:       var(--muted);
      letter-spacing: 0.02em;
    }

    /* ── Grid: chart + quick stats ──────────────────────────── */
    .dash-mid {
      display: grid;
      grid-template-columns: 1fr 340px;
      gap: 1.35rem;
      margin-bottom: 2rem;
    }

    .card {
      background:    var(--white);
      border:        1.5px solid var(--border);
      border-radius: 20px;
      overflow:      hidden;
    }
    .card-head {
      padding:        1.3rem 1.5rem 0;
      display:        flex;
      align-items:    center;
      justify-content: space-between;
      margin-bottom:  1.1rem;
    }
    .card-head-title {
      font-family:    var(--ffi);
      font-size:      1.05rem;
      font-weight:    900;
      letter-spacing: -0.02em;
      color:          var(--text);
    }
    .card-head-sub {
      font-size:   0.72rem;
      color:       var(--muted);
      font-weight: 500;
      margin-top:  0.1rem;
    }
    .card-body { padding: 0 1.5rem 1.5rem; }

    /* Chart canvas wrapper */
    .chart-wrap {
      height:    240px;
      position:  relative;
    }
    canvas#salesChart { width: 100% !important; height: 100% !important; }

    /* Quick-stats list */
    .qs-list { display: flex; flex-direction: column; gap: 0; }
    .qs-item {
      display:         flex;
      align-items:     center;
      justify-content: space-between;
      padding:         0.85rem 0;
      border-bottom:   1px solid var(--border);
    }
    .qs-item:last-child { border-bottom: none; }
    .qs-left { display: flex; align-items: center; gap: 0.65rem; }
    .qs-dot  { width: 10px; height: 10px; border-radius: 50%; flex-shrink: 0; }
    .qs-name { font-size: 0.83rem; font-weight: 600; color: var(--text); }
    .qs-cat  { font-size: 0.68rem; color: var(--muted); margin-top: 0.05rem; }
    .qs-val  { font-family: var(--ffi); font-size: 1rem; font-weight: 900; color: var(--text); letter-spacing: -0.02em; }

    /* ── Products Table ─────────────────────────────────────── */
    .table-card { margin-bottom: 2rem; }
    .table-toolbar {
      padding: 1.3rem 1.5rem;
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 1rem;
      flex-wrap: wrap;
      border-bottom: 1.5px solid var(--border);
    }
    .table-search {
      display:     flex;
      align-items: center;
      gap:         0.5rem;
      background:  var(--bg);
      border:      1.5px solid var(--border);
      border-radius: var(--r-sm);
      padding:     0.48rem 0.9rem;
      min-width:   220px;
    }
    .table-search input {
      border:      none;
      background:  transparent;
      font-family: var(--ff);
      font-size:   0.83rem;
      color:       var(--text);
      outline:     none;
      width:       100%;
    }
    .table-search input::placeholder { color: var(--dim); }
    .table-search-ico { color: var(--dim); font-size: 0.9rem; flex-shrink: 0; }

    table {
      width:           100%;
      border-collapse: collapse;
    }
    thead th {
      font-size:      0.67rem;
      font-weight:    700;
      letter-spacing: 0.1em;
      text-transform: uppercase;
      color:          var(--muted);
      padding:        0.75rem 1.35rem;
      background:     var(--surface2);
      text-align:     left;
      border-bottom:  1.5px solid var(--border);
    }
    tbody tr {
      border-bottom: 1px solid var(--border);
      transition:    background 0.15s;
    }
    tbody tr:last-child { border-bottom: none; }
    tbody tr:hover { background: var(--surface2); }
    tbody td {
      padding:     0.9rem 1.35rem;
      font-size:   0.83rem;
      font-weight: 500;
      color:       var(--text);
      vertical-align: middle;
    }
    .td-img {
      width:         46px; height: 46px;
      border-radius: 10px;
      object-fit:    cover;
      background:    var(--surface);
      border:        1.5px solid var(--border);
      display:       flex;
      align-items:   center;
      justify-content: center;
      font-size:     1.2rem;
    }
    .td-name    { font-weight: 700; color: var(--text); }
    .td-brand   { font-size: 0.72rem; color: var(--muted); margin-top: 0.08rem; }
    .td-price   { font-family: var(--ffi); font-weight: 900; letter-spacing: -0.02em; }
    .stock-yes  { display: inline-flex; align-items: center; gap: 0.35rem; color: var(--green); font-weight: 700; font-size: 0.72rem; }
    .stock-no   { display: inline-flex; align-items: center; gap: 0.35rem; color: var(--red);  font-weight: 700; font-size: 0.72rem; }
    .stock-yes::before, .stock-no::before {
      content: ''; width: 7px; height: 7px; border-radius: 50%; flex-shrink: 0;
    }
    .stock-yes::before { background: var(--green); }
    .stock-no::before  { background: var(--red); }

    /* Action buttons in table */
    .tbl-actions { display: flex; gap: 0.4rem; align-items: center; }
    .tbl-btn {
      border:        none;
      border-radius: 8px;
      padding:       0.38rem 0.7rem;
      font-size:     0.72rem;
      font-weight:   700;
      font-family:   var(--ff);
      transition:    all 0.18s;
    }
    .tbl-btn-edit { background: var(--green-light); color: var(--green); }
    .tbl-btn-edit:hover { background: var(--green); color: #fff; }
    .tbl-btn-del  { background: #fff1f1; color: var(--red); }
    .tbl-btn-del:hover  { background: var(--red); color: #fff; }

    /* Buttons */
    .btn {
      display:     inline-flex;
      align-items: center;
      gap:         0.45rem;
      padding:     0.72rem 1.5rem;
      border-radius: var(--r-sm);
      font-family: var(--ff);
      font-weight: 700;
      font-size:   0.83rem;
      cursor:      pointer;
      border:      none;
      transition:  all 0.22s var(--ease);
      white-space: nowrap;
      text-decoration: none;
    }
    .btn-g {
      background: linear-gradient(135deg, var(--green) 0%, var(--green2) 100%);
      color:      #fff;
      box-shadow: 0 3px 14px rgba(26,107,56,.3);
    }
    .btn-g:hover { transform: translateY(-2px); box-shadow: 0 8px 26px rgba(26,107,56,.40); }
    .btn-o {
      background:  var(--white);
      color:       var(--text);
      border:      1.5px solid var(--border2);
    }
    .btn-o:hover { border-color: var(--green); color: var(--green); background: var(--green-light); }
    .btn-r { background: #fff1f1; color: var(--red); border: 1.5px solid rgba(200,60,60,.18); }
    .btn-r:hover { background: var(--red); color: #fff; }

    /* ══════════════════════════════════════════════════════════════
       MODAL
    ══════════════════════════════════════════════════════════════ */
    .modal-bg {
      position:   fixed;
      inset:      0;
      background: rgba(8,20,12,.55);
      backdrop-filter: blur(5px);
      z-index:    400;
      display:    none;
      align-items: center;
      justify-content: center;
      padding:    1rem;
    }
    .modal-bg.open { display: flex; }
    .modal {
      background:    var(--white);
      border-radius: 24px;
      width:         100%;
      max-width:     540px;
      max-height:    90vh;
      overflow-y:    auto;
      box-shadow:    0 32px 96px rgba(8,20,12,.28);
      animation:     modalIn 0.32s var(--ease) both;
    }
    @keyframes modalIn { from{opacity:0;transform:translateY(24px) scale(.97)} to{opacity:1;transform:none} }
    .modal-head {
      padding:        1.5rem 1.65rem 1rem;
      display:        flex;
      align-items:    center;
      justify-content: space-between;
      border-bottom:  1.5px solid var(--border);
    }
    .modal-title {
      font-family:    var(--ffi);
      font-size:      1.25rem;
      font-weight:    900;
      letter-spacing: -0.025em;
      color:          var(--text);
    }
    .modal-close {
      border:        none;
      background:    var(--surface);
      width:         34px; height: 34px;
      border-radius: 50%;
      font-size:     1rem;
      display:       flex;
      align-items:   center;
      justify-content: center;
      color:         var(--muted);
      transition:    all 0.18s;
    }
    .modal-close:hover { background: #fff1f1; color: var(--red); }
    .modal-body { padding: 1.5rem 1.65rem; }
    .modal-foot {
      padding:      1rem 1.65rem 1.5rem;
      display:      flex;
      gap:          0.75rem;
      justify-content: flex-end;
      border-top:   1.5px solid var(--border);
    }

    /* Form fields */
    .fg { margin-bottom: 1.15rem; }
    .fg label {
      display:     block;
      font-size:   0.71rem;
      font-weight: 700;
      color:       var(--text2);
      margin-bottom: 0.45rem;
      letter-spacing: 0.025em;
    }
    .fg input, .fg select, .fg textarea {
      width:         100%;
      background:    var(--bg);
      border:        1.5px solid var(--border);
      border-radius: var(--r-sm);
      padding:       0.75rem 1rem;
      font-family:   var(--ff);
      font-size:     0.84rem;
      color:         var(--text);
      outline:       none;
      transition:    all 0.2s var(--ease);
      appearance:    none;
    }
    .fg input:focus, .fg select:focus, .fg textarea:focus {
      border-color: var(--green);
      background:   var(--white);
      box-shadow:   0 0 0 3px rgba(26,107,56,.08);
    }
    .fg textarea { resize: vertical; min-height: 90px; }
    .fg-row { display: grid; grid-template-columns: 1fr 1fr; gap: 0.85rem; }

    /* Toggle switch */
    .toggle-wrap { display: flex; align-items: center; gap: 0.7rem; }
    .toggle {
      position: relative; width: 44px; height: 24px;
      --tw: calc(44px - 4px - 20px);
    }
    .toggle input { opacity: 0; width: 0; height: 0; }
    .toggle-track {
      position:      absolute; inset: 0;
      background:    var(--border2);
      border-radius: 12px;
      transition:    background 0.22s;
    }
    .toggle input:checked ~ .toggle-track { background: var(--green); }
    .toggle-thumb {
      position:      absolute;
      top: 2px; left: 2px;
      width:         20px; height: 20px;
      background:    #fff;
      border-radius: 50%;
      box-shadow:    0 2px 6px rgba(0,0,0,.2);
      transition:    transform 0.22s var(--ease);
    }
    .toggle input:checked ~ .toggle-thumb { transform: translateX(var(--tw)); }
    .toggle-label { font-size: 0.82rem; font-weight: 600; color: var(--text); }

    /* Delete confirm modal */
    .del-modal-ico {
      width:           64px; height: 64px;
      background:      #fff1f1;
      border-radius:   50%;
      margin:          0 auto 1rem;
      display:         flex;
      align-items:     center;
      justify-content: center;
      font-size:       2rem;
    }

    /* ── Toast ──────────────────────────────────────────────── */
    .toast-container {
      position:  fixed;
      top:       1.25rem;
      right:     1.25rem;
      z-index:   600;
      display:   flex;
      flex-direction: column;
      gap:       0.5rem;
      pointer-events: none;
    }
    .toast {
      background:    var(--text);
      color:         #fff;
      padding:       0.85rem 1.3rem;
      border-radius: 13px;
      font-size:     0.82rem;
      font-weight:   600;
      display:       flex;
      align-items:   center;
      gap:           0.6rem;
      box-shadow:    var(--shadow-lg);
      animation:     toastIn 0.3s var(--ease) both;
      pointer-events: auto;
      max-width:     320px;
    }
    @keyframes toastIn { from{opacity:0;transform:translateX(24px)} to{opacity:1;transform:none} }
    .toast.success { background: var(--green); }
    .toast.error   { background: var(--red);   }
    .toast-ico { font-size: 1rem; flex-shrink: 0; }
  </style>
</head>
<body>

<!-- ══════════════════════════════════════════════════
     SIDEBAR
══════════════════════════════════════════════════ -->
<aside class="adm-sidebar" id="admSidebar">
  <div class="adm-logo">
    <div class="adm-logo-mark">AG</div>
    <div class="adm-logo-txt">
      <div class="adm-logo-brand">AluGhadi</div>
      <div class="adm-logo-sub">Admin Panel</div>
    </div>
  </div>

  <nav class="adm-nav">
    <div class="adm-nav-label">Main</div>
    <a href="#" class="active" onclick="showSection('dashboard',this)">
      <span class="nav-ico">&#9778;</span> Dashboard
    </a>
    <a href="#" onclick="showSection('products',this)">
      <span class="nav-ico">&#128718;</span> Products
    </a>
    <a href="#" onclick="showSection('orders',this)">
      <span class="nav-ico">&#128230;</span> Orders
    </a>
    <a href="#" onclick="showSection('customers',this)">
      <span class="nav-ico">&#128100;</span> Customers
    </a>

    <div class="adm-nav-label">Analytics</div>
    <a href="#" onclick="showSection('sales',this)">
      <span class="nav-ico">&#128200;</span> Sales Report
    </a>
    <a href="#" onclick="showSection('inventory',this)">
      <span class="nav-ico">&#128179;</span> Inventory
    </a>

    <div class="adm-nav-label">System</div>
    <a href="${pageContext.request.contextPath}/" target="_blank">
      <span class="nav-ico">&#127760;</span> View Site
    </a>
    <a href="${pageContext.request.contextPath}/logout">
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
    <div class="adm-topbar-title" id="topbarTitle">Dashboard</div>
    <div class="adm-topbar-right">
      <div class="adm-topbar-chip">
        <span class="topbar-dot"></span> Live
      </div>
      <button class="btn btn-g" onclick="openAddModal()">&#43; Add Product</button>
    </div>
  </header>

  <!-- Body -->
  <div class="adm-body">

    <!-- ═══════════════════════════════════════
         DASHBOARD SECTION
    ═══════════════════════════════════════ -->
    <div id="sec-dashboard">

      <!-- KPI Cards -->
      <div class="kpi-grid">

        <!-- Revenue -->
        <div class="kpi-card">
          <div class="kpi-card-glow" style="background:var(--green);"></div>
          <div class="kpi-top">
            <div class="kpi-ico" style="background:var(--green-light);">&#128178;</div>
            <span class="kpi-badge" style="background:var(--green-light);color:var(--green);">+18.4%</span>
          </div>
          <div class="kpi-num">Rs 4.28L</div>
          <div class="kpi-label">Total Revenue (Month)</div>
        </div>

        <!-- Orders -->
        <div class="kpi-card">
          <div class="kpi-card-glow" style="background:#3b82f6;"></div>
          <div class="kpi-top">
            <div class="kpi-ico" style="background:#eff6ff;">&#128230;</div>
            <span class="kpi-badge" style="background:#eff6ff;color:#1d4ed8;">+12.7%</span>
          </div>
          <div class="kpi-num">342</div>
          <div class="kpi-label">Orders This Month</div>
        </div>

        <!-- Products in Stock -->
        <div class="kpi-card">
          <div class="kpi-card-glow" style="background:var(--gold);"></div>
          <div class="kpi-top">
            <div class="kpi-ico" style="background:var(--gold-light);">&#128718;</div>
            <span class="kpi-badge" style="background:var(--gold-light);color:var(--gold2);" id="kpiStockBadge">In Stock</span>
          </div>
          <div class="kpi-num" id="kpiStockCount">—</div>
          <div class="kpi-label">Products in Stock</div>
        </div>

        <!-- Customers -->
        <div class="kpi-card">
          <div class="kpi-card-glow" style="background:#7c3aed;"></div>
          <div class="kpi-top">
            <div class="kpi-ico" style="background:#f5f3ff;">&#128100;</div>
            <span class="kpi-badge" style="background:#f5f3ff;color:#6d28d9;">+6.1%</span>
          </div>
          <div class="kpi-num">1,084</div>
          <div class="kpi-label">Registered Customers</div>
        </div>

      </div><!-- /kpi-grid -->

      <!-- Chart + quick stats -->
      <div class="dash-mid">

        <!-- Sales chart -->
        <div class="card">
          <div class="card-head">
            <div>
              <div class="card-head-title">Live Sales Earnings</div>
              <div class="card-head-sub">Revenue trend — last 7 days</div>
            </div>
            <select id="chartRange" onchange="updateChart()" style="font-family:var(--ff);font-size:.75rem;padding:.32rem .7rem;border-radius:8px;border:1.5px solid var(--border);background:var(--bg);color:var(--text);cursor:pointer;outline:none;">
              <option value="7">Last 7 days</option>
              <option value="14">Last 14 days</option>
              <option value="30">Last 30 days</option>
            </select>
          </div>
          <div class="card-body">
            <div class="chart-wrap">
              <canvas id="salesChart"></canvas>
            </div>
          </div>
        </div>

        <!-- Best-selling quick list -->
        <div class="card">
          <div class="card-head">
            <div>
              <div class="card-head-title">Top Products</div>
              <div class="card-head-sub">By revenue this month</div>
            </div>
          </div>
          <div class="card-body">
            <div class="qs-list" id="topProductsList">
              <!-- JS populated -->
            </div>
          </div>
        </div>

      </div><!-- /dash-mid -->

      <!-- Products table (also shown in Products section) -->
      <div class="card table-card" id="mainTable">
        <div class="table-toolbar">
          <div>
            <div class="card-head-title">Listed Products</div>
            <div class="card-head-sub" id="productCount">Loading products…</div>
          </div>
          <div style="display:flex;gap:.75rem;align-items:center;flex-wrap:wrap;">
            <div class="table-search">
              <span class="table-search-ico">&#128269;</span>
              <input type="text" id="searchInput" placeholder="Search products…" oninput="filterTable()" />
            </div>
            <button class="btn btn-g" onclick="openAddModal()">&#43; Add Product</button>
          </div>
        </div>
        <div style="overflow-x:auto;">
          <table id="productTable">
            <thead>
              <tr>
                <th>#</th>
                <th>Product</th>
                <th>Brand</th>
                <th>Category</th>
                <th>Price</th>
                <th>Stock</th>
                <th>Rating</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody id="productTbody">
              <tr><td colspan="8" style="text-align:center;padding:3rem;color:var(--muted);font-size:.84rem;">Loading…</td></tr>
            </tbody>
          </table>
        </div>
      </div>

    </div><!-- /sec-dashboard -->

    <!-- ═══════════════════════════════════════
         PRODUCTS SECTION (dedicated)
    ═══════════════════════════════════════ -->
    <div id="sec-products" style="display:none;">
      <div style="margin-bottom:1.5rem;">
        <div style="font-family:var(--ffi);font-size:1.6rem;font-weight:900;letter-spacing:-0.03em;color:var(--text);">Product Management</div>
        <div style="font-size:.84rem;color:var(--muted);margin-top:.2rem;">Add, update, and remove products from the catalogue.</div>
      </div>
      <!-- same table is shown (shared dom reference) -->
      <div id="productsTablePlaceholder" style="font-size:.84rem;color:var(--muted);">
        ↑ Switch here to manage products — the table card is shown above.
      </div>
    </div>

    <!-- ═══════════════════════════════════════
         ORDERS / PLACEHOLDER SECTIONS
    ═══════════════════════════════════════ -->
    <div id="sec-orders" style="display:none;" class="card" style="padding:3rem;text-align:center;">
      <div style="padding:3rem;text-align:center;">
        <div style="font-size:3rem;margin-bottom:1rem;">&#128230;</div>
        <div style="font-family:var(--ffi);font-size:1.4rem;font-weight:900;color:var(--text);margin-bottom:.5rem;">Orders Module</div>
        <div style="font-size:.84rem;color:var(--muted);">Order management will be available once the orders table is set up in the database.</div>
      </div>
    </div>

    <div id="sec-customers" style="display:none;" class="card">
      <div style="padding:3rem;text-align:center;">
        <div style="font-size:3rem;margin-bottom:1rem;">&#128100;</div>
        <div style="font-family:var(--ffi);font-size:1.4rem;font-weight:900;color:var(--text);margin-bottom:.5rem;">Customer Accounts</div>
        <div style="font-size:.84rem;color:var(--muted);">Customer records and account data will appear here.</div>
      </div>
    </div>

    <div id="sec-sales" style="display:none;" class="card">
      <div style="padding:3rem;text-align:center;">
        <div style="font-size:3rem;margin-bottom:1rem;">&#128200;</div>
        <div style="font-family:var(--ffi);font-size:1.4rem;font-weight:900;color:var(--text);margin-bottom:.5rem;">Sales Report</div>
        <div style="font-size:.84rem;color:var(--muted);">Detailed sales analytics and export options coming soon.</div>
      </div>
    </div>

    <div id="sec-inventory" style="display:none;" class="card">
      <div style="padding:3rem;text-align:center;">
        <div style="font-size:3rem;margin-bottom:1rem;">&#128179;</div>
        <div style="font-family:var(--ffi);font-size:1.4rem;font-weight:900;color:var(--text);margin-bottom:.5rem;">Inventory Manager</div>
        <div style="font-size:.84rem;color:var(--muted);">Stock tracking, reorder alerts, and inventory history will appear here.</div>
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
          <input type="number" id="pPrice" placeholder="e.g. 12500" min="0" />
        </div>
        <div class="fg">
          <label for="pOldPrice">Original Price (Rs)</label>
          <input type="number" id="pOldPrice" placeholder="e.g. 14000" min="0" />
        </div>
      </div>
      <div class="fg-row">
        <div class="fg">
          <label for="pCategory">Category *</label>
          <select id="pCategory">
            <option value="">— Select category —</option>
            <option value="1">Luxury</option>
            <option value="2">Casual</option>
            <option value="3">Sport</option>
            <option value="4">Smart</option>
            <option value="5">Classic</option>
          </select>
        </div>
        <div class="fg">
          <label for="pRating">Rating (0–5)</label>
          <input type="number" id="pRating" placeholder="e.g. 4.5" min="0" max="5" step="0.1" />
        </div>
      </div>
      <div class="fg">
        <label for="pDesc">Description</label>
        <textarea id="pDesc" placeholder="Brief product description…"></textarea>
      </div>
      <div class="fg">
        <label for="pImg">Image URL</label>
        <input type="text" id="pImg" placeholder="https://… or /static/images/…" />
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
      <input type="hidden" id="pId" value="" />
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
    <div class="modal-body" style="text-align:center;padding:2rem 1.65rem;">
      <div class="del-modal-ico">&#128465;</div>
      <div style="font-family:var(--ffi);font-size:1.1rem;font-weight:900;color:var(--text);margin-bottom:.5rem;">Delete this product?</div>
      <div style="font-size:.84rem;color:var(--muted);line-height:1.65;">
        "<span id="delProdName" style="font-weight:700;color:var(--text);"></span>" will be permanently removed. This action cannot be undone.
      </div>
    </div>
    <div class="modal-foot">
      <button class="btn btn-o" onclick="closeDelModal()">Cancel</button>
      <button class="btn btn-r" id="delConfirmBtn">&#128465; Delete</button>
    </div>
  </div>
</div>

<!-- Toast container -->
<div class="toast-container" id="toastContainer"></div>

<!-- ══════════════════════════════════════════════════
     CHART.JS (CDN) + SCRIPT
══════════════════════════════════════════════════ -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.2/dist/chart.umd.min.js"></script>
<script>
  /* ─────────────────── In-memory product store ─────────────────── */
  let products = [
    { id:1, name:"Casio Edifice EF-539D",   brand:"Casio",        categoryId:3, categoryName:"Sport",   price:12500, oldPrice:14000, rating:4.5, inStock:true,  imageUrl:"", description:"Rugged sport chronograph." },
    { id:2, name:"Seiko Presage SRPE35",     brand:"Seiko",        categoryId:1, categoryName:"Luxury",  price:52000, oldPrice:0,     rating:4.8, inStock:true,  imageUrl:"", description:"Automatic prestige piece." },
    { id:3, name:"Citizen Eco-Drive AT2480", brand:"Citizen",      categoryId:2, categoryName:"Casual",  price:24500, oldPrice:27000, rating:4.3, inStock:false, imageUrl:"", description:"Solar-powered everyday watch." },
    { id:4, name:"Tissot PRX Powermatic",    brand:"Tissot",       categoryId:1, categoryName:"Luxury",  price:85000, oldPrice:0,     rating:4.7, inStock:true,  imageUrl:"", description:"Swiss automatic with tapisserie dial." },
    { id:5, name:"Orient Bambino V4",        brand:"Orient",       categoryId:5, categoryName:"Classic", price:18500, oldPrice:20000, rating:4.4, inStock:true,  imageUrl:"", description:"Hand-wound dress watch." },
    { id:6, name:"Fossil Gen 6 Smartwatch",  brand:"Fossil",       categoryId:4, categoryName:"Smart",   price:32000, oldPrice:36000, rating:4.0, inStock:true,  imageUrl:"", description:"Wear OS smartwatch." },
    { id:7, name:"G-Shock GA-2100",          brand:"Casio",        categoryId:3, categoryName:"Sport",   price:15000, oldPrice:0,     rating:4.6, inStock:false, imageUrl:"", description:"Ultra-thin CasiOak." },
    { id:8, name:"Hamilton Khaki Field Auto", brand:"Hamilton",    categoryId:5, categoryName:"Classic", price:125000, oldPrice:0,    rating:4.9, inStock:true,  imageUrl:"", description:"Military-inspired automatic." },
  ];
  let nextId = 9;

  /* ─────────────────── Section switching ─────────────────── */
  const sectionIds = ['dashboard','products','orders','customers','sales','inventory'];
  const sectionTitles = { dashboard:'Dashboard', products:'Product Management',
    orders:'Orders', customers:'Customers', sales:'Sales Report', inventory:'Inventory' };

  function showSection(id, el) {
    sectionIds.forEach(s => {
      const sec = document.getElementById('sec-'+s);
      if (sec) sec.style.display = s === id ? '' : 'none';
    });
    // Move table card to products section
    const tableCard = document.getElementById('mainTable');
    if (id === 'products') {
      document.getElementById('productsTablePlaceholder').style.display = 'none';
      document.getElementById('sec-products').appendChild(tableCard);
    } else {
      const dash = document.getElementById('sec-dashboard');
      if (id === 'dashboard') {
        dash.appendChild(tableCard);
      }
    }
    document.querySelectorAll('.adm-nav a').forEach(a => a.classList.remove('active'));
    if (el) el.classList.add('active');
    document.getElementById('topbarTitle').textContent = sectionTitles[id] || id;
  }

  /* ─────────────────── Render table ─────────────────── */
  function renderTable(list) {
    const tbody = document.getElementById('productTbody');
    document.getElementById('productCount').textContent = list.length + ' product' + (list.length !== 1 ? 's' : '') + ' in catalogue';
    // KPI
    const inStockCount = list.filter(p => p.inStock).length;
    document.getElementById('kpiStockCount').textContent = inStockCount;

    if (!list.length) {
      tbody.innerHTML = '<tr><td colspan="8" style="text-align:center;padding:3rem;color:var(--muted);font-size:.84rem;">No products found.</td></tr>';
      return;
    }
    tbody.innerHTML = list.map((p, i) => `
      <tr>
        <td style="color:var(--dim);font-size:.78rem;">${p.id}</td>
        <td>
          <div style="display:flex;align-items:center;gap:.8rem;">
            <div class="td-img">${p.imageUrl ? `<img src="${p.imageUrl}" alt="${p.name}" style="width:46px;height:46px;border-radius:8px;object-fit:cover;">` : '&#8987;'}</div>
            <div>
              <div class="td-name">${p.name}</div>
              <div class="td-brand">${p.description ? p.description.slice(0,40)+'…' : '—'}</div>
            </div>
          </div>
        </td>
        <td>${p.brand}</td>
        <td><span style="font-size:.7rem;font-weight:700;padding:.2rem .65rem;border-radius:999px;background:var(--surface);border:1.5px solid var(--border);color:var(--muted);">${p.categoryName}</span></td>
        <td class="td-price">Rs ${p.price.toLocaleString()}</td>
        <td>${p.inStock ? '<span class="stock-yes">In Stock</span>' : '<span class="stock-no">Out of Stock</span>'}</td>
        <td>
          <span style="color:var(--gold);font-size:.8rem;">&#9733;</span>
          <span style="font-size:.78rem;font-weight:700;margin-left:.2rem;">${p.rating}</span>
        </td>
        <td>
          <div class="tbl-actions">
            <button class="tbl-btn tbl-btn-edit" onclick="openEditModal(${p.id})">&#9998; Edit</button>
            <button class="tbl-btn tbl-btn-del"  onclick="openDelModal(${p.id},'${p.name.replace(/'/g,"\\'")}')">&#128465;</button>
          </div>
        </td>
      </tr>`).join('');
  }

  function filterTable() {
    const q = document.getElementById('searchInput').value.toLowerCase();
    const filtered = q ? products.filter(p =>
      p.name.toLowerCase().includes(q) ||
      p.brand.toLowerCase().includes(q) ||
      p.categoryName.toLowerCase().includes(q)
    ) : products;
    renderTable(filtered);
  }

  /* ─────────────────── Top Products list ────────────────── */
  const topColors = ['var(--green)','var(--gold)','#3b82f6','#7c3aed','#d97706'];
  function renderTopProducts() {
    const sorted = [...products].sort((a,b) => b.price - a.price).slice(0,5);
    document.getElementById('topProductsList').innerHTML = sorted.map((p,i) => `
      <div class="qs-item">
        <div class="qs-left">
          <div class="qs-dot" style="background:${topColors[i]};"></div>
          <div>
            <div class="qs-name">${p.name}</div>
            <div class="qs-cat">${p.brand} &middot; ${p.categoryName}</div>
          </div>
        </div>
        <div class="qs-val">Rs ${p.price.toLocaleString()}</div>
      </div>`).join('');
  }

  /* ─────────────────── Add / Edit Modal ──────────────────── */
  function openAddModal() {
    document.getElementById('modalTitle').textContent = 'Add New Product';
    document.getElementById('modalSaveBtn').textContent = '✓ Save Product';
    clearForm();
    document.getElementById('productModal').classList.add('open');
  }

  function openEditModal(id) {
    const p = products.find(x => x.id === id);
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
    ['pId','pName','pBrand','pPrice','pOldPrice','pDesc','pImg','pRating'].forEach(id => document.getElementById(id).value = '');
    document.getElementById('pCategory').value = '';
    document.getElementById('pStock').checked  = true;
  }

  const catNames = { '1':'Luxury','2':'Casual','3':'Sport','4':'Smart','5':'Classic' };

  function saveProduct() {
    const name  = document.getElementById('pName').value.trim();
    const brand = document.getElementById('pBrand').value.trim();
    const price = parseFloat(document.getElementById('pPrice').value);
    const catId = document.getElementById('pCategory').value;

    if (!name || !brand || isNaN(price) || !catId) {
      showToast('Please fill all required fields.', 'error');
      return;
    }

    const id        = document.getElementById('pId').value;
    const isEdit    = !!id;
    const productObj = {
      id:           isEdit ? parseInt(id) : nextId++,
      name, brand,
      categoryId:   parseInt(catId),
      categoryName: catNames[catId] || catId,
      price,
      oldPrice:     parseFloat(document.getElementById('pOldPrice').value) || 0,
      rating:       parseFloat(document.getElementById('pRating').value) || 0,
      description:  document.getElementById('pDesc').value.trim(),
      imageUrl:     document.getElementById('pImg').value.trim(),
      inStock:      document.getElementById('pStock').checked,
    };

    if (isEdit) {
      const idx = products.findIndex(x => x.id === productObj.id);
      if (idx !== -1) products[idx] = productObj;
      showToast('Product updated successfully!', 'success');
    } else {
      products.push(productObj);
      showToast('Product added successfully!', 'success');
    }

    closeProductModal();
    renderTable(products);
    renderTopProducts();
    updateStockKpi();
  }

  /* ─────────────────── Delete Modal ──────────────────────── */
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
    products = products.filter(p => p.id !== deletingId);
    closeDelModal();
    renderTable(products);
    renderTopProducts();
    updateStockKpi();
    showToast('Product deleted.', 'error');
  }

  /* ─────────────────── KPI helper ────────────────────────── */
  function updateStockKpi() {
    const c = products.filter(p => p.inStock).length;
    document.getElementById('kpiStockCount').textContent = c;
  }

  /* ─────────────────── Toast ──────────────────────────────── */
  function showToast(msg, type = '') {
    const container = document.getElementById('toastContainer');
    const t = document.createElement('div');
    t.className = 'toast ' + type;
    t.innerHTML = `<span class="toast-ico">${type === 'success' ? '✓' : type === 'error' ? '✕' : 'ℹ'}</span> ${msg}`;
    container.appendChild(t);
    setTimeout(() => { t.style.opacity = '0'; t.style.transform = 'translateX(24px)'; t.style.transition = 'all .3s'; setTimeout(() => t.remove(), 350); }, 3000);
  }

  /* ─────────────────── Sales Chart ───────────────────────── */
  let salesChart;
  const dayLabels7  = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
  const dayLabels14 = ['14 days ago','13','12','11','10','9','8','7','6','5','4','3','2','Yesterday'];
  const dayLabels30 = Array.from({length:30}, (_,i) => `Day ${i+1}`);
  const rand = (min,max) => Math.floor(Math.random() * (max-min+1)) + min;
  const genData = n => Array.from({length:n}, () => rand(8000, 55000));

  function buildChart() {
    const ctx = document.getElementById('salesChart').getContext('2d');
    const days = 7;
    salesChart = new Chart(ctx, {
      type: 'line',
      data: {
        labels:   dayLabels7,
        datasets: [{
          label:           'Revenue (Rs)',
          data:            genData(7),
          borderColor:     '#1a6b38',
          backgroundColor: 'rgba(26,107,56,0.09)',
          fill:            true,
          tension:         0.42,
          pointRadius:     5,
          pointBackgroundColor: '#1a6b38',
          pointBorderColor:     '#fff',
          pointBorderWidth:     2,
          pointHoverRadius:     7,
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        interaction: { mode: 'index', intersect: false },
        plugins: {
          legend: { display: false },
          tooltip: {
            backgroundColor: '#0b1c10',
            titleFont:  { family: "'Inter', sans-serif", weight: '700', size: 12 },
            bodyFont:   { family: "'Inter', sans-serif", size: 12 },
            padding:    12,
            cornerRadius: 10,
            callbacks: { label: ctx => ' Rs ' + ctx.raw.toLocaleString() }
          }
        },
        scales: {
          x: { grid: { display: false }, ticks: { font: { family: "'Inter', sans-serif", size: 11 }, color: '#4e6a59' } },
          y: {
            grid: { color: 'rgba(0,0,0,0.05)' },
            ticks: { font: { family: "'Inter', sans-serif", size: 11 }, color: '#4e6a59', callback: v => 'Rs ' + (v/1000).toFixed(0) + 'k' }
          }
        }
      }
    });
  }

  function updateChart() {
    const n = parseInt(document.getElementById('chartRange').value);
    const labels = n === 7 ? dayLabels7 : n === 14 ? dayLabels14 : dayLabels30;
    salesChart.data.labels   = labels;
    salesChart.data.datasets[0].data = genData(n);
    salesChart.update('active');
  }

  /* ─────────────────── Live data ticker (demo) ────────────── */
  setInterval(() => {
    if (!salesChart) return;
    const ds = salesChart.data.datasets[0].data;
    ds.push(rand(8000,55000));
    ds.shift();
    salesChart.update('none');
  }, 5000);

  /* ─────────────────── Close modals on backdrop click ──────── */
  document.getElementById('productModal').addEventListener('click', e => { if (e.target === e.currentTarget) closeProductModal(); });
  document.getElementById('delModal').addEventListener('click', e => { if (e.target === e.currentTarget) closeDelModal(); });

  /* ─────────────────── Init ─────────────────────────────────── */
  document.addEventListener('DOMContentLoaded', () => {
    renderTable(products);
    renderTopProducts();
    updateStockKpi();
    buildChart();
  });
</script>
</body>
</html>
