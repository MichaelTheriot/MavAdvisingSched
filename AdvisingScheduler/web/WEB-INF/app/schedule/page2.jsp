<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<c:catch var="e"><fmt:parseNumber var="dept" type="number" integerOnly="true" value="${param.dept}" /></c:catch><c:if test="${e != null}"><c:set var="dept" value="0" /></c:if>
<c:catch var="e"><fmt:parseNumber var="page" type="number" integerOnly="true" value="${param.page}" /></c:catch><c:if test="${e != null}"><c:set var="page" value="0" /></c:if>
<c:set var="slots" value="${slotsbean.getSlotsByDept(dept)}" />
<c:set var="major" value="${(not empty sessionScope.major) ? sessionScope.major : param.major}" />
<c:choose>
    <c:when test="${slots != null}">
        <form class="wide" action="${pageContext.request.contextPath}/schedule" method="POST">
            <input type="hidden" name="dept" value="${param.dept}" />
            <input type="hidden" name="major" value="${major}" />
            <fieldset class="radioblocks">
                <legend>Choose a slot</legend>
                <t:calendar slots="${slots}" page="${page}" />
                <input type="submit" value="Schedule slot" />
            </fieldset>
        </form>
    </c:when>
    <c:otherwise>
        <form class="list panel" action="${pageContext.request.contextPath}/schedule" method="POST">
            <input type="hidden" name="major" value="${major}" />
            <fieldset>
                <fieldset>
                    <legend>No slots available</legend>
                    <p>There are no slots available for this department at this time.</p>
                    <input type="submit" value="Back" />
                </fieldset>
            </fieldset>
        </form>
    </c:otherwise>
</c:choose>