<%-- 
    Document   : GS_CreateProposal
    Created on : 09 2, 15, 8:57:31 AM
    Author     : User
--%>

<%@page import="Entity.Testimonial"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Entity.Employee"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <% Employee e = (Employee) session.getAttribute("user");
        ArrayList<Testimonial> allTestimonials = (ArrayList<Testimonial>) request.getAttribute("allTestimonials");
    %>

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="Mosaddek">
        <meta name="keyword" content="FlatLab, Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
        <link rel="shortcut icon" href="img/favicon.png">

        <title>Create Proposal</title>

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
        <script src ='calendar/moment.min.js'></script>
        <script src ='calendar/jquery.min.js'></script>
        <script src ='calendar/fullcalendar.js'></script>
        <script src ='calendar/scheduler.js'></script>

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

                        <!-- inbox dropdown end -->
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
                            <a href="javascript:;"  class="active">
                                <i class="fa fa-tasks"></i>
                                <span>Project Proposals</span>
                            </a>
                            <ul class="sub">
                                <li><a  href="GS_CreateProposal"  class="active">&nbsp; &nbsp; &nbsp; &nbsp; Create Proposal</a></li>
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
                                                <div>Testimonial</div>
                                            </li>
                                            <li id="default-title-1" class="">
                                                <div>Project</div>
                                            </li>
                                            <li id="default-title-2" class="">
                                                <div>Details</div>
                                            </li>

                                            <li id="default-title-3" class="">
                                                <div>Program of Works</div>
                                            </li>

                                            <li id="default-title-4" class="">
                                                <div>Overview</div>
                                            </li>

                                        </ul>
                                    </div>

                                    <form class="form-horizontal" id="proposalForm" method="post" action="javascript:submitProposal()">

                                        <fieldset title="Testimonial" class="step" id="default-step-0">
                                            <legend></legend>

                                            <div class="col-md-12" id="Tview">                                                    
                                                <section class="panel">
                                                    <header class="panel-heading">
                                                        Select testimonials
                                                    </header>
                                                    <div>
                                                        <input size="50" type="text" placeholder="Type to search" id="Tview-testimonial">
                                                    </div>
                                                    <div id="TestimonialList">
                                                        <table id="TestimonialTable" class="table table-hover" id="mainTest" data-search-field="#Tview-testimonial">
                                                            <thead>
                                                                <tr>
                                                                    <th class="title">Title</th>
                                                                    <th class="message">Description/Message</th>
                                                                    <th class="date">Date Uploaded</th>
                                                                    <th class="uploader">Uploader</th>
                                                                    <th class="buttons"></th>
                                                                </tr>
                                                            </thead>



                                                            <tbody id="TestimonialTableBody">
                                                                <%for (int x = 0; x < allTestimonials.size(); x++) {%>

                                                                <tr>
                                                                    <td><%=allTestimonials.get(x).getTitle()%></td>
                                                                    <td><%=allTestimonials.get(x).getMessage()%></td>
                                                                    <td class="date"><%=allTestimonials.get(x).getDateUploaded()%></td>
                                                                    <td><%=allTestimonials.get(x).getCitizen().getUser().getUsername()%></td>
                                                                    <td>
                                                                        <p> <button id="viewDetails" type="button" class="btn btn-info btn-sm viewbutton" value="<%=allTestimonials.get(x).getId()%>"> View details</button></p>

                                                                        <%if (allTestimonials.get(x).getMainproject().getId() == null) {%>
                                                                        <p> <button type="button" class="btn btn-success btn-sm selectmainbtn" value="<%=allTestimonials.get(x).getId()%>">  Select as main</button> </p>
                                                                        <%}%>

                                                                        <p> <button type="button" class="btn btn-warning btn-sm selectreferencebtn" value="<%=allTestimonials.get(x).getId()%>"> Use as reference</button> </p>
                                                                    </td>
                                                                </tr>
                                                                <%}%>
                                                            </tbody>


                                                        </table>
                                                    </div>
                                                </section>

                                                <script>
                                                    $('.viewbutton').click(function () {
                                                        $.ajax({
                                                            type: 'post',
                                                            url: 'AJAX_GS_ViewTestimonialDetails',
                                                            dataType: 'json',
                                                            data:
                                                                    {
                                                                        testimonialID: $(this).val()
                                                                    },
                                                            cache: false,
                                                            success: function (data) {

                                                                $('#tVideoDisplay').empty();
                                                                $('#tImageDisplay').empty();
                                                                $('#tDocumentUploads').empty();

                                                                $('#testTitle').text("Title: " + data.title);
                                                                $('#testDate').text("Date Uploaded: " + data.dateUploaded);
                                                                $('#testCategory').text("Category: " + data.category);
                                                                $('#testMessage').text("Message: " + data.message);

                                                                $.each(data.files, function (i) {
                                                                    var url = data.folderName + data.title + "/" + data.files[i].fileName;

                                                                    if (data.files[i].type === "Video") {
                                                                        $("<video width='100%' height='100%' controls><source src=\"" + url + "\" type='video/mp4'></video>").appendTo("#tVideoDisplay");
                                                                    }
                                                                    else if (data.files[i].type === "Image") {
                                                                        $("<img src=\"" + url + "\" style=\"max-width: 570px; height:400px;\">").appendTo("#tImageDisplay");
                                                                    }

                                                                    else if (data.files[i].type === "Document") {
                                                                        $("<header id=\"docH\" class=\"panel-heading\">File: " + "<a class=\"panel-heading\" href=\"" + url + "\">" + data.files[i].fileName + "</a> </header>").appendTo("#tDocumentUploads");
                                                                    }
                                                                });
                                                            }
                                                        });
                                                        //Ajax Call here and change modal fields

                                                        $('#viewdetails').modal();

                                                    });
                                                </script>

                                                <div class="modal fade" id="viewdetails" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog modal-lg">
                                                        <div class="modal-content" style="">
                                                            <div class="modal-header">
                                                                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">x</span> <span class="sr-only">close</span></button>
                                                                <h4 id="" class="modal-title">Testimonial Details</h4>
                                                            </div>
                                                            <div id="modalBody" class="modal-body" style="overflow-y: auto;">
                                                                <fieldset title="Description" id="abcd" class="step" id="default-step-0">
                                                                    <header id="testTitle" class="panel-heading"></header>
                                                                    <header id="testDate" class="panel-heading"></header>
                                                                    <header id="testCategory" class="panel-heading"></header>
                                                                    <header id="testMessage" class="panel-heading"></header>
                                                                    <div id="tLocation"></div>
                                                                    <div id="tVideoDisplay"></div>
                                                                    <div id="tImageDisplay"></div>
                                                                    <div id="tDocumentUploads"></div>


                                                                </fieldset>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-default" id="closeModalB" data-dismiss="modal">Close</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>


                                            <div class="col-md-12" style="display: none;" id="MainTestimonial">

                                                <header class="panel-heading" style="background: #99ffd6; font-size: 13px; text-align: center;">
                                                    <label id="TestiTitle"></label>
                                                </header>

                                                <center>
                                                    <button type="button" class="btn btn-danger btn-sm deselectmainbtn"><i class="fa fa-times"></i> Remove as main testimonial</button>
                                                </center>

                                                <br>

                                            </div>

                                            <div class="col-md-12" style="display: none" id="ReferenceTestimonialList">
                                                <section class="panel">
                                                    <header class="panel-heading">
                                                        Referenced testimonials
                                                    </header>
                                                    <div id="RTestimonialList">
                                                        <table id="RTestimonialTable" class="table table-hover" id="mainTest" data-search-field="#TRview-testimonial">
                                                            <thead>
                                                                <tr>
                                                                    <th class="title">Title</th>
                                                                    <th class="message">Description/Message</th>
                                                                    <th class="date">Date Uploaded</th>
                                                                    <th class="uploader">Uploader</th>
                                                                    <th class="buttons"></th>
                                                                </tr>
                                                            </thead>



                                                            <tbody id="RTestimonialTableBody">

                                                            </tbody>


                                                        </table>
                                                    </div>
                                                </section>

                                            </div>


                                            <script>
                                                var mainTestimonial = [];
                                                var referencedTestimonial = [];
                                                var detachedMainRow;
                                                var tablerow;
                                                var Testimonialmarkers = [];


                                                //Select Testimonial from Testimonial List as Main Testimonial and append labels.
                                                $('.selectmainbtn').click(function () {
                                                    detachedMainRow = $(this).closest('tr').detach();

                                                    var testimonial = {id: $(this).val()};
                                                    mainTestimonial.push(testimonial);

                                                    $.ajax({
                                                        type: 'post',
                                                        url: 'AJAX_GS_SelectMainTestimonial',
                                                        dataType: 'json',
                                                        data: {mainTestimonial: JSON.stringify(mainTestimonial)},
                                                        cache: false,
                                                        success: function (data) {
                                                            //Place the object in the Main Testimonial Div
                                                            $("#TestiTitle").text("You have selected " + data[0].title + " as your main testimonial");

                                                            //Set Testimonial Locaiton on map markers
                                                            $.each(data[0].tlocation, function (i) {
                                                                Testimonialmarkers.push(data[0].tlocation[i]);
                                                            });
                                                            initMap();


                                                            $("#MainTestimonial").show();
                                                            $('.selectmainbtn').hide();
                                                        }
                                                    });
                                                });

                                                //Remove the Selected Main Testimonial, detach and put back to testimonial list
                                                $('.deselectmainbtn').click(function () {
                                                    mainTestimonial.length = 0;
                                                    $("#TestimonialTableBody").append(detachedMainRow);
                                                    $('.selectmainbtn').show();
                                                    $("#MainTestimonial").hide();

                                                    //Map Functions
                                                    Testimonialmarkers.length = 0;
                                                    allPosition.length = 0;
                                                    document.getElementById("location").value = allPosition;
                                                    initMap();

                                                });

                                                //Transfer from Testi List to Referenced Table List via detach
                                                $(document).on('click', '.selectreferencebtn', function () {

                                                    $("#ReferenceTestimonialList").show();

                                                    var Rtestimonial = {id: $(this).val()};
                                                    referencedTestimonial.push(Rtestimonial);
                                                    var Rt = $(this).closest('tr').detach();
                                                    $("#RTestimonialTableBody").append(Rt);
                                                    $(this).removeClass('btn btn-warning btn-sm selectreferencebtn').addClass('btn btn-danger btn-sm unselectreferencebtn');
                                                    $(this).text("Remove");
                                                });

                                                //Transfer from Referenced Table back to Testi list
                                                $(document).on('click', '.unselectreferencebtn', function () {
                                                    for (var x = 0; x < referencedTestimonial.length; x++) {
                                                        if (referencedTestimonial[x].id == $(this).val()) {
                                                            referencedTestimonial.splice(x, 1);
                                                        }
                                                    }

                                                    if (referencedTestimonial.length == 0) {
                                                        $("#ReferenceTestimonialList").hide();
                                                    }

                                                    var detached = $(this).closest('tr').detach();
                                                    $("#TestimonialTableBody").append(detached);
                                                    $(this).removeClass('btn btn-danger btn-sm unselectreferencebtn').addClass('btn btn-warning btn-sm selectreferencebtn');
                                                    $(this).text("Use as reference");
                                                });

                                            </script>

                                            <br>
                                            <br><br><br><br>
                                        </fieldset> 




                                        <fieldset title="Project" class="step" id="default-step-1" >
                                            <legend> </legend>

                                            <div class="adv-table" id="projectTable">
                                                <table  class="display table table-bordered table-striped" id="dynamic-table">
                                                    <thead>
                                                        <tr>
                                                            <th>Title</th>
                                                            <th>Date Sent</th>
                                                            <th>Message/Description</th>
                                                            <th>Uploader</th>
                                                            <th></th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr class="gradeX">
                                                            <td class="title">Ro</td>
                                                            <td class="date">Jan 14, 2016</td>
                                                            <td class="message">Maecenas in tincidunt ante. Vestibulum pellentesque dignissim eros, id pellentesque libero egestas sed. Cras eu augue nunc. Donec dictum justo a metus hendrerit pellentesque. Curabitur finibus dolor sit amet eleifend tempor. Suspendisse dignissim molestie dolor non mollis</td>
                                                            <td class="uploader">rochellesisa@yahoo.com.ph</td>
                                                            <td class="buttons center">
                                                                <p>
                                                                    <button type="button" class="btn btn-info btn-sm"><i class="fa fa-eye"></i> View Details</button>
                                                                </p>
                                                                <p>
                                                                <div class="btn-group dropdown">
                                                                    <button data-toggle="dropdown" class="btn btn-success btn-sm dropdown-toggle" type="button"><i class="fa fa-plus"></i> Add as... <span class="caret"></span></button>
                                                                    <ul role="menu" class="dropdown-menu">
                                                                        <li><a href="#">Main testimonial</a></li>
                                                                        <li><a href="#">Reference</a></li>
                                                                    </ul>
                                                                </div>
                                                                </p>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <br>
                                            <br><br><br><br>

                                        </fieldset>


                                        <fieldset title="Details" class="step" id="default-step-2" >
                                            <legend></legend>
                                            <div class="form-group">
                                                <label class="col-lg-2 control-label">Project ID</label>
                                                <div class="col-lg-10">
                                                    <input id="projectID" type="text" class="form-control" name="projectid" readonly>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="col-lg-2 control-label">Project Name</label>
                                                <div class="col-lg-10">
                                                    <input id="projectname" type="text" class="form-control" name="projectname" value="" placeholder="Enter project name">

                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-lg-2 control-label">Project Description</label>
                                                <div class="col-lg-10">
                                                    <textarea id="projectdescription" class="form-control" name="projectdescription" cols="60" rows="5"></textarea>
                                                </div>
                                            </div>


                                            <div class="form-group">
                                                <label class="col-sm-2 col-sm-2 control-label">Category</label>
                                                <div class="col-sm-10" id="maincategorydiv">
                                                    <select name="category" id="maincategory">
                                                        <option value="">Select Category</option>
                                                        <option value="Vertical">Vertical</option>
                                                        <option value="Horizontal">Horizontal</option>
                                                        <option value="Maintenance">Maintenance</option>
                                                    </select>
                                                </div>

                                            </div>


                                            <div class="form-group">
                                                <label class="col-sm-2 col-sm-2 control-label">Sub-Category</label>
                                                <div class="col-sm-10" id="subcategorydiv">

                                                    <select name="subcategory" id="subcategory">
                                                        <option value="">Select Category</option>
                                                    </select>

                                                    <input id="OtherSub" type="text" name="OtherSubCategory" placeholder="Input New Sub Category" style="display: none; width: 200px">

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

                                            <div class="form-group">
                                                <label class="col-sm-2 control-label">Target Implementation Date</label>
                                                <div class="col-md-3 col-xs-11">
                                                    <input class="form-control form-control-inline input-medium default-date-picker" name="targetimplementationdate" size="16" type="date" id="targetimplementationdate">
                                                    <span class="help-block">Select date</span>
                                                </div>
                                            </div>
                                        </fieldset>

                                        <fieldset title="Program" class="step" id="default-step-3" >
                                            <legend></legend>

                                            <div class="col-md-12">
                                                <div class="col-md-3">
                                                    <header class="panel-heading no-border">
                                                        Works
                                                    </header>

                                                    <table class="table table-bordered table-striped table-condensed" id="powTable">
                                                        <thead>
                                                            <tr>
                                                                <th>#</th>
                                                                <th>Works</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr>
                                                                <td>1</td>
                                                                <td>
                                                                    <button class="btn btn-white viewMaterials">Demolition Works <i class="fa fa-caret-right pull-right"></i></button>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>2</td>
                                                                <td>
                                                                    <button class="btn btn-white viewMaterials">Earthworks <i class="fa fa-caret-right pull-right"></i></button>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>3</td>
                                                                <td>
                                                                    <button class="btn btn-white viewMaterials">Concrete Works <i class="fa fa-caret-right pull-right"></i></button>
                                                                </td>
                                                            </tr>
                                                        </tbody>                                                
                                                    </table>
                                                    <button class="btn btn-danger btn-sm pull-right"><i class="fa fa-times"></i> Delete </button>
                                                    <button class="btn btn-success btn-sm pull-right" style="margin-right: 5px"><i class="fa fa-plus"></i> Add </button>

                                                </div>


                                                <div class="col-md-9">
                                                    <header class="panel-heading no-border">
                                                        Components - Demolition Works
                                                    </header>
                                                    <table class="table table-bordered table-striped table-condensed">
                                                        <thead>
                                                            <tr>
                                                                <th style="width: 40%">Component</th>
                                                                <th>Qty/Area</th>
                                                                <th>Unit</th>
                                                                <th>Unit Cost</th>
                                                                <th>Amount</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr>
                                                                <td>Dismantling of Existing Roof & Gates (Deep Well Structure</td>
                                                                <td>1</td>
                                                                <td>lot</td>
                                                                <td>15,000.50</td>
                                                                <td>15,000.50</td>
                                                            </tr>
                                                            <tr>
                                                                <td>Concrete Cutting</td>
                                                                <td>84</td>
                                                                <td>meters</td>
                                                                <td>1,500.00</td>
                                                                <td>126,000.00</td>
                                                            </tr>
                                                            <tr id="totalTR">
                                                                <td colspan="3"></td>
                                                                <td style="font-weight: bold;">Subtotal</td>
                                                                <td style="font-weight: bold; border-bottom: 3px double;">141,000.50</td>
                                                            </tr>
                                                        </tbody>                                                
                                                    </table>
                                                    <button class="btn btn-danger btn-sm pull-right"><i class="fa fa-times"></i> Delete </button>
                                                    <button class="btn btn-success btn-sm pull-right" style="margin-right: 5px"><i class="fa fa-plus"></i> Add </button>
                                                    <br><br><br><br>
                                                </div>
                                            </div>
                                        </fieldset>

                                        <fieldset title="Overview" class="step" id="default-step-4" >
                                            <legend></legend>
                                        </fieldset>

                                        <input type="hidden" name="hiddenlocation" id="location" value="">
                                        <input type="hidden" name="actionI" id="actionI">
                                        <button type="button" onclick ="draftbutton()" class="finish btn btn-info" >Save Draft</button>
                                        <button type="button" onclick ="finishbutton()" class="finish btn btn-success">Finish</button>



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
        <!--        <script src="js/jquery.js"></script>-->
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

        <!--Form Wizard-->
        <script src="js/jquery.steps.min.js" type="text/javascript"></script>
        <script src="js/jquery.validate.min.js" type="text/javascript"></script>
        <script src="js/create-proposal.js" type="text/javascript"></script>
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
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAI6e73iIoB6fgzlEmgdJBFYO3DX0OhMLw&callback=initMap"
        async defer></script> 

        <script>
                                            $.fn.searchableTable = function () {
                                                return this.each(function () {
                                                    var data = $(this).data(), $rows = $(this).find('tbody > tr'),
                                                            $searchField = $(data.searchField),
                                                            $rowsCount;
                                                    if (data.searchRows) {
                                                        $rowsCount = $(data.searchRows);
                                                    }
                                                    $searchField.keyup(function () {
                                                        var val = $.trim($(this).val()).replace(/ +/g, ' ').toLowerCase();
                                                        var $filtered = $rows.show().filter(function () {
                                                            var text = $(this).text().replace(/\s+/g, ' ').toLowerCase();
                                                            return !~text.indexOf(val);
                                                        }).hide();
                                                        if ($rowsCount)
                                                            $rowsCount.text($rows.length - $filtered.length);
                                                    })
                                                            .trigger('keyup');
                                                });
                                            };
                                            // Initialize
                                            $('.table').searchableTable();
        </script>
        <script>
            var map;
            var markers = [];
            var allPosition = [];
            function initMap() {
                map = new google.maps.Map(document.getElementById('map'), {
                    center: {lat: 14.45, lng: 120.98},
                    zoom: 14
                });
                google.maps.event.addListener(map, 'click', function (event) {
                    placeMarker(event.latLng);
                });
                function placeMarker(location) {
                    var marker = new google.maps.Marker({
                        position: location,
                        map: map
                    });
                    markers.push(marker);
                    latitude = marker.position.lat();
                    longitude = marker.position.lng();
                    var string = latitude + "&" + longitude;
                    allPosition.push(string);
                    document.getElementById("location").value = allPosition;
                }

                Testimonialmarkers.forEach(function (coor) {
                    var geocoder = new google.maps.Geocoder;
                    var latLng = new google.maps.LatLng(coor.latitude, coor.longitude);
                    var latitude = coor.latitude;
                    var longitude = coor.longitude;

                    var string = latitude + "&" + longitude;
                    allPosition.push(string);
                    document.getElementById("location").value = allPosition;

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

            function removeMarker() {
                for (var i = 0; i < markers.length; i++) {
                    markers[i].setMap(null);
                }
                markers = [];
                allPosition = [];
            }
        </script>

    </body>
</html>
