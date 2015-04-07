<%-- 
    Document   : AccountConfirmation
    Created on : Apr 7, 2015, 2:09:48 AM
    Author     : Michael Theriot
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:useBean id="updatepassword" class="uta.cse4361.beans.UpdateBean"/> 
        <jsp:setProperty name="updatepassword" property="email" value='<%=session.getAttribute("email")%>' />
        <jsp:setProperty name="updatepassword" property="oldPassword" value='<%=request.getParameter("oldPassword")%>' />
        <jsp:setProperty name="updatepassword" property="newPassword" value='<%=request.getParameter("newPassword")%>' />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Account Confirmation</title>
    </head>
    <body>
        <jsp:include page="navigationbar.jsp" />
        <div id="wrapper">
            <jsp:include page="header.jsp" />
            <div id="accordion">
                <h3>Update Password</h3>
                <div>
                <%
                    String result = updatepassword.Update();
                    out.print(result);
                %>
                </div>
            </div>
        </div>

    </body>
    <jsp:include page="footer.jsp" />
    <script type="text/javascript" src="js/AccountConfirmation.js"></script>
</html>
