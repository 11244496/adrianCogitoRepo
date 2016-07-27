<%@page import="java.util.Locale"%>
<%@page import="Entity.Project_Inspection"%>
<%@page import="Entity.Project_Progress"%>
<%@page import="Entity.Employee"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="Entity.Task"%>
<%@page import="java.text.DecimalFormat"%>

<%@page import="Entity.Testimonial"%>
<%@page import="Entity.Location"%>
<%@page import="Entity.Files"%>
<%@page import="Entity.Schedule"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Entity.Project"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%Project p = (Project) session.getAttribute("project");%>

<%//Employee e = (Employee) session.getAttribute("user");%>


<%ArrayList<Files> pfiles = (ArrayList<Files>) session.getAttribute("pFiles");%>
<!DOCTYPE html>

<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="Mosaddek">
        <meta name="keyword" content="FlatLab, Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
        <link rel="shortcut icon" href="img/favicon.png">

        <title>View Project</title>

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

        <style type="text/css">
            .tg  {border-collapse:collapse;border-spacing:0; margin-left: 2cm;}
            .tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 20px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
            .tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 20px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
            .tg .tg-s6z2{text-align:center}
            .tg .tg-baqh{text-align:center;vertical-align:top}
            .tg .tg-yw4l{vertical-align:top}
        </style>  



        <style>
            .editablelegend {color:#00ffaa;}
            .uneditablelegend {color:#ff6666;}
        </style>
        <!--<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>-->
    </head>
    <body>

        <section id="container" class="">
            <!--header start-->
            <header class="header green-bg">
                <div class="sidebar-toggle-box">
                    <div data-original-title="Toggle Navigation" data-placement="right" class="fa fa-bars tooltips"></div>
                </div>
                <!--logo start-->
                <a href="index.html" class="logo" >COGITO<span></span></a>
                <!--logo end-->
                <div class="nav notify-row" id="top_menu">
                    <!--  notification start -->
                    <ul class="nav top-menu">
                        <!-- settings start -->
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
                                <!--REFER TO RIGHT SIDEBAR FOR SAMPLE CODE OF TASK + PROGRESS BAR
      
                          ADD THE CODE BELOW IF AT LEAST ONE(?) TASK IS LISTED
                          
                          <li class="external">
          <a href="#">See All Tasks</a>
      </li>
                          
                                -->
                            </ul>
                        </li>
                        <!-- settings end -->
                        <!-- inbox dropdown start-->
                        <li id="header_inbox_bar" class="dropdown">
                            <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                                <i class="fa fa-envelope-o"></i>
                                <span class="badge bg-important"><!--NUMBER OF MESSAGES UNREAD--></span>
                            </a>
                            <ul class="dropdown-menu extended inbox">
                                <div class="notify-arrow notify-arrow-red"></div>
                                <li>
                                    <p class="red">You have __ new messages</p>
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
                                    <p class="yellow">You have XX notifications</p>
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
                        <!-- user login dropdown start-->
                        <li class="dropdown">
                            <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                                <img alt="" src="img/avatar1_small.jpg">
                                <span class="username">Hello <b><u></u></b>!</span>
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

                        <!-- user login dropdown end -->
                        <li class="sb-toggle-right">
                            <i class="fa  fa-align-right"></i>
                        </li>
                    </ul>
                </div>
            </header>
            <!--header end-->

            <section id="main-content">
                
                
                
                <section class="wrapper site-min-height">
                    <!-- page start-->
                    <section class="panel">

                        <header class="panel-heading">
                            <h3>Accomplishment Report</h3>

                            <span class="pull-right">
                            </span>
                        </header>
                    </section>

                    <div class="row">

                        <div class="col-md-12">
                            <section class="panel">
                                <div class="bio-graph-heading project-heading">
                                    <strong>Project Name </strong>
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
                                                    
                                                    <%--
                                                    <%if (p.getBudget() != 0) {%>

                                                    <div>
                                                        <p><span class="bold">Budget</span> :</p>
                                                        <p>PHP <%=df.format(p.getBudget())%></p>
                                                    </div><br>
                                                    <%}%>
                                                    
                                                    --%>
                                                    
                                                    <div>
                                                        <p><span class="bold">Additional Files:</span> :</p>
                                                        <p>FILE.doc</p>
                                                    </div>

                                                    <br>  

                                                    <p><span class="bold">Project Progress:</span> :</p>

                                                    

                                                    <div class="progress progress-striped active ">
                                                        <div style="" class="progress-bar progress-bar-success"></div>
                                                    </div>
                                                    <small>Current Status: <%=p.getStatus()%></small>



                                                </div>
                                            </section>
                                        </div>

                                        <!------------------------------------------------------LOCATION------------------------------------------>

                                        <div class="col-lg-6">
                                            <section class="panel">
                                                <div class="panel-body">                            
                                                    <div><p><span class="bold">Location: (Insert map here)</span> :</p></div>
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
                            <div class="row">

                                <!------------------------------------------------------MATERIALS------------------------------------------>

                                <section class="panel">

                                    <div class="col-lg-12">
                                        <div class="bio-graph-heading project-heading">
                                            <strong>Program Works</strong>
                                        </div>

                                        <section class="panel">
                                            <div class="panel-body">
                                                <table class="table" style="width:100%; text-align: center">
                                                    <tr>
                                                        <th><center>Item Description</center></th>
                                                    <th><center>% of Total</center></th>
                                                    <th><center>Quantity</center></th>
                                                    <th><center>Unit</center></th>
                                                    <th><center>Unit Price</center></th>
                                                    <th><center>Total</center></th>
                                                    </tr>
                                                    
                                                    <tr>
                                                        <td>Name</td>
                                                        <td>Percentage</td>
                                                        <td>Quantity</td>
                                                        <td>Unit</td>
                                                        <td>Unit price</td>
                                                        <td>Total</td>
                                                    </tr>
                                                    
                                                    <tr>
                                                        <td>Total cost: </td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td>PHP cost</td>
                                                    </tr>

                                                    <tr>
                                                        <td colspan="5">Indirect Cost 17% of Total Cost: </td>
                                                        <td>PHP cost</td>
                                                    </tr>

                                                    <tr>
                                                        <td colspan="5">Tax 5% of Total Cost + Indirect Cost: </td>
                                                        <td>PHP cost</td>
                                                    </tr>

                                                    <tr>
                                                        <td colspan="5">Estimated cost: </td>
                                                        <td>PHP cost</td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </section>
                                    </div>
                                </section>                                                 
                            </div>

                            <!------------------------------------------------------SCHEDULE------------------------------------------>


                            <section class="panel">
                                <div class="bio-graph-heading project-heading">
                                    <strong>Timeline</strong>
                                </div>
                                <div class="panel-body bio-graph-info">
                                    <div id='calendar' style="height: 100%; width: 100%"></div>
                                    <br>
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    

                                </div>

                                
                                <br>             



                                <div class="modal fade" id="AddRemarks" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>
                                                <h4 class="modal-title">Add Remarks</h4>
                                            </div>
                                            <div class="modal-body">



                                            </div>
                                            <div class="modal-footer">
                                                <button data-dismiss="modal" class="btn btn-default" type="button">Close</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </section>
                            <input type="hidden" id="projId" value="" name="projId">
                            
                            
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
                                            <%
                                                
                                            Date convertedCurrentDate1;
                                            Date convertedCurrentDate2;
                                            
                                             for(int x = 0; x < completedDatesReport.size();x++){
                                                
                                                
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
                                                <td><%=completedDatesReport.get(x).getTask().getDescription()%></td>
                                                <td><%=completedDatesReport.get(x).getStartdate()%></td>
                                                <td><%=completedDatesReport.get(x).getEnddate()%></td>
                                                <td><%=completedDatesReport.get(x).getActualenddate()%></td>
                                                <%
                                                if(convertedCurrentDate1.after(convertedCurrentDate2)){
                                                %>
                                                <td>
                                                    <font color="blue"> Ahead <%out.print(diffDays + " days");%></font>
                                                </td>
                                                <%
                                                }

                                                if(convertedCurrentDate1.equals(convertedCurrentDate2)){
                                                %>
                                                <td>
                                                    <font color="green"> On-time </font>
                                                </td>
                                                <%
                                                }
                                                if(convertedCurrentDate1.before(convertedCurrentDate2)){
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
                            
                            
                            
                            
                            
                            <!------------------------------------------------------UPLOADS------------------------------------------>
                            <section class="panel">
                                <div class="bio-graph-heading project-heading">
                                    <strong>Citizen Testimonials</strong>
                                </div>
                                <div class="panel-body bio-graph-info" style="height: 250px;">
                                    <div class="DocumentList2">
                                        
                                    </div>
                                </div>
                            </section>

                            <!------------------------------------------------------GS UPLOADS------------------------------------------>
                            <section class="panel">
                                <div class="bio-graph-heading project-heading">
                                    <strong>Project Proposals</strong>
                                </div>
                                <div class="panel-body bio-graph-info" style="height: 250px;">
                                    <div class="DocumentList2">
                                        
                                    </div>
                                </div>
                            </section>

                            <section class="panel">
                                <div class="row">

                                    <div class="col-md-12">
                                        



                                    </div>   


                                </div>


                                <!-- page end-->
                            </section>             

                            
                            
                            
                            

                            <section class="panel">				
                                <div class="panel-body">

                                    <label>Progress Report</label>      


                                </div>



                                <div class="panel-body"  style="overflow: scroll;">

                                    Progress report
                                </div>




                                <!-- page end-->
                            </section>           












                        </div>

                    </div>

                    <!-- page end-->
                </section>

            </section>


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


            <div class="sb-slidebar sb-right sb-style-overlay">
                <h5 class="side-title"> Pending Tasks</h5>
            </div>

        </section>



        

        <!-- js placed at the end of the document so the pages load faster -->
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

</html>