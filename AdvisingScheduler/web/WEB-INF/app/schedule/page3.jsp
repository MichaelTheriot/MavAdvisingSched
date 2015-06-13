<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="major" value="${(not empty sessionScope.student) ? sessionScope.student.getMajor() : param.major}" />
<form class="list panel" action="${pageContext.request.contextPath}/schedule" method="POST">
    <input type="hidden" name="dept" value="${param.dept}" />
    <input type="hidden" name="major" value="${major}" />
    <input type="hidden" name="slot" value="${param.slot}" />    
    <fieldset>
        <fieldset>
            <legend>Enter appointment details</legend>
            <ol>
                <c:if test="${empty sessionScope.student}">
                    <li>
                        <t:forminput name="fname" label="First name" type="text" required="true" />
                    </li>
                    <li>
                        <t:forminput name="lname" label="Last name" type="text" required="true" />
                    </li>
                    <li>
                        <t:forminput name="email" label="Email" type="email" required="true" />
                    </li>
                    <li>
                        <t:forminput name="phone" label="Phone number" type="text" required="true" />
                    </li>
                </c:if>
                <li>
                    <t:forminput name="reason" label="Reason" type="text" placeholder="Enter a reason..." value="${param.reason}" required="true" />
                </li>
                <li>
                    <label for="s_desc">Additional Information</label>
                    <textarea name="desc" id="s_desc" placeholder="Enter additional information (optional)..."></textarea>
                </li>
            </ol>
            <input type="submit" value="Next" />
        </fieldset>
    </fieldset>
</form>
<h1>Schedule an Appointment</h1>
<p>Please use the form to the right to schedule an appointment.</p>