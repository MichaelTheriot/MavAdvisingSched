<%-- 
    Document   : AccountConfirmation
    Created on : Nov 22, 2014, 8:54:58 PM
    Author     : Melissa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:useBean id="newadvisor" class="uta.cse4361.beans.CreateAdvisorAccountBean"/> 
        <jsp:setProperty name="newadvisor" property="email" value="<%=request.getParameter("email")%>" />
        <jsp:setProperty name="newadvisor" property="tempPassword" value="<%=request.getParameter("password")%>" />
        <jsp:setProperty name="newadvisor" property="department" value="<%=request.getParameter("dept")%>" />
        <jsp:setProperty name="newadvisor" property="name" value="<%=request.getParameter("name")%>" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Account Confirmation</title>
    </head>
    <body>
        <jsp:include page="navigationbar.jsp" />
        <div id="wrapper">
            <jsp:include page="header.jsp" />
            <div id="accordion">
                <h3>Account Confirmation</h3>
                <%
                    String result = newadvisor.Advisor();
                    out.print(request.getParameter("email")+"<br>");
                    out.print(request.getParameter("password")+"<br>");
                    out.print(request.getParameter("dept")+"<br><br>");
                    out.print(request.getParameter("name")+"<br><br>");
                    if (result == "") {
                        out.print("Account created");
                    } 
                    else {
                        newadvisor.getEmail();
//                        out.print(result);
                    }
                %>
            </div>
        </div>

    </body>
    <jsp:include page="footer.jsp" />
    <script type="text/javascript" src="js/AccountConfirmation.js"></script>
</html>