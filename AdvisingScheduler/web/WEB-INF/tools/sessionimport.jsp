<%
  int rank = -1;
  if(!(session.getAttribute("rank") == null)) {
    rank = Integer.parseInt((String) session.getAttribute("rank").toString());
  }
%>