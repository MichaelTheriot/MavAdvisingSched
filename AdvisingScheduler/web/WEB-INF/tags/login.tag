<%@tag description="Login form" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<form class="right panel" action="${pageContext.request.contextPath}/login" method="POST">
    <fieldset>
        <legend>Access your account</legend>
        <ol>
            <li>
                <t:forminput name="email" label="Email" type="email" placeholder="email@mavs.uta.edu" title="Enter your UTA email" required="true" />
            </li>
            <li>
                <t:forminput name="password" label="Password" type="password" placeholder="Enter your password..." required="true" />
            </li>
        </ol>
        <input type="submit" value="Sign in">
    </fieldset>
</form>