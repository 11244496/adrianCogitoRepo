<%-- 
    Document   : Citizen_ViewProjectDetails
    Created on : 03 24, 16, 10:49:56 PM
    Author     : RoAnn
--%>


<%@page import="Entity.Schedule"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Entity.Contractor_User"%>
<%@page import="Entity.Feedback"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="Entity.Files"%>
<%@page import="Entity.Project"%>
<%@page import="Entity.Reply"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Entity.Testimonial"%>
<%@page import="Entity.Citizen"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%Citizen c = (Citizen) session.getAttribute("user");%>
<%Project p = (Project) session.getAttribute("project");%>
<%Feedback feedback = (Feedback) session.getAttribute("feedback");%>
<%ArrayList<Files> files = p.getFiles();%>
<%ArrayList<Files> pfiles = (ArrayList<Files>) session.getAttribute("pFiles");%>
<%DecimalFormat df = new DecimalFormat("#,###.00");%>

<%ArrayList<Project> pList = (ArrayList<Project>) session.getAttribute("contractorPList");%>
<%Contractor_User cu = (Contractor_User) session.getAttribute("contractor");%>


<!DOCTYPE html>
<html lang="en">
    <head>

        <title>View Project</title>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="Mosaddek">
        <meta name="keyword" content="FlatLab, Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
        <link rel="shortcut icon" href="img/favicon.png">

        <!-- Bootstrap core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap-reset.css" rel="stylesheet">
        <!--external css-->
        <link href="assets/font-awesome/css/font-awesome.css" rel="stylesheet" >

        <!--right slidebar-->
        <link href="css/slidebars.css" rel="stylesheet">

        <!-- Custom styles for this template -->
        <link href="css/style.css" rel="stylesheet">
        <link href="css/style-responsive.css" rel="stylesheet">

        <link href = 'calendar/fullcalendar.css' rel='stylesheet'>
        <link href = 'calendar/scheduler.css' rel='stylesheet'>
        <script src ='calendar/moment.min.js'></script>
        <script src ='calendar/jquery.min.js'></script>
        <script src ='calendar/fullcalendar.js'></script>
        <script src ='calendar/scheduler.js'></script>

        <style>
            .DocumentList2
            {
                overflow-x:scroll;
                overflow-y:hidden;
                height:105%;
                white-space: nowrap;
                position: relative;
            }

            .row2 {
                width: 500%;
            }

            .DocumentItem2
            {
                border:1px solid #d9d9d9;
                margin-right: 10px;
                padding:0;
                height:200px;
                width: 200px;
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
                                <span class="username">Hello <b><u><%=c.getFirstName()%></u></b>!</span>
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
                        <a href="Citizen_Home">
                            <i class="fa fa-dashboard"></i>
                            <span>Home</span>
                        </a>
                    </li>

                    <li>
                        <a href="Citizen_SearchTestimonial">
                            <i class="fa fa-book"></i>
                            <span>Testimonials</span>
                        </a>
                    </li>

                    <li>
                        <a href="Citizen_ProjectsImplemented">
                            <i class="fa fa-book"></i>
                            <span>Projects Implemented</span>
                        </a>
                    </li>

                    <li>
                        <a href="Citizen_NotificationActivity">
                            <i class="fa fa-book"></i>
                            <span>Notification and Activity</span>
                        </a>
                    </li>
                </ul>
            </div>
        </aside>

        <section id="main-content">
            <section class="wrapper site-min-height">
                <!-- page start-->
                <section class="panel">

                    <header class="panel-heading">
                        View Project

                        <span class="pull-right">
                            <button type="button" class="btn btn-info" onclick="checkFeedback()">Send a feedback form</button>  
                            <br>
                        </span>
                        <br>
                    </header>
                </section>

                <div class="row">

                    <div class="col-md-12">
                        <section class="panel">
                            <div class="bio-graph-heading project-heading">
                                <strong><%=p.getName()%> </strong>
                            </div><p>
                            <div class="panel-body bio-graph-info">
                                <!--<h1>New Dashboard BS3 </h1>-->
                                <div class="row">
                                    <div class="col-lg-5" >
                                        <section class="panel">
                                            <div class="panel-body">


                                                <!------------------------------------------------------DETAILS------------------------------------------>
                                                <div>
                                                    <p><span class="bold">Project ID: </span></p>
                                                    <p><%=p.getId()%></p>
                                                </div><br>

                                                <div>
                                                    <p><span class="bold">Brief description: </span></p>
                                                    <p><%=p.getDescription()%></p>
                                                </div><br>

                                                <div>
                                                    <p><span class="bold">Category </span>:</p>
                                                    <p><%=p.getCategory()%></p>
                                                </div><br>
                                                <div>
                                                    <p><span class="bold">Date Submitted</span> :</p>
                                                    <p><%=p.getDatesubmitted()%></p>
                                                </div><br>
                                                <%if (p.getBudget() != 0) {%>

                                                <div>
                                                    <p><span class="bold">Budget</span> :</p>
                                                    <p>PHP <%=df.format(p.getBudget())%></p>
                                                </div><br>
                                                <%}%>

                                                <br>  

                                                <p><span class="bold">Project Progress:</span> :</p>
                                                <div class="progress progress-striped active ">
                                                    <div style="width: 10;" class="progress-bar progress-bar-success"></div>
                                                </div>
                                                <small>Current Status: <%out.print(p.getStatus());%></small>



                                            </div>
                                        </section>
                                    </div>

                                    <!------------------------------------------------------LOCATION------------------------------------------>

                                    <div class="col-lg-6">
                                        <section class="panel">
                                            <div class="panel-body">                            
                                                <div><p><span class="bold">Location: </span> :</p></div>
                                                <div class="panel-body bio-graph-info">
                                                    <center>
                                                        <div id="map" style="height: 500px; width: 575px; margin: 0; padding: 0;"></div>
                                                    </center>
                                                </div>
                                            </div>
                                        </section>
                                    </div>
                                </div>
                            </div>

                        </section>

                        <section class="panel">
                            <div class="bio-graph-heading project-heading">
                                <strong>Project Contractor - <%out.print(cu.getContractor().getName());%></strong>
                            </div>
                            <div class="panel-body bio-graph-info" style="height: 250px;">

                                <h4>List of Projects Accomplished</h4>
                                <table class="table table-hover p-table">

                                    <thead>
                                        <tr>
                                            <th>Name</th>
                                            <th>Description</th>
                                            <th>Completed</th>
                                            <th>Rating</th>
                                            <th></th>



                                        </tr>
                                    </thead>


                                    <tbody>

                                        <%

                                            for (int x = 0; x < pList.size(); x++) {

                                        %>
                                        <tr>
                                            <td class="p-name">
                                                <%=pList.get(x).getName()%>
                                            </td>
                                            <td class="p-name">
                                                <%=pList.get(x).getDescription()%>
                                            </td>
                                            <td class="p-name">

                                            </td>
                                            <td class="p-name">

                                            </td>
                                            <td>
                                                <form action="Citizen_ViewProjectDetails">
                                                    <input type="hidden" name="projid" value="<%=pList.get(x).getId()%>">

                                                    <button type="submit" class="btn btn-success" value="View proposal details">Project details</button>

                                                </form>
                                            </td>
                                        </tr>

                                        <%
                                            }
                                        %>

                                    </tbody>



                                </table>
                            </div>
                        </section> 

                        <!-------------------------------------------------MAIN TESTIMONIAL UPLOADS------------------------------------------>
                        <section class="panel">
                            <div class="bio-graph-heading project-heading">
                                <strong>Project Main Testimonial</strong>
                            </div>
                            <div class="panel-body bio-graph-info" style="height: 250px;">
                                <div class="DocumentList2">
                                    <div class="row2">
                                        <%String url = null;%>
                                        <%Testimonial t = p.getMainTestimonial();
                                            for (Files f : t.getFiles()) {
                                                url = t.getFolderName() + "/" + t.getTitle() + "/" + f.getFileName();
                                                if (f.getType().equalsIgnoreCase("image")) {%>

                                        <div class="col-lg-3 DocumentItem2">
                                            <img src="<%=url%>" style="width:100%; height:100%">
                                            <br/>
                                            <button type="button" value="<%=f.getId()%>" class="btn btn-info btn-sm" onclick="getTestimonial(<%=f.getId()%>)" style="width:100%; position: absolute; bottom:0;">View Details</button>                                        
                                        </div>

                                        <%} else if (f.getType().equalsIgnoreCase("video")) {%>

                                        <div class="col-lg-3 DocumentItem2">
                                            <video style="position: absolute; width: 100%; height: 100%; top:0px; left:0px;">
                                                <source src="<%=url%>" type="video/mp4">
                                            </video>
                                            <br/>
                                            <button type="button" class="btn btn-info btn-sm" style="width:100%; position: absolute; bottom:0;" onclick="getTestimonial(<%=f.getId()%>)">View Details</button>                                        
                                        </div>

                                        <%} else if (f.getType().equalsIgnoreCase("document")) {%>
                                        <div class="col-lg-3 DocumentItem2">
                                            <img src="img/docu.png" style="width:50px; height:50px; vertical-align: middle;">
                                            <br/>
                                            <button type="button" value="<%=f.getId()%>" class="btn btn-info btn-sm" onclick="getTestimonial(<%=f.getId()%>)" style="width:100%; position: absolute; bottom:0;">View Details</button>                                        
                                        </div>

                                        <%}
                                            }
                                        %>
                                    </div>
                                </div>
                            </div>
                        </section>                        

                        <!------------------------------------------------------GS UPLOADS------------------------------------------>
                        <section class="panel">
                            <div class="bio-graph-heading project-heading">
                                <strong>Project Files</strong>
                            </div>
                            <div class="panel-body bio-graph-info" style="height: 250px;">
                                <div class="DocumentList2">
                                    <div class="row2">
                                        <%
                                            for (Files f : pfiles) {

                                                url = p.getFoldername() + "/" + p.getId() + "/" + f.getFileName();
                                                if (f.getType().equalsIgnoreCase("image")) {%>

                                        <div class="col-lg-3 DocumentItem2">
                                            <img src="<%=url%>" style="width:100%; height:100%">
                                            <br/>
                                            <button type="button" value="<%=f.getId()%>" class="btn btn-info btn-sm" onclick="getProjectFiles(<%=f.getId()%>)" style="width:100%; position: absolute; bottom:0;">View Details</button>                                        
                                        </div>

                                        <%} else if (f.getType().equalsIgnoreCase("video")) {%>

                                        <div class="col-lg-3 DocumentItem2">
                                            <video style="position: absolute; width: 100%; height: 100%; top:0px; left:0px;">
                                                <source src="<%=url%>" type="video/mp4">
                                            </video>
                                            <br/>
                                            <button type="button" class="btn btn-info btn-sm" style="width:100%; position: absolute; bottom:0;" onclick="getProjectFiles(<%=f.getId()%>)">View Details</button>                                        
                                        </div>

                                        <%} else if (f.getType().equalsIgnoreCase("document")) {%>
                                        <div class="col-lg-3 DocumentItem2">
                                            <img src="img/docu.png" style="width:50px; height:50px; vertical-align: middle;">
                                            <br/>
                                            <button type="button" value="<%=f.getId()%>" class="btn btn-info btn-sm" onclick="getProjectFiles(<%=f.getId()%>)" style="width:100%; position: absolute; bottom:0;">View Details</button>                                        
                                        </div>

                                        <%}

                                            }
                                        %>
                                    </div>
                                </div>
                            </div>
                        </section>

                        <!---------------------------------------------For the summary of the works----------------->

                        <section class="panel">

                            <%ArrayList<Schedule> completedDatesReport = (ArrayList<Schedule>) session.getAttribute("completedDatesReport");%>

                            <div class="bio-graph-heading project-heading">
                                <strong>Work Done</strong>
                            </div>
                            <div class="panel-body bio-graph-info">


                                <%

                                    long total = 0;


                                %>


                                <style>
                                    .okaylegend {color: blue;}
                                    .semiokaylegend {color: green;}
                                    .notokaylegend {color: red;}
                                </style>

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

                                                total += diffDays;


                                        %>
                                        <tr>
                                            <td><%=completedDatesReport.get(x).getTask().getName()%></td>
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

                        <%if (feedback != null) {%>               
                        <div class="row">
                            <div class="col-md-12">
                                <!------------------------------------------------------FEEDBACK------------------------------------------>
                                <section class="panel">
                                    <div class="bio-graph-heading project-heading">
                                        <strong>Feedback Summary</strong>
                                    </div>
                                    <div class="panel-body bio-graph-info" style="height: 100%;">
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
                                                        <%=df.format(feedback.getQualityave() / 5 * 100) + "%"%> 
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
                                                        <%=df.format(feedback.getPromptnessave() / 5 * 100) + "%"%>  
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
                                                        <%=df.format(feedback.getConvenienceave() / 5 * 100) + "%"%>
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
                                                        <%=df.format(feedback.getSafetyave() / 5 * 100) + "%"%>
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
                                                        <%=df.format(feedback.getDetailsave() / 5 * 100) + "%"%>
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
                                                        <%=df.format(feedback.getSatisfactionave() / 5 * 100) + "%"%>
                                                    </td>    
                                                </tr> 
                                            </tbody>    
                                        </table>

                                        <%

                                            double totalave = feedback.getQualityave() + feedback.getPromptnessave() + feedback.getConvenienceave() + feedback.getSafetyave() + feedback.getDetailsave() + feedback.getSatisfactionave();
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
                                    </div>
                                </section>

                            </div>
                        </div>
                        <%}%>

                        <!------------------------------------------------------FEEDBACK------------------------------------------>
                    </div>

                </div>

                <!-- page end-->
            </section>

        </section>
        <style>
            #feedbackTable td{
                width:65%;
            }
        </style>


        <form action="Citizen_SubmitFeedback">
            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title">Feedback</h4>
                            <input type="hidden" name="projId" value="<%=p.getId()%>">
                        </div>
                        <div class="modal-body">
                            <center>We value your opinions and insights. To improve our projects and services, the Local Government of Las Pinas would like to hear your thoughts. Please take time to answer our citizen's feedback form. Thank you.
                                <br><br>
                                <i>Pinahahalagahan namin ang iyong mga opinyon at mga pananaw. Upang mapabuti ang aming mga proyekto at serbisyo,
                                    ang lokal na pamahalaan ng Las Pinas ay nais na marinig ang iyong mga saloobin.
                                    Mangyaring maglaan ng oras upang sagutin ang aming feedback form. Maraming Salamat po.</i>
                                <br><br>
                                Legend: <br><b>1</b> - Needs Improvement  | <b>2</b> - Fair | <b>3</b> - Good | 
                                <b>4</b> - Very Good | <b>5</b> - Excellent 
                            </center>
                            <br><br>
                            <table class="table table-bordered" id="feedbackTable" >

                                <tr>
                                    <th colspan="2" style="text-align: center">Quality/Kalidad</th>
                                </tr>                              
                                <tr>
                                    <td>
                                        The project was able to address the problem correctly.
                                        <br><br><i>Ang proyekto ay natugunan ang problema ng tama.</i>
                                    </td>
                                    <td>
                                        <div class="btn-group" data-toggle="buttons">
                                            <label class="btn btn-info">
                                                <input type="radio" name="quality" value="1" id="option1"> 1
                                            </label>
                                            <label class="btn btn-info">
                                                <input type="radio" name="quality" value="2" id="option2"> 2
                                            </label>
                                            <label class="btn btn-info">
                                                <input type="radio" name="quality" value="3" id="option3"> 3
                                            </label>
                                            <label class="btn btn-info">
                                                <input type="radio" name="quality" value="4" id="option3"> 4
                                            </label>
                                            <label class="btn btn-info">
                                                <input type="radio" name="quality" value="5" id="option3"> 5
                                            </label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th colspan="2" style="text-align: center">Promptness/Kaagahan</th>
                                </tr>                              
                                <tr>
                                    <td>The problem was addressed immediately.<br>
                                        <br><i>Ang problema ay naaksyunan kaagad</i>
                                    </td>
                                    <td>
                                        <div class="btn-group" data-toggle="buttons">
                                            <label class="btn btn-info">
                                                <input type="radio" name="promptness" value="1" id="option1"> 1
                                            </label>
                                            <label class="btn btn-info">
                                                <input type="radio" name="promptness" value="2" id="option2"> 2
                                            </label>
                                            <label class="btn btn-info">
                                                <input type="radio" name="promptness" value="3" id="option3"> 3
                                            </label>
                                            <label class="btn btn-info">
                                                <input type="radio" name="promptness" value="4" id="option3"> 4
                                            </label>
                                            <label class="btn btn-info">
                                                <input type="radio" name="promptness" value="5" id="option3"> 5
                                            </label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th colspan="2" style="text-align: center">Convenience/Kaginhawaan</th>
                                </tr>                              
                                <tr>
                                    <td>The project did not cause much disturbance or trouble.<br><br>
                                        <i>Ang proyekto ay hindi nagsanhi sa anumang gulo o problema.</i>
                                    </td>
                                    <td>
                                        <div class="btn-group" data-toggle="buttons">
                                            <label class="btn btn-info">
                                                <input type="radio" name="convenience" value="1" id="option1"> 1
                                            </label>
                                            <label class="btn btn-info">
                                                <input type="radio" name="convenience" value="2" id="option2"> 2
                                            </label>
                                            <label class="btn btn-info">
                                                <input type="radio" name="convenience" value="3" id="option3"> 3
                                            </label>
                                            <label class="btn btn-info">
                                                <input type="radio" name="convenience" value="4" id="option3"> 4
                                            </label>
                                            <label class="btn btn-info">
                                                <input type="radio" name="convenience" value="5" id="option3"> 5
                                            </label>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <th colspan="2" style="text-align: center">Safety/Kaligtasan</th>
                                </tr>                              
                                <tr>
                                    <td>Markers and warning signs were present within the area of implementation.<br><br>
                                        <i>May mga babala at palatandaan sa lugar ng pagpapatupad.</i>
                                    </td>
                                    <td>
                                        <div class="btn-group" data-toggle="buttons">
                                            <label class="btn btn-info">
                                                <input type="radio" name="safety" value="1" id="option1"> 1
                                            </label>
                                            <label class="btn btn-info">
                                                <input type="radio" name="safety" value="2" id="option2"> 2
                                            </label>
                                            <label class="btn btn-info">
                                                <input type="radio" name="safety" value="3" id="option3"> 3
                                            </label>
                                            <label class="btn btn-info">
                                                <input type="radio" name="safety" value="4" id="option3"> 4
                                            </label>
                                            <label class="btn btn-info">
                                                <input type="radio" name="safety" value="5" id="option3"> 5
                                            </label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th colspan="2" style="text-align: center">Details/Detalye</th>
                                </tr>                              
                                <tr>
                                    <td>Signs regarding the project were present within the area of implementation.<br><br>
                                        <i>Mayroon mga nakapaskil na detalye ng proyekto sa lugar ng pagpapatupad.</i>
                                    </td>
                                    <td>
                                        <div class="btn-group" data-toggle="buttons">
                                            <label class="btn btn-info">
                                                <input type="radio" name="details" value="1" id="option1"> 1
                                            </label>
                                            <label class="btn btn-info">
                                                <input type="radio" name="details" value="2" id="option2"> 2
                                            </label>
                                            <label class="btn btn-info">
                                                <input type="radio" name="details" value="3" id="option3"> 3
                                            </label>
                                            <label class="btn btn-info">
                                                <input type="radio" name="details" value="4" id="option3"> 4
                                            </label>
                                            <label class="btn btn-info">
                                                <input type="radio" name="details" value="5" id="option3"> 5
                                            </label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>The signage provided enough details about the project.<br><br>
                                        <i>Sapat ang nilalaman na detalye ng mga paskil o karatula ukol sa proyekto.</i>
                                    </td>
                                    <td>
                                        <div class="btn-group" data-toggle="buttons">
                                            <label class="btn btn-info">
                                                <input type="radio" name="details2" value="1" id="option1"> 1
                                            </label>
                                            <label class="btn btn-info">
                                                <input type="radio" name="details2" value="2" id="option2"> 2
                                            </label>
                                            <label class="btn btn-info">
                                                <input type="radio" name="details2" value="3" id="option3"> 3
                                            </label>
                                            <label class="btn btn-info">
                                                <input type="radio" name="details2" value="4" id="option3"> 4
                                            </label>
                                            <label class="btn btn-info">
                                                <input type="radio" name="details2" value="5" id="option3"> 5
                                            </label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th colspan="2" style="text-align: center">Satisfaction/Kaligayahan</th>
                                </tr>                              
                                <tr>
                                    <td>I am satisfied with the results of the project.<br><br>
                                        <i>Ako ay nasisisyahan sa resulta ng proyekto</i>
                                    </td>
                                    <td>
                                        <div class="btn-group" data-toggle="buttons">
                                            <label class="btn btn-info">
                                                <input type="radio" name="satisfaction" value="1" id="option1"> 1
                                            </label>
                                            <label class="btn btn-info">
                                                <input type="radio" name="satisfaction" value="2" id="option2"> 2
                                            </label>
                                            <label class="btn btn-info">
                                                <input type="radio" name="satisfaction" value="3" id="option3"> 3
                                            </label>
                                            <label class="btn btn-info">
                                                <input type="radio" name="satisfaction" value="4" id="option3"> 4
                                            </label>
                                            <label class="btn btn-info">
                                                <input type="radio" name="satisfaction" value="5" id="option3"> 5
                                            </label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th colspan="2" style="text-align: center">Comments, Complaints, Suggestions/Komento, Reklamo, Mungkahi</th>
                                </tr>                              
                                <tr>
                                    <td colspan="2">
                                        <textarea class="wysihtml5 form-control" rows="5" placeholder="" name="comments"></textarea>
                                    </td>
                                </tr>
                            </table>


                        </div>
                        <div class="modal-footer">
                            <button data-dismiss="modal" class="btn btn-default" type="button">Close</button>
                            <input class="btn btn-success" type="submit" value="Submit">
                        </div>
                    </div>
                </div>
            </div>
        </form>

        <div id="testModal" class="modal fade " data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog">

                <div class="modal-content" style="">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">x</span> <span class="sr-only">close</span></button>
                        <h4 id="" class="modal-title">Testimonial Details</h4>
                    </div>
                    <div id="modalBody" class="modal-body" style="overflow-y: auto;">
                        <div id="fDisplay"></div>
                        <fieldset title="Description" id="abcd" class="step" id="default-step-0">
                            <header id="testTitle" class="panel-heading"></header>
                            <header id="testDate" class="panel-heading"></header>
                            <header id="testLoc" class="panel-heading"></header>
                            <header id="testDesc" class="panel-heading"></header>
                        </fieldset>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" id="closeModalB" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <div id="projectFiles" class="modal fade " data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog">

                <div class="modal-content" style="">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">x</span> <span class="sr-only">close</span></button>
                        <h4 id="" class="modal-title">Project File</h4>
                    </div>
                    <div id="modalBody" class="modal-body" style="overflow-y: auto;">
                        <div id="pfDisplay"></div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" id="closeModalB" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

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
        <!--<script src="js/jquery.js"></script>-->
        <script src="js/bootstrap.min.js"></script>
        <script class="include" type="text/javascript" src="js/jquery.dcjqaccordion.2.7.js"></script>
        <script src="js/jquery.scrollTo.min.js"></script>
        <script src="js/slidebars.min.js"></script>
        <script src="js/jquery.nicescroll.js" type="text/javascript"></script>
        <script src="js/respond.min.js" ></script>
        <script src="js/bootstrap.js"></script>
        <!--common script for all pages-->
        <script src="js/common-scripts.js"></script>
    </body>
    <script>
                                                var proj = "<%=p.getId()%>";

//                                                        $(window).scroll(function () {
//                                                            if ($(window).scrollTop() + window.innerHeight === $(document).height()) {
//                                                                checkFeedback();
//                                                            }
//                                                        });


                                                function checkFeedback() {
                                                    $.ajax({
                                                        type: 'POST',
                                                        url: 'Citizen_CheckFeedback',
                                                        dataType: 'json',
                                                        data: {projId: proj},
                                                        cache: false,
                                                        success: function (r) {
                                                            if (r <= 0) {
                                                                $('#myModal').modal();

                                                            } else {

                                                                alert("You have submitted an evaluation already!");

                                                            }



                                                        }
                                                    });

                                                }
    </script>
    <script>
        function getTestimonial(id) {
            $.ajax({
                type: 'POST',
                url: 'AJAX_BAC_gettestimonial',
                dataType: 'json',
                data: {testId: id}, cache: false,
                success: function (f) {
                    $('#fDisplay').empty();
                    var url = f.testimonial.folderName + "/" + f.testimonial.title + "/" + f.fileName;
                    if (f.type === "Video") {
                        $("<div data-p=\"144.50\"><video><source src=\"" + url + "\" type=\"video/mp4\"><source src=" + url + " type=\"video/ogg\"></video></div>").appendTo("#fDisplay");

                    }
                    else if (f.type === "Image") {
                        $("<img src=\"" + url + "\" style=\"max-width: 570px; height:400px;\">").appendTo("#fDisplay");

                    }

                    else if (f.type === "Document") {
                        $("#docH").remove();
                        $("<header id=\"docH\" class=\"panel-heading\">File: " + "<a class=\"panel-heading\" href=\"" + url + "\">" + f.fileName + "</a> </header>").appendTo("#abcd");
                    }
                    $('#testTitle').text("Title: " + f.testimonial.title);
                    $('#testDate').text("Date Uploaded: " + f.testimonial.dateUploaded);
                    $('#testLoc').text("Location Details: " + f.testimonial.location + " + " + f.testimonial.locationdetails);
                    $('#testDesc').text("Description: " + f.testimonial.message);
                    $('#testModal').modal();
                }
            });
        }


        function getProjectFiles(id) {
            $.ajax({
                type: 'POST',
                url: 'AJAX_BAC_getProjectFiles',
                dataType: 'json',
                data: {testId: id}, cache: false,
                success: function (f) {
                    $('#pfDisplay').empty();
                    var url = "<%=p.getFoldername()%>" + "/" +<%=p.getId()%> + "/" + f.fileName;
                    if (f.type === "Video") {
                        $("<div data-p=\"144.50\"><video><source src=\"" + url + "\" type=\"video/mp4\"><source src=" + url + " type=\"video/ogg\"></video></div>").appendTo("#pfDisplay");

                    }
                    else if (f.type === "Image") {
                        $("<img src=\"" + url + "\" style=\"max-width: 570px; height:400px;\">").appendTo("#pfDisplay");

                    }

                    else if (f.type === "Document") {
                        $("#docH").remove();
                        $("<header id=\"docH\" class=\"panel-heading\">File: " + "<a class=\"panel-heading\" href=\"" + url + "\">" + f.fileName + "</a> </header>").appendTo("#pfDisplay");
                    }
                    $('#projectFiles').modal();
                }
            });
        }

    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAI6e73iIoB6fgzlEmgdJBFYO3DX0OhMLw&callback=initMap"async defer></script>
    <script>
        var map;
        var markers = <%=session.getAttribute("location")%>;
        function initMap() {
            map = new google.maps.Map(document.getElementById('map'), {
                center: {lat: 14.45, lng: 120.98},
                zoom: 14
            });

            markers.forEach(function (coor) {
                var geocoder = new google.maps.Geocoder;
                var latLng = new google.maps.LatLng(coor.lats, coor.longs);
                var marker = new google.maps.Marker({
                    position: latLng,
                    map: map
                });

                var infowindow = new google.maps.InfoWindow;

                marker.addListener('click', function () {
                    geocodeLatLng(geocoder, map, infowindow, latLng);
                });
            });

        }

        function geocodeLatLng(geocoder, map, infowindow, latLng) {
            var latlng = latLng;
            geocoder.geocode({'location': latlng}, function (results, status) {
                if (status === google.maps.GeocoderStatus.OK) {
                    if (results[0]) {
                        var marker = new google.maps.Marker({
                            position: latlng,
                            map: map
                        });
                        infowindow.setContent(results[0].formatted_address);
                        infowindow.open(map, marker);
                    } else {
                        window.alert('No results found');
                    }
                } else {
                    window.alert('Geocoder failed due to: ' + status);
                }
            });
        }

    </script>

</html>

