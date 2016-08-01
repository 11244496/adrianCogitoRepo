<%-- 
    Document   : Citizen_Home
    Created on : 02 4, 16, 9:19:29 AM
    Author     : RoAnn
--%>

<%@page import="Entity.Contractor_User"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="Entity.Task"%>
<%@page import="Entity.PWorks"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="Entity.Testimonial"%>
<%@page import="Entity.Files"%>
<%@page import="Entity.Schedule"%>
<%@page import="Entity.InvitationToBid"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Entity.Project"%>
<%@page import="Entity.Employee"%>
<%@page import="Entity.Citizen"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%Contractor_User c = (Contractor_User) session.getAttribute("user");%>
<%
    Project p = (Project) request.getAttribute("project");
    String projid = p.getId();
    int conid = c.getContractor().getID();
%>
<%float cost = (Float) request.getAttribute("cost");%>
<%ArrayList<PWorks> pworks = p.getpWorks();%>
<%ArrayList<Task> tasks = p.getTask();
    String tasksJSON = new Gson().toJson(tasks);%>
<%ArrayList<Files> files = p.getFiles();%>
<%DecimalFormat df = new DecimalFormat("#,###.00");%>

<!DOCTYPE html>
<html lang="en">
    <head>

        <title>Home</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap-reset.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <link href="assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
        <link rel="stylesheet" type="text/css" href="assets/gritter/css/jquery.gritter.css" />

        <script src='amcharts/amcharts.js'></script>
        <script src='amcharts/serial.js'></script>
        <script src='amcharts/themes/dark.js'></script>
        <script src='amcharts/gantt.js'></script>

        <link href = 'calendar/fullcalendar.css' rel='stylesheet'>
        <link href = 'calendar/scheduler.css' rel='stylesheet'>
        <script src ='calendar/moment.min.js'></script>
        <script src ='calendar/jquery.min.js'></script>
        <script src ='calendar/fullcalendar.js'></script>
        <script src ='calendar/scheduler.js'></script>
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
                        <a href="Contractor_Home">
                            <i class="fa fa-dashboard"></i>
                            <span>Home</span>
                        </a>
                    </li>
                    <li>
                        <a href="Contractor_Profile">
                            <i class="fa fa-dashboard"></i>
                            <span>Profile</span>
                        </a>
                    </li>
                    <li>
                        <a href="Contractor_ViewProjectList">
                            <i class="fa fa-dashboard"></i>
                            <span>View All Projects</span>
                        </a>
                    </li>
                    <li class="sub-menu">
                        <a href="javascript:;" >
                            <i class="fa fa-tasks"></i>
                            <span>Bidding</span>
                        </a>
                        <ul class="sub">
                            <li><a  href="Contractor_HandleInvitations">&nbsp; &nbsp; &nbsp; &nbsp;Handle Invitations</a></li>
                            <li><a  href="Contractor_ViewHistory">&nbsp; &nbsp; &nbsp; &nbsp; View History</a></li>
                        </ul>
                    </li>

                    <li class="sub-menu">
                        <a href="javascript:;" >
                            <i class="fa fa-tasks"></i>
                            <span>Implementation</span>
                        </a>
                        <ul class="sub">
                            <li><a  href="Contractor_ViewProjectList">&nbsp; &nbsp; &nbsp; &nbsp;Monitor Projects</a></li>
                            <li><a  href="Contractor_ViewAR">&nbsp; &nbsp; &nbsp; &nbsp; View Accomplishment Reports</a></li>
                        </ul>
                    </li>

                    <li>
                        <a href="Contractor_ScheduleChange">
                            <i class="fa fa-dashboard"></i>
                            <span>Schedule Change</span>
                        </a>
                    </li>

                    <li>
                        <a href="Contractor_ActivityandNotification">
                            <i class="fa fa-dashboard"></i>
                            <span>View Activity and Notifications</span>
                        </a>
                    </li>



                </ul>
            </div>
        </aside>


        <section id="main-content">
            <section class="wrapper site-min-height">

                <section class="panel">
                    <header class="panel-heading">
                        Create Schedule and Program of Works
                    </header>
                    <br>
                    <div class="panel-body">
                        <form class="form-horizontal" id="proposalForm" method="post" action="Contractor_SubmitGanttSchedule">
                            <div class="col-md-12">
                                <section class="panel">

                                    <header class="panel-heading">
                                        Create Program of Works
                                    </header>
                                </section>
                                <div class="row">
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

                            </div>

                            <div class="col-md-12">
                                <section class="panel">

                                    <header class="panel-heading">
                                        Create Schedule
                                    </header>
                                </section>
                                <div class="row">
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
                                        <div class="panel-body">
                                            <div id="chartdiv2" style="width: 100%; height: 400px;"></div>
                                        </div>
                                    </div>

                                </div>


                            </div>
                        </form>

                    </div>

                </section> 
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
                            <div class="row">

                                <!------------------------------------------------------PROGRAM OF WORKS------------------------------------------>

                                <section class="panel">

                                    <div class="col-lg-12">
                                        <div class="bio-graph-heading project-heading">
                                            <strong>Program Works</strong>
                                        </div>

                                        <section class="panel">
                                            <div class="panel-body">
                                                <table class="table" style="width:100%; text-align: center">
                                                    <%for (int x = 0; x < pworks.size(); x++) {%>

                                                    <tr>
                                                        <th colspan="6"><%=pworks.get(x).getName()%></th>
                                                    </tr>
                                                    <tr>
                                                        <th><center>Name</center></th>
                                                    <th><center>Quantity</center></th>
                                                    <th><center>Unit</center></th>
                                                    <th><center>Unit Price</center></th>
                                                    <th><center>Total</center></th>
                                                    </tr>
                                                    <%for (int y = 0; y < pworks.get(x).getComponents().size(); y++) {%>
                                                    <tr>
                                                        <td><%=pworks.get(x).getComponents().get(y).getName()%></td>
                                                        <td><%=pworks.get(x).getComponents().get(y).getQuantity()%></td>
                                                        <td><%=pworks.get(x).getComponents().get(y).getUnit().getUnit()%></td>
                                                        <td><%=pworks.get(x).getComponents().get(y).getUnitPrice()%></td>
                                                        <td><%=pworks.get(x).getComponents().get(y).getUnitPrice() * pworks.get(x).getComponents().get(y).getQuantity()%></td>
                                                    </tr>


                                                    <%}%>

                                                    <%}%>

                                                </table>
                                                <br> 
                                                <table class="table" style="width:100%; text-align: center">    
                                                    <tr>
                                                        <td colspan="4">Total cost: </td>
                                                        <td>PHP <%=df.format(cost)%></td>
                                                    </tr>

                                                    <tr>
                                                        <td colspan="4">Indirect Cost 17% of Total Cost: </td>
                                                        <td>PHP <%=df.format(cost * 0.17)%></td>
                                                    </tr>

                                                    <tr>
                                                        <td colspan="4">Tax 5% of Total Cost + Indirect Cost: </td>
                                                        <td>PHP <%=df.format((cost * 0.17) * .05)%></td>
                                                    </tr>

                                                    <tr>
                                                        <td colspan="4">Estimated cost: </td>
                                                        <td>PHP <%=df.format(cost + (cost * 0.17) + ((cost * 0.17) * .05))%></td>
                                                    </tr>

                                                </table>
                                            </div>
                                        </section>
                                    </div>
                                </section>                                                 
                            </div>

                            <div class="row">

                                <!------------------------------------------------------GANTT CHART------------------------------------------>

                                <section class="panel">

                                    <div class="col-lg-12">
                                        <div class="bio-graph-heading project-heading">
                                            <strong>Project Task</strong>
                                        </div>

                                        <section class="panel">
                                            <div class="panel-body">
                                                <div id="chartdiv" style="width: 100%; height: 400px;"></div>
                                            </div>

                                            <div id="submitEntryEdit">

                                            </div>

                                        </section>
                                    </div>
                                </section>                                                 
                            </div>            
                        </div>

                    </div>

                    <!-- page end-->
                </section>
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
        <!--<script src="js/jquery.js"></script>-->
        <script>


            var map;
            var markers = <%=request.getAttribute("location")%>;
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
        <script>
            //These are the properties of the chart, you set what it  will look like here
            var chartD;
            var chartVal = Object.create(null);
            var chart = AmCharts.makeChart("chartdiv", {
                "type": "gantt",
                "period": "DD",
                "theme": "dark",
                "valueAxis": {
                    "type": "date"
                },
                "brightnessStep": 10,
                "graph": {
                    "fillAlphas": 1,
                    "balloonText": "[[open]] - [[value]]"
                },
                "rotate": true,
                "categoryField": "name",
                "segmentsField": "schedules",
                "dataDateFormat": "YYYY-MM-DD",
                "startDateField": "startdate",
                "endDateField": "enddate",
                "dataProvider": <%=tasksJSON%>,
                "chartCursor": {
                    "valueBalloonsEnabled": false,
                    "cursorAlpha": 0,
                    "valueLineBalloonEnabled": true,
                    "valueLineEnabled": true,
                    "valueZoomable": true,
                    "zoomable": false
                },
                "valueScrollbar": {
                    "position": "top",
                    "autoGridCount": true,
                    "color": "#000000"
                },
            });


            //Event method: click item
            //Once you click one of the bars in the gantt chart, this method will execute
            var index = 0;
            var clickItemEvent = function (event) {
                index = 0;

                $.map(event.item.dataContext, function (val, i) {
                    //When the index is referring to the category of the selected value
                    if (i == "name") {

                        //Place the name of the selected value on the textfield 
                        $("#category").val(event.item.dataContext.name);


                    }
                    //Else, if the index is referring to the segments of that particular value selected
                    else {


                        var name = i.indexOf("start") != -1 ? "startdate" : "enddate";
                        var labelName = i.indexOf("start") != -1 ? "Start date: " : "End date: ";



                        var divInd = "#" + "div-" + index;


                        //Creates a div that will store the start date and end date for a particular Task   
                        if (i.indexOf("start") != -1) {


                            //Creates a label and then pushes it  to the div
                            var div = $("<div></div>");
                            div.prop("id", "div-" + index);
                            div.prop("class", "divinput");
                            div.appendTo("#submitEntryEdit");

                        }
                        //Creates a label and then pushes it  to the div
                        var label = $("<label/>");
                        label.html(labelName);
                        label.prop("id", name + index);
                        label.appendTo("#" + "div-" + index);

                        //Creates a textfield then puts it to the div
                        var newStart = $("<label/>");
                        newStart.prop("id", name + '-' + index);
                        newStart.appendTo("#" + "div-" + index);
                        newStart.val(formatDate(new Date(val)));

                        $("<br>").appendTo("#" + "div-" + index);


                        if (i.indexOf("end") != -1) {
                            index++;
                        }
                    }
                });
            };
            //var index = 0;
            var addSegment = function (event) {
                $.map(event.item.dataContext, function (val, i) {

                    //When the index is referring to the category of the selected value
                    if (i == "name") {

                        //Place the name of the selected value on the textfield 
                        $("#category").val(event.item.dataContext.category);


                    }
                    //Else, if the index is referring to the segments of that particular value selected
                    else {


                        var name = i.indexOf("start") != -1 ? "startdate" : "enddate";
                        var labelName = i.indexOf("start") != -1 ? "Start date: " : "End date: ";
                        var divInd = "#" + "div-" + index;

                        //Creates a div that will store the start date and end date for a particular Task   
                        if (i.indexOf("start") != -1) {
                            //Creates a div and then pushes it  to the div
                            var div = $("<div></div>");
                            div.prop("id", "div-" + index);
                            div.prop("class", "divinput");
                            div.appendTo("#submitEntryEdit");
                        }

                        //Creates a label and then pushes it  to the div
                        var label = $("<label/>");
                        label.html(labelName);
                        label.prop("id", name + index);
                        label.appendTo("#" + "div-" + index);
                        //Creates a label then puts it to the div
                        var newStart = $("<input type='text'/>");
                        newStart.prop("id", name + index);
                        newStart.appendTo("#" + "div-" + index);
                        newStart.val(new Date(val));
                        $("<br>").appendTo("#" + "div-" + index);


                        if (i.indexOf("end") != -1) {
                            index++;

                        }
                    }
                });

            };

            function formatDate(date) {
                var d = new Date(date),
                        month = '' + (d.getMonth() + 1),
                        day = '' + d.getDate(),
                        year = d.getFullYear();

                if (month.length < 2)
                    month = '0' + month;
                if (day.length < 2)
                    day = '0' + day;

                return [year, month, day].join('-');
            }

            function getId(str) {
                var spl = str.split("-");
                return spl[1];
            }
            ;

            function getUpdatedChartVal() {
                return chartVal;
            }
            ;

        </script>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAI6e73iIoB6fgzlEmgdJBFYO3DX0OhMLw&callback=initMap"async defer></script>
        <script src="js/bootstrap.min.js"></script>
        <script class="include" type="text/javascript" src="js/jquery.dcjqaccordion.2.7.js"></script>
        <script src="js/jquery.scrollTo.min.js"></script>
        <script src="js/slidebars.min.js"></script>
        <script src="js/jquery.nicescroll.js" type="text/javascript"></script>
        <script src="js/respond.min.js" ></script>

        <!--common script for all pages-->
        <script src="js/common-scripts.js"></script>

        <script>
            var powNumber = 1;
            var taskName = [];
            var taskSchedule = [];
            var finalTasks = [];
            var taskDetails;
            var powNumber = 1;
            function addRowForWorks() {
                //debugger;

                var table = document.getElementById("powTable");
                var row = table.insertRow(-1);
                var cell2 = row.insertCell(-1);
                var cell3 = row.insertCell(-1);
                var sel = document.createElement('select');
                sel.setAttribute("id", "worksSelect-" + powNumber);
                sel.setAttribute("class", "worksSelect");
                sel.setAttribute("class", "form-control");
                sel.setAttribute("name", "works");
                var ok = document.createElement('button');
                sel.setAttribute("id", "worksOk-" + powNumber);
                var button = document.createElement('button');
                button.setAttribute("id", "worksButton-" + powNumber);
                button.setAttribute("class", "form-control finalWorks");
                button.setAttribute("name", "works");
                button.setAttribute("type", "button");
                var newWork = document.createElement('input');
                newWork.setAttribute("id", "newWork-" + powNumber);
                newWork.setAttribute("class", "form-control");
                newWork.setAttribute("type", "text");
                var delBtn = document.createElement('button');
                delBtn.setAttribute("id", "worksDel-" + powNumber);
                delBtn.setAttribute("class", "btn btn-danger btn-sm");
                delBtn.innerHTML = "-";
                delBtn.addEventListener("click", function () {
                    var row = delBtn.parentNode.parentNode;
                    row.parentNode.removeChild(row);
                    for (var x = 0; x < taskName.length; x++) {
                        var task = taskName[x];
                        if (task === $(this).val()) {
                            taskName.splice(x, 1);
                        }
                    }

                    console.log(taskName);
                    $('#componentsDiv-' + (getIdNum(delBtn.id))).remove();
                });
                var option = document.createElement("option");
                option.setAttribute('hidden', true);
                option.text = 'Select Works';
                sel.appendChild(option);
                for (var i = 0; i < worksList.length; i++) {
                    option = document.createElement("option");
                    option.setAttribute("value", worksList[i].name);
                    option.text = worksList[i].name;
                    sel.appendChild(option);
                }

                option = document.createElement("option");
                option.setAttribute("value", "new");
                option.text = "New...";
                sel.appendChild(option);
                powTableFc(button, sel, powNumber, newWork);
                cell2.appendChild(sel);
                cell2.appendChild(button);
                cell2.appendChild(newWork);
                cell3.appendChild(delBtn);
                powNumber++;
            }

            function createTble(works, id) {
                var div = $('<div id="componentsDiv-' + id + '"></div>');
                var header = $('<header class="panel-heading no-border"> Components - ' + works + '</header>');
                var table = $('<table class="table table-bordered table-striped table-condensed" id="comp-' + id + '"></table>');
                var tableHeader = $('<thead><tr><th style="width: 20%">Component</th><th style="width: 10%">Qty/Area</th><th style="width: 12%">Unit</th><th style="width: 20%">Unit Cost</th><th style="width: 20%">Amount</th></tr></thead>');
                var tableBody = $('<tbody></tbody>');
                var tableFoot = $('<tfoot><tr id="totalTR"><td colspan="3"></td><td style="font-weight: bold;">Subtotal</td><td style="font-weight: bold; border-bottom: 3px double;"> <input type="text" class="form-control" name="subtotal" id="subtotal-"' + id + ' readonly style="background: transparent"></td></tr></tfoot>');
                var deleteBtn = $('<button class="btn btn-danger btn-sm pull-right" type="button" onclick="delBtn(this)" id="componentsDelete-' + id + '"><i class="fa fa-times"></i> Delete </button>');
                var addBtn = $('<button class="btn btn-success btn-sm pull-right" type="button" onclick="addComponentsRow(this)" id="componentsAdd-' + id + '" style="margin-right: 5px"><i class="fa fa-plus"></i> Add </button>');
                var brk = $('<br><br><br>');
                $('#compMain').append(div);
                $(div).append(header);
                $(div).append(table);
                $(table).append(tableHeader);
                $(table).append(tableBody);
                $(table).append(tableFoot);
                $(div).append(deleteBtn);
                $(div).append(addBtn);
                $(div).append(brk);
            }

            function powTableFc(button, sel, num, work) {
                $(button).hide();
                $(work).hide();
                $(sel).change(function () {
                    if ($(sel).val() === "new") {
                        $(work).show();
                        $(work).keypress(function (e) {
                            var key = e.which;
                            if (key === 13) {
                                $(work).hide();
                                $(sel).hide();
                                $(button).text($(work).val());
                                $(button).show();
                                $('#compMain div').each(function () {
                                    $(this).hide();
                                });
                                $(button).val($(work).val());
                                createTble(button.innerHTML, num);
                                $('#worksDel-' + num).val($(sel).val());
                            }
                        });
                    }
                    else {
                        $(sel).hide();
                        $(button).text($(sel).val());
                        $(button).val($(sel).val());
                        $(button).show();
                        $('#compMain div').each(function () {
                            $(this).hide();
                        });
                        createTble(button.innerHTML, num);
                        $('#worksDel-' + num).val($(sel).val());
                    }
                });
                $(button).dblclick(function () {
                    $(button).hide();
                    $(sel).show();
                });
                $(button).click(function () {
                    $('#compMain div').each(function () {
                        if (this.id === "componentsDiv-" + num) {
                            $('#componentsDiv-' + num).show();
                        }
                        else {
                            $(this).hide();
                        }
                    });
                });
            }

            function getIdNum(string) {
                var spl = string.split('-', 2);
                return spl[1];
            }

            function delBtn(btn) {
                var row = btn.parentNode.parentNode;
                row.parentNode.removeChild(row);
            }

            function addComponentsRow(btn) {
                var id = getIdNum(btn.id);
                var tableId = "comp-" + id;
                var row = $('<tr></tr>');
                var x = 1;
                var componenttd = $('<td></td>');
                var component = $('<input type="text" name="component" class="form-control" id="component"> ');
                componenttd.append(component);
                var quantitytd = $('<td></td>');
                var quantity = $('<input type="text" name="quantity" class="form-control" id="quantity"> ');
                quantitytd.append(quantity);
                var unittd = $('<td></td>');
                var select = $('<select type="text" name="unit" class="form-control" id="unit" ></select>');
                for (var i = 0; i < unitList.length; i++) {
                    $(select).append($("<option></option>").val(unitList[i].unit).html(unitList[i].unit));
                }
                $(unittd).append(select);
                var unitCosttd = $('<td></td>');
                var unitCost = $('<input type="text" name="unitCost" class="form-control" id="unitCost">');
                unitCosttd.append(unitCost);
                var amounttd = $('<td></td>');
                var amount = $('<input readonly type="text" name="amount" class="form-control amount" style="background: white">');
                amounttd.append(amount);
                $(row).append(componenttd);
                $(row).append(quantitytd);
                $(row).append(unittd);
                $(row).append(unitCosttd);
                $(row).append(amounttd);
                onchanges(quantity, unitCost, amount, id);
                $("#" + tableId).append(row);
            }

            function onchanges(quantity, unitcost, amount, id) {
                var cost;
                $(quantity).change(function () {
//if unitcost is not empty set amount
                    if ($(unitcost).val() !== "") {
                        cost = parseFloat($(quantity).val() * $(unitcost).val());
                        $(amount).val(cost.toFixed(2));
                        var total;
                        $('#comp-' + id + ' .amount').each(function () {
                            total += $(this).val();
                        });
                        $('#subtotal-' + id).val(total.toFixed(2));
                    }
                });
                $(unitcost).change(function () {
                    if ($(quantity).val() !== "") {
                        cost = parseFloat($(quantity).val() * $(unitcost).val());
                        $(amount).val(cost.toFixed(2));
                        var total = 0;
                        $('#comp-' + id + ' .amount').each(function () {
                            total = total + parseFloat($(this).val());
                        });
                        $('#comp-' + id + ' tfoot input').val(total.toFixed(2));
                    }
                });
            }

            var works = [];
            var pw, comps, compList = [], pworks;
            var n, q, u, c;
            function insertWorks() {

                for (var x = 1; x < powNumber; x++) {
                    pw = $('#worksButton-' + x).text();
                    $('#comp-' + x + ' tbody tr').each(function (row, tr) {

                        n = $(tr).find('#component').val();
                        q = $(tr).find('#quantity').val();
                        u = $(tr).find('#unit').val();
                        c = $(tr).find('#unitCost').val();
                        comps = {cname: n, qty: q, unit: u, cost: c};
                        compList.push(comps);
                    });
                    pworks = {name: pw, component: compList};
                    works.push(pworks);
                    compList = [];
                }

//    JSON.stringify(works);
                $('#pworks').val(JSON.stringify(works));

                $('#schedule').val(JSON.stringify(finalTasks));
//    console.log(JSON.stringify(finalTasks));

            }

//SCRIPTS FOR SCHEDULE SECTION
            $(document).ready(function () {
                var isExisting;
                $('#proposalForm-title-4 div').click(function () {
                    $('.finalWorks').each(function () {
                        if (taskName.length > 0) {
                            for (var x = 0; x < taskName.length; x++) {
                                if (taskName[x] !== $(this).text()) {
                                    isExisting = false;
                                }
                                else {
                                    isExisting = true;
                                    break;
                                }
                            }
                            if (!isExisting) {
                                taskName.push($(this).text());
                            }
                        }
                        else {
                            taskName.push($(this).text());
                        }
                    });
                    setTasksTable();
                });
            });
            function setTasksTable() {


                var taskDet;
                $('#taskTable tbody > tr').remove();
                for (var x = 0; x < taskName.length; x++) {
                    if (taskName.length > 0) {
                        var task = taskName[x];
                        var tr = $('<tr></tr>');
                        var buttontd = $('<td></td>');
                        var button = $('<button type="button" class="btn btn-white form-control" value="' + task + '" data-toggle="modal" onclick="addScheduleModal(this)">' + task + '</button>');
//            var deltd = $('<td></td>');
//            var del = $('<button class = "btn btn-danger btn-sm" type="button" value="' + task + '" onclick="deleteForSchedule(this)"> - </button>');
                        buttontd.append(button);
//            deltd.append(del);
                        tr.append(buttontd);
//            tr.append(deltd);
                        $('#taskTable tbody').append(tr);
                        var schedDetails = [];
                        taskDet = {name: task, details: schedDetails};
                        finalTasks.push(taskDet);
                    }
                }
            }



            function addScheduleModal(btn) {
                $('#schedModal > .modal-header > h4').html($(btn).val());
                $('#taskNameMod').val($(btn).val());
                $('#schedModal').modal();
            }

            var tempTasks = [];

            function addScheduleToArray() {
                var name = $('#taskNameMod').val();
                var start = $('#startDate').val();
                var end = $('#endDate').val();
                var det = {start: start, end: end};

                for (var x = 0; x < finalTasks.length; x++) {
                    if (finalTasks[x].name === name) {
                        finalTasks[x].details.push(det);
                        break;
                    }
                }

                $('#startDate').val("");
                $('#endDate').val("");

                renderChart(JSON.stringify(finalTasks));
            }

            function finalizeTasks() {
                for (var x = 0; x < tempTasks.length; x++) {
                    var exists = false;
                    var index;
                    //insert into array {name, details}
                    //loop through said array and check names
                    //if same, push into one details array
                    //
                    if (finalTasks.length > 0) {
                        for (var y = 0; y < finalTasks.length; y++ && !exists) {
                            if (tempTasks[x].name === finalTasks[y].name) {
                                exists = true;
                                index = y;
                            }
                        }
                        if (exists) {
                            finalTasks[y].details.push(tempTasks[x].details[0]);
                        } else {

                        }

                    } else {
                        finalTasks.push(tempTasks[x]);
                    }
                }
            }

            function deleteForSchedule(btn) {
                var row = btn.parentNode.parentNode;
                row.parentNode.removeChild(row);
                for (var x = 0; x < taskName.length; x++) {
                    var task = taskName[x];
                    if (task === $(btn).val()) {
                        taskName.splice(x, 1);
                    }
                }
                console.log(taskName);
            }


        </script>
    </body>
</html>
