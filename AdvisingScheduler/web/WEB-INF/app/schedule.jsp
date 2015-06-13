<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:useBean id="department" class="uta.cse4361.beans.DepartmentBean"/>
<jsp:useBean id="slotsbean" class="uta.cse4361.beans.SlotsBean"/>
<c:choose>
    <c:when test="${(not empty param.major or not empty sessionScope.student) and not empty param.reason and not empty param.slot and param.confirm == true}">
        <%@include file="/WEB-INF/app/schedule/submit.jsp" %>
    </c:when>
    <c:otherwise>
<t:layout>
    <jsp:attribute name="studentorloggedout">
        <c:choose>
            <c:when test="${empty param.dept or (empty param.major and empty sessionScope.student)}">
                <%@include file="/WEB-INF/app/schedule/page1.jsp" %>
            </c:when>
            <c:when test="${empty param.slot or not empty param.page}">
                <%@include file="/WEB-INF/app/schedule/page2.jsp" %>
            </c:when>
            <c:when test="${empty param.reason}">
                <%@include file="/WEB-INF/app/schedule/page3.jsp" %>
            </c:when>
            <c:when test="${empty param.confirm}">
                <%@include file="/WEB-INF/app/schedule/page4.jsp" %>
            </c:when>
            <c:when test="${(not empty param.confirm) and param.confirm != true}">
                <c:redirect url="/schedule" />
            </c:when>
            <c:otherwise>
                <%@include file="/WEB-INF/app/schedule/page1.jsp" %>
            </c:otherwise>
        </c:choose>
    </jsp:attribute>
</t:layout>
    </c:otherwise>
</c:choose>