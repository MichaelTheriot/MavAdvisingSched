<%@tag description="Header block" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@attribute name="pagetitle" required="true" %>
<%@attribute name="rank" required="true" type="java.lang.Integer" %>
    <header>
      <h1>${pagetitle}</h1>
      <nav>
        <ul>
<t:navlink url="${pageContext.request.contextPath}/" name="Home" />
<% if(rank < 1) { %>
<t:navlink url="${pageContext.request.contextPath}/schedule" name="Schedule Appointment" />
<% }
   if(rank == -1) { %>
<t:navlink url="${pageContext.request.contextPath}/login" name="Sign in" />
<t:navlink url="${pageContext.request.contextPath}/register" name="Register" />
<% } else if(rank == 0) { %>
<t:navlink url="${pageContext.request.contextPath}/appointments" name="View Appointments" />
<% } %>
<% if(rank >= 0) { %>
<t:navlink url="${pageContext.request.contextPath}/logout" name="Sign Out" />
<% } %>
        </ul>
      </nav>
    </header>