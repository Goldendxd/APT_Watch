<%-- header.jsp — shared layout header (nav + loading screen + sidebar)
     Adapted for AluGhadi Watches ecommerce platform
     Included by every page JSP via: <jsp:include page="/WEB-INF/views/layout/header.jsp">
     Parameters consumed:
       pageTitle   (String) — <title> content
       pageDesc    (String) — meta description
       activeNav   (String) — which nav link gets aria-current="page"
       pageStyle   (String) — optional per-page CSS file name (no extension)
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>${not empty pageTitle ? pageTitle : 'AluGhadi Watches'}</title>
  <meta name="description" content="${not empty pageDesc ? pageDesc : 'Premium watch collection and online shopping in Nepal.'}" />
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&family=Playfair+Display:ital,wght@0,700;0,900;1,700&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/styles/global.css" />
  <c:if test="${not empty pageStyle}">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/styles/pages/${pageStyle}.css" />
  </c:if>
</head>
<body>

  <%-- ======== LOADING SCREEN ======== --%>
  <div id="page-loader">
    <div class="loader-inner">
      <div class="loader-logo-box">
        <img src="${pageContext.request.contextPath}/static/images/alughadiweblogo.png" alt="AluGhadi" class="loader-logo-img" />
      </div>
      <div class="loader-bar"><div class="loader-fill"></div></div>
    </div>
  </div>

  <%-- ======== NAVIGATION ======== --%>
  <nav id="nav" role="navigation" aria-label="Main navigation">
    <div class="nav-inner">

      <%-- Logo --%>
      <a class="logo" href="${pageContext.request.contextPath}/" aria-label="AluGhadi — Home">
        <img src="${pageContext.request.contextPath}/static/images/alughadiweblogo.png" alt="AluGhadi" class="nav-logo-img" />
      </a>

      <%-- Desktop nav links --%>
      <div class="nav-links">
        <a href="${pageContext.request.contextPath}/"
           ${activeNav == 'home' ? 'class="active" aria-current="page"' : ''}>Home</a>
        <a href="${pageContext.request.contextPath}/products"
           ${activeNav == 'products' ? 'class="active" aria-current="page"' : ''}>Products</a>
        <a href="${pageContext.request.contextPath}/gifting"
           ${activeNav == 'gifting' ? 'class="active" aria-current="page"' : ''}>Gifting</a>
        <a href="${pageContext.request.contextPath}/about"
           ${activeNav == 'about' ? 'class="active" aria-current="page"' : ''}>About</a>
        <a href="${pageContext.request.contextPath}/contact"
           ${activeNav == 'contact' ? 'class="active" aria-current="page"' : ''}>Contact</a>
      </div>

      <%-- Right actions --%>
      <div class="nav-end">
        <button class="btn-out-nav" id="nav-cart-btn" type="button" onclick="openCart()" aria-label="Open cart">
          &#128717; Cart <span id="nav-cart-count">(0)</span>
        </button>
        <c:choose>
          <c:when test="${not empty sessionScope.authUser}">
            <span class="nav-user-chip">
              ${sessionScope.authUser}
            </span>
            <a href="${pageContext.request.contextPath}/logout" class="btn-fill-nav">Logout</a>
          </c:when>
          <c:otherwise>
            <a href="${pageContext.request.contextPath}/register" class="btn-reg-nav">Register</a>
            <a href="${pageContext.request.contextPath}/login"    class="btn-fill-nav">Sign In</a>
          </c:otherwise>
        </c:choose>
      </div>

      <%-- Hamburger (mobile) --%>
      <button class="hamburger" id="nav-ham" aria-label="Open menu" onclick="toggleSidebar()">
        <span></span><span></span><span></span>
      </button>

    </div>
  </nav>

  <%-- ======== MOBILE SIDEBAR ======== --%>
  <div class="sidebar-overlay" id="sidebar-overlay" onclick="closeSidebar()"></div>
  <aside class="sidebar" id="sidebar" aria-label="Mobile navigation">
    <div class="sidebar-head">
      <a class="logo" href="${pageContext.request.contextPath}/" onclick="closeSidebar()">
        <div class="logo-mark">AG</div>
        <span class="logo-brand">Alu<span>Ghadi</span></span>
      </a>
      <button class="sidebar-close" onclick="closeSidebar()" aria-label="Close menu">&#10005;</button>
    </div>
    <nav class="sidebar-nav" aria-label="Sidebar navigation">
      <a href="${pageContext.request.contextPath}/"
         onclick="closeSidebar()"
         ${activeNav == 'home' ? 'class="active"' : ''}>&#127968; Home</a>
      <a href="${pageContext.request.contextPath}/products"
         onclick="closeSidebar()"
         ${activeNav == 'products' ? 'class="active"' : ''}>&#8987; Products</a>
      <a href="${pageContext.request.contextPath}/gifting"
         onclick="closeSidebar()"
         ${activeNav == 'gifting' ? 'class="active"' : ''}>&#127873; Gifting</a>
      <a href="${pageContext.request.contextPath}/about"
         onclick="closeSidebar()"
         ${activeNav == 'about' ? 'class="active"' : ''}>&#8505; About</a>
      <a href="${pageContext.request.contextPath}/contact"
         onclick="closeSidebar()"
         ${activeNav == 'contact' ? 'class="active"' : ''}>&#9993; Contact</a>
    </nav>
    <div class="sidebar-foot">
      <button class="btn-out-nav" type="button"
              style="width:100%;justify-content:center;"
              onclick="closeSidebar();openCart()">&#128717; Cart</button>
      <c:choose>
        <c:when test="${not empty sessionScope.authUser}">
          <div class="sidebar-user">${sessionScope.authUser}</div>
          <a href="${pageContext.request.contextPath}/logout"
             class="btn-fill-nav"
             style="width:100%;justify-content:center;">Logout</a>
        </c:when>
        <c:otherwise>
          <a href="${pageContext.request.contextPath}/register"
             class="btn-reg-nav"
             style="width:100%;justify-content:center;"
             onclick="closeSidebar()">Create Account</a>
          <a href="${pageContext.request.contextPath}/login"
             class="btn-fill-nav"
             style="width:100%;justify-content:center;"
             onclick="closeSidebar()">Sign In</a>
        </c:otherwise>
      </c:choose>
    </div>
  </aside>
