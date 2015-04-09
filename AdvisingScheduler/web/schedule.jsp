<%--
    Document   : Appointment
    Created on : Sep 19, 2014, 12:43:15 PM
    Author     : Han
--%>

<%@include file="/WEB-INF/tools/sessionimport.jsp"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="uta.cse4361.databases.DatabaseManager"%>
<%@page import="uta.cse4361.businessobjects.Slot"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%
    DatabaseManager dm = new DatabaseManager();
//    ArrayList<Date> availableDates = dm.getDatesForAvailability();
    ArrayList<Slot> availableDates = dm.getAvailableSlots();
    ArrayList<String> availables = new ArrayList<String>();
    for (Slot s : availableDates) {
       int dd = s.getDate().getDate();
       int mm = s.getDate().getMonth() + 1;
       int yy = s.getDate().getYear() + 1900;
       String newRecord = "" + dd + "-" + mm + "-" + yy;
       availables.add(newRecord);
    }
    StringBuilder sb = new StringBuilder();
    for (int i = 0; i < availables.size(); i++) {
        sb.append(availables.get(i) + ",");
    }
    request.setAttribute("temp", sb.toString());
    request.setAttribute("availablesSize", availables.size());
%>
<t:box title="Schedule Appointment">
    <jsp:attribute name="script">
        <script type="text/javascript">
            window.addEventListener('load', function(event) {
                temp = "${temp}";
                var availableDates = new Array();
                availableDates = temp.split(',', '${availablesSize}');
                
                //alert("array: " + availableDates);
                function available(date) {
                    dmy = date.getDate() + "-" + (date.getMonth() + 1) + "-" + date.getFullYear();
                    if ($.inArray(dmy, availableDates) !== -1) {
                        return [true, "", "Available"];
                    } else {
                        return [false, "", "unAvailable"];
                    }
                }
                $(function () {
                    $('#date').datepicker({beforeShowDay: available});
                })
            });
        </script>
        <script type="text/javascript">

            function isNumberKey(evt)
            {
                var e = evt || window.event; //window.event is safer, thanks @ThiefMaster
                var charCode = e.which || e.keyCode;
                if (charCode > 31 && (charCode < 47 || charCode > 57))
                    return false;
                if (e.shiftKey)
                    return false;
                return true;
            }
            function validate() {
                var sID = document.forms["schedule"]["s_ID"].value;
                var sName = document.forms["schedule"]["s_name"].value;
                var email = document.forms["schedule"]["s_email"].value;
                var atpos = email.indexOf("@");
                var dotpos = email.lastIndexOf(".");
                var ddate = document.forms["schedule"]["s_date"].value;
                var dp = document.forms["schedule"]["s_description"].value;
                if (email === null || email === "") {
                    $("#s_email").notify("Please enter your email", "error",
                            {elementPosition: 'bottom center',
                                globalPosition: 'bottom center'})
                    document.forms["schedule"]["s_email"].focus();
                    return false;
                }
                if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= email.length) {
                    $("#s_email").notify("Please enter a valid email", "error",
                            {elementPosition: 'bottom center',
                                globalPosition: 'bottom center'})
                    document.forms["schedule"]["s_email"].focus();
                    return false;
                }
                if (sID === null || sID === "") {
                    $("#s_ID").notify("Please enter your student ID", "error",
                            {elementPosition: 'bottom center',
                                globalPosition: 'bottom center'})
                    document.forms["schedule"]["s_ID"].focus();
                    return false;
                }
                if (isNaN(sID)) {
                    $("#s_ID").notify("Your student ID must be a number", "error",
                            {elementPosition: 'bottom center',
                                globalPosition: 'bottom center'})
                    document.forms["schedule"]["s_ID"].focus();
                    return false;
                }
                if (sID.length !== 10) {
                    $("#s_ID").notify("Your student ID must be a 10-digit number", "error",
                            {elementPosition: 'bottom center',
                                globalPosition: 'bottom center'})
                    document.forms["schedule"]["s_ID"].focus();
                    return false;
                }
                if (sID.indexOf("1000") === -1 && sID.indexOf("6000") === -1) {
                    $("#s_ID").notify("Your student ID should begin with 1000 or 6000", "error",
                            {elementPosition: 'bottom center',
                                globalPosition: 'bottom center'})
                    document.forms["schedule"]["s_ID"].focus();
                    return false;
                }
                if (sName === null || sName === "") {
                    $("#s_name").notify("Please enter your name", "error",
                            {elementPosition: 'bottom center',
                                globalPosition: 'bottom center'})
                    document.forms["schedule"]["s_name"].focus();
                    return false;
                }
                if (ddate === null || ddate === "") {
                    $("#s_date").notify("Please select your appointment date", "error",
                            {elementPosition: 'right middle',
                                globalPosition: 'right middle'})
//                    document.forms["schedule"]["date"].focus();
                    return false;
                }
                if (dp === null || dp === "") {
                    $("#s_description").notify("Please enter a proper description", "error",
                            {elementPosition: 'bottom center',
                                globalPosition: 'bottom center'})
                    document.forms["schedule"]["s_description"].focus();
                    return false;
                }
            }
        </script>
        <script type="text/javascript" src="js/schedule.js"></script>
    </jsp:attribute>
    <jsp:body>
        <form role="form" id="schedule" name="schedule" action="StudentCalendar.jsp" onSubmit="return validate();" >
            <t:forminput name="email" label="Email"/>
            <div class="form-group">
                <label for="sID">Student ID</label>
                <input type="text" onkeypress="return isNumberKey(event)" name="sID" id="s_ID" value="" class="form-control">
            </div>
            <t:forminput name="name" label="Name"/>
            <div class="form-group">
                <label for="major">Major</label>
                <select name="major" id="major" class="form-control" >
                    <option value="CSE">CSE</option>
                    <option value="SE">SE</option>
                    <option value="CPE">CPE</option>
                    <option value="Undecided">Undecided</option>
                </select>
            </div>
            <div class="form-group">
                <label for="aName">Advisor</label>
                <select name="aName" id="aName" class="form-control" >
                    <option value="Linda Barasch">Linda Barasch</option>
                    <option value="Bob Weems">Bob Weems</option>
                    <option value="Eric Becker">Eric Becker</option>
                    <option value="Ramez Elmasri">Ramez Elmasri</option>
                    <option value="Bahram Khalili">Bahram Khalili</option>
                </select>
            </div>
            <div class="form-group">
                <label for="type">Advising Type</label>
                <select name="type" id="type" class="form-control">
                    <option value="New Student">New Student</option>
                    <option value="Returning Student">Returning Student</option>
                    <option value="Drop Course">Drop Course</option>
                    <option value="Enroll">Enroll</option>
                    <option value="Others">Others</option>
                </select>
            </div>
            <div class="form-group">
                <label for="date">Date</label>
                <input type="text" name="date" id="s_date" readonly="true" class="form-control">
            </div>
            <div class="form-group">
                <label for="description">Description</label>
                <textarea name="description" id="s_description"  value="" class="form-control"></textarea>
            </div>
            <input type="submit" value="Submit" id="submitBtn" class="btn btn-default">
            <input type="reset" value="Reset" id="resetBtn" class="btn btn-default">
        </form>
    </jsp:body>
</t:box>
