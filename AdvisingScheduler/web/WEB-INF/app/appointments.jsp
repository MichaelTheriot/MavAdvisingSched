<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:useBean id="appointmentbean" class="uta.cse4361.beans.AppointmentBean"/>
<t:layout>
    <jsp:attribute name="student">
        <p>Below is a list of open appointments you have scheduled.</p>
        <table class="module">
            <tbody>
                <tr>
                    <th>Time</th>
                    <th>Advisor</th>
                    <th>Reason</th>
                    <th>Description</th>
                </tr>
                <c:set var="appts" value="${appointmentbean.getAppointmentsByStudentId(sessionScope.studentid)}" />
                <c:if test="${fn:length(appts) > 0}">
                    <c:forEach var="i" begin="0" end="${fn:length(appts) - 1}">
                        <td>${appts[i].getTime()}</td>
                        <td>${appts[i].getAdvisor()}</td>
                        <td>${appts[i].getReason()}</td>
                        <td>${appts[i].getDescription()}</td>
                    </c:forEach>
                </c:if>
            </tbody>
        </table>
    </jsp:attribute>
</t:layout>