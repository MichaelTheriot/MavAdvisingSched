<%-- 
    Document   : AccountConfirmation
    Created on : Apr 7, 2015, 2:09:48 AM
    Author     : Michael Theriot
--%>

<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<jsp:useBean id="updatepassword" class="uta.cse4361.beans.UpdateBean"/> 
<jsp:setProperty name="updatepassword" property="email" value='<%=session.getAttribute("email")%>' />
<jsp:setProperty name="updatepassword" property="oldPassword" value='<%=request.getParameter("oldPassword")%>' />
<jsp:setProperty name="updatepassword" property="newPassword" value='<%=request.getParameter("newPassword")%>' />
<%
    String result = updatepassword.Update();
    request.setAttribute("result", result);
%>
<t:response title="Update Password" redirect="index.jsp">
  ${result}
</t:response>