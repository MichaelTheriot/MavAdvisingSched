<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="loginbean" class="uta.cse4361.beans.LoginBean"/> 
<jsp:useBean id="studentbean" class="uta.cse4361.beans.StudentBean"/> 
<jsp:useBean id="advisorbean" class="uta.cse4361.beans.AdvisorBean"/> 
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<c:set var="rank" value="${!(empty sessionScope.rank) ? sessionScope.rank : -1}" />
<c:choose>
    <c:when test="${not empty param.email and rank < 0}">
        <jsp:setProperty name="loginbean" property="email" value='${param.email}' />
        <jsp:setProperty name="loginbean" property="password" value='${param.password}' />
        <c:set var="user" value="${loginbean.getUser()}" />
        <t:redirect pagetitle="Sign in" url="${pageContext.request.contextPath}/">
            <c:choose>
                <c:when test="${user != null}">
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
                </c:when>
                <c:otherwise>
                    Invalid username or password.
                </c:otherwise>
            </c:choose>
        </t:redirect>
    </c:when>
    <c:otherwise>
        <t:layout pagetitle="Sign in">
            <jsp:attribute name="loggedout">
                <t:login />
                <h1>Sign in to access your account</h1>
                <p>Use this form to sign into your account. Once you are signed in you will be able to create appointments with information pre-filled from your profile, and manage open appointments.</p>
           </jsp:attribute>
        </t:layout>
    </c:otherwise>
</c:choose>