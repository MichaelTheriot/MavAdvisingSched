<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<jsp:useBean id="schedulebean" class="uta.cse4361.beans.ScheduleBean"/>
<c:catch var="e"><fmt:parseNumber var="id" type="number" integerOnly="true" value="${param.slot}" /></c:catch><c:if test="${e != null}"><c:redirect url="/schedule" /></c:if>
<c:set var="major" value="${(not empty sessionScope.major) ? sessionScope.major : param.major}" />
<c:choose>
    <c:when test="${not empty sessionScope.studentid}">
        <c:set var="appt" value="${schedulebean.scheduleAppointment(param.slot, sessionScope.studentId, param.reason, param.desc)}" />
    </c:when>
    <c:otherwise>
        <c:set var="appt" value="${schedulebean.scheduleAppointment(param.slot, param.email, param.fname, param.lname, param.phone, param.reason, param.desc)}" />
    </c:otherwise>
</c:choose>
<t:redirect pagetitle="Schedule Appointment" url="${pageContext.request.contextPath}/">
    <c:choose>
        <c:when test="${(not empty appt) and appt != null and appt == true}">
            Appointment scheduled.
        </c:when>
        <c:otherwise>
            Unable to schedule appointment. Please review your schedule details again.
        </c:otherwise>
    </c:choose>
</t:redirect>