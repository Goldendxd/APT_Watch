<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%
request.setAttribute("pageTitle", "About | AluGhadi");
request.setAttribute("pageDesc", "About AluGhadi watches.");
request.setAttribute("activeNav", "about"); %>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="pg-body" style="margin-top: 86px">
  <h1 class="sec-h" style="margin-bottom: 1rem">About AluGhadi</h1>
  <p class="sec-sub">
    Premium watch storefront template. Add your company story and backend
    integration here.
  </p>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
