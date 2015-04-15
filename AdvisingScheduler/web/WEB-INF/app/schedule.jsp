<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/tools/sessionimport.jsp"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%
    if(rank > 0) {
        response.sendRedirect("/");
    }
    String  dept = request.getParameter("dept"),
           major = request.getParameter("major"),
           month = request.getParameter("month"),
            date = request.getParameter("date"),
            slot = request.getParameter("slot"),
          reason = request.getParameter("reason"),
            desc = request.getParameter("desc");

    request.setAttribute("dept", dept);
    request.setAttribute("major", major);
    request.setAttribute("month", month);
    request.setAttribute("date", date);
    request.setAttribute("slot", slot);
    request.setAttribute("reason", reason);
    request.setAttribute("desc", desc);
%>
<% if(dept == null || major == null) { %>
<t:layout pagetitle="Schedule an Appointment" rank="<%= rank %>">
    <jsp:body>
        <form class="list panel" action="/schedule" method="POST">
            <fieldset>
                <fieldset>
                    <legend>Enter basic information</legend>
                    <ol>
                        <li>
                            <label for="s_dept">Department</label>
                            <select name="dept" id="s_dept" required>
                                <option disabled selected>-- Select a department --</option>
                                <option value="cse">Computer Science and Engineering</option>
                            </select>
                        </li>
                        <li>
                            <t:forminput name="major" label="Major" type="text" placeholder="Enter your major" required="true" />
                        </li>
                        <input type="submit" value="Next" />
                    </ol>
                </fieldset>
            </fieldset>
        </form>
        <h1>Schedule an Appointment</h1>
        <p>Please use the form to the right to schedule an appointment.</p>
    </jsp:body>
</t:layout>
<% } else if(dept == null || major == null) { %>
<t:layout pagetitle="Schedule an Appointment" rank="<%= rank %>">
    <jsp:body>
        <form class="list panel" action="/schedule" method="POST">
            <fieldset>
                <fieldset>
                    <legend>Enter basic information</legend>
                    <ol>
                        <li>
                            <label for="s_dept">Department</label>
                            <select name="dept" id="s_dept" required>
                                <option disabled selected>-- Select a department --</option>
                                <option value="cse">Computer Science and Engineering</option>
                            </select>
                        </li>
                        <li>
                            <t:forminput name="major" label="Major" type="text" placeholder="Enter your major" required="true" />
                        </li>
                        <li>
                            <input type="submit" value="Next" />
                        </li>
                    </ol>
                </fieldset>
            </fieldset>
        </form>
        <h1>Schedule an Appointment</h1>
        <p>Please use the form to the right to schedule an appointment.</p>
    </jsp:body>
</t:layout>
<% } else if(month == null) { %>
<t:layout pagetitle="Schedule an Appointment" rank="<%= rank %>">
    <jsp:body>
        <form class="list panel" action="/schedule" method="POST">
            <input type="hidden" name="dept" value="${dept}" />
            <input type="hidden" name="major" value="${major}" />
            <fieldset>
                <fieldset class="radioblocks">
                    <legend>Select a month</legend>
                    <table>
                      <caption>2015</caption>
                      <tbody>
                        <tr>
                          <td><input type="radio" name="month" id="s_jan" /><label for="s_jan">Jan</label></td>
                          <td><input type="radio" name="month" id="s_feb" /><label for="s_feb">Feb</label></td>
                          <td><input type="radio" name="month" id="s_mar" /><label for="s_mar">Mar</label></td>
                        </tr>
                        <tr>
                          <td><input type="radio" name="month" id="s_apr" /><label for="s_apr">Apr</label></td>
                          <td><input type="radio" name="month" id="s_may" /><label for="s_may">May</label></td>
                          <td><input type="radio" name="month" id="s_jun" /><label for="s_jun">Jun</label></td>
                        </tr>
                        <tr>
                          <td><input type="radio" name="month" id="s_jul" /><label for="s_jul">Jul</label></td>
                          <td><input type="radio" name="month" id="s_aug" /><label for="s_aug">Aug</label></td>
                          <td><input type="radio" name="month" id="s_sep" /><label for="s_sep">Sep</label></td>
                        </tr>
                        <tr>
                          <td><input type="radio" name="month" id="s_oct" /><label for="s_oct">Oct</label></td>
                          <td><input type="radio" name="month" id="s_nov" /><label for="s_nov">Nov</label></td>
                          <td><input type="radio" name="month" id="s_dec" /><label for="s_dec">Dec</label></td>
                        </tr>
                      </tbody>
                    </table>
                    <input type="submit" value="Next" />
                </fieldset>
            </fieldset>
        </form>
        <h1>Schedule an Appointment</h1>
        <p>Please use the form to the right to schedule an appointment.</p>
    </jsp:body>
</t:layout>
<% } else if(date == null) { %>
<t:layout pagetitle="Schedule an Appointment" rank="<%= rank %>">
    <jsp:body>
        <form class="list panel" action="/schedule" method="POST">
            <input type="hidden" name="dept" value="${dept}" />
            <input type="hidden" name="major" value="${major}" />
            <input type="hidden" name="month" value="${month}" />
            <fieldset>
                <fieldset class="radioblocks">
            <legend>Select a date</legend>
            <table>
              <caption>January</caption>
              <tbody>
                <tr>
                  <th>Sun</th>
                  <th>Mon</th>
                  <th>Tue</th>
                  <th>Wed</th>
                  <th>Thu</th>
                  <th>Fri</th>
                  <th>Sat</th>
                </tr>
                <tr>
                  <td>1</td>
                  <td>2</td>
                  <td>3</td>
                  <td>4</td>
                  <td>5</td>
                  <td>6</td>
                  <td>7</td>
                </tr>
                <tr>
                  <td>8</td>
                  <td>9</td>
                  <td>10</td>
                  <td><input type="radio" name="date" id="s_date11"><label for="s_date11">11</label></td>
                  <td><input type="radio" name="date" id="s_date12"><label for="s_date12">12</label></td>
                  <td><input type="radio" name="date" id="s_date13"><label for="s_date13">13</label></td>
                  <td><input type="radio" name="date" id="s_date14"><label for="s_date14">14</label></td>
                </tr>
                <tr>
                  <td><input type="radio" name="date" id="s_date15"><label for="s_date15">15</label></td>
                  <td><input type="radio" name="date" id="s_date16"><label for="s_date16">16</label></td>
                  <td><input type="radio" name="date" id="s_date17"><label for="s_date17">17</label></td>
                  <td><input type="radio" name="date" id="s_date18"><label for="s_date18">18</label></td>
                  <td><input type="radio" name="date" id="s_date19"><label for="s_date19">19</label></td>
                  <td><input type="radio" name="date" id="s_date20"><label for="s_date20">20</label></td>
                  <td><input type="radio" name="date" id="s_date21"><label for="s_date21">21</label></td>
                </tr>
                <tr>
                  <td><input type="radio" name="date" id="s_date22"><label for="s_date22">22</label></td>
                  <td><input type="radio" name="date" id="s_date23"><label for="s_date23">23</label></td>
                                <td><input type="radio" name="date" id="s_date24"><label for="s_date24">24</label></td>
                                <td><input type="radio" name="date" id="s_date25"><label for="s_date25">25</label></td>
                                <td><input type="radio" name="date" id="s_date26"><label for="s_date26">26</label></td>
                                <td><input type="radio" name="date" id="s_date27"><label for="s_date27">27</label></td>
                                <td><input type="radio" name="date" id="s_date28"><label for="s_date28">28</label></td>
                            </tr>
                            <tr>
                                <td><input type="radio" name="date" id="s_date29"><label for="s_date29">29</label></td>
                                <td><input type="radio" name="date" id="s_date30"><label for="s_date30">30</label></td>
                                <td><input type="radio" name="date" id="s_date31"><label for="s_date31">31</label></td>
                                <td colspan="4"></td>
                            </tr>
                        </tbody>
                    </table>
                    <input type="submit" value="Next" />
                </fieldset>
            </fieldset>
        </form>
        <h1>Schedule an Appointment</h1>
        <p>Please use the form to the right to schedule an appointment.</p>
    </jsp:body>
</t:layout>
<% } else if(slot == null) { %>
<t:layout pagetitle="Schedule an Appointment" rank="<%= rank %>">
    <jsp:body>
        <form class="list panel" action="/schedule" method="POST">
            <input type="hidden" name="dept" value="${dept}" />
            <input type="hidden" name="major" value="${major}" />
            <input type="hidden" name="month" value="${month}" />
            <input type="hidden" name="date" value="${date}" />
            <fieldset>
                <fieldset class="radioblocks">
            <legend>Select a time slot</legend>
            <table>
              <caption>Time slots</caption>
              <tbody>
                <tr>
                  <td><input type="radio" name="slot" id="s_0000"><label for="s_0000">12:00 AM</label></td>
                </tr>
                <tr>
                  <td><input type="radio" name="slot" id="s_0030"><label for="s_0030">12:30 AM</label></td>
                </tr>
                <tr>
                  <td><input type="radio" name="slot" id="s_0100"><label for="s_0100">01:00 AM</label></td>
                </tr>
              </tbody>
            </table>
            <input type="submit" value="Next" />
                </fieldset>
            </fieldset>
        </form>
        <h1>Schedule an Appointment</h1>
        <p>Please use the form to the right to schedule an appointment.</p>
    </jsp:body>
</t:layout>
<% } else if(reason == null && rank == -1) { %>
<t:layout pagetitle="Schedule an Appointment" rank="<%= rank %>">
    <jsp:body>
        <form class="list panel" action="/schedule" method="POST">
            <input type="hidden" name="dept" value="${dept}" />
            <input type="hidden" name="major" value="${major}" />
            <input type="hidden" name="month" value="${month}" />
            <input type="hidden" name="date" value="${date}" />
            <input type="hidden" name="slot" value="${slot}" />
            <fieldset>
                <fieldset>
            <legend>Enter appointment details</legend>
            <ol>
              <li>
                <t:forminput name="fname" label="First Name" type="text" placeholder="Enter your first name" required="true" />
              </li>
              <li>
                <t:forminput name="lname" label="Last Name" type="text" placeholder="Enter your last name" required="true" />
              </li>
              <li>
                <t:forminput name="email" label="Email" type="email" placeholder="Enter your email address" required="true" />
              </li>
              <li>
                <label for="s_reason">Reason</label>
                <input type="text" name="reason" id="s_reason" placeholder="Enter a reason" required />
              </li>
              <li>
                <label for="s_info">Additional Information</label>
                <textarea name="info" id="s_info" placeholder="Enter additional information (optional)"></textarea>
              </li>
            </ol>
            <input type="submit" value="Next" />
                </fieldset>
            </fieldset>
        </form>
        <h1>Schedule an Appointment</h1>
        <p>Please use the form to the right to schedule an appointment.</p>
    </jsp:body>
</t:layout>
<% } else if(reason == null) { %>
<t:layout pagetitle="Schedule an Appointment" rank="<%= rank %>">
    <jsp:body>
        <form class="list panel" action="/schedule" method="POST">
            <input type="hidden" name="dept" value="${dept}" />
            <input type="hidden" name="major" value="${major}" />
            <input type="hidden" name="month" value="${month}" />
            <input type="hidden" name="date" value="${date}" />
            <input type="hidden" name="slot" value="${slot}" />
            <fieldset>
                <fieldset>
            <legend>Enter appointment details</legend>
            <ol>
              <li>
                <label for="s_reason">Reason</label>
                <input type="text" name="reason" id="s_reason" placeholder="Enter a reason" required />
              </li>
              <li>
                <label for="s_info">Additional Information</label>
                <textarea name="info" id="s_info" placeholder="Enter additional information (optional)"></textarea>
              </li>
            </ol>
            <input type="submit" value="Next" />
                </fieldset>
            </fieldset>
        </form>
        <h1>Schedule an Appointment</h1>
        <p>Please use the form to the right to schedule an appointment.</p>
    </jsp:body>
</t:layout>
<% } %>