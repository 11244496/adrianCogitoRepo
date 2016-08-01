<%-- 
    Document   : Citizen_Home
    Created on : 02 4, 16, 9:19:29 AM
    Author     : RoAnn
--%>


<%@page import="com.google.gson.Gson"%>
<%@page import="Entity.Task"%>
<%@page import="Entity.Timeline_Update"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Entity.Project"%>
<%@page import="Entity.Contractor_User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%Contractor_User c = (Contractor_User) session.getAttribute("user");%>
<!DOCTYPE html>
<html lang="en">
    <head>

        <title>Home</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap-reset.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <link href="assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
        <link rel="stylesheet" type="text/css" href="assets/gritter/css/jquery.gritter.css" />

        <!--external css-->
        <link href="assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
        <link rel="stylesheet" type="text/css" href="assets/gritter/css/jquery.gritter.css" />

        <!--right slidebar-->
        <link href="css/slidebars.css" rel="stylesheet">

        <!-- Custom styles for this template -->
        <link href="css/style.css" rel="stylesheet">
        <link href="css/style-responsive.css" rel="stylesheet" />


        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">

        <script src='amcharts/amcharts.js'></script>
        <script src='amcharts/serial.js'></script>
        <script src='amcharts/themes/dark.js'></script>
        <script src='amcharts/gantt.js'></script>

    </head>






    <body>


        <%

            Project project = (Project) request.getAttribute("project");
            ArrayList<Timeline_Update> tList = (ArrayList<Timeline_Update>) request.getAttribute("tList");

            ArrayList<Task> tasks = project.getTask();
            String tasksJSON = new Gson().toJson(tasks);
        %>

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
                        <a href="Contractor_Home" class="active">
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


        <!--main content start-->
        <section id="main-content">
            <section class="wrapper site-min-height">
                <!-- page start-->
                <section class="panel">
                    <header class="panel-heading">
                        Project description
                    </header>
                    <div class="panel-body">
                        <label><%=project.getName()%></label><br>

                        <label><%=project.getDescription()%></label>




                    </div>
                </section>


                <section class="panel" style="height:  900px; overflow: scroll;">
                    <header class="panel-heading">
                        Timeline
                    </header>

                    <div class="panel-body" style="margin-bottom: 10px; height: 80%">


                        <div id="chartdiv" style="width: 100%; height: 400px;"></div>

                            
                        <br>



                        <hr>


                        <div class="col-sm-12 panel">
                            <div class="col-sm-6">


                                <form action="Contractor_RequestForChange">

                                    <div>
                                        <input type="hidden" name="projectID" value="<%=project.getId()%>">
                                        <h4><label>Contact city engineer</label></h4><br>
                                        <textarea class="wysihtml5 form-control" required rows="5" name="contractormessage"></textarea>


                                    </div>
                                    <br>
                                    <button type="submit" class="btn btn-success">Submit</button>
                                </form>



                            </div>


                            <div class="col-sm-6">


                                <table class="table table-striped table-advance table-hover">
                                    <thead>
                                    <th>Date posted</th>
                                    <th></th>

                                    </thead>    
                                    <tbody>
                                        <%
                                            for (int x = 0; x < tList.size(); x++) {
                                                // int repid = tList.get(x).getID();

                                        %>

                                        <tr>

                                            <td>
                                                <%=tList.get(x).getMessage()%>
                                            </td>
                                            <td>
                                                <button id="viewMedia" type="button" class="btn btn-round btn-info" onClick='javascript:getReport("<%=tList.get(x).getID()%>")'>Read</button>
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






                </section>

                <div class="modal fade" id="timelineupdate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-md">
                        <div class="modal-content">




                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                                <h5>New Inspection</h5>
                            </div>
                            <div class="modal-body">


                                <div id="itemField">



                                </div>    



                            </div>
                            <div class="modal-footer">


                                <button data-dismiss="modal" class="btn btn-default" type="button">Close</button>

                            </div>


                        </div>
                    </div>
                </div>   
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


        <script>
            function getReport(updateId) {

                $.ajax({
                    type: 'POST',
                    url: 'Contractor_OpenMessage',
                    dataType: 'json',
                    cache: false,
                    data: {updateId: updateId},
                    success: function (file) {

                        $("#itemField").empty();

                        var txtArea = $("<textarea/>");
                        txtArea.prop("style", "width: 100%");
                        txtArea.val(file.message);
                        txtArea.appendTo("#itemField");


                        $('#timelineupdate').modal();



                    }
                });

            }
        </script>






        <!-- js placed at the end of the document so the pages load faster -->
        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script class="include" type="text/javascript" src="js/jquery.dcjqaccordion.2.7.js"></script>
        <script src="js/jquery.scrollTo.min.js"></script>
        <script src="js/slidebars.min.js"></script>
        <script src="js/jquery.nicescroll.js" type="text/javascript"></script>
        <script type="text/javascript" src="assets/gritter/js/jquery.gritter.js"></script>
        <script src="js/respond.min.js" ></script>
        <script type="text/javascript" src="js/jquery.pulsate.min.js"></script>

        <!--right slidebar-->
        <script src="js/slidebars.min.js"></script>

        <!--common script for all pages-->
        <script src="js/common-scripts.js"></script>

        <!--script for this page only-->
        <script src="js/gritter.js" type="text/javascript"></script>
        <script src="js/pulstate.js" type="text/javascript"></script>

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





    </body>
</html>
