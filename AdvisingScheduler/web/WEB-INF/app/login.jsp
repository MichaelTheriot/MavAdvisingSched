<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="loginbean" class="uta.cse4361.beans.LoginBean"/>
<jsp:useBean id="studentbean" class="uta.cse4361.beans.StudentBean"/>
<jsp:useBean id="advisorbean" class="uta.cse4361.beans.AdvisorBean"/>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<c:set var="rank" value="${!(empty sessionScope.rank) ? sessionScope.rank : -1}" />
<c:choose>
    <c:when test="${rank >= 0}">
        <c:redirect url="/" />
    </c:when>
    <c:when test="${rank < 0 and empty param.code}">
        <c:redirect url="${loginbean.getAuthUri()}"/>
    </c:when>
    <c:otherwise>
        <c:choose>
            <c:when test="${not empty param.code}">
                <c:set var="user" value="${loginbean.certifyUser(param.code)}"/>
                <c:choose>
                    <c:when test="${user != null}">
                        <c:set var="user" value="${user}" scope="session" />
                        <c:set var="rank" value="${user.getRank()}" scope="session" />
                        <c:choose>
                            <c:when test="${user.getRank() == 0}">
                                <jsp:setProperty name="studentbean" property="userId" value="${user.getId()}" />
                                <c:set var="student" value="${studentbean.getStudent()}" scope="session" />
                            </c:when>
                            <c:when test="${user.getRank() == 2 or user.getRank() == 3}">
                                <jsp:setProperty name="advisorbean" property="userId" value="${user.getId()}" />
                                <c:set var="advisor" value="${advisorbean.getAdvisor()}" scope="session" />
                            </c:when>
                        </c:choose>
                        <t:redirect pagetitle="Sign in" url="${pageContext.request.contextPath}/">
                            You have signed in successfully!
                        </t:redirect>
                    </c:when>
                    <c:otherwise>
                        <t:redirect url="${pageContext.request.contextPath}">
                            There was a problem verifying your login. Please try again.
                        </t:redirect>
                    </c:otherwise>
                </c:choose>
            </c:when>
            <c:otherwise>
                <c:redirect url="${pageContext.request.contextPath}"/>
            </c:otherwise>
        </c:choose>
    </c:otherwise>
</c:choose>