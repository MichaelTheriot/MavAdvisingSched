<%@tag description="Page redirect" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@attribute name="pagetitle" %>
<%@attribute name="url" required="true" %>
<%
    if(pagetitle == null) {
        pagetitle = "Redirect";
    }
%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title><%= pagetitle %></title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/normalize.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/calendar.css" />
    <link rel="shortcut icon" href="https://www.uta.edu/favicon.ico" type="image/x-icon">
    <script>
        setTimeout(function() {
            window.location.href = '<%= url %>';
        }, 5000);
    </script>
  </head>
  <body>
     <div id="alert">
        <div>
          <p><jsp:doBody/></p>
          <p>You will be redirected in 5 seconds, or <a href="<%= url %>">click here</a> if you do not wish to wait.</p>
        </div>
     </div>
  </body>
</html>
