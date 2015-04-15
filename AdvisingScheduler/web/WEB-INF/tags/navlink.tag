<%@tag description="Navigation link" pageEncoding="UTF-8"%>
<%@attribute name="url" required="true" %>
<%@attribute name="name" required="true" %>
<% String url2 = (request.getServletPath().equals("") ? "/" : request.getServletPath()); %>
<li><a href="<%= url %>"<%= url2.equals(request.getContextPath() + url) ? " class=\"sel\"" : "" %>>${name}</a></li>