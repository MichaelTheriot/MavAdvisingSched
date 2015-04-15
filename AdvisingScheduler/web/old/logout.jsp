<%-- 
    Document   : logout.jsp
    Created on : Nov 30, 2014, 4:54:23 PM
    Author     : Melissa
--%>

<%
    request.getSession().invalidate();
    response.sendRedirect("index.jsp");
%>