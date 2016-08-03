<%-- 
    Document   : Citizen_ViewProjectDetails
    Created on : 03 24, 16, 10:49:56 PM
    Author     : RoAnn
--%>


<%@page import="Entity.Schedule"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
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
<%ArrayList<Files> files = p.getFiles();%>
<%ArrayList<Files> pfiles = (ArrayList<Files>) session.getAttribute("pFiles");%>
<%DecimalFormat df = new DecimalFormat("#,###.00");%>

<%ArrayList<Project> pList = (ArrayList<Project>) session.getAttribute("contractorPList");%>
<%Contractor_User cu = (Contractor_User) session.getAttribute("contractor");%>


<!DOCTYPE html>
<html lang="en">
    <head>

        <title>View Letter</title>

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
    </body>


</html>

