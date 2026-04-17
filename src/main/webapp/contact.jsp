<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%
request.setAttribute("pageTitle", "Contact | AluGhadi");
request.setAttribute("pageDesc", "Contact AluGhadi.");
request.setAttribute("activeNav", "contact"); %>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="pg-body" style="margin-top: 86px">
  <h1 class="sec-h" style="margin-bottom: 1rem">Contact</h1>
  <p class="sec-sub">
    Email: support@alughadi.com<br />Phone: +977-1-XXXX-XXXX
  </p>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
