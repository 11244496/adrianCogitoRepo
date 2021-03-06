<%@page import="com.google.gson.Gson"%>
<%@page import="Entity.Timeline_Update"%>
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


    <% 
        Employee e = (Employee) session.getAttribute("user");
       

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
                                <li><a  href="GS_CreateProposal.jsp">&nbsp; &nbsp; &nbsp; &nbsp; Create Proposal</a></li>
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
                               
                                 
                        <form action="GS_TimelineUpdate">
                        
                        <div>
                            <input type="hidden" name="projectID" value="<%=project.getId()%>">
                            <h4><label>Contact contractor</label></h4><br>
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
                                        for(int x= 0; x < tList.size();x++){
                                           // int repid = tList.get(x).getID();
                                       
                                        %>
                                        
                                        <tr>
                                            
                                            <td>
                                              <%=tList.get(x).getMessage()%>
                                            </td>
                                            <td>
                                                <button id="viewMedia" type="button" class="btn btn-round btn-info" onClick='javascript:getReport("<%=tList.get(x).getID()%>")'>Open report</button>
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
                                        
                                        
                                        
                <!-- page end-->
            </section>
        </section>
        </section>

        <div class="modal fade" id="adjustModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">�</button>
                        <h4 class="modal-title" id="adjMheader"></h4>
                    </div>
                    <div class="modal-body">


                        <div class="form-group">
                            <label class="control-label pull-left regFieldTitle">Set Date: </label>
                            <input type="date" class="form-control" name="SetDate" id="startDM">
                        </div>
                        <div class="form-group">
                            <label class="control-label pull-left regFieldTitle">Set Time: </label>
                            <input type="time" class="form-control" name="timeDM" id="timeDM">
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-success" type="button" id="submitadjustModal"> Save</button>
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
