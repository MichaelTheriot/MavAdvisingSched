<%@tag description="Page template" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@attribute name="pagetitle" %>
<%@attribute name="loggedout" fragment="true" %>
<%@attribute name="loggedin" fragment="true" %>
<%@attribute name="studentorloggedout" fragment="true" %>
<%@attribute name="student" fragment="true" %>
<%@attribute name="advisororleadadvisor" fragment="true" %>
<%@attribute name="leadadvisor" fragment="true" %>
<%@attribute name="admin" fragment="true" %>
<c:set var="pagetitle" value="${(empty pagetitle) ? 'UTA Advising' : pagetitle}" />
<c:set var="rank" value="${!(empty sessionScope.rank) ? sessionScope.rank : -1}" />
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>${pagetitle}</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/normalize.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/calendar.css" />
    <link rel="shortcut icon" href="https://www.uta.edu/favicon.ico" type="image/x-icon">
  </head>
  <body>
    <t:header pagetitle="UTA Advisor Scheduling" rank="${rank}" />
    <main>
      <div id="content">
        <c:choose>
            <c:when test="${not empty loggedout and rank < 0}">
              <jsp:invoke fragment="loggedout" />
            </c:when>
            <c:when test="${not empty loggedin and rank >= 0}">
              <jsp:invoke fragment="loggedin" />
            </c:when>
            <c:when test="${not empty studentorloggedout and rank <= 0}">
              <jsp:invoke fragment="studentorloggedout" />
            </c:when>
            <c:when test="${not empty student and rank == 0}">
              <jsp:invoke fragment="student" />
            </c:when>
            <c:when test="${not empty advisororleadadvisor and rank >= 1 && rank < 3}">
              <jsp:invoke fragment="advisororleadadvisor" />
            </c:when>
            <c:when test="${not empty leadadvisor and rank == 2}">
              <jsp:invoke fragment="leadadvisor" />
            </c:when>
            <c:when test="${not empty admin and rank >= 3}">
              <jsp:invoke fragment="admin" />
            </c:when>
            <c:otherwise>
                <c:choose>
                    <c:when test="${not empty loggedout or not empty loggedin or not empty studentorloggedout or not empty student or not empty advisororleadadvisor or not empty leadadvisor or not empty admin}">
                        <c:redirect url="/" />
                    </c:when>
                    <c:otherwise>
                        <jsp:doBody/>
                    </c:otherwise>
                </c:choose>
            </c:otherwise>
        </c:choose>
      </div>
    </main>
    <t:footer />
  </body>
</html>
