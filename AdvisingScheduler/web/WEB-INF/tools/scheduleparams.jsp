<%
    String  dept = request.getParameter("dept"),
           major = request.getParameter("major"),
            slot = request.getParameter("slot"),
       viewmonth = request.getParameter("viewmonth"),
          reason = request.getParameter("reason"),
            desc = request.getParameter("desc");

    request.setAttribute("dept", dept);
    request.setAttribute("major", major);
    request.setAttribute("slot", slot);
    request.setAttribute("viewmonth", viewmonth);
    request.setAttribute("reason", reason);
    request.setAttribute("desc", desc);
%>