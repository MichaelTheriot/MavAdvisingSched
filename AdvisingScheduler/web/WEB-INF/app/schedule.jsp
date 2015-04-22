<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<t:layout>
    <jsp:attribute name="studentorloggedout">
        <c:choose>
            <c:when test="${empty param.dept or (empty param.major and empty sessionScope.major)}">
                <%@include file="/WEB-INF/app/schedule/page1.jsp" %>
            </c:when>
            <c:when test="${empty param.slot or not empty param.page}">
                <%@include file="/WEB-INF/app/schedule/page2.jsp" %>
            </c:when>
        </c:choose>
    </jsp:attribute>
</t:layout>