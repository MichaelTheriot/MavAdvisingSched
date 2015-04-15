<%-- 
    Document   : CreateAccount
    Created on : Nov 22, 2014, 5:50:01 PM
    Author     : Melissa
--%>

<%@include file="/WEB-INF/tools/sessionimport.jsp"%>
<%
    if(rank != 1) {
        response.sendRedirect("index.jsp");
    }
%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<t:box title="Create Advisor Account">
    <jsp:attribute name="script">
        <script type="text/javascript">
            function validate() {
//                var username = document.forms["create"]["username"].value;
                var email = document.forms["create"]["s_email"].value;
                var atpos = email.indexOf("@");
                var dotpos = email.lastIndexOf(".");
                var mavs = email.indexOf("mavs.uta.edu");
                var password = document.forms["create"]["s_password"].value;
                var passwordConfirm = document.forms["create"]["s_passwordConfirm"].value;
                var name = document.forms["create"]["s_name"].value;

//                if (username === null || username === "") {
//                    $("#username").notify("Please enter your username", "error",
//                            {elementPosition: 'bottom center',
//                                globalPosition: 'bottom center'})
//                    return false;
//                }
                if (email === null || email === "") {
                    $("#s_email").notify("Please enter your email", "error",
                            {elementPosition: 'bottom center',
                                globalPosition: 'bottom center'})
                    return false;
                }
                if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= email.length || mavs < 0) {
                    $("#s_email").notify("Please enter a valid mavs email", "error",
                            {elementPosition: 'bottom center',
                                globalPosition: 'bottom center'})
                    return false;
                }
                if (password === null || password === "") {
                    $("#s_password").notify("Please enter your password", "error",
                            {elementPosition: 'bottom center',
                                globalPosition: 'bottom center'})
                    return false;
                }
                if (passwordConfirm === null || passwordConfirm === "") {
                    $("#s_passwordConfirm").notify("Please confirm your password", "error",
                            {elementPosition: 'bottom center',
                                globalPosition: 'bottom center'})
                    return false;
                }
                if (passwordConfirm !== password) {
                    $("#s_passwordConfirm").notify("Your password does not match", "error",
                            {elementPosition: 'bottom center',
                                globalPosition: 'bottom center'})
                    return false;
                }
                if (name === null || name === "") {
                    $("#s_name").notify("Please enter your name", "error",
                            {elementPosition: 'bottom center',
                                globalPosition: 'bottom center'})
                    return false;
                }

            }
        </script>
    </jsp:attribute>
    <jsp:body>
        <form role="form" id="create" onSubmit="return validate();" action="AccountConfirmation.jsp" method="POST">
            <t:forminput name="email" label="Email"/>
            <t:forminput name="password" label="Password" type="password"/>
            <t:forminput name="passwordConfirm" label="Confirm Password" type="password"/>
            <t:forminput name="name" label="Name"/>
            <div class="form-group">
                <label for="dept">Department</label>
                    <select name="dept" id="dept" class="form-control" >
                    <option value="Computer Science">Computer Science</option>
                    <option value="Civil Engineering">Civil Engineering</option>
                    <option value="Electrical Engineering">Electrical Engineering</option>
                    <option value="Bioengineering">Bioengineering</option>
                </select>
            </div>
            <div class="centerthis">
                <input type="submit" value="Create Account" id="submitBtn" class="btn btn-default">
                <input type="reset" value="Reset" id="resetBtn" class="btn btn-default">
            </div>
        </form>
    </jsp:body>
</t:box>