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