<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- <jsp:useBean id="profilebean" class="uta.cse4361.beans.ProfileBean"/> --%>
<c:choose>
    <c:when test="${rank == 0 and not empty param.utastudentid and not empty param.major}">
        <%--<c:set var="student" value="${profilebean.certifyStudent(user.getId(), param.utaStudentId, param.major)}" />--%>
        <p>form submission TBA</p>
    </c:when>
    <c:when test="${(rank == 2 or rank == 3) and not empty param.dept}">
        <%--<c:set var="advisor" value="${profilebean.certifyAdvisor(user.getId(), param.dept)}" />--%>
        <p>form submission TBA</p>
    </c:when>
    <c:when test="${rank >= 4 and not empty param.phone}">
        <%--<c:set var="success" value="${profilebean.updatePhone(user.getId(), param.phone)}" />--%>
        <p>form submission TBA</p>
    </c:when>
<c:otherwise>
<t:layout pagetitle="Edit Profile">
    <jsp:attribute name="loggedin">
        <form class="list panel" action="${pageContext.request.contextPath}/profile" method="POST">
            <fieldset>
                <fieldset>
                    <legend>Enter Details</legend>
                    <ol>
                        <c:if test="${rank == 0}">
                            <li>
                                <t:forminput name="major" label="Major" type="text" value="${empty param.major ? sessionScope.student.getMajor() : param.major}" placeholder="Enter your major" required="true" maxlength="30" />
                            </li>
                            <li>
                                <t:forminput name="utastudentid" label="UTA Student ID" type="text" value="${empty param.utastudentid ? sessionScope.student.getUtaStudentId() : param.utastudentid}" placeholder="Enter your UTA Student ID" pattern="^\d{10}$" required="true" maxlength="10" />
                            </li>
                        </c:if>
                        <c:if test="${rank == 2 or rank == 3}">
                            <jsp:useBean id="department" class="uta.cse4361.beans.DepartmentBean"/>
                            <c:set var="depts" value="${department.getDepartments()}" />
                            <li>
                                <label for="s_dept">Department</label>
                                <select name="dept" id="s_dept" required>
                                    <c:choose>
                                        <c:when test="${empty sessionScope.advisor}">
                                            <option disabled selected>-- Select a department --</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option disabled>-- Select a department --</option>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:forEach var="dept" items="${depts}">
                                        <c:choose>
                                            <c:when test="${dept.getId() == sessionScope.advisor.getDept()}">
                                                <option value="${dept.getId()}" selected>${dept.getName()}</option>
                                            </c:when>
                                            <c:otherwise>
                                                <option value="${dept.getId()}">${dept.getName()}</option>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </select>
                            </li>
                        </c:if>
                        <li>
                            <t:forminput name="phone" label="Phone number" type="text" pattern="^\d{10}$" value="${sessionScope.user.getPhone()}" placeholder="Enter a 10 digit phone number (optional)" maxlength="10" />
                        </li>
                    </ol>
                    <input type="submit" value="Update Profile" />
                </fieldset>
            </fieldset>
        </form>
        <c:choose>
            <c:when test="${(rank == 0 and empty sessionScope.student) or ((rank == 2 or rank == 3) and empty sessionScope.advisor)}">
                <h1>Complete your Account</h1>
                <p>Please enter the required information in order to complete your registration.</p>
            </c:when>
            <c:otherwise>
                <h1>Edit Profile</h1>
                <p>You can use this form to fill in details about your university profile.</p>
            </c:otherwise>
        </c:choose>
    </jsp:attribute>
</t:layout>
</c:otherwise>
</c:choose>