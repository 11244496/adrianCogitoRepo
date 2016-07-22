<%-- 
    Document   : GS_ViewImageDetails
    Created on : 11 1, 15, 3:13:29 PM
    Author     : RoAnn
--%>
<%@page import="Entity.Reply"%>
<%@page import="Entity.Employee"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Entity.Files"%>
<%@page import="Entity.Testimonial"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%Testimonial testimonial = (Testimonial) session.getAttribute("openTestimonial");%>
<%Employee e = (Employee) session.getAttribute("user");%>
<%
    ArrayList<Files> image = (ArrayList<Files>) session.getAttribute("openImage");
    ArrayList<Files> video = (ArrayList<Files>) session.getAttribute("openVideo");
    ArrayList<Files> docs = (ArrayList<Files>) session.getAttribute("openDocument");
%>
<!DOCTYPE html>

<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="Mosaddek">
        <meta name="keyword" content="FlatLab, Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
        <link rel="shortcut icon" href="img/favicon.png">

        <title>View Testimonial</title>

        <!-- Bootstrap core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap-reset.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <link href="assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
        <link rel="stylesheet" type="text/css" href="assets/gritter/css/jquery.gritter.css" />
        <link href="unitegallery/css/unite-gallery.css" rel="stylesheet" >
        <link href="unitegallery/themes/default/ug-theme-default.css" rel="stylesheet">
        <style>
            #textar{
                background: white;
                cursor: default;
            }
        </style>

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
                            <a href="CityAdmin_Home">
                                <i class="fa fa-dashboard"></i>
                                <span>Home</span>
                            </a>
                        </li>
                        <li>
                            <a href="CityAdmin_NotificationActivity">
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


                    <div class="row">
                        <div class="col-md-12">
                            <section class="panel">

                                <header class="panel-heading" style="width: 30%">
                                    <p>Testimonial Details</p>
                                </header>

                            </section>   
                        </div>
                    </div>


                    <div class="row">
                        <div class="col-md-8">
                            <section class="panel">
                                <div class="bio-graph-heading project-heading">
                                    <strong><%=testimonial.getTitle()%></strong>
                                </div>

                                <div class="panel-body">

                                    <%for (int x = 0; x < video.size(); x++) {%>
                                    <video width="100%" height="100%" controls>
                                        <source src="<%=testimonial.getFolderName() + testimonial.getTitle() + "/" + video.get(x).getFileName()%>" type="video/mp4">
                                        Your browser does not support the video tag.
                                    </video>
                                    <%}%>

                                    <div id="gallery" style="display:none;">

                                        <%for (int x = 0; x < image.size(); x++) {
                                                String desc = image.get(x).getDescription();
                                                String imagelocation = testimonial.getFolderName() + testimonial.getTitle() + "/" + image.get(x).getFileName();
                                        %>

                                        <img alt="<%=desc%>"
                                             src="<%=imagelocation%>"
                                             data-image="<%=imagelocation%>"
                                             data-description="<%=desc%>">
                                        <%}%>
                                    </div>

                                    <div id="OtherFiles">
                                        <h3>Document Uploads</h3>  
                                        <br>
                                        <ul class="list-unstyled p-files">

                                            <%
                                                if (docs.isEmpty() == false || image == null) {
                                                    String d;
                                                    for (int x = 0; x < docs.size(); x++) {
                                                        d = testimonial.getFolderName() + testimonial.getTitle() + "/" + docs.get(x).getFileName();

                                            %>

                                            <h4><a href="<%=d%>"><i class="fa fa-file-text"></i> <%out.print(docs.get(x).getFileName());%></a> 
                                                - <%out.print(docs.get(x).getDescription());%>
                                            </h4>
                                            <br>
                                            <%

                                                    }
                                                }

                                            %>  

                                        </ul>

                                    </div>    
                                </div>
                            </section>
                        </div>
                        <div class="col-md-4">
                            <section class="panel">

                                <div class="bio-graph-heading project-heading">
                                    <strong>Location</strong>
                                </div>
                                <div class="panel-body">
                                    <div id="map" style="height: 300px; width: 320px; margin: 0; padding: 0;"></div>
                                </div>


                                <div class="bio-graph-heading project-heading">
                                    <strong>Other Information</strong>
                                </div>

                                <div class="panel-body">

                                    <h5 class="bold">Category</h5>
                                    <p><%=testimonial.getCategory()%></p>
                                    <br>

                                    <h5 class="bold">Message</h5>
                                    <p>
                                        <%=testimonial.getMessage()%>                        
                                    </p>
                                    <br>
                                    <h5 class="bold">Uploaded by</h5>
                                    <p><%=testimonial.getCitizen().getUser().getUsername()%></p>
                                    <br>

                                    <h5 class="bold">Date Uploaded</h5>
                                    <p><%=testimonial.getDateUploaded()%></p>
                                    <br>
                                    <br>


                                </div>

                            </section>
                        </div>

                        <br>


                        <br><br>
                    </div>
                    <center>
                        <button type="button" onclick="history.go(-1)" class="btn btn-info" >Back</button>                                    
                    </center> 
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
                                    var latLng = new google.maps.LatLng(coor.latitude, coor.longitude);
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
            <script src="js/jquery.js"></script>
            <script src="js/bootstrap.min.js"></script>
            <script class="include" type="text/javascript" src="js/jquery.dcjqaccordion.2.7.js"></script>
            <script src="js/jquery.nicescroll.js" type="text/javascript"></script>
            <script type="text/javascript" src="js/jquery.pulsate.min.js"></script>
            <script src="js/slidebars.min.js"></script>
            <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
            <script src='unitegallery/js/unitegallery.min.js'></script>
            <script src="unitegallery/themes/default/ug-theme-default.js"></script>
            <script type="text/javascript">

                                jQuery(document).ready(function () {

                                    jQuery("#gallery").unitegallery();

                                });

            </script>

        </section>

    </body>
</html>
