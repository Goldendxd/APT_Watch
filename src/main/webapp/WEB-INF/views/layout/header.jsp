<%-- header.jsp — shared layout header (nav + loading screen + sidebar)
     Adapted for AluGhadi Watches ecommerce platform
     Included by every page JSP via: <jsp:include page="/WEB-INF/views/layout/header.jsp">
     Parameters consumed:
       pageTitle   (String) — <title> content
       pageDesc    (String) — meta description
       activeNav   (String) — which nav link gets aria-current="page"
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>${not empty pageTitle ? pageTitle : 'AluGhadi Watches'}</title>
  <meta name="description" content="${not empty pageDesc ? pageDesc : 'Premium watch collection and online shopping.'}" />
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/styles/global.css" />
  <c:if test="${not empty pageStyle}">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/styles/pages/${pageStyle}.css" />
  </c:if>
</head>
<body>

  <%-- ======== LOADING SCREEN ======== --%>
  <div id="page-loader">
    <div class="loader-inner">
      <div class="loader-logo" style="font-size:2.5rem;font-weight:900;">AG</div>
      <div class="loader-name">AluGhadi</div>
      <div class="loader-bar"><div class="loader-fill"></div></div>
    </div>
  </div>

  <%-- ======== NAVIGATION ======== --%>
  <nav id="nav">
    <div class="nav-inner">
      <a class="logo" href="${pageContext.request.contextPath}/">
        <div style="font-size:1.5rem;font-weight:900;">AG</div>
        <span style="font-weight:900;font-size:1.2rem;">AluGhadi</span>
      </a>

      <div class="nav-links">
        <a href="${pageContext.request.contextPath}/"
           ${activeNav == 'home' ? 'class="active"' : ''}>Home</a>
        <a href="${pageContext.request.contextPath}/products"
           ${activeNav == 'products' ? 'class="active"' : ''}>Products</a>
          <a href="${pageContext.request.contextPath}/gifting"
            ${activeNav == 'gifting' ? 'class="active"' : ''}>Gifting</a>
        <a href="${pageContext.request.contextPath}/about"
           ${activeNav == 'about' ? 'class="active"' : ''}>About</a>
        <a href="${pageContext.request.contextPath}/contact"
           ${activeNav == 'contact' ? 'class="active"' : ''}>Contact</a>
      </div>

      <div class="nav-end">
          <button class="btn-out-nav" type="button" onclick="openCart()">Cart (0)</button>
        <c:choose>
          <c:when test="${not empty sessionScope.authUser}">
            <span class="nav-user-chip">User: ${sessionScope.authUser}</span>
            <a href="${pageContext.request.contextPath}/logout" class="btn-fill-nav">Logout</a>
          </c:when>
          <c:otherwise>
            <a href="${pageContext.request.contextPath}/login" class="btn-fill-nav">Login</a>
          </c:otherwise>
        </c:choose>
      </div>

      <%-- Hamburger (mobile only) --%>
      <button class="hamburger" id="nav-ham" aria-label="Open menu" onclick="toggleSidebar()">
        <span></span><span></span><span></span>
      </button>
    </div>
  </nav>

  <%-- ======== MOBILE SIDEBAR ======== --%>
  <div class="sidebar-overlay" id="sidebar-overlay" onclick="closeSidebar()"></div>
  <aside class="sidebar" id="sidebar">
    <div class="sidebar-head">
      <a class="logo" href="${pageContext.request.contextPath}/">
        <div style="font-size:1.5rem;font-weight:900;">AG</div>
        <span class="logo-brand" style="font-size:1.2rem;font-weight:900;">AluGhadi</span>
      </a>
      <button class="sidebar-close" onclick="closeSidebar()" aria-label="Close menu">✕</button>
    </div>
    <nav class="sidebar-nav">
      <a href="${pageContext.request.contextPath}/"
         onclick="closeSidebar()"
         ${activeNav == 'home' ? 'class="active"' : ''}>Home</a>
      <a href="${pageContext.request.contextPath}/products"
         onclick="closeSidebar()"
         ${activeNav == 'products' ? 'class="active"' : ''}>Products</a>
      <a href="${pageContext.request.contextPath}/gifting"
         onclick="closeSidebar()"
        ${activeNav == 'gifting' ? 'class="active"' : ''}>Gifting</a>
      <a href="${pageContext.request.contextPath}/about"
         onclick="closeSidebar()"
         ${activeNav == 'about' ? 'class="active"' : ''}>About</a>
      <a href="${pageContext.request.contextPath}/contact"
         onclick="closeSidebar()"
         ${activeNav == 'contact' ? 'class="active"' : ''}>Contact</a>
    </nav>
    <div class="sidebar-foot">
      <button class="btn-out-nav" type="button" style="width:100%;justify-content:center;" onclick="closeSidebar();openCart()">Cart</button>
      <c:choose>
        <c:when test="${not empty sessionScope.authUser}">
          <div class="sidebar-user">User: ${sessionScope.authUser}</div>
          <a href="${pageContext.request.contextPath}/logout" class="btn-fill-nav" style="width:100%;justify-content:center;">Logout</a>
        </c:when>
        <c:otherwise>
          <a href="${pageContext.request.contextPath}/login" class="btn-fill-nav" style="width:100%;justify-content:center;">Login</a>
        </c:otherwise>
      </c:choose>
    </div>
  </aside>
