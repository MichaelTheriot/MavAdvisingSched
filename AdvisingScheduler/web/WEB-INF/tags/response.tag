<%-- 
    Document   : response
    Created on : Apr 7, 2015, 8:19:27 PM
    Author     : Michael
--%>

<%@tag description="Response Page template" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@attribute name="redirect" required="true" %>
<%@attribute name="title" required="true" %>
<t:box title="${title}">
    <jsp:attribute name="script">
        <script>
            setTimeout(function() {
                window.location.href = '${redirect}';
            }, 5000);
        </script>
    </jsp:attribute>
    <jsp:body>
        <p><jsp:doBody/><br><br>You will be redirected in 5 seconds, or <a href="${redirect}">click here</a> to go now.</p>
    </jsp:body>
</t:box>