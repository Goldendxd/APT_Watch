<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Integer statuscode = (Integer) request.getAttribute("jakarta.servlet.error.status_code");
    if (statuscode == null) {
        statuscode = response.getStatus();
    }
    if(statuscode == 200) {
        statuscode = 404;
    }
    String errorTittle = "Something Went Wrong";

    if (statuscode == 400) {
        errorTittle = "Bad Request";
    } else if (statuscode == 401) {
        errorTittle = "Unauthorized";
    } else if (statuscode == 402) {
        errorTittle = "Payment Required";
    } else if (statuscode == 403) {
        errorTittle = "Forbidden";
    } else if (statuscode == 404) {
        errorTittle = "Page Not Found";
    } else if (statuscode == 500) {
        errorTittle = "Server Error";
    }

    request.setAttribute("pageTitle", statuscode + " - "+ errorTittle);
    request.setAttribute("pageStyle", "error");
%>
<%--<jsp:include page="/WEB-INF/views/layout/header.jsp" />--%>
<jsp:include page="/WEB-INF/views/layout/head.jsp" />
<main class="error-shell">
    <section class="error-card">
        <p class="error-brand">AluGhadi Watches</p>

        <div class="error-code"><%= statuscode %></div>

        <h1>Oops! <%= errorTittle %></h1>

        <p class="error-message">
            The page you are looking for is unavailable, moved, or something went wrong.
        </p>

        <div class="error-actions">
            <a href="${pageContext.request.contextPath}/home" class="error-btn primary">Go to Home</a>
            <a href="${pageContext.request.contextPath}/products" class="error-btn secondary">Browse Watches</a>
        </div>
    </section>
</main>
<%--<jsp:include page="/WEB-INF/views/layout/footer.jsp" />--%>

