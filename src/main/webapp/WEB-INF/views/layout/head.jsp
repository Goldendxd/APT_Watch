<%--
  Created by IntelliJ IDEA.
  User: ACER
  Date: 4/23/2026
  Time: 5:17 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta name="ctx" content="${pageContext.request.contextPath}" />
        <title>${not empty pageTitle ? pageTitle : 'AluGhadi Watches'}</title>
        <meta name="description" content="${not empty pageDesc ? pageDesc : 'Premium watch collection and online shopping in Nepal.'}" />
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&family=Playfair+Display:ital,wght@0,700;0,900;1,700&display=swap" rel="stylesheet" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/global.css" />
        <c:if test="${not empty pageStyle}">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/pages/${pageStyle}.css" />
        </c:if>
</head>
<body>

</body>
</html>
