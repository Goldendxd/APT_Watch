<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String method = request.getMethod();
  if ("POST".equalsIgnoreCase(method)) {
    String username = request.getParameter("username");
    if (username != null && !username.trim().isEmpty()) {
      session.setAttribute("authUser", username.trim());
      session.setAttribute("authRole", "user");
      response.sendRedirect(request.getContextPath() + "/");
      return;
    }
  }

  request.setAttribute("pageTitle", "Login | AluGhadi");
  request.setAttribute("pageDesc", "Login to your AluGhadi account.");
  request.setAttribute("activeNav", "");
%>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="pg-body" style="margin-top:86px;max-width:700px;">
  <div class="gc" style="margin:2rem auto;">
    <div class="gc-tag">Account Access</div>
    <h1 class="gc-h" style="margin-bottom:0.8rem;">Login</h1>
    <p class="gc-sub">Temporary frontend login placeholder until backend auth is connected.</p>

    <form method="post" action="${pageContext.request.contextPath}/login">
      <div class="fg">
        <label for="username">Username</label>
        <input id="username" name="username" type="text" placeholder="Enter username" required />
      </div>
      <div class="fg">
        <label for="password">Password</label>
        <input id="password" name="password" type="password" placeholder="Enter password" required />
      </div>
      <button type="submit" class="btn-fill">Login</button>
    </form>
  </div>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
