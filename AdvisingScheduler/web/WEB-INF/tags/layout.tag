<%-- 
    Document   : layout
    Created on : Apr 7, 2015, 3:00:45 PM
    Author     : Michael
--%>

<%@tag description="Page layout" pageEncoding="UTF-8"%>
<%@attribute name="pagetitle" %>
<%@attribute name="script" fragment="true" %>
<!DOCTYPE html>
<html>
    <head>
        <title><%= pagetitle != null ? pagetitle : "UTA Advising" %></title>
        <meta charset='UTF-8'>
        <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1'>
        <jsp:invoke fragment="script"/>
    </head>
    <body>
        <jsp:include page='/WEB-INF/views/navigationbar.jsp' />
        <jsp:include page='/WEB-INF/views/header.jsp' />
        <div id='wrapper'>
            <jsp:doBody/>
        </div>
        <jsp:include page='/WEB-INF/views/footer.jsp' />
        <script type='text/javascript' src='js/index.js'></script>
    </body>
</html>
