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
    ArrayList<InvitationToBid> invitation = (ArrayList<InvitationToBid>) request.getAttribute("invitation");
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
<%ArrayList<Files> pfiles = (ArrayList<Files>) request.getAttribute("pFiles");%>


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
                            <li><a  href="Contractor_ViewEligibleProjects">&nbsp; &nbsp; &nbsp; &nbsp;Upload Works and Gantt</a></li>
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
                        Invitation to bid
                    </header>
                    <br>
                    <div class="panel-body">

                        <div class="row">
                            <div class="col-md-12">
                                <section class="panel">


                                    <div class="panel-body bio-graph-info">
                                        <!--<h1>New Dashboard BS3 </h1>-->

                                        Sample File:
                                        <%

                                            if (invitation.isEmpty() == false) {
                                                String d;
                                                for (int x = 0; x < invitation.size(); x++) {
                                                    d = invitation.get(x).getFolderName() + "/" + invitation.get(x).getFileName();


                                        %>

                                    </div>
                                    <center>    
                                        <div>
                                            <iframe src="<%=d%>" width="1000" height="800"></iframe>
                                        </div>   
                                    </center> 

                                    <%

                                            }
                                        }

                                    %>  









                                </section>






                            </div>

                        </div>



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
                                                        <td>PHP <%=df.format(pworks.get(x).getComponents().get(y).getUnitPrice())%></td>
                                                        <td>PHP <%=df.format(pworks.get(x).getComponents().get(y).getUnitPrice() * pworks.get(x).getComponents().get(y).getQuantity())%></td>
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

                            <!------------------------------------------------------Calendar SCHEDULE------------------------------------------>

                            <section class="panel">
                                <div class="bio-graph-heading project-heading">
                                    <strong>Schedule</strong>
                                </div>
                                <div class="panel-body bio-graph-info">
                                    <div id='calendar' style="height: 100%; width: 100%"></div>
                                </div>
                                <br>
                            </section>

                            <!-------------------------------------------------MAIN TESTIMONIAL UPLOADS------------------------------------------>
                            <section class="panel">
                                <div class="bio-graph-heading project-heading">
                                    <strong>Project Main Testimonial</strong>
                                </div>
                                <div class="panel-body bio-graph-info" style="height: 250px;">
                                    <div class="DocumentList2">
                                        <div class="row2">
                                            <%String url = null;%>
                                            <%Testimonial t = p.getMainTestimonial();
                                                for (Files f : t.getFiles()) {
                                                    url = t.getFolderName() + "/" + t.getTitle() + "/" + f.getFileName();
                                                    if (f.getType().equalsIgnoreCase("image")) {%>

                                            <div class="col-lg-3 DocumentItem2">
                                                <img src="<%=url%>" style="width:100%; height:100%">
                                                <br/>
                                                <button type="button" value="<%=f.getId()%>" class="btn btn-info btn-sm" onclick="getTestimonial(<%=f.getId()%>)" style="width:100%; position: absolute; bottom:0;">View Details</button>                                        
                                            </div>

                                            <%} else if (f.getType().equalsIgnoreCase("video")) {%>

                                            <div class="col-lg-3 DocumentItem2">
                                                <video style="position: absolute; width: 100%; height: 100%; top:0px; left:0px;">
                                                    <source src="<%=url%>" type="video/mp4">
                                                </video>
                                                <br/>
                                                <button type="button" class="btn btn-info btn-sm" style="width:100%; position: absolute; bottom:0;" onclick="getTestimonial(<%=f.getId()%>)">View Details</button>                                        
                                            </div>

                                            <%} else if (f.getType().equalsIgnoreCase("document")) {%>
                                            <div class="col-lg-3 DocumentItem2">
                                                <img src="img/docu.png" style="width:50px; height:50px; vertical-align: middle;">
                                                <br/>
                                                <button type="button" value="<%=f.getId()%>" class="btn btn-info btn-sm" onclick="getTestimonial(<%=f.getId()%>)" style="width:100%; position: absolute; bottom:0;">View Details</button>                                        
                                            </div>

                                            <%}
                                                }
                                            %>
                                        </div>
                                    </div>
                                </div>
                            </section>                        

                            <!------------------------------------------------------GS UPLOADS------------------------------------------>
                            <section class="panel">
                                <div class="bio-graph-heading project-heading">
                                    <strong>Project Files</strong>
                                </div>
                                <div class="panel-body bio-graph-info" style="height: 250px;">
                                    <div class="DocumentList2">
                                        <div class="row2">
                                            <%
                                                for (Files f : pfiles) {

                                                    url = p.getFoldername() + "/" + p.getId() + "/" + f.getFileName();
                                                    if (f.getType().equalsIgnoreCase("image")) {%>

                                            <div class="col-lg-3 DocumentItem2">
                                                <img src="<%=url%>" style="width:100%; height:100%">
                                                <br/>
                                                <button type="button" value="<%=f.getId()%>" class="btn btn-info btn-sm" onclick="getProjectFiles(<%=f.getId()%>)" style="width:100%; position: absolute; bottom:0;">View Details</button>                                        
                                            </div>

                                            <%} else if (f.getType().equalsIgnoreCase("video")) {%>

                                            <div class="col-lg-3 DocumentItem2">
                                                <video style="position: absolute; width: 100%; height: 100%; top:0px; left:0px;">
                                                    <source src="<%=url%>" type="video/mp4">
                                                </video>
                                                <br/>
                                                <button type="button" class="btn btn-info btn-sm" style="width:100%; position: absolute; bottom:0;" onclick="getProjectFiles(<%=f.getId()%>)">View Details</button>                                        
                                            </div>

                                            <%} else if (f.getType().equalsIgnoreCase("document")) {%>
                                            <div class="col-lg-3 DocumentItem2">
                                                <img src="img/docu.png" style="width:50px; height:50px; vertical-align: middle;">
                                                <br/>
                                                <button type="button" value="<%=f.getId()%>" class="btn btn-info btn-sm" onclick="getProjectFiles(<%=f.getId()%>)" style="width:100%; position: absolute; bottom:0;">View Details</button>                                        
                                            </div>

                                            <%}

                                                }
                                            %>
                                        </div>
                                    </div>
                                </div>

                                <form action="Contractor_UploadDocPage" class="form-horizontal tasi-form" method="POST">  
                                    <input type="hidden" name="projectID" value="<%=p.getId()%>">


                                    <hr>

                                    <center>
                                        <div>
                                            <br>    
                                            <br>


                                            <button id="respondToInvite" class="btn btn-success" type="submit" disabled>Respond to invitation</button>  


                                            <button class="btn btn-default" type="button" onclick="history.go(-1)">Back</button>  
                                        </div>
                                    </center>   
                                    <br>   
                                </form>         
                            </section>


                        </div>

                    </div>

                    <!-- page end-->
                </section>
            </section>

            <div id="testModal" class="modal fade " data-keyboard="false" data-backdrop="static">
                <div class="modal-dialog">

                    <div class="modal-content" style="">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">x</span> <span class="sr-only">close</span></button>
                            <h4 id="" class="modal-title">Testimonial Details</h4>
                        </div>
                        <div id="modalBody" class="modal-body" style="overflow-y: auto;">
                            <div id="fDisplay"></div>
                            <fieldset title="Description" id="abcd" class="step" id="default-step-0">
                                <header id="testTitle" class="panel-heading"></header>
                                <header id="testDate" class="panel-heading"></header>
                                <header id="testLoc" class="panel-heading"></header>
                                <header id="testDesc" class="panel-heading"></header>
                            </fieldset>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" id="closeModalB" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>

            <div id="projectFiles" class="modal fade " data-keyboard="false" data-backdrop="static">
                <div class="modal-dialog">

                    <div class="modal-content" style="">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">x</span> <span class="sr-only">close</span></button>
                            <h4 id="" class="modal-title">Project File</h4>
                        </div>
                        <div id="modalBody" class="modal-body" style="overflow-y: auto;">
                            <div id="pfDisplay"></div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" id="closeModalB" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>



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
            var proj = "<%=projid%>";
            var cont = "<%=conid%>";

            $(document).ready(function () {
                $.ajax({
                    type: 'POST',
                    url: 'AJAX_Contractor_CheckPage',
                    dataType: 'json',
                    cache: false,
                    data: {contprojID: cont, projID: proj},
                    success: function (text) {

                        if (text === "Y") {

                            document.getElementById("respondToInvite").disabled = true;

                        }
                        else {
                            document.getElementById("respondToInvite").disabled = false;

                        }


                    }
                });
            });
        </script>

        <script>
            function checkPage(cont, proj) {

                $.ajax({
                    type: 'POST',
                    url: 'AJAX_Contractor_CheckPage',
                    dataType: 'json',
                    cache: false,
                    data: {contprojID: cont, projID: proj},
                    success: function (text) {
                        console.log(text);

                        if (text === "Y") {

                            document.getElementById("respondToInvite").disabled = true;

                        }
                        else {
                            document.getElementById("respondToInvite").disabled = false;

                        }


                    }
                });

            }
            ;



        </script>
        <script>
            function getTestimonial(id) {
                $.ajax({
                    type: 'POST',
                    url: 'AJAX_BAC_gettestimonial',
                    dataType: 'json',
                    data: {testId: id}, cache: false,
                    success: function (f) {
                        $('#fDisplay').empty();
                        var url = f.testimonial.folderName + "/" + f.testimonial.title + "/" + f.fileName;
                        if (f.type === "Video") {
                            $("<div data-p=\"144.50\"><video><source src=\"" + url + "\" type=\"video/mp4\"><source src=" + url + " type=\"video/ogg\"></video></div>").appendTo("#fDisplay");

                        }
                        else if (f.type === "Image") {
                            $("<img src=\"" + url + "\" style=\"max-width: 570px; height:400px;\">").appendTo("#fDisplay");

                        }

                        else if (f.type === "Document") {
                            $("#docH").remove();
                            $("<header id=\"docH\" class=\"panel-heading\">File: " + "<a class=\"panel-heading\" href=\"" + url + "\">" + f.fileName + "</a> </header>").appendTo("#abcd");
                        }
                        $('#testTitle').text("Title: " + f.testimonial.title);
                        $('#testDate').text("Date Uploaded: " + f.testimonial.dateUploaded);
                        $('#testLoc').text("Location Details: " + f.testimonial.location + " + " + f.testimonial.locationdetails);
                        $('#testDesc').text("Description: " + f.testimonial.message);
                        $('#testModal').modal();
                    }
                });
            }
            ;


            function getProjectFiles(id) {
                $.ajax({
                    type: 'POST',
                    url: 'AJAX_BAC_getProjectFiles',
                    dataType: 'json',
                    data: {testId: id}, cache: false,
                    success: function (f) {
                        $('#pfDisplay').empty();
                        var url = "<%=p.getFoldername()%>" + "/" +<%=p.getId()%> + "/" + f.fileName;
                        if (f.type === "Video") {
                            $("<div data-p=\"144.50\"><video><source src=\"" + url + "\" type=\"video/mp4\"><source src=" + url + " type=\"video/ogg\"></video></div>").appendTo("#pfDisplay");

                        }
                        else if (f.type === "Image") {
                            $("<img src=\"" + url + "\" style=\"max-width: 570px; height:400px;\">").appendTo("#pfDisplay");

                        }

                        else if (f.type === "Document") {
                            $("#docH").remove();
                            $("<header id=\"docH\" class=\"panel-heading\">File: " + "<a class=\"panel-heading\" href=\"" + url + "\">" + f.fileName + "</a> </header>").appendTo("#pfDisplay");
                        }
                        $('#projectFiles').modal();
                    }
                });
            }
            ;
        </script>
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
            var cal = <%=session.getAttribute("calendar")%>;
            $('document').ready(function () {

                $('#calendar').fullCalendar({
                    defaultView: 'month',
                    schedulerLicenseKey: 'GPL-My-Project-Is-Open-Source',
                    header: {
                        left: '',
                        center: 'title',
                        right: 'today prev,next'
                    }
                });
                inputActivities(cal);

            });

            function inputActivities(sched) {
                $('#calendar').fullCalendar('removeEvents');
                $.each(sched, function (i) {
                    var my_events = {
                        events: [
                            {
                                title: sched[i].event,
                                start: sched[i].startdate,
                                end: sched[i].enddate,
                                status: sched[i].status,
                            }
                        ]
                    };

                    $('#calendar').fullCalendar('addEventSource', my_events);
                });
            }

        </script>
    </body>
</html>
