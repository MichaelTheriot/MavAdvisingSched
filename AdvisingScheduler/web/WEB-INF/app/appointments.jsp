<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:useBean id="appointmentbean" class="uta.cse4361.beans.AppointmentBean"/>
<t:layout>
    <jsp:attribute name="loggedin">
        <p>Below is a list of open appointments you have scheduled.</p>
        <table class="module">
            <tbody>
                <tr>
                    <th>Time</th>
                    <th>Advisor</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Reason</th>
                    <th>Description</th>
                </tr>
                <c:choose>
                    <c:when test="${sessionScope.rank >= 3}">
                        <c:set var="appts" value="${appointmentbean.getAppointments()}" />
                    </c:when>
                    <c:when test="${sessionScope.rank == 2}">
                        <c:set var="appts" value="${appointmentbean.getAppointmentsByDeptId(sessionScope.dept)}" />
                    </c:when>
                    <c:when test="${sessionScope.rank == 1}">
                        <c:set var="appts" value="${appointmentbean.getAppointmentsByDeptId(sessionScope.advisorid)}" />
                    </c:when>
                    <c:otherwise>
                        <c:set var="appts" value="${appointmentbean.getAppointmentsByStudentId(sessionScope.studentid)}" />
                    </c:otherwise>
                </c:choose>
                <c:if test="${fn:length(appts) > 0}">
                    <c:forEach var="i" begin="0" end="${fn:length(appts) - 1}">
                        <tr>
                            <td>${appts[i].getTimestamp("EEEE, MMMM d, yyyy  h:mm a")}</td>
                            <td>${appts[i].getAdvisor()}</td>
                            <td>${appts[i].getAdvisorEmail()}</td>
                            <td>${appts[i].getAdvisorPhone()}</td>
                            <td>${appts[i].getReason()}</td>
                            <td>${appts[i].getDescription()}</td>
                        </tr>
                    </c:forEach>
                </c:if>
            </tbody>
        </table>
    </jsp:attribute>
</t:layout>