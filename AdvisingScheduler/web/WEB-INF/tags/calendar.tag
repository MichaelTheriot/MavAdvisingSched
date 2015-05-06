<%@tag description="Calendar template" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@attribute name="slots" type="uta.cse4361.businessobjects.Slot[]" %>
<%@attribute name="page" type="java.lang.Integer" %>
<jsp:useBean id="SlotCal" class="uta.cse4361.businessobjects.SlotCalendar"/>
<jsp:useBean id="date" class="java.util.Date"/>
<c:set var="page" value="${(not empty page) ? (page < 0 ? 0 : page) : 0}" />
<c:set var="slotMonth" value="${SlotCal.getRelativeMonthBySlot(slots, page)}" />
${date.setTime(slotMonth.getTime())}
    <table class="calendar">
        <caption><c:if test="${page > 0}"><button class="previousbutton" name="page" value="${page - 1}" type="submit">Previous month</button></c:if><fmt:formatDate value="${date}" pattern="MMMM yyyy" /><button class="nextbutton" name="page" value="${page + 1}" type="submit">Next month</button></caption>
        <tbody>
            <tr>
                <th>Sunday</th>
                <th>Monday</th>
                <th>Tuesday</th>
                <th>Wednesday</th>
                <th>Thursday</th>
                <th>Friday</th>
                <th>Saturday</th>
            </tr>
            <c:forEach var="i" begin="0" end="41">
                <c:if test="${i % 7 == 0}">
                    <tr class="min">
                        <c:forEach var="j" begin="0" end="6">
                            <c:choose>
                                <c:when test="${slotMonth.getCalendarDateInMonth(i + j) == false}">
                                    <td class="non">${slotMonth.getCalendarDate(i + j)}</td>
                                </c:when>
                                <c:otherwise>
                                    <td>${slotMonth.getCalendarDate(i + j)}</td>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </tr>
                    <tr>
                        <c:forEach var="j" begin="0" end="6">
                            <c:choose>
                                <c:when test="${slotMonth.getCalendarDateInMonth(i + j) == false}">
                                    <td class="non"></td>
                                </c:when>
                                <c:otherwise>
                                    <c:set var="dateSlots" value="${slotMonth.getSlotsOnDate(slotMonth.getCalendarDate(i + j))}" />
                                    <td>
                                        <c:if test="${fn:length(dateSlots) > 0}">
                                            <c:forEach var="k" begin="0" end="${fn:length(dateSlots) - 1}">
                                                <c:choose>
                                                    <c:when test="${dateSlots[k].getAvailable() == true}">
                                                        <t:radioblock label="<span class=\"heading\">${dateSlots[k].getTimestamp('hh:mm a')}</span> <span class=\"chk\">${dateSlots[k].getAdvisorName()}</span>" name="slot" uid="${dateSlots[k].getId()}" value="${dateSlots[k].getId()}" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <t:radioblock label="<span class=\"heading\">${dateSlots[k].getTimestamp('hh:mm a')}</span> <span class=\"chk\">${dateSlots[k].getAdvisorName()}</span>" name="slot" uid="${dateSlots[k].getId()}" value="${dateSlots[k].getId()}" title="This slot has been reserved" disabled="true" />
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </c:if>
                                    </td>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </tr>
                </c:if>
            </c:forEach>
        </tbody>
    </table>