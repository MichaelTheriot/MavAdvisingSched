<%@tag description="Basic form input element for radioblock class" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@attribute name="label" required="true" %>
<%@attribute name="name" required="true" %>
<%@attribute name="uid" required="true" %>
<%@attribute name="title" %>
<%@attribute name="value" %>
<%@attribute name="disabled" type="java.lang.Boolean" %>
<c:set var="attr" value="" />
<c:if test="${(not empty title)}"><c:set var="attr" value="${attr} title=\"${title}\"" /></c:if>
<c:if test="${(not empty value)}"><c:set var="attr" value="${attr} value=\"${value}\"" /></c:if>
<c:if test="${(not empty disabled)}"><c:set var="attr" value="${attr} disabled" /></c:if>
<input type="radio" name="${name}" id="s_${uid}"${attr} />
<label for="s_${uid}">${label}</label>