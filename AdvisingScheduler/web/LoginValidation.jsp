<%-- 
    Document   : LoginValidation
    Created on : Nov 22, 2014, 10:39:39 PM
    Author     : Melissa
--%>

<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<jsp:useBean id="login" class="uta.cse4361.beans.LogInBean"/> 
<jsp:setProperty name="login" property="email" value='<%=request.getParameter("username")%>' />
<jsp:setProperty name="login" property="password" value='<%=request.getParameter("password")%>' />
<%
    String result = login.LogIn();
    if(result.equals("Invalid login")) {
        result = "Wrong username or password.";
    } else {
        session.setAttribute("email", login.getEmail());
        session.setAttribute("confirmation", login.getPassword());
        session.setAttribute("id", result.substring(0, result.length()-1));
        session.setAttribute("rank", result.substring(result.length()-1));
        response.sendRedirect("index.jsp");
        result = "You have successfully logged in.";
    }
    request.setAttribute("result", result);
%>
<t:response title="Login Validation" redirect="index.jsp">
  ${result}
</t:response>