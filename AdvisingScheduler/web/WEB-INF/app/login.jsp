<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="login" class="uta.cse4361.beans.LoginBean"/> 
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<c:set var="rank" value="${!(empty sessionScope.rank) ? sessionScope.rank : -1}" />
<c:choose>
    <c:when test="${not empty param.email and rank < 0}">
        <jsp:setProperty name="login" property="email" value='${param.email}' />
        <jsp:setProperty name="login" property="password" value='${param.password}' />
        <c:set var="user" value="${login.getUser()}" />
        <t:redirect pagetitle="Sign in" url="${pageContext.request.contextPath}/">
            <c:choose>
                <c:when test="${user != null}">
                    <c:set var="id" value="${user.getId()}" scope="session" />
                    <c:set var="email" value="${user.getEmail()}" scope="session" />
                    <c:set var="fname" value="${user.getFname()}" scope="session" />
                    <c:set var="lname" value="${user.getLname()}" scope="session" />
                    <c:set var="phone" value="${user.getPhone()}" scope="session" />
                    <c:set var="rank" value="${user.getRank()}" scope="session" />
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
                <form class="panel" action="${pageContext.request.contextPath}/login" method="POST">
                    <fieldset>
                        <legend>Access your account</legend>
                        <ol>
                            <li>
                                <t:forminput name="email" label="Email" type="email" placeholder="email@mavs.uta.edu" pattern=".*@mavs\.uta\.edu" title="Enter your UTA email" required="true" />
                            </li>
                            <li>
                                <t:forminput name="password" label="Password" type="password" placeholder="************" required="true" />
                            </li>
                        </ol>
                        <input type="submit" value="Sign in">
                    </fieldset>
                </form>
            </jsp:attribute>
        </t:layout>
    </c:otherwise>
</c:choose>