<%-- 
    Document   : index
    Created on : Sep 12, 2014, 2:12:40 PM
    Author     : Melissa
--%>

<%@page contentType='text/html' pageEncoding='UTF-8'%>
<%@include file="/WEB-INF/tools/sessionimport.jsp"%>
<%
    String template = "guestFront";
    switch(rank) {
        case 0:
            template = "adminFront";
            break;
        case 1:
            template = "advisorFront";
            break;
    }
%>
<jsp:include page='/WEB-INF/templates/<%= template %>' />