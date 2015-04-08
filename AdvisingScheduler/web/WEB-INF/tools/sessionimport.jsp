<%-- 
    Document   : sessionimport
    Created on : Apr 7, 2015, 4:36:53 PM
    Author     : Michael
--%>

<%
  int rank = -1;
  int sessionid = -1;
  if(!(session.getAttribute("id") == null)) {
    sessionid = Integer.parseInt((String) session.getAttribute("id"));
  }
  if(!(session.getAttribute("rank") == null)) {
    rank = Integer.parseInt((String) session.getAttribute("rank"));
  }
%>