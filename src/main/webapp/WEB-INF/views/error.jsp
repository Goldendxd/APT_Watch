<%--
  error.jsp — Generic error page (isErrorPage="true").
  Reads jakarta.servlet.error.status_code from the request to show 400 / 401 / 403 / 404 / 500.
  Configured in web.xml so Tomcat forwards here on HTTP errors.
  Standalone page with its own <html> structure — does not use header.jsp.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    Integer statusCode = (Integer) request.getAttribute("jakarta.servlet.error.status_code");
    if (statusCode == null) statusCode = 404;

    String errorTitle;
    if      (statusCode == 400) errorTitle = "Bad Request";
    else if (statusCode == 401) errorTitle = "Unauthorized";
    else if (statusCode == 403) errorTitle = "Forbidden";
    else if (statusCode == 404) errorTitle = "Page Not Found";
    else if (statusCode == 500) errorTitle = "Server Error";
    else                        errorTitle = "Something Went Wrong";

    request.setAttribute("pageTitle",  statusCode + " – " + errorTitle);
    request.setAttribute("pageStyle",  "error");
    request.setAttribute("activeNav",  "");
%>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<main class="error-shell">
  <section class="error-card">
    <div class="error-icon">
      <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor"
           stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
        <circle cx="12" cy="12" r="10"/>
        <line x1="12" y1="8"  x2="12"    y2="12"/>
        <line x1="12" y1="16" x2="12.01" y2="16"/>
      </svg>
    </div>

    <div class="error-code"><%= statusCode %></div>
    <h1 class="error-title"><%= errorTitle %></h1>

    <p class="error-message">
      The page you are looking for is unavailable, moved, or something went wrong on our end.
    </p>

    <div class="error-actions">
      <a href="${pageContext.request.contextPath}/"         class="btn-fill error-btn">Go to Home</a>
      <a href="${pageContext.request.contextPath}/products" class="btn-out-nav error-btn">Browse Watches</a>
    </div>
  </section>
</main>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
