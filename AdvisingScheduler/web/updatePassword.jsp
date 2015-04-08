<%--
    Document   : Appointment
    Created on : Apr 7, 2015, 2:08:32 AM
    Author     : Michael Theriot
--%>

<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<t:box title="Update Password">
    <form role="form" name="update" action="UpdatePasswordSubmit.jsp" method="POST">
        <t:forminput name="oldPassword" label="Current Password"/>
        <t:forminput name="newPassword" label="New Password"/>
        <input type="submit" value="Update" id="submitBtn" class="btn btn-default" class="btn btn-default">
    </form>
</t:box>