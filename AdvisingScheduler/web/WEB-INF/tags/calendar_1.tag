<%@tag description="Calendar template" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@attribute name="slots" type="uta.cse4361.businessobjects.Slot[]" %>
<%@attribute name="page" type="java.lang.Integer" %>
<jsp:useBean id="date" class="java.util.Date"/>
<c:if test="${fn:length(slots) > 0}">
    <c:set var="safepage" value="0" />
    <c:set target="${date}" property="time" value="${slots[0].getTime()}" />
    <c:set var="maxpage" value="${fn:length(slots) - 1}" />
    <fmt:formatDate var="last_moy" value="${date}" pattern="yyyy-MM" />
    <c:if test="${page > 0}">
        <c:forEach var="i" begin="0" end="${maxpage}">
            <c:set target="${date}" property="time" value="${slots[i].getTime()}" />
            <fmt:formatDate var="cur_moy" value="${date}" pattern="yyyy-MM" />
            <c:if test="${cur_moy != last_moy}">
                <c:set var="last_moy" value="${cur_moy}" />
                <c:set var="safepage" value="${safepage + 1}" />
                <c:if test="${maxpage >= safepage}">
                    <c:set var="maxpage" value="${safepage}" />
                </c:if>
            </c:if>
        </c:forEach>
    </c:if>
    <c:if test="${page < 0}">
        <c:set var="page" value="0" />
    </c:if>
    <c:if test="${page > safepage}">
        <c:set var="page" value="${safepage}" />
    </c:if>
    <table class="calendar">
        <caption><fmt:formatDate value="${date}" pattern="MMMM yyyy" /></caption>
        <tbody>
            <tr>
                <th>Sun</th>
                <th>Mon</th>
                <th>Tue</th>
                <th>Wed</th>
                <th>Thu</th>
                <th>Fri</th>
                <th>Sat</th>
            </tr>
        </tbody>
    </table>
</c:if>