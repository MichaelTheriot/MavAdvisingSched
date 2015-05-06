<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:useBean id="appointmentbean" class="uta.cse4361.beans.AppointmentBean"/>
<c:choose>
    <c:when test="${rank >= 0 and not empty param.id and not empty param.cancel and param.cancel == true}">
        <c:choose>
            <c:when test="${rank == 0}">
                <c:set var="success" value="${appointmentbean.cancelAppointmentStudent(param.id, sessionScope.studentid)}" />
            </c:when>
            <c:when test="${rank == 1}">
                <c:set var="success" value="${appointmentbean.cancelAppointmentAdvisor(param.id, sessionScope.advisorid)}" />
            </c:when>
            <c:when test="${rank == 2}">
                <c:set var="success" value="${appointmentbean.cancelAppointmentDepartment(param.id, sessionScope.dept)}" />
            </c:when>
            <c:when test="${rank >= 3}">
                <c:set var="success" value="${appointmentbean.cancelAppointment(param.id)}" />
            </c:when>
        </c:choose>
        <t:redirect pagetitle="Cancel appointment" url="${pageContext.request.contextPath}/appointments">
            <c:choose>
                <c:when test="${success == true}">
                    Appointment canceled.
                </c:when>
                <c:otherwise>
                    Failed to cancel appointment.
                </c:otherwise>
            </c:choose>
        </t:redirect>
    </c:when>
    <c:otherwise>
<t:layout>
    <jsp:attribute name="loggedin">
        <h1>Appointments</h1>
        <p>Below is a list of open appointments you may modify.</p>
        <table class="module">
            <tbody>
                <tr>
                    <th>Time</th>
                    <c:if test="${rank != 1}">
                        <th colspan="3">Advisor</th>
                    </c:if>
                    <c:if test="${rank != 0}">
                        <th colspan="4">Student</th>
                    </c:if>
                    <th>Reason</th>
                    <th>Description</th>
                    <th>Options</th>
                </tr>
                <c:choose>
                    <c:when test="${sessionScope.rank >= 3}">
                        <c:set var="appts" value="${appointmentbean.getAppointments()}" />
                    </c:when>
                    <c:when test="${sessionScope.rank == 2}">
                        <c:set var="appts" value="${appointmentbean.getAppointmentsByDeptId(sessionScope.dept)}" />
                    </c:when>
                    <c:when test="${sessionScope.rank == 1}">
                        <c:set var="appts" value="${appointmentbean.getAppointmentsByAdvisorId(sessionScope.advisorid)}" />
                    </c:when>
                    <c:otherwise>
                        <c:set var="appts" value="${appointmentbean.getAppointmentsByStudentId(sessionScope.studentid)}" />
                    </c:otherwise>
                </c:choose>
                <c:if test="${fn:length(appts) > 0}">
                    <c:forEach var="i" begin="0" end="${fn:length(appts) - 1}">
                        <tr>
                            <td>${appts[i].getTimestamp("M/d/y  h:mm a")}</td>
                            <c:if test="${rank != 1}">
                                <td>${appts[i].getAdvisor()}</td>
                                <td>${appts[i].getAdvisorEmail()}</td>
                                <td>${appts[i].getAdvisorPhone()}</td>
                            </c:if>
                            <c:if test="${rank != 0}">
                                <td>${appts[i].getStudent()}</td>
                                <td>${appts[i].getStudentEmail()}</td>
                                <td>${appts[i].getStudentPhone()}</td>
                                <td>${appts[i].getUtaStudentId()}</td>
                            </c:if>
                            <td>${appts[i].getReason()}</td>
                            <td>${appts[i].getDescription()}</td>
                            <td><form class="cell" action="${pageContext.request.contextPath}/appointments" method="POST"><input type="hidden" name="id" value="${appts[i].getApptId()}" /><input type="hidden" name="cancel" value="true" /><input type="submit" value="Cancel"/></form></td>
                        </tr>
                    </c:forEach>
                </c:if>
            </tbody>
        </table>
    </jsp:attribute>
</t:layout>
    </c:otherwise>
</c:choose>