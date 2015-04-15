<%@tag description="Page template" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@attribute name="rank" required="true" type="java.lang.Integer"%>
<%@attribute name="pagetitle" %>
<%
    if(pagetitle == null) {
        pagetitle = "UTA Advising";
    }
%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title><%= pagetitle %></title>
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/3.0.3/normalize.css" />
    <link rel="stylesheet" type="text/css" href="css/main.css" />
    <link rel="stylesheet" type="text/css" href="css/calendar.css" />
  </head>
  <body>
    <t:header pagetitle="<%= pagetitle %>" rank="<%= rank %>" />
    <main>
      <div id="content">
        <jsp:doBody/>
      </div>
    </main>
    <t:footer />
  </body>
</html>
