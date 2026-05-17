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

<%-- Load cart count for nav badge if user is logged in and not already set --%>
<%@ page import="com.alughadi.dao.CartDaoImpl" %>
<%
  if (request.getAttribute("cartCount") == null) {
    Object uid = session.getAttribute("authUserId");
    if (uid != null) {
      CartDaoImpl _cartDao = new CartDaoImpl();
      int _userId = (Integer) uid;
      request.setAttribute("cartCount", _cartDao.getCartCount(_userId));
      if (request.getAttribute("cartItems") == null) {
        request.setAttribute("cartItems", _cartDao.getCartItems(_userId));
        request.setAttribute("grandTotal", _cartDao.getGrandTotal(_userId));
      }
    }
  }
%>
<!doctype html>
<html lang="en">
<body>

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
          <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="flex-shrink:0;"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
          Cart <span id="nav-cart-count">(${not empty cartCount ? cartCount : 0})</span>
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
        <img src="${pageContext.request.contextPath}/static/images/alughadiweblogo.png" alt="AluGhadi" class="nav-logo-img" style="height:32px;width:auto;" />
      </a>
      <button class="sidebar-close" onclick="closeSidebar()" aria-label="Close menu">&#10005;</button>
    </div>
    <nav class="sidebar-nav" aria-label="Sidebar navigation">
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
      <button class="btn-out-nav" type="button"
              style="width:100%;justify-content:center;"
              onclick="closeSidebar();openCart()">Cart</button>
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
