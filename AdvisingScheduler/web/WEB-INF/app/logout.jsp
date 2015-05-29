<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<jsp:useBean id="loginbean" class="uta.cse4361.beans.LoginBean"/>
<c:choose>
    <c:when test="${not empty sessionScope.user}">
        <% request.getSession().invalidate(); %>
        <c:redirect url="${loginbean.getDeauthUri()}" />
    </c:when>
    <c:otherwise>
        <c:redirect url="/" />
    </c:otherwise>
</c:choose>
