<%-- 
    Document   : GS_EditProposal
    Created on : 03 18, 16, 6:20:01 PM
    Author     : RoAnn
--%>

<%@page import="Entity.Annotation"%>
<%@page import="Entity.Project"%>
<%@page import="Entity.PWorks"%>
<%@page import="Entity.Testimonial"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Entity.Employee"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <%
        Employee e = (Employee) session.getAttribute("user");
        Annotation a = (Annotation) session.getAttribute("annotations");
        Project p = (Project) request.getAttribute("project");
        Testimonial t = (Testimonial) request.getAttribute("testimonial");
    %>

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="Mosaddek">
        <meta name="keyword" content="FlatLab, Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
        <link rel="shortcut icon" href="img/favicon.png">

        <title>Edit Proposal</title>

        <!-- Bootstrap core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/added.css" rel="stylesheet">
        <link href="css/bootstrap-reset.css" rel="stylesheet">
        <!--external css-->
        <link href="assets/font-awesome/css/font-awesome.css" rel="stylesheet" >
        <link href="assets/advanced-datatable/media/css/demo_page.css" rel="stylesheet" />
        <link href="assets/advanced-datatable/media/css/demo_table.css" rel="stylesheet" />
        <link rel="stylesheet" href="assets/data-tables/DT_bootstrap.css" />

        <!--right slidebar-->
        <link href="css/slidebars.css" rel="stylesheet">

        <!-- Custom styles for this template -->
        <link href="css/style.css" rel="stylesheet">
        <link href="css/style-responsive.css" rel="stylesheet" >
        <link rel="stylesheet" type="text/css" href="assets/bootstrap-datepicker/css/datepicker.css" >
        <link rel="stylesheet" type="text/css" href="assets/bootstrap-colorpicker/css/colorpicker.css" >
        <link rel="stylesheet" type="text/css" href="assets/bootstrap-daterangepicker/daterangepicker.css" >
        <link rel="stylesheet" type="text/css" href="css/added.css" >

        <link href = 'calendar/fullcalendar.css' rel='stylesheet'>
        <link href = 'calendar/scheduler.css' rel='stylesheet'>
        <style>
            .uneditable{
                background:white;
                cursor: default;
                border:none;
            }
        </style>
        <script src ='calendar/moment.min.js'></script>
        <script src ='calendar/jquery.min.js'></script>
        <script src ='calendar/fullcalendar.js'></script>
        <script src ='calendar/scheduler.js'></script>
        <script>
            var worksList = <%=request.getAttribute("works")%>;
            var unitList = <%=request.getAttribute("unitGson")%>;
            var allPworks = <%=request.getAttribute("allPworks")%>;
            var markers = <%=request.getAttribute("location")%>;
        </script>

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
                                <li>
                                    <a href="#">See all notifications</a>
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
                                <span class="username">Hello <b><u><%=e.getFirstName()%></u></b>!</span>
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
            <!--sidebar start-->
            <aside>
                <div id="sidebar"  class="nav-collapse ">
                    <!-- sidebar menu start-->
                    <ul class="sidebar-menu" id="nav-accordion">
                        <li>
                            <a href="GS_Home">
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

            <!--main content start-->
            <section id="main-content">
                <section class="wrapper site-min-height">
                    <!-- page start-->
                    <div class="row">
                        <div class="col-lg-12">
                            <section class="panel">
                                <header class="panel-heading">
                                    Project Proposal
                                </header>
                                <div class="panel-body">
                                    <div class="stepy-tab">
                                        <ul id="default-titles" class="stepy-titles clearfix">

                                            <li id="default-title-0" class="current-step">
                                                <div>Details</div>
                                            </li>

                                            <li id="default-title-1" class="">
                                                <div>Program of Works</div>
                                            </li>

                                            <li id="default-title-2" class="">
                                                <div>Schedule</div>
                                            </li>

                                        </ul>
                                    </div>

                                    <form class="form-horizontal" id="proposalForm" method="post" action="GS_SubmitEdit">
                                        <fieldset title="Details" class="step" id="default-step-0" >
                                            <legend></legend>
                                            <div class="form-group">
                                                <center>
                                                    <button class="btn btn-success btn-sm" data-toggle="modal" type="button" value="Details" id="detailsB"><i class="fa fa-plus"></i> Show Comment</button>
                                                </center>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-lg-2 control-label">Testimonial</label>
                                                <div class="col-lg-10">
                                                    <input id="testimonial" type="text" readonly class="form-control uneditable" id="testimonial" name="testimimonial" value="<%=t.getTitle()%>" readonly>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-lg-2 control-label">Project ID</label>
                                                <div class="col-lg-10">
                                                    <input id="projectID" type="text" readonly class="form-control uneditable" id="projectid" name="projectid" value="<%=p.getId()%>" readonly>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="col-lg-2 control-label">Project Name</label>
                                                <div class="col-lg-10">
                                                    <input id="projectname" type="text" class="form-control" name="projectname" value="<%=p.getName()%>">

                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-lg-2 control-label">Project Description</label>
                                                <div class="col-lg-10">
                                                    <textarea id="projectdescription" class="form-control" name="projectdescription" cols="60" rows="5"><%=p.getDescription()%></textarea>
                                                </div>
                                            </div>


                                            <div class="form-group">
                                                <label class="col-sm-2 col-sm-2 control-label">Category</label>
                                                <div class="col-sm-10" id="maincategorydiv">
                                                    <input id="projectID" type="text" readonly class="form-control uneditable" name="category" value="<%=p.getCategory()%>" readonly>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-lg-2 control-label">Location</label>
                                                <div class="col-lg-10">
                                                    <!--Map should be here -->
                                                    <div id="floating-panel">
                                                        <input onclick="removeMarker();" type=button value="Delete Markers">
                                                    </div>
                                                    <div id="map" style="height: 500px; margin: 0; padding: 0; width: 800px"></div>
                                                </div>
                                            </div>

                                        </fieldset>

                                        <fieldset title="Program" class="step" id="default-step-1" >
                                            <legend></legend>
                                            <div class="form-group">
                                                <center>
                                                    <button class="btn btn-success btn-sm" data-toggle="modal" type="button" value="Details" id="pworksB"><i class="fa fa-plus"></i> Show Comment</button>
                                                </center>
                                            </div>

                                            <div class="col-md-12">
                                                <div class="col-md-3">
                                                    <header class="panel-heading no-border">
                                                        Works
                                                    </header>

                                                    <table class="table table-bordered table-striped table-condensed" id="powTable">
                                                        <thead>
                                                            <tr>
                                                                <th>Works</th>
                                                                <th style="width: 20px"></th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                        </tbody> 
                                                    </table>

                                                    <button class="btn btn-success btn-sm pull-right" style="margin-right: 5px" onclick="addRowForWorks()" type="button"><i class="fa fa-plus"></i> Add </button>

                                                </div>


                                                <div class="col-md-9" id="compMain">

                                                </div>
                                            </div>
                                        </fieldset>

                                        <fieldset title="Schedule" class="step" id="default-step-2" >
                                            <legend></legend>
                                            <div class="form-group">
                                                <center>
                                                    <button class="btn btn-success btn-sm" data-toggle="modal" type="button" value="Details" id="scheduleB"><i class="fa fa-plus"></i> Show Comment</button>
                                                </center>
                                            </div>

                                            <header class="panel-heading no-border">
                                                Schedule
                                            </header>

                                            <div class="col-md-12">
                                                <div class="col-md-3">
                                                    <table class="table table-bordered table-striped table-condensed" id="taskTable">
                                                        <thead>
                                                            <tr>
                                                                <th>Task/s</th>
                                                                <!--<th></th>-->
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                        </tbody>
                                                    </table>
                                                    <input type="hidden" name="pworks" id="pworks">
                                                    <!--<button class="btn btn-success btn-sm pull-right" style="margin-right: 5px" type="button"><i class="fa fa-plus"></i> Add </button>-->

                                                    <br>
                                                </div>
                                                <div class="col-md-9">
                                                    <div id="ganttDiv"></div>
                                                </div>
                                            </div>
                                        </fieldset>
                                        <input type="hidden" name="hiddenlocation" id="location" value="">
                                        <input type="hidden" name="actionI" id="actionI">
                                            <input type="hidden" name="annotationsid" value="<%=a.getId()%>">
                                            <input type="hidden" name="projid" value="<%=p.getId()%>">
                                            <button type="submit" class="finish btn btn-success">Finish</button>
                                        <input type="hidden" name="schedule" id="schedule">
                                    </form>
                                </div>
                            </section>
                        </div>
                    </div>

                    <!-- page end-->
                </section>

                <!--Modal for Upload Files-->
                <div class="modal fade modal-dialog-center " id="fileUpload" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog ">
                        <div class="modal-content-wrap">
                            <form name="uploadFiles" action="GS_UploadFile" method="POST" enctype="multipart/form-data">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h4 class="modal-title">Upload Proposal Files</h4>
                                    </div>
                                    <div class="modal-body">

                                        <div class="panel-body">

                                            <input type="hidden" id="UploadFileID" name="ProjectID" value="">
                                            <input type="file" name="uploadFile" multiple>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button data-dismiss="modal" class="btn btn-default" type="button">Cancel</button>
                                        <button id="SubmitUpload" class="btn btn-success" type="submit"> Upload</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="modal fade" id="schedModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-sm">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                <h4 class="modal-title">Add Schedule</h4>
                            </div>
                            <div class="modal-body panel-body" id="scheduleDetails">
                                <div class="col-md-12 form-group">
                                    <div class="col-md-3">
                                        <label class="control-label pull-left">Task </label>
                                    </div>
                                    <div class="col-md-9">
                                        <input type="text" class="form-control" id="taskNameMod" readonly style="background: white; border:none; cursor: default">
                                    </div>
                                </div>
                                <div class="col-md-12 form-group">
                                    <div class="col-md-3">
                                        <label class="control-label pull-left ">Start Date: </label>                                    
                                    </div>    
                                    <div class="col-md-9">
                                        <input type="date" class="form-control" id="startDate">
                                    </div>    
                                </div>
                                <div class="col-md-12 ">
                                    <div class="col-md-3">
                                        <label class="control-label pull-left">End Date:</label>
                                    </div>
                                    <div class="col-md-9">
                                        <input type="date" class="form-control" id="endDate">
                                    </div>
                                </div>
                                <br>
                                <button class="btn btn-success pull-right btn-sm"  data-dismiss="modal" id="addDate" onclick="addScheduleToArray()">Add Date</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal fade full-width-modal-right" id="addComments" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                    <div class="modal-dialog modal-sm">
                        <div class="modal-content-wrap">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                                    <h4 class="modal-title" id="comHead">Title</h4>
                                </div>
                                <div class="modal-body">
                                    <label class="panel-heading">Comments:</label>
                                    <textarea rows="10" style="background: white; cursor:default; border:0px;" class="wysihtml5 form-control" id="detailsTA" readonly name="detailsTA"><%=a.getDetails()%></textarea>
                                    <textarea rows="10" style="background: white; border:0px; cursor:default;" class="wysihtml5 form-control" id="pworksTA" readonly name="pworksTA"><%=a.getPworks()%></textarea>
                                    <textarea rows="10" style="background: white; border:0px; cursor:default;" class="wysihtml5 form-control" id="scheduleTA" readonly name="scheduleTA"><%=a.getSchedule()%></textarea>
                                </div>
                                <div class="modal-footer">
                                    <button class="btn btn-default" data-dismiss="modal" type="button">Close</button>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

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

            </section>
            <!--main content end-->

        </section>

        <!-- js placed at the end of the document so the pages load faster -->
        <script src="js/jquery.js"></script>
        <script src="js/edit_proposal.js" type="text/javascript"></script>

        <script src="js/bootstrap.min.js"></script>
        <script class="include" type="text/javascript" src="js/jquery.dcjqaccordion.2.7.js"></script>
        <script src="js/jquery.scrollTo.min.js"></script>
        <script src="js/jquery.nicescroll.js" type="text/javascript"></script>
        <script src="js/respond.min.js" ></script>

        <!-- js placed at the end of the document so the pages load faster -->
        <script src="js/jquery-ui-1.9.2.custom.min.js"></script>
        <script src="js/jquery-migrate-1.2.1.min.js"></script>
        <script type="text/javascript" src="assets/data-tables/jquery.dataTables.js"></script>
        <script type="text/javascript" src="assets/data-tables/DT_bootstrap.js"></script>

        <!--right slidebar-->
        <script src="js/slidebars.min.js"></script>


        <!--Form Validation-->
        <script src="js/bootstrap-validator.min.js" type="text/javascript"></script>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAI6e73iIoB6fgzlEmgdJBFYO3DX0OhMLw&callback=initMap"
        async defer></script> 

        <!--Form Wizard-->
        <script src="js/jquery.steps.min.js" type="text/javascript"></script>
        <script src="js/jquery.validate.min.js" type="text/javascript"></script>

        <script type="text/javascript" src="assets/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
        <script type="text/javascript" src="assets/bootstrap-daterangepicker/date.js"></script>
        <script type="text/javascript" src="assets/bootstrap-daterangepicker/daterangepicker.js"></script>
        <!--common script for all pages-->
        <script src="js/common-scripts.js"></script>
        <!--script for this page-->
        <script src="js/jquery.stepy.js"></script>
        <!--script for this page only-->
        <script src="js/dynamic_table_init.js"></script>
        <script src="js/GS_CreateProposal.js"></script>
        <!--        <script src="amcharts/amcharts.js" type="text/javascript"></script>
                <script src="amcharts/serial.js" type="text/javascript"></script>
                <script src="amcharts/themes/dark.js"></script>
                <script src="amcharts/gantt.js" type="text/javascript"></script>-->
        <script>
                                    $('#detailsB').click(function () {
                                        $('#comHead').text("Project Details");
                                        $('#detailsTA').show();
                                        $('#pworksTA').hide();
                                        $('#scheduleTA').hide();

                                        $('#addComments').modal();
                                    });

                                    $('#pworksB').click(function () {
                                        $('#comHead').text("Program of Works");
                                        $('#detailsTA').hide();
                                        $('#pworksTA').show();
                                        $('#scheduleTA').hide();
                                        $('#addComments').modal();
                                    });

                                    $('#scheduleB').click(function () {
                                        $('#comHead').text("Schedule");
                                        $('#detailsTA').hide();
                                        $('#pworksTA').hide();
                                        $('#scheduleTA').show();
                                        $('#addComments').modal();
                                    });
        </script>

    </body>
</html>
