<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<c:catch var="e"><fmt:parseNumber var="id" type="number" integerOnly="true" value="${param.slot}" /></c:catch><c:if test="${e != null}"><c:redirect url="/schedule" /></c:if>
<c:set var="major" value="${(not empty sessionScope.major) ? sessionScope.major : param.major}" />
<c:set var="slot" value="${slotsbean.getSlotById(id)}" />
<c:choose>
    <c:when test="${slot == null}">
        <form class="list panel" action="${pageContext.request.contextPath}/schedule" method="POST">
            <input type="hidden" name="dept" value="${param.dept}" />
            <input type="hidden" name="major" value="${major}" />
            <fieldset>
                <fieldset>
                    <legend>Slot not available</legend>
                    <p>This slot is no longer available.</p>
                    <input type="submit" value="Back" />
                </fieldset>
            </fieldset>
        </form>
    </c:when>
    <c:otherwise>
        <c:set var="major" value="${(not empty sessionScope.major) ? sessionScope.major : param.major}" />
        <form class="list panel" action="${pageContext.request.contextPath}/schedule" method="POST">
            <input type="hidden" name="dept" value="${param.dept}" />
            <input type="hidden" name="major" value="${major}" />
            <input type="hidden" name="slot" value="${id}" />
            <input type="hidden" name="reason" value="${param.reason}" />
            <input type="hidden" name="desc" value="${param.desc}" />
            <input type="hidden" name="confirm" value="true" />
            <fieldset>
                <fieldset>
                    <legend>Review appointment</legend>
                    <ol>
                        <c:if test="${empty sessionScope.studentid}">
                            <li>
                                <t:forminput name="fname" label="First name" type="text" value="${param.fname}" required="true" disabled="true" />
                            </li>
                            <li>
                                <t:forminput name="lname" label="Last name" type="text" value="${param.lname}" required="true" disabled="true" />
                            </li>
                            <li>
                                <t:forminput name="email" label="Email" type="email" value="${param.email}" required="true" disabled="true" />
                            </li>
                            <li>
                                <t:forminput name="phone" label="Phone number" type="text" value="${param.phone}" required="true" disabled="true" />
                            </li>
                        </c:if>
                        <li>
                            <t:forminput name="advisor" label="Advisor" type="text" value="${slot.getAdvisorName()}" disabled="true" />
                        </li>
                        <li>
                            <t:forminput name="time" label="Appointment Time" type="text" value="${slot.getTimestamp(\"EEEE, MMMM d, yyyy 'at' h:mm a\")}" disabled="true" />
                        </li>
                        <li>
                            <t:forminput name="major" label="Major" type="text" value="${major}" disabled="true" />
                        </li>
                        <li>
                            <t:forminput name="slot" label="Reason" type="text" value="${param.reason}" disabled="true" />
                        </li>
                        <li>
                            <label for="s_desc">Additional Information</label>
                            <textarea name="desc" id="s_desc" disabled>${param.desc}</textarea>
                        </li>
                    </ol>
                    <input type="submit" value="Schedule Appointment" />
                </fieldset>
            </fieldset>
        </form>
        <h1>Schedule an Appointment</h1>
        <p>You are about to schedule an appointment. Please review before submitting.</p>
    </c:otherwise>
</c:choose>