<%-- 
    Document   : forminput
    Created on : Apr 7, 2015, 9:53:34 PM
    Author     : Michael
--%>

<%@attribute name="label" required="true" %>
<%@attribute name="name" required="true" %>
<%@attribute name="type" %>
<%@attribute name="value" %>
<div class="form-group">
    <label for="s_${name}">${label}</label>
    <input type="<%= type != null ? type : "text" %>" name="${name}" id="s_${name}" value="<%= value != null ? value : "" %>" class="form-control">
</div>