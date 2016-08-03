<%-- 
    Document   : Citizen_Home
    Created on : 02 4, 16, 9:19:29 AM
    Author     : RoAnn
--%>


<%@page import="Entity.Schedule"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="Entity.Feedback"%>
<%@page import="Entity.Project"%>
<%@page import="Entity.Contractor_User"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%Contractor_User c = (Contractor_User) session.getAttribute("user");%>

<!DOCTYPE html>
<html lang="en">
    <head>

        <title>Home</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap-reset.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <link href="assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
        <link rel="stylesheet" type="text/css" href="assets/gritter/css/jquery.gritter.css" />

        <!--external css-->
        <link href="assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
        <link rel="stylesheet" type="text/css" href="assets/gritter/css/jquery.gritter.css" />

        <!--right slidebar-->
        <link href="css/slidebars.css" rel="stylesheet">

        <!-- Custom styles for this template -->
        <link href="css/style.css" rel="stylesheet">
        <link href="css/style-responsive.css" rel="stylesheet" />


        <style>

            table, td, th {
                border: 1px solid black;
                padding: 15px;
            }

        </style>    


    </head>

    <body>

        <section id="container" class="">
            <header class="header green-bg">

                <div class="sidebar-toggle-box">
                    <div data-original-title="Toggle Navigation" data-placement="right" class="fa fa-bars tooltips"></div>
                </div>

                <a href="index.html" class="logo" >COGITO<span></span></a>

                <div class="nav notify-row" id="top_menu">

                    <ul class="nav top-menu">
                        <li class="dropdown">
                            <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                                <i class="fa fa-tasks"></i>
                                <span class="badge bg-success"><!--NUMBER OF TASKS--></span>
                            </a>
                            <ul class="dropdown-menu extended tasks-bar">
                                <div class="notify-arrow notify-arrow-green"></div>
                                <li>
                                    <p class="green">You have __ pending tasks</p>
                                </li>
                            </ul>
                        </li>

                        <li id="header_notification_bar" class="dropdown">
                            <a data-toggle="dropdown" class="dropdown-toggle" href="#">

                                <i class="fa fa-bell-o"></i>
                                <span class="badge bg-warning"><!--NUMBER OF NOTIFICATIONS--></span>
                            </a>
                            <ul class="dropdown-menu extended notification">
                                <div class="notify-arrow notify-arrow-yellow"></div>
                                <li>
                                    <p class="yellow">You have __ new notifications</p>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>

                <div class="top-nav ">
                    <ul class="nav pull-right top-menu">

                        <li>
                            <input type="text" class="form-control search" placeholder="">
                        </li>

                        <li class="dropdown">
                            <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                                <img alt="" src="img/avatar1_small.jpg">
                                <span class="username">Hello <b><u><%=c.getName()%></u></b>!</span>
                                <b class="caret"></b>
                            </a>
                            <ul class="dropdown-menu extended logout">
                                <div class="log-arrow-up"></div>
                                <li><a href="#"><i class=" fa fa-suitcase"></i>Profile</a></li>
                                <li><a href="#"><i class="fa fa-cog"></i> Settings</a></li>
                                <li><a href="#"><i class="fa fa-bell-o"></i> Notification</a></li>
                                <li><a href="Logout"><i class="fa fa-key"></i> Log Out</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>

            </header>
        </section>

        <aside>
            <div id="sidebar"  class="nav-collapse ">
                <ul class="sidebar-menu" id="nav-accordion">

                    <li>
                        <a href="BAC_Home" class="active">
                            <i class="fa fa-dashboard"></i>
                            <span>Home</span>
                        </a>
                    </li>

                    <li>
                        <a href="BAC_ViewContractorList">
                            <i class="fa fa-book"></i>
                            <span>Contractors</span>
                        </a>
                    </li>

                    <li>
                        <a href="BAC_NotificationActivity">
                            <i class="fa fa-book"></i>
                            <span>Notifications and Activity</span>
                        </a>
                    </li>
                </ul>
            </div>
        </aside>
        <%

            Project project = (Project) request.getAttribute("project");
            Feedback feedbackSummary = (Feedback) request.getAttribute("feedbackSummary");
            int total = (Integer) request.getAttribute("tRespondents");
            DecimalFormat df = new DecimalFormat("#.##");
        %>

        <!--main content start-->
        <section id="main-content">
            <section class="wrapper site-min-height">
                <!-- page start-->
                <section class="panel">
                    <div class="col-lg-8" style="padding-left: 0px; padding-right:0px; width:100%;">
                        <div class="row">
                            <div class="col-lg-6" style="width:100%;">
                                <!--widget start-->



                                <section class="panel">
                                    <section class="panel-body">

                                        <div>
                                            <b style="margin-right: 55px"> Project Name: </b>          <%=project.getName()%> <br>
                                            <b style="margin-right: 20px"> Project Description: </b>   <%=project.getDescription()%>
                                        </div>    


                                    </section>   

                                </section>   







                                <!--widget end-->

                            </div>
                        </div>

                    </div>
                </section>

                <section class="panel">
                    <div class="col-lg-8" style="padding-left: 0px; padding-right:0px; width:100%;">
                        <div class="row">
                            <div class="col-lg-6" style="width: 100%">
                                <!--widget start-->



                                <section class="panel">
                                    <section class="panel-body">

                                        <b>Citizen Evaluation</b>
                                        <hr>







                                        <table>
                                            <thead>
                                            <th>Criteria</th>
                                            <th>Description</th>  
                                            <th>Rating</th>
                                            </thead>    

                                            <tbody>

                                                <tr>
                                                    <td>
                                                        <b>Quality: </b> 
                                                    </td>
                                                    <td>
                                                        The project was able to address the problem correctly. 
                                                    </td>    
                                                    <td style="padding: 10px">
                                                        <%=df.format(feedbackSummary.getQualityave() / 5 * 100) + "%"%> 
                                                    </td>    
                                                </tr> 

                                                <tr>
                                                    <td >
                                                        <b>Promptness: </b>
                                                    </td>
                                                    <td>
                                                        The project was able to address the problem within a considerable amount of time.  
                                                    </td>    
                                                    <td style="padding: 10px">
                                                        <%=df.format(feedbackSummary.getPromptnessave() / 5 * 100) + "%"%>  
                                                    </td>    
                                                </tr> 
                                                <tr>
                                                    <td>
                                                        <b>Convenience: </b>
                                                    </td>
                                                    <td>
                                                        The project did not cause much disturbance or trouble and were of no hindrance to the everyday work of the citizens.   
                                                    </td>    

                                                    <td style="padding: 10px">
                                                        <%=df.format(feedbackSummary.getConvenienceave() / 5 * 100) + "%"%>
                                                    </td>    
                                                </tr> 
                                                <tr>
                                                    <td>
                                                        <b>Safety: </b>
                                                    </td>
                                                    <td>
                                                        Markers and warning signs were present within the area of implementation. 
                                                    </td>    
                                                    <td style="padding: 10px">
                                                        <%=df.format(feedbackSummary.getSafetyave() / 5 * 100) + "%"%>
                                                    </td>    
                                                </tr> 
                                                <tr>
                                                    <td>
                                                        <b>Details: </b> 
                                                    </td>
                                                    <td>

                                                        Signs regarding the project were present within the area of implementation. The signage provided enough details about the project.

                                                    </td>    
                                                    <td style="padding: 10px">
                                                        <%=df.format(feedbackSummary.getDetailsave() / 5 * 100) + "%"%>
                                                    </td>    
                                                </tr> 
                                                <tr>
                                                    <td>
                                                        <b>Satisfaction: </b> 
                                                    </td>
                                                    <td>
                                                        Over-all satisfaction of the citizens who benefit the said project  
                                                    </td>    
                                                    <td style="padding: 10px">
                                                        <%=df.format(feedbackSummary.getSatisfactionave() / 5 * 100) + "%"%>
                                                    </td>    
                                                </tr> 
                                            </tbody>    
                                        </table>  

                                        <%

                                            double totalave = feedbackSummary.getQualityave() + feedbackSummary.getPromptnessave() + feedbackSummary.getConvenienceave() + feedbackSummary.getSafetyave() + feedbackSummary.getDetailsave() + feedbackSummary.getSatisfactionave();
                                            double ave = totalave / 30;
                                            double percentave = ave * 100;

                                        %>     

                                        <br>
                                        <div>
                                            <p><b>Total respondents to date:</b> <%=total%></p>
                                        </div>    

                                        <div>
                                            <p><b>Total project evaluation:</b> <%=df.format(percentave)%>%</p>
                                        </div>    
                                        <br>    

                                    </section>   

                                </section>   







                                <!--widget end-->

                            </div>











                        </div>           




                    </div>








                    </div>
                </section>

                <section class="panel">
                    <div class="col-lg-8" style="padding-left: 0px; padding-right:0px; width:100%;">
                        <div class="row">
                            <div class="col-lg-6" style="width: 100%">
                                <!--widget start-->



                                <section class="panel">

                                    <%ArrayList<Schedule> completedDatesReport = (ArrayList<Schedule>) request.getAttribute("completedDatesReport");%>

                                    <style>
                                        .okaylegend {color: blue;}
                                        .semiokaylegend {color: green;}
                                        .notokaylegend {color: red;}
                                    </style>

                                    <div class="panel-body bio-graph-info">
                                        <b>Rate of completion of project</b>
                                        <hr>

                                        <%

                                            long total2 = 0;


                                        %>


                                        <div class="pull-right">
                                            <i class="fa fa-square okaylegend" style="margin-left: 7px"></i> Ahead
                                            <br>
                                            <i class="fa fa-square semiokaylegend" style="margin-left: 7px"></i>  On-time
                                            <br>
                                            <i class="fa fa-square notokaylegend" style="margin-left: 7px"></i>  Delayed
                                        </div>

                                        <table class="table table-bordered">

                                            <thead>
                                            <th>Work</th>
                                            <th>Description</th>
                                            <th>Date Started</th>
                                            <th>Target End date</th>
                                            <th>Actual date completed</th>
                                            <th>Status</th>


                                            </thead>
                                            <tbody>
                                                <%                                                Date convertedCurrentDate1;
                                                    Date convertedCurrentDate2;

                                                    for (int x = 0; x < completedDatesReport.size(); x++) {

                                                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                                                        convertedCurrentDate1 = sdf.parse(completedDatesReport.get(x).getEnddate());
                                                        String date1 = sdf.format(convertedCurrentDate1);

                                                        String date2 = "";
                                                        long diffDays = 0;

                                                        convertedCurrentDate2 = sdf.parse(completedDatesReport.get(x).getActualenddate());
                                                        date2 = sdf.format(convertedCurrentDate2);

                                                        long diff = Math.abs(convertedCurrentDate1.getTime() - convertedCurrentDate2.getTime());
                                                        diffDays = diff / (24 * 60 * 60 * 1000);

                                                        total2 += diffDays;


                                                %>
                                                <tr>
                                                    <td><%=completedDatesReport.get(x).getTask().getName()%></td>
                                                    <td><%=completedDatesReport.get(x).getTask().getDescription()%></td>
                                                    <td><%=completedDatesReport.get(x).getStartdate()%></td>
                                                    <td><%=completedDatesReport.get(x).getEnddate()%></td>
                                                    <td><%=completedDatesReport.get(x).getActualenddate()%></td>
                                                    <%
                                                        if (convertedCurrentDate1.after(convertedCurrentDate2)) {
                                                    %>
                                                    <td>
                                                        <font color="blue"> Ahead <%out.print(diffDays + " days");%></font>
                                                    </td>
                                                    <%
                                                        }

                                                        if (convertedCurrentDate1.equals(convertedCurrentDate2)) {
                                                    %>
                                                    <td>
                                                        <font color="green"> On-time </font>
                                                    </td>
                                                    <%
                                                        }
                                                        if (convertedCurrentDate1.before(convertedCurrentDate2)) {
                                                    %>

                                                    <td>
                                                        <font color="red"> Delayed <%out.print(diffDays + " days");%></font>
                                                    </td>

                                                    <%
                                                        }
                                                    %>


                                                </tr>

                                                <%
                                                    }

                                                %>
                                            </tbody>


                                        </table>    





                                    </div>


                                    <br>             



                                </section>  







                                <!--widget end-->

                            </div>











                        </div>           




                    </div>









                </section>                  


                <!-- page end-->
            </section>

        </section>
        <!--main content end-->

        <!--footer start-->
        <footer class="site-footer">
            <div class="text-center">
                2016 &copy; KAYA
                <a href="#" class="go-top">
                    <i class="fa fa-angle-up"></i>
                </a>
            </div>
        </footer>

        <!-- js placed at the end of the document so the pages load faster -->
        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script class="include" type="text/javascript" src="js/jquery.dcjqaccordion.2.7.js"></script>
        <script src="js/jquery.scrollTo.min.js"></script>
        <script src="js/slidebars.min.js"></script>
        <script src="js/jquery.nicescroll.js" type="text/javascript"></script>
        <script type="text/javascript" src="assets/gritter/js/jquery.gritter.js"></script>
        <script src="js/respond.min.js" ></script>
        <script type="text/javascript" src="js/jquery.pulsate.min.js"></script>

        <!--right slidebar-->
        <script src="js/slidebars.min.js"></script>

        <!--common script for all pages-->
        <script src="js/common-scripts.js"></script>

        <!--script for this page only-->
        <script src="js/gritter.js" type="text/javascript"></script>
        <script src="js/pulstate.js" type="text/javascript"></script>
    </body>
</html>
