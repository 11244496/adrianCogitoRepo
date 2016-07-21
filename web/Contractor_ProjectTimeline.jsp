<%-- 
    Document   : Citizen_Home
    Created on : 02 4, 16, 9:19:29 AM
    Author     : RoAnn
--%>


<%@page import="Entity.Contractor_User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

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

        <link rel="stylesheet" href="/Cogito/samples/style.css" type="text/css">
        <script src="/Cogito/amcharts/amcharts.js" type="text/javascript"></script>
        <script src="/Cogito/amcharts/serial.js" type="text/javascript"></script>
        <script src="/Cogito/amcharts/themes/dark.js"></script>
        <script src="/Cogito/amcharts/gantt.js" type="text/javascript"></script>

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
                        Panel 1 for project description
                    </header>
                    <div class="panel-body">







                    </div>
                </section>


                <section class="panel" style="height:  900px;">
                    <header class="panel-heading">
                        Panel 2 for the timeline
                    </header>

                    <div class="panel-body" style="margin-bottom: 10px; height: 80%">


                        <div id="chartdiv" style="width: 100%; height: 400px;"></div>

                        <table style="padding: 10px;">
                            <tr>
                            <h4><label id="labelGantt" >Add task</label></h4>

                            </tr>    
                            <tr>

                            <div> 
                                <b>Category:</b> <input id="category" type="text">
                            </div><br>

                            </tr> 
                            <tr>
                            <div id="submitEntry"> 

                                <div>
                                    <b> Start date:</b>   <input id="startD" type="text" ></input> 
                                </div>
                                <br>
                                <div>  
                                    <b>End date:</b>     <input id="endD" type="text" ></input>
                                </div>


                            </div>
                            </tr> 
                            <tr>

                            <div id="submitEntryEdit">


                            </div>


                            </tr>    
                            <tr>

                            <button id="submitGData" class="btn btn-success">Submit</button>
                            <button id="addSegment" class="btn btn-warning" style="display: none;">Add date</button>
                            <button id="prvBtn" class="btn btn-danger" style="display: none;">Preview</button>

                            </tr>    

                        </table>    







                    </div>
                    <div class="panel-body">


                        <p>For the table</p>



                    </div>





                </section>


                <!-- page end-->
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
                "categoryField": "category",
                "segmentsField": "segmentList",
                "dataDateFormat": "YYYY-MM-DD",
                "startDateField": "startDate",
                "endDateField": "endDate",
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
            var clickItemEvent = function (event) {

                //Refresh
                $("#submitEntryEdit").html("");
                //Hide the input for new tasks
                $("#submitEntry").hide();
                //Change the label to edit task
                $("#labelGantt").text("Edit task");
                $("#prvBtn").show();
                $("#addSegment").show();




                var index = 0;
                $.map(event.item.dataContext, function (val, i) {

                    //When the index is referring to the category of the selected value
                    if (i == "category") {

                        //Place the name of the selected value on the textfield 
                        $("#category").val(event.item.dataContext.category);


                    }
                    //Else, if the index is referring to the segments of that particular value selected
                    else {


                        var name = i.indexOf("start") != -1 ? "startDate" : "endDate";
                        var labelName = i.indexOf("start") != -1 ? "Start date: " : "End date: ";



                        var divInd = "#" + "div" + index;


                        //Creates a div that will store the start date and end date for a particular Task   
                        if (i.indexOf("start") != -1) {


                            //Creates a label and then pushes it  to the div
                            var div = $("<div></div>");
                            div.prop("id", "div" + index);
                            div.appendTo("#submitEntryEdit");

                        }




                        //Creates a label and then pushes it  to the div
                        var label = $("<label/>");
                        label.html(labelName);
                        label.prop("id", name + index);
                        label.appendTo("#" + "div" + index);



                        //Creates a textfield then puts it to the div
                        var newStart = $("<input type='text'/>");
                        newStart.prop("id", name + '-' + index);
                        newStart.appendTo("#" + "div" + index);
                        newStart.val(new Date(val));



                        $("<br>").appendTo("#" + "div" + index);


                        if (i.indexOf("end") != -1) {

                            //Creates a delete button so you can delete the components
                            var btnDelete = $("<input type='button' value='Delete'></input>");
                            btnDelete.prop("id", "delete-" + index);
                            //Function added to the button
                            $('#submitEntryEdit').on('click', '#delete-' + index, function () {
                                var cat = $('#category').val();
                                var id = getId(this.id);
                                $.each(chartVal, function (i) {
                                    if (chartVal[i].category === cat) {
                                        chartVal[i].segmentList.splice(id, 1);
                                    }
                                    if (chartVal[i].segmentList.length == 0) {
                                        chartVal.splice(i, 1);
                                    }
                                });
                                //Removes the div
                                console.log(chartVal.length);
                                $(divInd).remove();
                                renderChart(chartVal);



                                //Needs to reload the chartVal, containing the new values


                            });

                            btnDelete.appendTo(divInd);
                            $("<br>").appendTo("#submitEntryEdit");
                            index++;

                        }




                    }




                });




            };

            //Method that will add segments to the category selected
            var clickAddSegment = function (event) {




                //






            };








            //Once you click the edit button
            var clickEditEvent = function () {

                //alert("called");
                //Gets the category name of the bar selected and puts it on the text field
                var category = $("#category").val();

                //Loops through the value of the entire chart itself
                for (var i = 0; i < chartVal.length; i++) {

                    //If one of category values of the entire chart is equal to the selected one
                    if (category == chartVal[i].category) {

                        //Loop through the segments of that particular category
                        for (var x = 0; x < chartVal[i].segmentList.length; x++) {

                            //Place the values on the textfields on the html
                            chartVal[i].segmentList[x].startDate = $("#startDate" + x).val();
                            chartVal[i].segmentList[x].endDate = $("#endDate" + x).val();



                        }


                    }




                }



            }



            $("#prvBtn").click(function (event) {


                clickEditEvent();

                alert(JSON.stringify(chartVal));
                //Draws the chart
                renderChart(chartVal);


            });




            //This will draw the chart
            var renderChart = function (data) {

                //Sets the data source    
                chart.dataProvider = data;

                //This method should be called after data in your data provider changed or a new array was set to dataProvider. 
                chart.validateData();

                //Adds event listener to the object.
                chart.addListener("clickGraphItem", clickItemEvent);


            }


            $.ajax({
                type: 'post',
                url: 'getGanttData',
                dataType: 'json',
                data: {},
                cache: false,
                success: function (data) {
                    chartVal = data;
                    console.log(JSON.stringify(data));




                    renderChart(data);
                }
            });


            //Function called when the submit button is selected
            //Gets the value input from the text fields, and then adds it to the current chart graph drawn, and it re-draws the chart
            //This only works when you're adding a new entry, for now
            //Should support edits
            var submitClick = function () {

                //Gets the input here and stores it on the variable
                var category = $("#category").val();
                var startDate = $("#startD").val();
                var endDate = $("#endD").val();



                //Loops through the value of the entire chart itself
                for (var i = 0; i < chartVal.length; i++) {

                    //If the task you typed is already exists
                    if (category == chartVal[i].category) {

                        alert("Task already exists!");
                        return;

                    }




                }



                //Creates a format for the values to be put in the graph
                var ganttData = {category: category, segmentList: [{startDate: startDate, endDate: endDate}]}

                //Place it on the chart
                chartVal.push(ganttData);
                //alert(JSON.stringify(chartVal));
                //Draws the chart
                renderChart(chartVal);
            };

            $("#submitGData").click(submitClick);
            $("#addSegment").click(clickAddSegment);

            function getId(str) {
                var spl = str.split("-");
                return spl[1];
            }
        </script>    





    </body>
</html>
