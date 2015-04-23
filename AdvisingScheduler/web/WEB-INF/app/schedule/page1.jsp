<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@page import="uta.cse4361.businessobjects.Department"%>
<c:set var="depts" value="${department.getDepartments()}" />
<form class="list panel" action="${pageContext.request.contextPath}/schedule" method="POST">
    <fieldset>
        <fieldset>
            <legend>Enter basic information</legend>
            <ol>
                <li>
                    <label for="s_dept">Department</label>
                    <select name="dept" id="s_dept" required>
                        <option disabled selected>-- Select a department --</option>
                        <c:forEach var="dept" items="${depts}">
                            <option value="${dept.getId()}">${dept.getName()}</option>
                        </c:forEach>
                    </select>
                </li>
                <li>
                    <c:choose>
                        <c:when test="${not empty sessionScope.major}">
                            <t:forminput name="major" label="Major" type="text" placeholder="Enter your major" required="true" value="${sessionScope.major}" disabled="true" />
                        </c:when>
                        <c:otherwise>
                            <t:forminput name="major" label="Major" type="text" placeholder="Enter your major" required="true" value="${param.major}" />
                        </c:otherwise>
                    </c:choose>
                </li>
            </ol>
            <input type="submit" value="Next" />
        </fieldset>
    </fieldset>
</form>
<h1>Schedule an Appointment</h1>
<p>Please use the form to the right to schedule an appointment.</p>
<c:if test="${empty sessionScope.studentid}">
    <p>You are not signed in; you will be asked to provide your email and phone number. Create a student account to remember these details and view scheduled appointments.</p>
</c:if>