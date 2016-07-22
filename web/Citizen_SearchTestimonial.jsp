<%-- 
    Document   : Citizen_SearchTestimonial
    Created on : 02 4, 16, 9:19:08 AM
    Author     : RoAnn
--%>

<%@page import="Entity.TLocation"%>
<%@page import="Entity.Location"%>
<%@page import="Entity.Files"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Entity.Testimonial"%>
<%@page import="Entity.Citizen"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%Citizen c = (Citizen) session.getAttribute("user");%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Search Testimonial</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap-reset.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <link href="assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>

        <style>
            table.table { table-layout:fixed; }
            table.table td { overflow: hidden; }
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
                            <a href="Citizen_SearchTestimonial" class="active">
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


            <%
                ArrayList<Testimonial> myTestimonials = (ArrayList<Testimonial>) request.getAttribute("myTestimonials");
                ArrayList<Testimonial> allTestimonials = (ArrayList<Testimonial>) request.getAttribute("allTestimonials");
                ArrayList<Testimonial> subscribedTestimonials = (ArrayList<Testimonial>) request.getAttribute("subscribedTestimonials");
                ArrayList<Testimonial> trendingTestimonials = (ArrayList<Testimonial>) request.getAttribute("trendingTestimonials");

                String allLocation = (String) request.getAttribute("allLocation");
            %>

            <script>
                var map;
                var markers = <%=allLocation%>;
            </script>

            <section id="main-content">
                <section class="wrapper site-min-height">
                    <section class="panel">
                        <header class="panel-heading">
                            Testimonial Search
                        </header>
                        <div class="panel-body">

                            <a href="Citizen_CreateTestimonial.jsp" class="pull-right position"><button type="button" align="right" class="btn btn-primary">Create New Testimonial</button></a>
                            <br>
                            <br>
                            <br>

                            <section class="panel">
                                <header class="panel-heading tab-bg-dark-navy-blue">
                                    <ul class="nav nav-tabs nav-justified ">
                                        <li class="active">
                                            <a href="#mapview" data-toggle="tab">
                                                Map View
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#tabview" data-toggle="tab">
                                                Tab view
                                            </a>
                                        </li>
                                    </ul>
                                </header>

                                <div class="panel-body">
                                    <div class="tab-content tasi-tab">
                                        <div class="tab-pane active" id="mapview">
                                            <div>
                                                <input size="50" type="text" placeholder="Type to search" id="all-testimonial">

                                                <input type="checkbox" value="Followed" style="margin-left: 20px">Followed

                                                <input type="checkbox" value="My" style="margin-left: 20px">My Testimonials

                                                <input type="checkbox" value="Trending" style="margin-left: 20px">Trending
                                            </div>
                                            <div class="form-group">
                                                <div class="directory-info-row">                                                    
                                                    <div class="row">
                                                        <div class="col-lg-13">
                                                            <!--Map should be here -->
                                                            <center>
                                                                <div id="map" style="height: 700px; margin: 0; padding: 0; width: 80%;"></div>
                                                            </center>
                                                        </div> 
                                                    </div>
                                                </div>
                                            </div>

                                            <script>
                                                $(document).on("keyup", "#all-testimonial", function () {
                                                    $.ajax({
                                                        type: 'POST',
                                                        url: 'AJAX_Citizen_SearchTestimonialViaMap',
                                                        dataType: 'json',
                                                        data: {searchtext: $('#all-testimonial').val()},
                                                        cache: false,
                                                        success: function (searchresult) {
                                                            markers = searchresult;
                                                            initMap();
                                                        }
                                                    });
                                                });

                                            </script>    

                                        </div>

                                        <div class="tab-pane" id="tabview">
                                            <div>
                                                <input size="50" type="text" placeholder="Type to search" id="tabview-testimonial">

                                                <input type="checkbox" value="Followed" style="margin-left: 20px">Followed

                                                <input type="checkbox" value="My" style="margin-left: 20px">My Testimonials

                                                <input type="checkbox" value="Trending" style="margin-left: 20px">Trending
                                            </div> 
                                            <div class="directory-info-row">


                                                <div class="row">


                                                    <table id="ListViewTestimonial" class="table" data-search-field="#tabview-testimonial">

                                                        <thead>
                                                            <tr>

                                                                <th style="width: 15%">Title</th>
                                                                <th style="width: 25%">Description</th>
                                                                <th style="width: 10%">Date Uploaded</th>
                                                                <th style="width: 8%">Project Linked</th>
                                                                <th style="width: 17%">Uploader</th>    
                                                                <th style="width: 15%"></th>
                                                            </tr>
                                                        </thead>
                                                        <tbody id="ListViewBody">
                                                            <%      for (int x = 0; x < allTestimonials.size(); x++) {
                                                                    int testID1 = allTestimonials.get(x).getId();
                                                                    Testimonial test1 = allTestimonials.get(x);
                                                                    ArrayList<Files> files = test1.getFiles();
                                                                    String[] split = allTestimonials.get(x).getDateUploaded().split("\\s+");
                                                                    int fileID = 0;
                                                            %>

                                                            <tr>

                                                                <td>
                                                                    <a href="Citizen_OpenTestimonial?idd=<%=testID1%>"> <%out.print(test1.getTitle());%> </a>
                                                                </td>
                                                                <td>
                                                                    <%out.print(test1.getMessage());%> 
                                                                </td>

                                                                <td>
                                                                    <%out.print(split[0]);%>
                                                                </td>

                                                                <%if (test1.getMainproject().getId() != null) {%>
                                                                <td>
                                                                    Available
                                                                </td>   
                                                                <%} else {%>
                                                                <td>
                                                                    None
                                                                </td>
                                                                <%}%>

                                                                <td>
                                                                    <%out.print(test1.getCitizen().getUser().getUsername());%> 
                                                                </td>    

                                                                <td>
                                                                    <%
                                                                        boolean hasimage = false;
                                                                        boolean hasvideo = false;
                                                                        boolean hasdoc = false;
                                                                        boolean isletter = false;
                                                                        for (int a = 0; a < files.size(); a++) {
                                                                            if (files.get(a).getType().equalsIgnoreCase("image")) {
                                                                                hasimage = true;
                                                                            } else if (files.get(a).getType().equalsIgnoreCase("video")) {
                                                                                hasvideo = true;
                                                                            } else if (files.get(a).getType().equalsIgnoreCase("document")) {
                                                                                hasdoc = true;
                                                                            }
                                                                        }

                                                                        isletter = true;
                                                                    %>
                                                                    <%if (hasimage == true) {%>        
                                                                    <img  src="img/imgicon.png" width="30" height="30" alt="">
                                                                    <%}
                                                                        if (hasvideo == true) {%>
                                                                    <img  src="img/vidicon.png" width="30" height="30" alt="">
                                                                    <%}
                                                                        if (hasdoc == true) {%>
                                                                    <img  src="img/docicon.png" width="30" height="30" alt="">
                                                                    <%}%>

                                                                </td>
                                                            </tr>    



                                                            <%

                                                                }
                                                            %>
                                                        </tbody>  
                                                    </table>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </section>

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

            <!-- ===========MODAL POP UP HERE =================== -->

            <%
                String success = (String) request.getAttribute("success");
            %>
            <script>                 //force open a modal using a hidden button                 window.onload = onLoad;
                function onLoad()
                {
                    var success = "<%=success%>";
                    if (success !== null) {
                        if (success === "NewProjectSuccess") {
                            $("#NPModal").click();
                        }
                        else if (success === "MaintenanceSuccess") {
                            $("#MModal").click();
                        }
                    } else {
                    }
                }
                ;</script>

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
                $('.table').searchableTable();</script>


            <!-- modal -->

            <button id="NPModal" style="visibility: hidden" data-toggle="modal" href="#npModal"></button> 
            <div class="modal fade" id="npModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-sm">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title">New Project Testimonial Sent</h4>
                        </div>
                        <div class="modal-body">

                            Your Testimonial for a new project has been sent. Please wait for the Local Government Unit's reply. 

                        </div>
                        <div class="modal-footer">
                            <button data-dismiss="modal" class="btn btn-default" type="button">Ok</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- modal -->

            <button id="MModal" style="visibility: hidden" data-toggle="modal" href="#mModal"></button> 
            <div class="modal fade" id="mModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-sm">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title">Maintenance Testimonial Sent</h4>
                        </div>
                        <div class="modal-body">

                            Your Testimonial for maintenance or repair has been sent. Please wait for the Local Government Unit's reply. 

                        </div>
                        <div class="modal-footer">
                            <button data-dismiss="modal" class="btn btn-default" type="button">Ok</button>
                        </div>
                    </div>
                </div>
            </div>


            <script src="js/jquery.js"></script>
            <script src="js/bootstrap.min.js"></script>
            <script class="include" type="text/javascript" src="js/jquery.dcjqaccordion.2.7.js"></script>
            <script src="js/jquery.nicescroll.js" type="text/javascript"></script>
            <script type="text/javascript" src="js/jquery.pulsate.min.js"></script>
            <script src="js/slidebars.min.js"></script>

            <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAI6e73iIoB6fgzlEmgdJBFYO3DX0OhMLw&callback=initMap"
            async defer></script>


            <!--PLACE ALL AJAX HERE
            
            1. LOAD ALL TESTIMONIALS BOTH IN MAPS AND IN TABULAR FORM
            2. UPON CHECKBOX TOGGLE CALL AJAX METHOD
            3. RELOAD MAP AND REFRESH THE TABLE
            4. UPON SELECTING MARKER -- DISPLAY TESTI DETAILS -- CLICK ID/NAME DISPLAY FULL DETAILS
            
            -->

            <script>
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
                            geocodeLatLng(geocoder, map, infowindow, latLng, coor);
                        });
                    });

                }

                function geocodeLatLng(geocoder, map, infowindow, latLng, coor) {
                    var latlng = latLng;
                    geocoder.geocode({'location': latlng}, function (results, status) {
                        if (status === google.maps.GeocoderStatus.OK) {
                            if (results[0]) {
                                var marker = new google.maps.Marker({
                                    position: latlng,
                                    map: map
                                });
                                var contentString = '<div id="content">' +
                                        '<div id="siteNotice">' +
                                        '</div>' +
                                        '<h1 id="firstHeading" class="firstHeading"><a href="Citizen_OpenTestimonial?idd=' + coor.testimonial.id + '">' + coor.testimonial.title + '</a></h1>' +
                                        '<div id="bodyContent">' +
                                        '<br><div>Date Uploaded: ' + coor.testimonial.dateuploaded + '</div>' +
                                        '<br><div>Location: ' + results[0].formatted_address + '</div>' +
                                        '<br><div>Category: ' + coor.testimonial.category + '</div>' +
                                        '<br><div>Message: ' + coor.testimonial.message + ' </div>' +
                                        '<br><div>Uploader: ' + coor.testimonial.citizen.firstName + ' ' + coor.testimonial.citizen.lastName + ' </div>' +
                                        '</div>' +
                                        '</div>';

                                infowindow.setContent(contentString);
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