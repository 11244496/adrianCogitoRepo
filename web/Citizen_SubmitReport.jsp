<%-- 
    Document   : Citizen_CreateTestimonial
    Created on : 02 4, 16, 9:19:44 AM
    Author     : RoAnn 
--%>

<%@page import="Entity.Project"%>
<%@page import="Entity.Citizen"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%Citizen c = (Citizen) session.getAttribute("user");%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Citizen report</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap-reset.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <link href="assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
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
    
        <% Project p = (Project) request.getAttribute("Project");%>



        <section id="main-content">
            <section class="wrapper site-min-height">
                <section class="panel">
                    <header class="panel-heading">
                        Report
                    </header>
                    <br>
                    <form action="Citizen_SubmitReport" class="form-horizontal tasi-form" method="POST" enctype="multipart/form-data">
                        
                        
                        
                        <div class="col-sm-12 panel">
                            <div class="col-sm-6">
                                    <input type="hidden" value="<%=p.getId()%>" name="projectID"/>
                                    <input type="hidden" value="<%=p.getName()%>" name="projectName"/>
                                
                                <label class="col-sm-2 col-sm-2 control-label">Message<i class="formAsterisk">*</i></label>
                                <div class="col-sm-10">
                                    <textarea class="wysihtml5 form-control" required rows="5" name="reportdescription"></textarea>
                                    <span class="help-block">What would you like to report?</span>
                                    <br>
                                </div>
                                <label class="col-sm-2 col-sm-2 control-label">Video</label>
                                <div class="col-sm-10">
                                    <input name="Videos" type="file" class="default form-control" multiple style="border:0"/>
                                    
                                    <br>
                                </div>

                                <label class="col-sm-2 col-sm-2 control-label">Image</label>
                                <div class="col-sm-10">
                                    <input name="Videos" type="file" class="default form-control" multiple style="border:0"/>
                                    
                                    <br>
                                </div>

                                
                            </div>


                            <div class="col-sm-6">
                                
                               
                                
                                <label >Project name: </label> <%=p.getName()%> <br><br>
                                <label >Description: </label> <%=p.getDescription()%> <br>
                                
                                <div class="col-sm-12">
                                    
                                </div>
                            </div>
                        </div>

                        
                        <div>
                            <button type="submit" class="btn btn-success">Submit</button>
                            <button type="button" class="btn btn-danger">Cancel</button>
                        </div>
                        <br>
                        <br>
                        </div>


                    </form>
                    </div>
                </section>
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

    </body>
</html>