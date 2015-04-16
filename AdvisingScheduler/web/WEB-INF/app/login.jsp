<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uta.cse4361.businessobjects.Account"%>
<%@include file="/WEB-INF/tools/sessionimport.jsp"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%
    if(rank >= 0) {
        response.sendRedirect("/");
    } else if(request.getParameter("email") == null) {
%>
<t:layout pagetitle="Sign in" rank="<%= rank %>">
    <form class="panel" action="/login" method="POST">
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
</t:layout>
<% } else { %>
<jsp:useBean id="login" class="uta.cse4361.beans.LoginBean"/> 
<jsp:setProperty name="login" property="email" value='<%=request.getParameter("email")%>' />
<jsp:setProperty name="login" property="password" value='<%=request.getParameter("password")%>' />
<%
    if(rank == -1) {
        Account user = login.getUser();
        if(user != null) {
            session.setAttribute("id", user.getId());
            session.setAttribute("email", user.getEmail());
            session.setAttribute("fname", user.getFname());
            session.setAttribute("lname", user.getLname());
            session.setAttribute("phone", user.getPhone());
            session.setAttribute("rank", user.getRank());
            request.setAttribute("result", "You have signed in successfully.");
        } else {
            request.setAttribute("result", "Invalid username or password.");
        }
    }
%>
<t:redirect pagetitle="Sign in" url="/">
  ${result}
</t:redirect>
<% } %>