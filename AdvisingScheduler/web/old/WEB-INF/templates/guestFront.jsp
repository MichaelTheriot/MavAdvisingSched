<%-- 
    Document   : guestFront
    Created on : Apr 7, 2015, 6:57:41 PM
    Author     : Michael
--%>

<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<t:layout>
    <jsp:attribute name="script">
        <script type='text/javascript' src='js/index.js'></script>
    </jsp:attribute>
    <jsp:body>
        <table class="centerthis" style='margin: 0 auto;'>
            <tr>
                <td style='width: 640px'>
                    <div id='leftAccordion'>
                        <a href="index.jsp"><img class="centerthis" src="css/images/horse-lord.png"></a>
                        <h3>Faculty</h3>
                        <p>Would you like to check on your current schedule?</p>
                        <input type='submit' value='Login to your account' id='loginBtn' class='btn btn-default'/>
                    </div>
                </td>
                <td style='width: 640px'>
                    <div id='rightAccordion'>
                        <a href='index.jsp'><img class='centerthis' src='css/images/utA.png'></a>
                        <h3>Student</h3>
                        <p>Would you like to schedule an appointment with an advisor?</p>
                        <form action='schedule.jsp'>
                            <input type='submit' value='Make an appointment' id='scheduleBtn' class='btn btn-default'/>
                        </form>
                    </div>
                </td>
            </tr>
        </table>
    </jsp:body>
</t:layout>