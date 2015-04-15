<%-- 
    Document   : box
    Created on : Apr 7, 2015, 9:41:54 PM
    Author     : Michael
--%>

<%@tag description="Response Page template" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@attribute name="title" required="true" %>
<%@attribute name="script" fragment="true" %>
<t:layout pagetitle="${title}">
    <jsp:attribute name="script"><jsp:invoke fragment="script"/></jsp:attribute>
    <jsp:body>
        <div id="accordion">
            <h3>${title}</h3>
            <jsp:doBody/>
        </div>
    </jsp:body>
</t:layout>