<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<t:layout>
    <jsp:attribute name="loggedout">
        <form class="right panel" action="${pageContext.request.contextPath}/login" method="POST">
            <fieldset>
                <legend>Access your account</legend>
                <ol>
                    <li>
                        <t:forminput name="email" label="Email" type="email" placeholder="email@mavs.uta.edu" pattern=".*@mavs\.uta\.edu" title="Enter your UTA email" required="true" />
                    </li>
                    <li>
                        <t:forminput name="password" label="Password" type="password" placeholder="************" required="true" />
                    </li>
                </ol>
                <input type="submit" value="Sign in">
            </fieldset>
        </form>
        <h1>Welcome to the UTA advising scheduling system</h1>
        <p>This system shall allow students to log in and schedule advising appointments with their college advisors, all online! Also advisors shall be able to set their appointment times and edit appointments. In this version students can schedule appointments and advisors can create time slots for appointments.</p>
    </jsp:attribute>
    <jsp:attribute name="loggedin">
        <h1>Welcome to the UTA advising scheduling system</h1>
        <p>You are signed in as ${sessionScope.fname} ${sessionScope.lname}!</p>
    </jsp:attribute>
</t:layout>