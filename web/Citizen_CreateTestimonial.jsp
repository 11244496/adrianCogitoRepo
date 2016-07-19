<%-- 
    Document   : Citizen_CreateTestimonial
    Created on : 02 4, 16, 9:19:44 AM
    Author     : RoAnn 
--%>

<%@page import="Entity.Citizen"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%Citizen c = (Citizen) session.getAttribute("user");%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Create Testimonial</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap-reset.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <link href="assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
        <style>
            #floating-panel {
                position: absolute;
                top: 10px;
                left: 25%;
                z-index: 5;
                background-color: #fff;
                padding: 5px;
                border: 1px solid #999;
                text-align: center;
                font-family: 'Roboto','sans-serif';
                line-height: 30px;
                padding-left: 10px;
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
                                <span class="username">Hello <b><u><%//=c.getFirstName()%></u></b>!</span>
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
                <section class="panel">
                    <header class="panel-heading">
                        Create Testimonial
                    </header>
                    <br>
                    <form action="Citizen_SendTestimonial" class="form-horizontal tasi-form" method="POST" enctype="multipart/form-data">
                        <div class="col-sm-12 panel">
                            <div class="col-sm-6">
                                <label class="col-sm-2 col-sm-2 control-label">Title <i class="formAsterisk">*</i></label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" required name="testimonialtitle">
                                    <span class="help-block">Input title of your testimonial.</span>
                                    <br>
                                </div>
                                <label class="col-sm-2 col-sm-2 control-label">Concern<i class="formAsterisk">*</i></label>
                                <div class="col-sm-10">
                                    <select class="form-control" required rows="10" name="testimonialtype" onchange="showDiv(this)">
                                        <option  selected disabled hidden required>Select category</option>
                                        <option value="NewProject">Suggest project</option>
                                        <option value="Maintenance">Maintenance/Repair</option>
                                    </select>
                                    <span class="help-block">Select area of concern</span>
                                    <br>
                                </div>
                                <label class="col-sm-2 col-sm-2 control-label">Message<i class="formAsterisk">*</i></label>
                                <div class="col-sm-10">
                                    <textarea class="wysihtml5 form-control" required rows="5" name="testimonialdescription"></textarea>
                                    <span class="help-block">Input Message of your testimonial.</span>
                                    <br>
                                </div>
                                <label class="col-sm-2 col-sm-2 control-label">Video</label>
                                <div class="col-sm-10">
                                    <input name="Videos" type="file" class="default form-control" multiple style="border:0"/>
                                    <textarea class="wysihtml5 form-control" name="videodescription" placeholder=""></textarea>
                                    <br>
                                </div>

                                <label class="col-sm-2 col-sm-2 control-label">Image</label>
                                <div class="col-sm-10">
                                    <input name="Videos" type="file" class="default form-control" multiple style="border:0"/>
                                    <textarea class="wysihtml5 form-control" name="imagedescription" placeholder=""></textarea>
                                    <br>
                                </div>

                                <label class="col-sm-2 col-sm-2 control-label">Documents</label>
                                <div class="col-sm-10">
                                    <input name="Documents" type="file" class="default form-control" multiple style="border:0"/>
                                    <textarea class="wysihtml5 form-control" name="documentdescription" placeholder=""></textarea>
                                </div>
                            </div>


                            <div class="col-sm-6">
                                <label class="col-sm-2 col-sm-2 control-label">Location<i class="formAsterisk">*</i></label>
                                <div class="col-sm-10">
                                    <div class="default form-control" style="border:0"></div>
                                </div>
                                <div class="col-sm-12">
                                    <div id="floating-panel">
                                        <input onclick="removeMarker();" type=button value="Delete Markers">
                                    </div>
                                    <div id="map" style="height: 500px; margin: 0; padding: 0; width: 100%"></div>
                                    <input type="hidden" name="hiddenlocation" id="location" value="">
                                </div>
                            </div>
                        </div>


                        <center>
                            <button type="submit" class="btn btn-success">Submit</button>
                            <button type="button" class="btn btn-danger">Cancel</button>
                        </center>
                        <br>
                        <br>
                        </div>


                    </form>
                    </div>
                </section>
            </section>
        </section>
        <footer class="site-footer">
            <div class="text-center">
                2016 &copy; KAYA
                <a href="#" class="go-top">
                    <i class="fa fa-angle-up"></i>
                </a>
            </div>
        </footer>

        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script class="include" type="text/javascript" src="js/jquery.dcjqaccordion.2.7.js"></script>
        <script src="js/jquery.nicescroll.js" type="text/javascript"></script>
        <script type="text/javascript" src="js/jquery.pulsate.min.js"></script>
        <script src="js/slidebars.min.js"></script>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAI6e73iIoB6fgzlEmgdJBFYO3DX0OhMLw&callback=initMap"
        async defer></script>
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