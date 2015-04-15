<%@page import="uta.cse4361.businessobjects.Account"%>
<%@include file="/WEB-INF/tools/sessionimport.jsp"%>
<jsp:useBean id="login" class="uta.cse4361.beans.LoginBean"/> 
<jsp:setProperty name="login" property="email" value='<%=request.getParameter("email")%>' />
<jsp:setProperty name="login" property="password" value='<%=request.getParameter("password")%>' />
<%
    if(rank == -1) {
        Account user = login.getUser();
        if(user != null) {
            session.setAttribute("id", user.getId());
            session.setAttribute("email", user.getEmail());
            session.setAttribute("fname", user.getFname());
            session.setAttribute("lname", user.getLname());
            session.setAttribute("phone", user.getPhone());
            session.setAttribute("rank", user.getRank());
        }
    }

    response.sendRedirect("/");
%>
