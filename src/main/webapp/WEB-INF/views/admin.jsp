<%--
  admin.jsp — Admin dashboard. Only accessible to users with role="admin".
  Expects from AdminServlet:
    products          (List<Product>)       — all products for the product table
    productCount / inStockCount / outOfStockCount (int)
    customerCount / totalOrders / totalRevenue    — summary stats
    productDataJson   (JSON String) — for the product data table (client-side)
    monthlySales12Json / monthlySales6Json / monthlySales3Json — for the revenue chart
    topProductsJson   — for the top-products chart
  Standalone page with its own <html> — does not use header.jsp.
  Add/edit product modal POSTs to /admin?action=save.
  Delete POSTs to /admin?action=delete.
--%>
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
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/shared/base.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/pages/admin.css" />
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
    <a class="adm-nav-link" href="${pageContext.request.contextPath}/admin-profile">
      <span class="nav-ico">
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
      </span> My Profile
    </a>
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
    <%-- Mobile: hamburger button to open the sidebar --%>
    <button class="adm-menu-btn" id="admMenuBtn" onclick="toggleAdmSidebar()" aria-label="Open menu">
      <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"><line x1="3" y1="6" x2="21" y2="6"/><line x1="3" y1="12" x2="21" y2="12"/><line x1="3" y1="18" x2="21" y2="18"/></svg>
    </button>
    <div class="adm-topbar-title" id="topbarTitle">Dashboard</div>
    <div class="adm-topbar-right">
      <div class="adm-topbar-chip">
        <span class="topbar-dot"></span> Live
      </div>
      <button class="btn btn-g" onclick="openAddModal()">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
        <span class="adm-btn-label">Add Product</span>
      </button>
    </div>
  </header>
  <%-- Overlay to close sidebar on mobile when tapping outside --%>
  <div class="adm-overlay" id="admOverlay" onclick="toggleAdmSidebar()"></div>

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

      <!-- Revenue KPI cards -->
      <div style="display:grid;grid-template-columns:repeat(2,1fr);gap:1.2rem;margin-bottom:1.2rem;">
        <div class="kpi-card" style="border-color:var(--gold);">
          <div class="kpi-glow" style="background:var(--gold)"></div>
          <div class="kpi-top">
            <div class="kpi-ico" style="background:var(--gold-light);color:var(--gold2);">
              <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="1" x2="12" y2="23"/><path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"/></svg>
            </div>
            <span class="kpi-badge" style="background:var(--gold-light);color:var(--gold2);">Revenue</span>
          </div>
          <div class="kpi-num" style="font-size:1.6rem;">Rs <fmt:formatNumber value="${totalRevenue}" pattern="#,##0"/></div>
          <div class="kpi-label">Total Revenue (Paid Orders)</div>
        </div>
        <div class="kpi-card" style="border-color:var(--purple);">
          <div class="kpi-glow" style="background:var(--purple)"></div>
          <div class="kpi-top">
            <div class="kpi-ico" style="background:var(--purple-light);color:var(--purple);">
              <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"/><line x1="3" y1="6" x2="21" y2="6"/><path d="M16 10a4 4 0 0 1-8 0"/></svg>
            </div>
            <span class="kpi-badge" style="background:var(--purple-light);color:var(--purple);">Orders</span>
          </div>
          <div class="kpi-num">${totalOrders}</div>
          <div class="kpi-label">Total Orders Placed</div>
        </div>
      </div>

      <!-- Stock KPI strip -->
      <div style="display:grid;grid-template-columns:repeat(3,1fr);gap:1.2rem;margin-bottom:1.85rem;" id="stockKpiStrip"></div>

      <!-- Sales Line Chart -->
      <div class="card" style="margin-bottom:1.25rem;">
        <div class="card-head">
          <div>
            <div class="card-head-title">Monthly Sales Revenue</div>
            <div class="card-head-sub">Estimated revenue trend over the last 12 months</div>
          </div>
          <select class="chart-range-select" id="salesRangeSelect" onchange="updateSalesChart()">
            <option value="12">Last 12 months</option>
            <option value="6">Last 6 months</option>
            <option value="3">Last 3 months</option>
          </select>
        </div>
        <div class="card-body">
          <div class="chart-wrap" style="height:260px;"><canvas id="salesChart"></canvas></div>
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

      <!-- Top Performers -->
      <div class="card" style="margin-bottom:1.85rem;">
        <div class="card-head">
          <div>
            <div class="card-head-title">Top Performing Products</div>
            <div class="card-head-sub">Ranked by rating and stock health</div>
          </div>
        </div>
        <div class="card-body" style="padding-bottom:0;">
          <div class="qs-list" id="topPerformersList"></div>
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
              <tr><th>#</th><th>Product</th><th>Brand</th><th>Category</th><th>Price</th><th>Stock Qty</th><th>Status</th><th>Rating</th><th>Actions</th></tr>
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
                  <td>
                    <c:choose>
                      <c:when test="${p.stockQuantity le 0}"><span class="sqty sqty-out">${p.stockQuantity}</span></c:when>
                      <c:when test="${p.stockQuantity le 5}"><span class="sqty sqty-low">${p.stockQuantity}</span></c:when>
                      <c:otherwise><span class="sqty sqty-ok">${p.stockQuantity}</span></c:otherwise>
                    </c:choose>
                    <span style="font-size:.65rem;color:var(--muted);margin-left:2px;">units</span>
                  </td>
                  <td>
                    <c:choose>
                      <c:when test="${p.stockQuantity le 0}"><span class="stock-no">Out of Stock</span></c:when>
                      <c:when test="${p.stockQuantity le 5}"><span class="stock-low">Low Stock</span></c:when>
                      <c:otherwise><span class="stock-yes">In Stock</span></c:otherwise>
                    </c:choose>
                  </td>
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
              <tr><th>#</th><th>Product</th><th>Brand</th><th>Category</th><th>Price</th><th>Old Price</th><th>Stock Qty</th><th>Status</th><th>Rating</th><th>Actions</th></tr>
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
                  <td>
                    <c:choose>
                      <c:when test="${p.stockQuantity le 0}"><span class="sqty sqty-out">${p.stockQuantity}</span></c:when>
                      <c:when test="${p.stockQuantity le 5}"><span class="sqty sqty-low">${p.stockQuantity}</span></c:when>
                      <c:otherwise><span class="sqty sqty-ok">${p.stockQuantity}</span></c:otherwise>
                    </c:choose>
                    <span style="font-size:.65rem;color:var(--muted);margin-left:2px;">units</span>
                  </td>
                  <td>
                    <c:choose>
                      <c:when test="${p.stockQuantity le 0}"><span class="stock-no">Out of Stock</span></c:when>
                      <c:when test="${p.stockQuantity le 5}"><span class="stock-low">Low Stock</span></c:when>
                      <c:otherwise><span class="stock-yes">In Stock</span></c:otherwise>
                    </c:choose>
                  </td>
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
  <div class="modal" style="max-width:860px;" role="dialog" aria-modal="true" aria-labelledby="modalTitle">
    <div class="modal-head">
      <div class="modal-title" id="modalTitle">Add New Product</div>
      <button class="modal-close" onclick="closeProductModal()" aria-label="Close">&#10005;</button>
    </div>
    <div class="modal-body" style="display:grid;grid-template-columns:1fr 240px;gap:1.5rem;align-items:start;">
      <form id="productForm" action="${pageContext.request.contextPath}/admin" method="post" enctype="multipart/form-data">
        <input type="hidden" name="action" value="save" />
        <input type="hidden" name="id" id="pId" value="" />
        <input type="hidden" name="existingImageUrl" id="existingImageUrl" value="" />
        <div class="fg-row">
          <div class="fg"><label for="pName">Product Name *</label><input type="text" id="pName" name="name" placeholder="e.g. Casio Edifice" oninput="updatePreview()" /></div>
          <div class="fg"><label for="pBrand">Brand *</label><input type="text" id="pBrand" name="brand" placeholder="e.g. Casio" oninput="updatePreview()" /></div>
        </div>
        <div class="fg-row">
          <div class="fg"><label for="pPrice">Price (Rs) *</label><input type="number" id="pPrice" name="price" placeholder="12500" min="0" oninput="updatePreview()" /></div>
          <div class="fg"><label for="pOldPrice">Old Price (Rs)</label><input type="number" id="pOldPrice" name="oldPrice" placeholder="Optional" min="0" oninput="updatePreview()" /></div>
        </div>
        <div class="fg-row">
          <div class="fg">
            <label for="pCategory">Category *</label>
            <select id="pCategory" name="categoryId" onchange="updatePreview()">
              <option value="">Select...</option>
              <option value="1">Luxury</option>
              <option value="2">Sports</option>
              <option value="3">Classic</option>
              <option value="4">Smart</option>
              <option value="5">Womens</option>
            </select>
          </div>
          <div class="fg"><label for="pRating">Rating (0-5)</label><input type="number" id="pRating" name="rating" placeholder="4.5" min="0" max="5" step="0.1" oninput="updatePreview()" /></div>
        </div>
        <div class="fg"><label for="pDesc">Description</label><textarea id="pDesc" name="description" placeholder="Product description..."></textarea></div>
        <div class="fg">
          <label for="pImageFile">Product Image (JPG, PNG, WEBP only)</label>
          <input type="file" id="pImageFile" name="imageFile" onchange="handleImagePick(this)" />
          <div id="imgTypeError" style="display:none;color:var(--red);font-size:.72rem;font-weight:700;margin-top:.3rem;">Only JPG, PNG, or WEBP images are allowed.</div>
        </div>
        <input type="hidden" id="pImg" name="imageUrl" value="" />
        <div class="fg">
          <label for="pStockQuantity">Stock Quantity *</label>
          <input type="number" id="pStockQuantity" name="stockQuantity" min="0" value="10" oninput="updatePreview()" />
          <input type="hidden" id="pStock" name="inStock" value="true" />
        </div>
      </form>

      <!-- LIVE PREVIEW CARD -->
      <div style="position:sticky;top:0;">
        <div style="font-size:.65rem;font-weight:700;letter-spacing:.12em;text-transform:uppercase;color:var(--muted);margin-bottom:.6rem;">Live Preview</div>
        <div id="previewCard" style="background:var(--white);border:1.5px solid var(--border);border-radius:16px;overflow:hidden;box-shadow:var(--shadow);">
          <div style="width:100%;aspect-ratio:1/1;background:var(--surface);display:flex;align-items:center;justify-content:center;overflow:hidden;" id="previewImgWrap">
            <svg id="previewImgPlaceholder" width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="var(--dim)" stroke-width="1.2"><rect x="3" y="3" width="18" height="18" rx="2"/><circle cx="8.5" cy="8.5" r="1.5"/><polyline points="21 15 16 10 5 21"/></svg>
            <img id="previewImg" src="" alt="" style="width:100%;height:100%;object-fit:cover;display:none;" />
          </div>
          <div style="padding:.85rem .9rem;">
            <div id="previewCat" style="font-size:.6rem;font-weight:700;letter-spacing:.1em;text-transform:uppercase;color:var(--muted);margin-bottom:.3rem;">Category</div>
            <div id="previewName" style="font-size:.88rem;font-weight:800;color:var(--text);line-height:1.3;margin-bottom:.18rem;">Product Name</div>
            <div id="previewBrand" style="font-size:.72rem;color:var(--muted);margin-bottom:.5rem;">Brand</div>
            <div style="display:flex;align-items:center;gap:.5rem;flex-wrap:wrap;">
              <span id="previewPrice" style="font-size:1rem;font-weight:900;color:var(--green);">Rs —</span>
              <span id="previewOldPrice" style="font-size:.75rem;color:var(--muted);text-decoration:line-through;display:none;"></span>
            </div>
            <div style="display:flex;align-items:center;justify-content:space-between;margin-top:.5rem;">
              <span id="previewRating" style="font-size:.72rem;color:var(--gold);font-weight:700;">&#9733; —</span>
              <span id="previewStock" style="font-size:.68rem;font-weight:700;color:var(--green);">In Stock</span>
            </div>
          </div>
        </div>
      </div>
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

<%-- Pass product and sales data to JS via typed JSON blocks (avoids JS validator errors) --%>
<script type="application/json" id="__productData">${productDataJson}</script>
<script type="application/json" id="__monthlySales">{"12":${monthlySales12Json},"6":${monthlySales6Json},"3":${monthlySales3Json}}</script>
<script type="application/json" id="__topProducts">${topProductsJson}</script>
<div id="__adminMeta"
     data-total-products="${productCount}"
     data-in-stock="${inStockCount}"
     data-out-stock="${outOfStockCount}"
     data-revenue="${totalRevenue}"
     data-orders="${totalOrders}"
     data-customers="${customerCount}"
     style="display:none;"></div>
<script>
(function(){
  var m = document.getElementById('__adminMeta');
  var PRODUCT_DATA  = JSON.parse(document.getElementById('__productData').textContent);
  var MONTHLY_SALES = JSON.parse(document.getElementById('__monthlySales').textContent);
  var TOP_PRODUCTS  = JSON.parse(document.getElementById('__topProducts').textContent);
  var TOTAL_PRODUCTS  = parseInt(m.dataset.totalProducts);
  var IN_STOCK_COUNT  = parseInt(m.dataset.inStock);
  var OUT_STOCK_COUNT = parseInt(m.dataset.outStock);
  var TOTAL_REVENUE   = parseFloat(m.dataset.revenue);
  var TOTAL_ORDERS    = parseInt(m.dataset.orders);
  window.PRODUCT_DATA   = PRODUCT_DATA;
  window.MONTHLY_SALES  = MONTHLY_SALES;
  window.TOP_PRODUCTS   = TOP_PRODUCTS;
  window.TOTAL_PRODUCTS = TOTAL_PRODUCTS;
  window.IN_STOCK_COUNT = IN_STOCK_COUNT;
  window.OUT_STOCK_COUNT= OUT_STOCK_COUNT;
  window.TOTAL_REVENUE  = TOTAL_REVENUE;
  window.TOTAL_ORDERS   = TOTAL_ORDERS;
})();
</script>

<script>
/* ---- Mobile sidebar toggle ---- */
function toggleAdmSidebar() {
  var sidebar = document.getElementById('admSidebar');
  var overlay = document.getElementById('admOverlay');
  sidebar.classList.toggle('open');
  overlay.classList.toggle('open');
}

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
  /* Close sidebar on mobile after selecting a section */
  var sidebar = document.getElementById('admSidebar');
  var overlay = document.getElementById('admOverlay');
  if (sidebar && sidebar.classList.contains('open')) {
    sidebar.classList.remove('open');
    overlay.classList.remove('open');
  }
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
function setEmptyRow(tbodyId, colspan, show) {
  var tbody = document.getElementById(tbodyId);
  if (!tbody) return;
  var existing = tbody.querySelector('.empty-row');
  if (show) {
    if (!existing) {
      var tr = document.createElement('tr');
      tr.className = 'empty-row';
      tr.innerHTML = '<td colspan="' + colspan + '" style="text-align:center;padding:2.5rem;color:var(--muted);font-size:.85rem;">No products match your search.</td>';
      tbody.appendChild(tr);
    }
  } else {
    if (existing) existing.remove();
  }
}
function filterDashTable() {
  var q = document.getElementById('dashSearch').value.toLowerCase();
  var rows = getDataRows('dashTbody');
  var visible = 0;
  rows.forEach(function(r){
    var show = !q || r.dataset.name.toLowerCase().includes(q) || r.dataset.brand.toLowerCase().includes(q) || (r.dataset.categoryName||'').toLowerCase().includes(q);
    r.style.display = show ? '' : 'none';
    if (show) visible++;
  });
  setEmptyRow('dashTbody', 9, visible === 0 && q.length > 0);
}
function filterProdTable() {
  var q = document.getElementById('prodSearch').value.toLowerCase();
  var cat = document.getElementById('filterCat').value;
  var rows = getDataRows('prodMgmtTbody');
  var visible = 0;
  rows.forEach(function(r){
    var textMatch = !q || r.dataset.name.toLowerCase().includes(q) || r.dataset.brand.toLowerCase().includes(q);
    var catMatch = !cat || r.dataset.categoryName === cat;
    var show = textMatch && catMatch;
    r.style.display = show ? '' : 'none';
    if (show) visible++;
  });
  setEmptyRow('prodMgmtTbody', 10, visible === 0);
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
  document.getElementById('imgTypeError').style.display = 'none';
  updatePreview();
  document.getElementById('productModal').classList.add('open');
}
function closeProductModal() { document.getElementById('productModal').classList.remove('open'); }
function resetForm() {
  ['pId','pName','pBrand','pPrice','pOldPrice','pRating','pDesc','pImg','existingImageUrl'].forEach(function(id){ document.getElementById(id).value=''; });
  document.getElementById('pCategory').value = '';
  document.getElementById('pImageFile').value = '';
  document.getElementById('pStockQuantity').value = 10;
  document.getElementById('imgTypeError').style.display = 'none';
  updatePreview();
}
function saveProduct() {
  var form = document.getElementById('productForm');
  if (!form.name.value.trim() || !form.brand.value.trim() || !parseFloat(form.price.value) || !form.categoryId.value) {
    showToast('Please fill all required fields.', 'error'); return;
  }
  if (document.getElementById('imgTypeError').style.display !== 'none') {
    showToast('Please remove the invalid image file.', 'error'); return;
  }
  form.submit();
}

/* ---- Image type validation ---- */
function handleImagePick(input) {
  var errEl = document.getElementById('imgTypeError');
  var file = input.files && input.files[0];
  if (!file) { errEl.style.display = 'none'; updatePreview(); return; }
  var allowed = ['image/jpeg','image/png','image/webp'];
  if (allowed.indexOf(file.type) === -1) {
    errEl.style.display = 'block';
    input.value = '';
    updatePreview();
    return;
  }
  errEl.style.display = 'none';
  var reader = new FileReader();
  reader.onload = function(e) {
    showPreviewImage(e.target.result);
  };
  reader.readAsDataURL(file);
}

/* ---- Live preview ---- */
function updatePreview() {
  var catMap = {'1':'Luxury','2':'Sports','3':'Classic','4':'Smart','5':'Womens'};
  var name     = document.getElementById('pName').value.trim()     || 'Product Name';
  var brand    = document.getElementById('pBrand').value.trim()    || 'Brand';
  var price    = document.getElementById('pPrice').value;
  var oldPrice = document.getElementById('pOldPrice').value;
  var catId    = document.getElementById('pCategory').value;
  var rating   = document.getElementById('pRating').value;
  var stock    = parseInt(document.getElementById('pStockQuantity').value) || 0;
  var imgUrl   = '';

  document.getElementById('previewName').textContent  = name;
  document.getElementById('previewBrand').textContent = brand;
  document.getElementById('previewCat').textContent   = catId ? catMap[catId] : 'Category';
  document.getElementById('previewPrice').textContent = price ? 'Rs ' + parseInt(price).toLocaleString() : 'Rs —';
  document.getElementById('previewRating').textContent = rating ? '★ ' + parseFloat(rating).toFixed(1) : '★ —';

  var oldEl = document.getElementById('previewOldPrice');
  if (oldPrice) { oldEl.textContent = 'Rs ' + parseInt(oldPrice).toLocaleString(); oldEl.style.display = ''; }
  else { oldEl.style.display = 'none'; }

  var stockEl = document.getElementById('previewStock');
  stockEl.textContent = stock > 0 ? 'In Stock' : 'Out of Stock';
  stockEl.style.color = stock > 0 ? 'var(--green)' : 'var(--red)';

  /* image: only update from URL field if no file was picked */
  var fileInput = document.getElementById('pImageFile');
  if (!fileInput.files || !fileInput.files[0]) {
    if (imgUrl) showPreviewImage(imgUrl);
    else {
      var existing = document.getElementById('existingImageUrl').value;
      if (existing) showPreviewImage(existing);
      else clearPreviewImage();
    }
  }
}

function showPreviewImage(src) {
  var img  = document.getElementById('previewImg');
  var ph   = document.getElementById('previewImgPlaceholder');
  img.src  = src;
  img.style.display = 'block';
  ph.style.display  = 'none';
  img.onerror = function() { clearPreviewImage(); };
}
function clearPreviewImage() {
  var img = document.getElementById('previewImg');
  var ph  = document.getElementById('previewImgPlaceholder');
  img.src = '';
  img.style.display = 'none';
  ph.style.display  = 'block';
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

/* ---- Stock KPI strip ---- */
function buildStockKpiStrip() {
  var totalStock = PRODUCT_DATA.reduce(function(s,p){ return s + p.stock; }, 0);
  var lowStock = PRODUCT_DATA.filter(function(p){ return p.stock > 0 && p.stock <= 5; }).length;
  var strip = document.getElementById('stockKpiStrip');
  if (!strip) return;
  strip.innerHTML = [
    {label:'Total Units in Stock', val: totalStock, sub:'across all products', color:'var(--green)', bg:'var(--green-light)'},
    {label:'Low Stock Alerts',     val: lowStock,   sub:'products with ≤5 units', color:'var(--amber)', bg:'#fffbe6'},
    {label:'Avg Stock / Product',  val: TOTAL_PRODUCTS ? Math.round(totalStock / TOTAL_PRODUCTS) : 0, sub:'units per product', color:'var(--blue)', bg:'var(--blue-light)'}
  ].map(function(item){
    return '<div style="background:var(--white);border:1.5px solid var(--border);border-radius:16px;padding:1.1rem 1.25rem;">'
      + '<div style="font-size:.68rem;font-weight:700;color:var(--muted);letter-spacing:.06em;text-transform:uppercase;margin-bottom:.45rem;">' + item.label + '</div>'
      + '<div style="font-size:1.8rem;font-weight:900;letter-spacing:-.04em;color:' + item.color + ';margin-bottom:.12rem;">' + item.val + '</div>'
      + '<div style="font-size:.7rem;color:var(--muted);">' + item.sub + '</div>'
      + '</div>';
  }).join('');
}

/* ---- Top performers (real order data) ---- */
function buildTopPerformers() {
  var list = document.getElementById('topPerformersList');
  if (!list) return;
  var colors = ['#1a6b38','#258a4a','#3dba62','#c9a452','#b8913a','#2563eb'];
  if (!TOP_PRODUCTS || TOP_PRODUCTS.length === 0) {
    list.innerHTML = '<div style="padding:1.5rem;color:var(--muted);text-align:center;font-size:.83rem;">No order data yet.</div>';
    return;
  }
  list.innerHTML = TOP_PRODUCTS.map(function(p, i){
    var stockColor = p.stock <= 0 ? 'var(--red)' : p.stock <= 5 ? 'var(--amber)' : 'var(--green)';
    var soldBadge = p.unitsSold > 0
      ? '<span style="font-size:.65rem;background:var(--green-light);color:var(--green);padding:.1rem .45rem;border-radius:999px;font-weight:700;">' + p.unitsSold + ' sold</span>'
      : '<span style="font-size:.65rem;background:var(--surface);color:var(--muted);padding:.1rem .45rem;border-radius:999px;">no orders yet</span>';
    return '<div class="qs-item">'
      + '<div class="qs-left">'
      + '<span class="qs-dot" style="background:' + colors[i] + ';"></span>'
      + '<div><div class="qs-name">' + p.name + ' ' + soldBadge + '</div>'
      + '<div class="qs-cat">Stock: <span style="font-weight:700;color:' + stockColor + ';">' + p.stock + ' units</span></div></div>'
      + '</div>'
      + '<div style="text-align:right;">'
      + '<div class="qs-val">Rs ' + Math.round(p.price).toLocaleString() + '</div>'
      + '<div style="font-size:.68rem;color:var(--gold);">&#9733; ' + p.rating + '</div>'
      + '</div>'
      + '</div>';
  }).join('');
}

/* ---- Sales chart (real DB data) ---- */
var salesChartInstance = null;
function updateSalesChart() {
  var n = parseInt(document.getElementById('salesRangeSelect').value) || 12;
  var key = String(n);
  var rows   = MONTHLY_SALES[key] || [];
  var labels = rows.map(function(r){ return r.month; });
  var data   = rows.map(function(r){ return Math.round(r.revenue / 1000); });

  if (salesChartInstance) {
    salesChartInstance.data.labels = labels;
    salesChartInstance.data.datasets[0].data = data;
    salesChartInstance.update();
    return;
  }
  var ctx = document.getElementById('salesChart');
  if (!ctx) return;
  salesChartInstance = new Chart(ctx, {
    type:'line',
    data:{
      labels: labels,
      datasets:[{
        label:'Revenue',
        data: data,
        fill: true,
        backgroundColor: 'rgba(26,107,56,0.10)',
        borderColor: '#1a6b38',
        borderWidth: 2.5,
        tension: 0.42,
        pointRadius: 4,
        pointBackgroundColor: '#1a6b38',
        pointBorderColor: '#fff',
        pointBorderWidth: 2
      }]
    },
    options:{
      responsive:true,
      maintainAspectRatio:false,
      plugins:{
        legend:{display:false},
        tooltip:{
          callbacks:{
            label: function(ctx){ return ' Rs ' + (ctx.raw * 1000).toLocaleString(); }
          }
        }
      },
      scales:{
        y:{
          beginAtZero:true,
          grid:{color:'#d4e5da'},
          ticks:{callback:function(v){ return 'Rs '+v+'K'; }}
        },
        x:{grid:{display:false}}
      }
    }
  });
}

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

  /* Sales line chart */
  updateSalesChart();

  /* Stock KPI strip */
  buildStockKpiStrip();

  /* Top performers */
  buildTopPerformers();

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
        labels:['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'],
        datasets:[{label:'Customers',data:[1,2,3,3,4,5,5,6,6,7,7,parseInt(document.getElementById('__adminMeta').dataset.customers)||0],fill:true,backgroundColor:'rgba(26,107,56,0.08)',borderColor:'#1a6b38',tension:0.4,pointRadius:4,pointBackgroundColor:'#1a6b38',pointBorderColor:'#fff',pointBorderWidth:2}]
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
  var dashBtn = document.querySelector('.adm-nav-item[onclick*="dashboard"]');
  showSection('dashboard', dashBtn);
  buildCharts();
});
</script>
</body>
</html>
