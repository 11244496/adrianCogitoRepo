<%@page import="Entity.Task"%>
<%@page import="Entity.Project"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="Entity.Testimonial"%>
<%@page import="Entity.Schedule"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Entity.Employee"%>
<!DOCTYPE html>
<html lang="en">


    <% Employee e = (Employee) session.getAttribute("user");
        ArrayList<Task> meetings = (ArrayList<Task>) request.getAttribute("meetings");
        ArrayList<Task> pMeetings = (ArrayList<Task>) request.getAttribute("pending");
        int PP = (Integer) request.getAttribute("PP");

        int OP = (Integer) request.getAttribute("OP");

        int FP = (Integer) request.getAttribute("FP");

        int OH = (Integer) request.getAttribute("OH");
    %>


    <head>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="Mosaddek">
        <meta name="keyword" content="FlatLab, Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
        <link rel="shortcut icon" href="img/favicon.png">


        <title>Template</title>

        <!-- Bootstrap core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap-reset.css" rel="stylesheet">
        <!--external css-->
        <link href="assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
        <link rel="stylesheet" type="text/css" href="assets/gritter/css/jquery.gritter.css" />

        <!--right slidebar-->
        <link href="css/slidebars.css" rel="stylesheet">

        <!-- Custom styles for this template -->
        <link href="css/style.css" rel="stylesheet">
        <link href="css/style-responsive.css" rel="stylesheet" />

        <!--dynamic table-->
        <link href="assets/advanced-datatable/media/css/demo_page.css" rel="stylesheet" />
        <link href="assets/advanced-datatable/media/css/demo_table.css" rel="stylesheet" />
        <link rel="stylesheet" href="assets/data-tables/DT_bootstrap.css" />

        <!-- HTML5 shim and Respond.js IE8 support of HTML5 tooltipss and media queries -->
        <!--[if lt IE 9]>
          <script src="js/html5shiv.js"></script>
          <script src="js/respond.min.js"></script>
        <![endif]-->
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
                        <!-- notification dropdown start-->
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
                                <!--
                                SAMPLE CODE FOR NOTIFICATION
            <li>
                <a href="#">
                    <span class="label label-danger"><i class="fa fa-bolt"></i></span>
                    Server #3 overloaded.
                    <span class="small italic">34 mins</span>
                </a>
            </li>

                               ADD THE CODE BELOW IF AT LEAST ONE(?) NOTIFICATION IS LISTED

            <li>
                <a href="#">See all notifications</a>
            </li>
                                -->
                            </ul>
                        </li>
                        <!-- notification dropdown end -->
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
                                <span class="username">Hello <b><u><%out.print(e.getFirstName());%></u></b>!</span>
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
            <!--header end-->
            <!--sidebar start-->
            <aside>
                <div id="sidebar"  class="nav-collapse ">
                    <!-- sidebar menu start-->
                    <ul class="sidebar-menu" id="nav-accordion">
                        <li>
                            <a href="GS_Home" class="active">
                                <i class="fa fa-dashboard"></i>
                                <span>Home</span>
                            </a>
                        </li>

                        <li>
                            <a href="GS_ViewTestimonials">
                                <i class="fa fa-dashboard"></i>
                                <span>View Citizen Testimonials</span>
                            </a>
                        </li>	

                        <!--multi level menu start-->
                        <li class="sub-menu">
                            <a href="javascript:;">
                                <i class="fa fa-tasks"></i>
                                <span>Project Proposals</span>
                            </a>
                            <ul class="sub">
                                <li><a  href="GS_CreateProposal">&nbsp; &nbsp; &nbsp; &nbsp; Create Proposal</a></li>
                                <li><a  href="GS_ViewProjectList">&nbsp; &nbsp; &nbsp; &nbsp; View Project Proposals</a></li>
                                <li><a  href="GS_ViewImplementedProjects">&nbsp; &nbsp; Monitor Implemented Projects</a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="GS_ScheduleChange">
                                <i class="fa fa-dashboard"></i>
                                <span>Schedule Change Requests</span>
                            </a>
                        </li>
                        <!--multi level menu end-->
                        <li>
                            <a href="GS_DisplayCDPCLUP">
                                <i class="fa fa-book"></i>
                                <span>View CLUP and CDP</span>
                            </a>
                        </li>

                        <li>
                            <a href="GS_ViewAR.jsp">
                                <i class="fa fa-book"></i>
                                <span>View Accomplishment Report</span>
                            </a>
                        </li>
                        <li>
                            <a href="GS_NotificationActivity">
                                <i class="fa fa-book"></i>
                                <span>Notification and Activity</span>
                            </a>
                        </li>


                    </ul>
                    <!-- sidebar menu end-->
                </div>
            </aside>
            <!--sidebar end-->
            <!--main content start-->
            <section id="main-content">
                <section class="wrapper site-min-height">
                    <!-- page start-->
                    <section class="panel">
                        <header class="panel-heading">
                            Home
                        </header>
                        <div class="panel-body">



                            <section class="panel">
                                <header class="panel-heading tab-bg-dark-navy-blue">
                                    <ul class="nav nav-tabs nav-justified ">
                                        <li class="active">
                                            <a href="#active" data-toggle="tab">
                                                Unconfirmed Meetings
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#all" data-toggle="tab">
                                                Confirmed Meetings
                                            </a>
                                        </li>

                                    </ul>
                                </header>

                                <div class="panel-body">
                                    <div class="tab-content tasi-tab">

                                        <div class="tab-pane active" id="active">
                                            <div class="form-group">

                                                <div class="directory-info-row">
                                                    <div class="row"> 
                                                        <table class="table">
                                                            <thead>
                                                                <tr>
                                                                    <th>Project</th>
                                                                    <th>Scheduled Date</th>
                                                                    <th>Scheduled Time</th>
                                                                    <th>Remarks</th>
                                                                    <th></th>

                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <% for (int x = 0; x < meetings.size(); x++) {
                                                                        Task t = meetings.get(x);%>
                                                                <tr>
                                                                    <td><%=t.getProject().getName()%></td>
                                                                    <td><%=t.getSchedules().get(0).getStartdate()%></td>
                                                                    <td><%=t.getSchedules().get(0).getTime()%></td>
                                                                    <td><%=t.getSchedules().get(0).getRemarks()%></td>
                                                                    <td>
                                                                        <button data-toggle="modal" class="btn btn-success btn-sm" value="<%=t.getSchedules().get(0).getId()%>" type="button" onclick="approveMeeting(this)">Approve</button>  
                                                                        <button data-toggle="modal" class="btn btn-danger btn-sm" value="<%=t.getSchedules().get(0).getId()%>" type="button" onclick="reschedule(this)">Reschedule</button>  
                                                                        <button data-toggle="modal" class="btn btn-info btn-sm" value="<%=t.getId()%>" type="button" onclick="viewAgenda(this)">View Agenda</button>
                                                                    </td>
                                                                </tr>

                                                                <%}%>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>


                                        <div class="tab-pane" id="all">
                                            <div class="form-group">

                                                <div class="directory-info-row">
                                                    <div class="row"> <table class="table">
                                                            <thead>
                                                                <tr>
                                                                    <th>Project</th>
                                                                    <th>Scheduled Date</th>
                                                                    <th>Scheduled Time</th>
                                                                    <th>Remarks</th>
                                                                    <th></th>

                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <% for (int x = 0; x < pMeetings.size(); x++) {
                                                                        Task t = pMeetings.get(x);%>
                                                                <tr>
                                                                    <td><%=t.getProject().getName()%></td>
                                                                    <td><%=t.getSchedules().get(0).getStartdate()%></td>
                                                                    <td><%=t.getSchedules().get(0).getTime()%></td>
                                                                    <td><%=t.getSchedules().get(0).getRemarks()%></td>
                                                                    <td>
                                                                        <button data-toggle="modal" class="btn btn-success btn-sm" value="<%=t.getSchedules().get(0).getId()%>" type="button" onclick="setToDone(this)">Done</button>  
                                                                        <button data-toggle="modal" class="btn btn-danger btn-sm" value="<%=t.getSchedules().get(0).getId()%>" type="button" onclick="reschedule(this)">Reschedule</button>  
                                                                        <button data-toggle="modal" class="btn btn-info btn-sm" value="<%=t.getId()%>" type="button" onclick="viewAgenda(this)">View Agenda</button>
                                                                    </td>
                                                                </tr>

                                                                <%}%>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </section>
                            <div class="row">
                                <div class="col-lg-12">
                                    <section class="panel">
                                        <div class="panel-body">
                                            <center>
                                                <ul class="summary-list">
                                                    <li>
                                                        <a href="javascript:;">
                                                            <i class=" fa fa-minus"></i>
                                                            <%out.print(PP);%> Pending Projects
                                                        </a>
                                                    </li>
                                                    <li>
                                                        <a href="javascript:;">
                                                            <i class=" fa fa-refresh"></i>
                                                            <%out.print(OP);%> Ongoing Projects
                                                        </a>
                                                    </li>
                                                    <li>
                                                        <a href="javascript:;">
                                                            <i class="fa fa-check-square-o"></i>
                                                            <%out.print(FP);%> Finished Projects
                                                        </a>
                                                    </li>
                                                    <li>
                                                        <a href="javascript:;">
                                                            <i class="fa fa-exclamation"></i>
                                                            <%out.print(OH);%> On-hold Projects
                                                        </a>
                                                    </li>
                                                </ul>
                                            </center>
                                        </div>
                                    </section>
                                </div>
                            </div>


                        </div>
                    </section>


                    <!-- page end-->
                </section>
            </section>
        </section>

        <div class="modal fade" id="displayAgenda" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        <h4 class="modal-title">Agenda</h4>
                    </div>
                    <div class="modal-body panel-body">
                        <div class="col-md-12">
                            <div id="agendaDiv">
                                <br>
                                <table class="table table-bordered table-striped table-condensed" style="background: white; cursor:default; border:0px;"  id="agendaTable">
                                </table>
                            </div>
                        </div>                    
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="rescheduleModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        <h4 class="modal-title" id="adjMheader">Reschedule Meeting</h4>
                        <input type="hidden" id="unconId" name="unconId">
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label class="control-label pull-left regFieldTitle">Set Preferred Date: </label>
                            <input type="date" class="form-control" name="preferredDate" id="preferredDate">
                        </div>
                        <div class="form-group">
                            <label class="control-label pull-left regFieldTitle">Set Preferred Time: </label>
                            <input type="time" class="form-control" name="preferredTime" id="preferredTime">
                        </div>
                        <div class="form-group">
                            <label class="control-label pull-left regFieldTitle">Remarks: </label>
                            <textarea class="form-control" name="remarksSched" id="remarksSched"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <input type="hidden" id="reschedId">
                        <button class="btn btn-success" type="button" onclick="rescheduleMeeting()"> Submit</button>
                        <button class="btn btn-default" type="button" data-dismiss="modal"> Close</button>
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



        <!--footer end-->
        <!-- js placed at the end of the document so the pages load faster -->
        <script src="js/jquery.js"></script>
        <script src="js/jquery-ui-1.9.2.custom.min.js"></script>
        <script src="js/jquery-migrate-1.2.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script class="include" type="text/javascript" src="js/jquery.dcjqaccordion.2.7.js"></script>
        <script src="js/jquery.scrollTo.min.js"></script>
        <script src="js/jquery.nicescroll.js" type="text/javascript"></script>
        <script type="text/javascript" language="javascript" src="assets/advanced-datatable/media/js/jquery.dataTables.js"></script>
        <script type="text/javascript" src="assets/data-tables/DT_bootstrap.js"></script>
        <script src="js/respond.min.js" ></script>

        <!--right slidebar-->
        <script src="js/slidebars.min.js"></script>

        <!--dynamic table initialization -->
        <script src="js/dynamic_table_init.js"></script>


        <!--common script for all pages-->
        <script src="js/common-scripts.js"></script>
        <script>
                            function reschedule(btn) {
                                $('#rescheduleModal').modal();
                                $('#reschedId').val($(btn).val());
                            }

                            function approveMeeting(btn) {
                                $.ajax({
                                    type: 'POST',
                                    url: 'AJAX_UpdateMeeting',
                                    dataType: 'json',
                                    data: {
                                        schedId: $(btn).val(),
                                        action: "approve"
                                    },
                                    success: function () {
                                        alert("Meeting successfully approved");
                                        location.reload();
                                    }
                                });
                            }

                            function setToDone(btn) {
                                $.ajax({
                                    type: 'POST',
                                    url: 'AJAX_UpdateMeeting',
                                    dataType: 'json',
                                    data: {
                                        schedId: $(btn).val(),
                                        action: "settodone"
                                    },
                                    success: function () {
                                        alert("Meeting was held. You can now edit the proposal.");
                                        location.reload();
                                    }
                                });
                            }

                            function rescheduleMeeting() {
                                $.ajax({
                                    type: 'POST',
                                    url: 'AJAX_UpdateMeeting',
                                    dataType: 'json',
                                    data: {
                                        schedId: $('#reschedId').val(),
                                        start: $('#preferredDate').val(),
                                        end: $('#preferredDate').val(),
                                        time: $('#preferredTime').val(),
                                        remarks: $('#remarksSched').val(),
                                        action: "reschedule"
                                    },
                                    success: function () {
                                        alert("Meeting successfully rescheduled. Please wait for confirmation.");
                                        location.reload();
                                    }
                                });
                            }

                            function viewAgenda(btn) {
                                $.ajax({
                                    type: 'POST',
                                    url: 'AJAX_GetAgenda',
                                    dataType: 'json',
                                    data: {taskId: $(btn).val()},
                                    success: function (f) {
                                        $.each(f, function (i) {
                                            var tr = $('<tr></tr>');
                                            var td = $('<td>' + f[i].agenda + '</td>');
                                            tr.append(td);
                                            $('#agendaTable').append(tr);
                                        });
                                        $('#displayAgenda').modal();
                                    }
                                });
                            }
        </script>
    </body>
</html>
