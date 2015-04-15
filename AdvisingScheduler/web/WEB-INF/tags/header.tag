<%@tag description="Header block" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@attribute name="pagetitle" required="true" %>
<%@attribute name="rank" required="true" type="java.lang.Integer" %>
    <header>
      <h1>${pagetitle}</h1>
      <nav>
        <ul>
<t:navlink url="/" name="Home" />
<% if(rank < 1) { %>
<t:navlink url="/schedule" name="Schedule Appointment" />
<% }
   if(rank == -1) { %>
<t:navlink url="/login" name="Sign in" />
<t:navlink url="/register" name="Register" />
<% } else if(rank == 0) { %>
<t:navlink url="/appointments" name="View Appointments" />
<% } %>
<% if(rank >= 0) { %>
<t:navlink url="/logout" name="Sign Out" />
<% } %>
        </ul>
      </nav>
    </header>