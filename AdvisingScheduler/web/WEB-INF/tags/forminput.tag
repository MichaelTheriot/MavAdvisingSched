<%@tag description="Basic form input element" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@attribute name="label" required="true" %>
<%@attribute name="name" required="true" %>
<%@attribute name="type" %>
<%@attribute name="value" %>
<%@attribute name="placeholder" %>
<%@attribute name="title" %>
<%@attribute name="pattern" %>
<%@attribute name="maxlength" %>
<%@attribute name="required" type="java.lang.Boolean" %>
<%@attribute name="disabled" type="java.lang.Boolean" %>
<c:set var="attr" value="" />
<c:if test="${(not empty title)}"><c:set var="attr" value="${attr} title=\"${title}\"" /></c:if>
<c:if test="${(not empty value)}"><c:set var="attr" value="${attr} value=\"${value}\"" /></c:if>
<c:if test="${(not empty placeholder)}"><c:set var="attr" value="${attr} placeholder=\"${placeholder}\"" /></c:if>
<c:if test="${(not empty pattern)}"><c:set var="attr" value="${attr} pattern=\"${pattern}\"" /></c:if>
<c:if test="${(not empty maxlength)}"><c:set var="attr" value="${attr} maxlength=\"${maxlength}\"" /></c:if>
<c:if test="${(not empty disabled)}"><c:set var="attr" value="${attr} disabled" /></c:if>
<c:if test="${(not empty required)}"><c:set var="attr" value="${attr} required" /></c:if>
<label for="s_${name}">${label}</label>
<input type="${(not empty type) ? type : "text"}" id="s_${name}" name="${name}"${attr} />