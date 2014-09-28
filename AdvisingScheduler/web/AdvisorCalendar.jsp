<%-- 
    Document   : Calendar
    Created on : Sep 12, 2014, 9:59:13 PM
    Author     : Melissa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>Advisor Calendar</title>
        <link rel='stylesheet' href='css/fullcalendar.css' />
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
   </head>
        <jsp:include page="header.jsp" />
        <jsp:useBean id="fdm" class="uta.cse4361.businessobjects.FlyweightDatabaseManager" scope="session"/>
    <body>           
        <table id="table">
            <tr>
                <jsp:include page="sidebar.jsp" />
                
                <td style="vertical-align: top; float: right;">
                    <div style="width:780px" id="timeaccordion">
                        <h3>Calendar</h3>
                        <div id="calendar"></div>
                                              
                        <!--Andrews code-->
                         <%!
                            public int getHour(String time){
                                int hour = Integer.parseInt(time.substring(0,2));
                                if("PM".equalsIgnoreCase(time.substring(time.length() - 2))){
                                    if(hour!=12){hour += 12;};
                                };
                                return hour;
                            }
                            public int getMin(String time){
                                return Integer.parseInt(time.substring(3,5));
                            }
                            %>
                            <% boolean dateSubmitted = !(request.getParameter("date")==null || request.getParameter("date")=="");
                                boolean startSubmitted =  !(request.getParameter("startTime")==null || request.getParameter("startTime")=="");
                                boolean endSubmitted = !(request.getParameter("endTime")==null || request.getParameter("endTime")=="");
                                boolean formSubmitted = dateSubmitted || startSubmitted || endSubmitted;
                                boolean validFormSubmitted = dateSubmitted && startSubmitted && endSubmitted;%>
                        
                        <h3>Allocate Time</h3>
                        <div>
                            <form>
                                <table>
                                    <tr>
                                        <td>Date:</td>
                                        <td>
                                            <input type="text" id="datepicker" name="date"<% if (dateSubmitted){out.println(" value=\""+request.getParameter("date")+"\"");}%> readonly></p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Start Time:</td>
                                        <td>
                                            <input type="datetime" id = "starttimepicker" name="startTime"<% if (startSubmitted){out.println(" value=\""+request.getParameter("startTime")+"\"");}%>></p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>End Time:</td>
                                        <td>
                                            <input type="datetime" id ="endtimepicker" name="endTime"<% if (endSubmitted){out.println(" value=\""+request.getParameter("endTime")+"\"");}%>></p>
                                        </td>
                                    </tr>
                                </table>
                            <input id="button" type="submit" value="Submit">
                            </form>
                            <% if (validFormSubmitted){
                                   java.text.DateFormat format = new java.text.SimpleDateFormat("MM/dd/yyyy");
                                   format.setLenient(false);
                                   java.util.Date newDate = format.parse(request.getParameter("date"));
                                %>
                                 <jsp:useBean id="allocateTimeBean" class="uta.cse4361.businessobjects.TimeAllocationSlotBean" scope="session"/>
                                 <jsp:setProperty name="allocateTimeBean" property="date" value= '<%= newDate %>'/>
                                 <jsp:setProperty name="allocateTimeBean" property="startHour" value= '<%= getHour(request.getParameter("startTime")) %>'/>
                                 <jsp:setProperty name="allocateTimeBean" property="startMinute" value= '<%= getMin(request.getParameter("startTime")) %>'/>
                                 <jsp:setProperty name="allocateTimeBean" property="endHour" value= '<%= getHour(request.getParameter("endTime")) %>'/>
                                 <jsp:setProperty name="allocateTimeBean" property="endMinute" value= '<%= getMin(request.getParameter("endTime")) %>'/>
                                <%
                                allocateTimeBean.allocateTime();
                                //--------------
                                
                                    
                                
                                    //Flyweight array to Strings 
                                    java.util.ArrayList<uta.cse4361.businessobjects.Flyweight> fw = fdm.getDaysFlyweights(allocateTimeBean.getDate());
                                    int fwsize= fw.size();                                
                                    
                                            
                                    StringBuilder sbDay = new StringBuilder();
                                    for(int i=0;i<fwsize;i++) 
                                        sbDay.append(fw.get(i).getDate().getDate()+",");
                                     
                                    StringBuilder sbHour = new StringBuilder();
                                    for(int i=0;i<fwsize;i++) 
                                        sbHour.append(fw.get(i).getTime()/60+",");

                                    StringBuilder sbMin = new StringBuilder();
                                    for(int i=0;i<fwsize;i++) 
                                        sbMin.append(fw.get(i).getTime()%60+",");

                                    StringBuilder sbMonth = new StringBuilder();
                                    for(int i=0;i<fwsize;i++) 
                                        sbMonth.append(fw.get(i).getDate().getMonth()+",");

                                    StringBuilder sbYear = new StringBuilder();
                                    for(int i=0;i<fwsize;i++) 
                                        sbYear.append((fw.get(i).getDate().getYear()+1900)+",");                 
                                    
                                //---------------    
                                    %>
                                    
                                <script type="text/javascript">  
                                    
                                    //Parse String Flyweights to array
                                    window.size = '<%=fwsize%>';
                                    
                                    var temp="<%=sbDay.toString()%>";                               
                                    var day = new Array(); 
                                    window.day = temp.split(',',size);

                                    var temp="<%=sbHour.toString()%>";
                                    var hour = new Array();
                                    window.hour = temp.split(',',size);

                                    var temp="<%=sbMin.toString()%>";
                                    var min = new Array();
                                    window.min = temp.split(',',size);

                                    var temp="<%=sbMonth.toString()%>";
                                    var month = new Array();
                                    window.month = temp.split(',',size);

                                    var temp="<%=sbYear.toString()%>";
                                    var year = new Array();
                                    window.year = temp.split(',',size);
                                   
                                   //Declare global
                                   // window.formattedEventData = []; 
				</script>
				
                                    
                                    
                                    <%
                                out.println("Date " + allocateTimeBean.getDate() + "<br> " + 
                                        "Day" + allocateTimeBean.getDate().getDate() + "<br> " + 
                                        "Month " + allocateTimeBean.getDate().getMonth() + "<br> " +
                                        "Year " + (allocateTimeBean.getDate().getYear()+1900) + "<br> " + 
                                        "StartHour:StartMinute " + allocateTimeBean.getStartHour() + ":" + allocateTimeBean.getStartMinute() + "<br>" +
                                        "EndHour:EndMinute" + allocateTimeBean.getEndHour() + ":" + allocateTimeBean.getEndMinute());
                                }
                                else if(formSubmitted){
                                    if(!dateSubmitted){
                                        out.println("Please select a date.\n");
                                    }
                                    if (!startSubmitted){
                                        out.println("Please select a start time.\n");
                                    }
                                    if (!endSubmitted){
                                        out.println("Please select an end time.\n");
                                    }
                                }%>
                        </div><!--Andrew's code end-->                       
                    </div> <!--timeaccordion end-->
                </td>       
            </tr>           
        </table>

    </body>
        <%       
           //uta.cse4361.businessobjects.FlyweightDatabaseManager fdm = new uta.cse4361.businessobjects.FlyweightDatabaseManager();
//           
//           uta.cse4361.businessobjects.AppointmentFlyweight fwa[] = new uta.cse4361.businessobjects.AppointmentFlyweight[4];
//           uta.cse4361.businessobjects.AppointmentFlyweight fw = new uta.cse4361.businessobjects.AppointmentFlyweight(1,new java.util.Date(2014, 8, 22, 5, 30), 6, 15);
//           fwa[0] = fw;
//           fw = new uta.cse4361.businessobjects.AppointmentFlyweight(1, new java.util.Date(2014, 8, 2, 4, 10), 6, 15);
//           fwa[1] = fw;
//           fw = new uta.cse4361.businessobjects.AppointmentFlyweight(1, new java.util.Date(2014, 8, 5, 6, 20), 6, 15);
//           fwa[2] = fw;
//           fw = new uta.cse4361.businessobjects.AppointmentFlyweight(1, new java.util.Date(2014, 8, 8, 7, 30), 6, 15);
//           fwa[3] = fw;      
//           
//           //Retrieve all the data into seperate parts
//           StringBuilder sbDay = new StringBuilder();
//           for(int i=0;i<fwa.length;i++) 
//               sbDay.append(fwa[i].getDate().getDate()+",");
//           
//           StringBuilder sbHour = new StringBuilder();
//           for(int i=0;i<fwa.length;i++) 
//               sbHour.append(fwa[i].getDate().getHours()+",");
//           
//           StringBuilder sbMin = new StringBuilder();
//           for(int i=0;i<fwa.length;i++) 
//               sbMin.append(fwa[i].getDate().getMinutes()+",");
//           
//           StringBuilder sbMonth = new StringBuilder();
//           for(int i=0;i<fwa.length;i++) 
//               sbMonth.append(fwa[i].getDate().getMonth()+",");
//           
//           StringBuilder sbYear = new StringBuilder();
//           for(int i=0;i<fwa.length;i++) 
//               sbYear.append(fwa[i].getDate().getYear()+",");
//                  
           
        %>

    
        <jsp:include page="footer.jsp" />
        <script type="text/javascript">
            document.getElementById('starttimepicker').onkeydown = function(e){
                e.preventDefault();
            }
             document.getElementById('endtimepicker').onkeydown = function(e){
                e.preventDefault();
            }
        </script>
        <script type="text/javascript" src="js/fullcalendar/moment.min.js"></script>
        <script type="text/javascript" src="js/fullcalendar/fullcalendar.js"></script>
        <script type="text/javascript" src="js/AdvisorCalendar.js"></script>
</html>
