<%
    String major = request.getParameter("major"),
            date = request.getParameter("date"),
          reason = request.getParameter("reason"),
            desc = request.getParameter("desc");

    int dept, slot, selectedMonth;
    try {
        dept = Integer.parseInt(request.getParameter("dept"));
    } catch(NumberFormatException e) {
        dept = 0;
    }

    try {
        slot = Integer.parseInt(request.getParameter("slot"));
    } catch(NumberFormatException e) {
        slot = 0;
    }

    int viewmonth = 0;
    if(request.getParameter("viewmonth") != null) {
        viewmonth = Integer.parseInt(request.getParameter("viewmonth"));
    }

    request.setAttribute("dept", dept);
    request.setAttribute("major", major);
    request.setAttribute("date", date);
    request.setAttribute("slot", slot);
    request.setAttribute("reason", reason);
    request.setAttribute("desc", desc);
    request.setAttribute("viewmonth", viewmonth);
%>