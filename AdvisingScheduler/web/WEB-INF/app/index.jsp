<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/tools/sessionimport.jsp"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<% if(rank < 0) { %>
<t:layout rank="<%= rank %>">
    <jsp:body>
        <form class="right panel" action="/login" method="POST">
          <fieldset>
            <legend>Access your account</legend>
            <ol>
              <li>
                <t:forminput name="email" label="Email" type="email" placeholder="email@mavs.uta.edu" pattern=".*@mavs\.uta\.edu" title="Enter your UTA email" required="true" />
              </li>
              <li>
                <t:forminput name="password" label="Password" type="password" placeholder="************" required="true" />
              </li>
              <input type="submit" value="Sign in">
            </ol>
          </fieldset>
        </form>
        <h1>Welcome to the UTA advising scheduling system</h1>
        <p>This system shall allow students to log in and schedule advising appointments with their college advisors, all online! Also advisors shall be able to set their appointment times, edit appointments, and even sync with their Outlook calendars in a later version. In this version students can schedule appointments and advisors can create time slots for appointments.</p>
    </jsp:body>
</t:layout>
<%
    } else {

    request.setAttribute("fname", session.getAttribute("fname"));
    request.setAttribute("lname", session.getAttribute("lname"));
%>
<t:layout rank="<%= rank %>">
    <jsp:body>
        <h1>Welcome to the UTA advising scheduling system</h1>
        <p>You are signed in as ${fname} ${lname}!</p>
        <p>This system shall allow students to log in and schedule advising appointments with their college advisors, all online! Also advisors shall be able to set their appointment times, edit appointments, and even sync with their Outlook calendars in a later version. In this version students can schedule appointments and advisors can create time slots for appointments.</p>
    </jsp:body>
</t:layout>
<% } %>