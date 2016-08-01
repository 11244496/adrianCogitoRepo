<%@page import="Entity.Contractor_User"%>
<%@page import="Entity.Employee"%>
<%@page import="Entity.Notification"%>
<%@page import="Entity.Activity"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Entity.Citizen"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%Contractor_User cu = (Contractor_User) session.getAttribute("user");%>
<!DOCTYPE html>
<html lang="en">
    <head>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="Mosaddek">
        <meta name="keyword" content="FlatLab, Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
        <link rel="shortcut icon" href="img/favicon.png">


        <title>Activity and Notification</title>

        <!-- Bootstrap core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap-reset.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <link href="assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
        <link rel="stylesheet" type="text/css" href="assets/gritter/css/jquery.gritter.css" />

        <style>
            table.table {
                display: table;
                width: 100%;
            }
            table.table thead, table.table tbody {
                float: left;
                width: 100%;
            }
            table.table tbody {
                overflow: auto;
                height: 200px;
                display: inline-block;
            }
            table.table tr {
                width: 100%;
                display: table;
                text-align: left;
            }
            table.table th, table.table td {
                width: 33%;
                display: inline-block;
                overflow: auto;
            }

        </style>


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
                                <span class="username">Hello <b><u><%=cu.getName()%></u></b>!</span>
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
                            <a href="Contractor_ActivityandNotification"  class="active">
                                <i class="fa fa-dashboard"></i>
                                <span>View Activity and Notifications</span>
                            </a>
                        </li>



                    </ul>
                </div>
            </aside>
            <!--main content start-->

            <%

                ArrayList<Activity> activities = (ArrayList<Activity>) request.getAttribute("alist");

                ArrayList<Notification> notification = (ArrayList<Notification>) request.getAttribute("nlist");

            %>


            <section id="main-content">
                <section class="wrapper site-min-height">
                    <!-- page start-->
                    <section class="panel">
                        <header class="panel-heading">
                            Notifications and Activity
                        </header>
                        <br>
                        <div class="panel-body">
                            <div class="">
                                <section class="panel">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>Notification</th>
                                                <th>Date</th>
                                                <th>Time</th>

                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%                                                for (int x = 0; x < notification.size(); x++) {

                                            %>

                                            <tr>
                                                <td><%out.print(notification.get(x).getNotification());%></td>
                                                <td><%out.print(notification.get(x).getDateTime().substring(0, 10));%></td>
                                                <td><%out.print(notification.get(x).getDateTime().substring(11, 19));%></td>
                                            </tr>
                                            <%                                                }

                                            %>
                                        </tbody>
                                    </table>
                                </section>
                            </div>




                        </div>


                        <div class="panel-body">

                            <div class="">
                                <section class="panel">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>Activity</th>
                                                <th>Date</th>
                                                <th>Time</th>

                                            </tr>
                                        </thead>
                                        <tbody>

                                            <%                                                for (int x = 0; x < activities.size(); x++) {

                                            %>

                                            <tr>
                                                <td><%out.print(activities.get(x).getActivity());%></td>
                                                <td><%out.print(activities.get(x).getDateTime().substring(0, 10));%></td>
                                                <td><%out.print(activities.get(x).getDateTime().substring(11, 19));%></td>
                                            </tr>
                                            <%                                                }

                                            %>


                                        </tbody>
                                    </table>
                                </section>
                            </div>                


                        </div>


                    </section>


                    <!-- page end-->
                </section>
            </section>
            <!--main content end-->
        </section>
        <!--footer start-->
        <footer class="site-footer">
            <div class="text-center">
                2016 &copy; KAYA
                <a href="#" class="go-top">
                    <i class="fa fa-angle-up"></i>
                </a>
            </div>
        </footer>
        <!--footer end-->
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
    </body>
</html>
