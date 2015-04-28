<%@tag description="Header block" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@attribute name="pagetitle" required="true" %>
<%@attribute name="rank" required="true" type="java.lang.Integer" %>
    <header>
      <h1>${pagetitle}</h1>
      <nav>
        <ul>
<t:navlink url="${pageContext.request.contextPath}/" name="Home" />
<c:if test="${rank <= 0}">
    <t:navlink url="${pageContext.request.contextPath}/schedule" name="Schedule Appointment" />
</c:if>
<c:if test="${rank < 0}">
    <t:navlink url="${pageContext.request.contextPath}/login" name="Sign in" />
    <t:navlink url="${pageContext.request.contextPath}/register" name="Register" />
</c:if>
<c:if test="${rank >= 0}">
    <t:navlink url="${pageContext.request.contextPath}/appointments" name="View Appointments" />
    <t:navlink url="${pageContext.request.contextPath}/logout" name="Sign Out" />
</c:if>
        </ul>
      </nav>
    </header>