<%@attribute name="label" required="true" %>
<%@attribute name="name" required="true" %>
<%@attribute name="type" %>
<%@attribute name="value" %>
<%@attribute name ="placeholder" %>
<%@attribute name ="title" %>
<%@attribute name ="pattern" %>
<%@attribute name ="required" type="java.lang.Boolean" %>
<label for="s_${name}">${label}</label>
<input type="<%= type != null ? type : "text" %>" name="${name}" id="s_${name}"<%= value != null ? " value=\"" + value + "\"" : "" %><%= placeholder != null ? " placeholder=\"" + placeholder + "\"" : "" %><%= pattern != null ? " pattern=\"" + pattern + "\"" : "" %><%= title != null ? " title=\"" + title + "\"" : "" %><%= required ? " required" : "" %> />