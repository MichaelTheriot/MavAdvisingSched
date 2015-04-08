<%-- 
    Document   : AccountConfirmation
    Created on : Nov 22, 2014, 8:54:58 PM
    Author     : Melissa
--%>

<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<jsp:useBean id="newadvisor" class="uta.cse4361.beans.CreateAdvisorAccountBean"/> 
<jsp:setProperty name="newadvisor" property="email" value='<%=request.getParameter("email")%>' />
<jsp:setProperty name="newadvisor" property="tempPassword" value='<%=request.getParameter("password")%>' />
<jsp:setProperty name="newadvisor" property="department" value='<%=request.getParameter("dept")%>' />
<jsp:setProperty name="newadvisor" property="name" value='<%=request.getParameter("name")%>' />
<%
    String result = newadvisor.Advisor();
    if(result == "") {
        result = newadvisor.getName() +"'s has been Account created";
    } else {
        result = "Account could not be created.";
    }
    request.setAttribute("result", result);
%>
<t:response title="Account Confirmation" redirect="index.jsp">
  ${result}
</t:response>