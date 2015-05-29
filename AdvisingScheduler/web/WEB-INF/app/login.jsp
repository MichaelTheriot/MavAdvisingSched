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
                <c:set var="user" value="${loginbean.getUser(param.code)}"/>
                <c:choose>
                    <c:when test="${user != null}">
                        <t:redirect pagetitle="Sign in" url="${pageContext.request.contextPath}/">
                            <c:set var="user" value="${user}" scope="session" />
                            <c:set var="id" value="${user.getId()}" scope="session" />
                            <c:set var="email" value="${user.getEmail()}" scope="session" />
                            <c:set var="fname" value="${user.getFname()}" scope="session" />
                            <c:set var="lname" value="${user.getLname()}" scope="session" />
                            <c:set var="phone" value="${user.getPhone()}" scope="session" />
                            <c:set var="rank" value="${user.getRank()}" scope="session" />
                            <c:if test="${user.getRank() == 0}">
                                <jsp:setProperty name="studentbean" property="userId" value='${user.getId()}' />
                                <c:set var="student" value="${studentbean.getStudent()}" />
                                <c:set var="studentid" value="${student.getStudentId()}" scope="session" />
                                <c:set var="utastudentid" value="${student.getUtaStudentId()}" scope="session" />
                                <c:set var="major" value="${student.getMajor()}" scope="session" />
                            </c:if>
                            <c:if test="${user.getRank() == 1 or user.getRank() == 2}">
                                <jsp:setProperty name="advisorbean" property="userId" value='${user.getId()}' />
                                <c:set var="advisor" value="${advisorbean.getAdvisor()}" />
                                <c:set var="advisorid" value="${advisor.getAdvisorId()}" scope="session" />
                                <c:set var="dept" value="${advisor.getDept()}" scope="session" />
                            </c:if>
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