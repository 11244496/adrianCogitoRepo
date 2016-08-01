<%-- 
    Document   : Citizen_Home
    Created on : 02 4, 16, 9:19:29 AM
    Author     : RoAnn
--%>


<%@page import="Entity.Progress_Report"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Entity.Project"%>
<%@page import="Entity.Contractor_User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%Contractor_User c = (Contractor_User) session.getAttribute("user");%>
<%
    ArrayList<Progress_Report> progressList = (ArrayList<Progress_Report>) request.getAttribute("reportList");
    Project project = (Project) request.getAttribute("project");

%>

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
                <section class="panel">
                    <header class="panel-heading">
                        <b> Project: </b> <%=project.getName()%> <br><br>
                        <b>Description: </b> <%=project.getDescription()%> 

                        <button id="" style="float: right;"type="button" class="btn btn-default btn-danger" data-toggle="modal" href="#submitProgress">Submit Progress Report</button>
                        <br>
                        <br>
                    </header>
                    <br>




                    <div class="col-sm-12 panel">
                        <div class="col-sm-4">

                            <table class="table table-striped table-advance table-hover">
                                <thead>
                                <th>Date posted</th>
                                <th></th>

                                </thead>    
                                <tbody>
                                    <%
                                        for (int x = 0; x < progressList.size(); x++) {
                                            int repid = progressList.get(x).getID();

                                    %>

                                    <tr>

                                        <td>
                                            <%=progressList.get(x).getDateUploaded()%>
                                        </td>
                                        <td>
                                            <button id="viewMedia" type="button" class="btn btn-round btn-info" onClick='javascript:getReport(<%=repid%>)'>Open report</button>
                                        </td>    
                                    </tr>    



                                    <%
                                        }


                                    %>

                                </tbody>    


                            </table>    




                        </div>


                        <div class="col-sm-8">


                            <div id="fileFeed" class="modal-body">



                            </div>



                            <div class="col-sm-12">

                            </div>
                        </div>
                    </div>



                    <br>
                    <br>

                </section>
            </section>

            <form action="Contractor_SubmitProgressReport" class="form-horizontal tasi-form" method="POST" enctype="multipart/form-data">

                <div class="modal fade " id="submitProgress" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">






                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                <h4 class="modal-title">Submit Progress Report</h4>
                            </div>
                            <div class="modal-body">

                                <br>
                                <label class="col-sm-2 col-sm-2 control-label">Update:<i class="formAsterisk">*</i></label>
                                <div class="col-sm-10">
                                    <textarea class="wysihtml5 form-control" required rows="5" name="reportdescription"></textarea>
                                    <span class="help-block">Provide necessary updates regarding the progress of the project</span>
                                    <br>
                                </div>
                                <br>
                                <br>
                                <label class="col-sm-2 col-sm-2 control-label">Attach report: </label>
                                <br>
                                <div class="col-sm-10">
                                    <input name="Document" type="file" class="default form-control" multiple style="border:0"/>

                                    <br>
                                </div>




                            </div>

                            <!-- Modal -->
                            <input type="hidden" value="<%=project.getId()%>" name="projectID"/>
                            <div class="modal-footer">

                                <button class="btn btn-success" type="submit">Submit</button>
                                <button data-dismiss="modal" class="btn btn-default" type="button">Close</button>
                            </div>

                        </div>
                    </div>

                </div>
                <!-- modal -->

            </form>         



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
            function getReport(repId) {
                //console.log("-------" + repId);
                $.ajax({
                    type: 'POST',
                    url: 'Contractor_GetProgressReport',
                    dataType: 'json',
                    cache: false,
                    data: {reportId: repId},
                    success: function (file) {

                        $("#fileFeed").empty();

                        var label = $("<label/>");
                        label.text("Message: ")
                        label.prop("id", "label");
                        label.appendTo("#fileFeed");

                        $("<br>").appendTo("#fileFeed");

                        var label2 = $("<label/>");
                        label2.text(file.Message);
                        label2.prop("id", "label2");
                        label2.appendTo("#fileFeed");

                        $("<br>").appendTo("#fileFeed");
                        $("<br>").appendTo("#fileFeed");


                        var frame = $("<iframe/>");
                        frame.prop("id", "iframe");
                        frame.prop("src", file.FolderName + "/" + file.FileName);
                        frame.prop("height", "300");
                        frame.prop("width", "700");

                        frame.appendTo("#fileFeed");

                        $("<br>").appendTo("#fileFeed");
                        $("<br>").appendTo("#fileFeed");





//                        $.each(file, function (i) {
//                                    
//                                    console.log(file[i].citizenReport.foldername + "/" + file[i].filename);
//                                });

                        //var path = file.citizenReport.foldername + "/" + file.filename;
                        //var dateuploaded = file.DateUploaded;
                        //var docType = file.type;
                        //$('#frameDoc').attr('src', path);
                        //$('#doctype').text(docType);
                        //$('#dateuploaded').text("Date uploaded: " + dateuploaded);
                        //$('#eligibilitydocuments').modal();

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
    </body>
</html>
