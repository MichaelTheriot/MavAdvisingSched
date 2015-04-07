<%--
    Document   : Appointment
    Created on : Apr 7, 2015, 2:08:32 AM
    Author     : Michael Theriot
--%>

<%@page import="uta.cse4361.databases.DatabaseManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="//code.jquery.com/jquery-1.10.2.js"></script>
        <script src="//code.jquery.com/ui/1.11.1/jquery-ui.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Password</title>
    </head>
    <body>
    <tr>
        <jsp:include page="navigationbar.jsp" />
    <div id="wrapper">
        <jsp:include page="header.jsp" />
        <div id="accordion" class="centerthis">
            <h3>Update Password</h3>
            <div class="centerthis">
                <form role="form" name="update" action="UpdatePasswordSubmit.jsp" method="POST">
                    <div class="form-group">
                    </div>
                    <div class="form-group">
                        <label for="sID">Old Password</label>
                        <input type="password" name="oldPassword" id="sOldPassword" value="" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="sName">New Password</label>
                        <input type="password" name="newPassword" id="sNewPassword" value="" class="form-control">
                    </div>
                    <input type="submit" value="Update" id="submitBtn" class="btn btn-default" class="btn btn-default">
                </form>
            </div>
        </div>
    </div>
    <br>
</body>
<jsp:include page="footer.jsp" />
<script type="text/javascript" src="js/schedule.js"></script>
</html>
