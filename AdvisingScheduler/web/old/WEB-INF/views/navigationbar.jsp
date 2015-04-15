<%@include file="/WEB-INF/tools/sessionimport.jsp"%>
<div id="navbar">
    <ul class="navigation">
        <li class="home">
            <a href="index.jsp">Home</a>
        </li>
    <%
        switch(rank) {
            case -1:
                out.print("<li class='schedule'>\n"
                        + "    <a href='schedule.jsp'>Schedule Appointment</a>\n"
                        + "</li>\n");
                break;
            case 1:
                out.print("<li class='account'>\n"
                        + "    <a href='CreateAccount.jsp'>Create Account</a>\n"
                        + "</li>\n");
                break;
            case 0:
                out.print("<li class='calendar'>\n"
                        + "    <a href='AdvisorCalendar.jsp'>Calendar</a>\n"
                        + "</li>\n");
                out.print("<li class='timeslot'>\n"
                        + "    <a href='modifyTimeslot.jsp'>Time slot</a>\n"
                        + "</li>\n");
                out.print("<li class='appointment'>\n"
                        + "    <a href='modifyAppointment.jsp'>Appointment</a>\n"
                        + "</li>\n");
                break;
        }
        if(rank != -1) {
                out.print("<li class='update-password'>\n"
                        + "    <a href='updatePassword.jsp'>Update Password</a>\n"
                        + "</li>\n"
                        + "<li class='logout'>\n"
                        + "    <a href='logout.jsp'>Log Out</a>\n"
                        + "</li>\n");
        }
    %>                
    </ul>
</div>
