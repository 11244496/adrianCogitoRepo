<%@page import="Entity.Inspection_Report"%>
<%@page import="Entity.Project_has_Pwork"%>
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
            
            <%
            
            Project project = (Project) request.getAttribute("project");    
            ArrayList<Inspection_Report> listDate = (ArrayList<Inspection_Report>) request.getAttribute("listDate");
            
            %>
            
            
            <section id="main-content">
            <section class="wrapper site-min-height">
                <section class="panel">
                    <header class="panel-heading">
                       <b> Project: </b> <%=project.getName()%> <br><br>
                        <b>Description: </b> <%=project.getDescription()%> 
                        
                        <button class="btn btn-info" type="button" style="float: right;" onClick="javascript:getWorkItems('<%=project.getId()%>')">Submit Inspection</button>    
                        
                       
                      
                       <br>
                       <br>
                    </header>
                    <br>
                    
                        
                        
                        
                        <div class="col-sm-12 panel">
                            <div class="col-sm-4">
                               
                               
                                <table class="table table-striped table-advance table-hover">
                                     <thead>
                                     <th>Inspection date</th>
                                     <th></th>
                                     
                                     </thead>    
                                    <tbody>
                                        
                                         <%
                                        
                                        for(int x = 0; x < listDate.size();x++){
                                        
                                        String date = listDate.get(x).getDateUploaded();
                                        String idd = project.getId();
                                        %>
                                        <tr>
                                            <td>
                                                <%out.print(date);%>
                                            </td>
                                            
                                            <td>
                                                <button id="viewMedia" type="button" class="btn btn-round btn-danger" onClick='javascript:getReport("<%=idd%>","<%=date%>")'>Open report</button>
                                            </td>    
                                        </tr>                                        
                                        <%
                                        
                                        }
                                        
                                        %>
                                        
                                        
                                    </tbody>    
                                    
                                    
                                </table>    
                                            <br>
                                            <br>
                                
                              

                                
                            </div>


                            <div class="col-sm-8">
                                
                               
                                <div id="fileFeed" class="modal-body">
                                    


                                </div>
                                
                                
                                
                                <div class="col-sm-12">
                                    
                                </div>
                            </div>
                        </div>

                         
                        
                        


                  
                  
                </section>
            </section>
                                    
                                        
                      <div class="modal fade" id="inspectionreport" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-md">
                    <div class="modal-content">

                        <form action="GS_SubmitInspectionEntry">
                            
                            
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                
                                <h5>New Inspection</h5>
                            </div>
                            <div class="modal-body">
                              
                                
                                <div id="itemField">
                                    
                                       
                                    
                                </div>    
                                   
                                
                                    
                            </div>
                            <div class="modal-footer">
                                
                                <input type="hidden" id="listSize" name="listSize" value="">
                                <input type="hidden" id="projectID" name="projectID" value="<%=project.getId()%>">
                                

                                <button class="btn btn-success" type="submit">Submit</button>
                                <button data-dismiss="modal" class="btn btn-default" type="button">Close</button>

                            </div>
                        </form>

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
            function getReport(projid,date) {
                
                $.ajax({
                    type: 'POST',
                    url: 'GS_OpenInspectionReport',
                    dataType: 'json',
                    cache: false,
                   data: {projid: projid, date: date},
                    success: function (file) {
                        
                        $("#fileFeed").empty();
                          
                         var table = $("<table/>");
                          table.prop("id", "table");
                          table.prop("class", "table table-bordered table-striped table-condensed");
                          table.appendTo("#fileFeed");  
                          
                          var thead = $("<thead/>");
                          thead.prop("id", "thead");
                          thead.appendTo("#table");
                          
                          var th = $("<th/>");
                          th.text("Work Items")
                          th.appendTo("#thead");
                          
                          var th2 = $("<th/>");
                          th2.text("Remarks")
                          th2.appendTo("#thead");
                          
                           var tbody = $("<tbody/>");
                          tbody.prop("id", "tbody");
                          tbody.appendTo("#table");
                          
                        $.each( file, function( i, l ){
                            
                            
                          
                          var tr = $("<tr/>");
                          tr.prop("id", "tr"+i);
                          tr.appendTo("#tbody");
                          
                          var td = $("<td/>");
                          td.text(file[i].task.name);
                          td.appendTo("#tr"+i);
                          
                          var td2 = $("<td/>");
                          td2.text(file[i].Remark);
                          td2.appendTo("#tr"+i);
                          
                          
                          
                          
                          
                        });


                         $("<br>").appendTo("#fileFeed");
                          
                          var label = $("<label/>");
                          label.text("Date inspected :      ");
                          label.prop("id", "label");
                          label.appendTo("#fileFeed");
                          
                          
                          
                          var label2 = $("<label/>");
                          label2.text(file[0].DateUploaded);
                          label2.prop("id", "label2");
                          label2.appendTo("#fileFeed");
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
        
        
        
        <script>
            function getWorkItems(projid) {
                var proj = projid;
                console.log("value: " - proj);
                
                $.ajax({
                    type: 'POST',
                    url: 'GS_GetWorkItems',
                    dataType: 'json',
                    cache: false,
                   data: {projid: projid},
                    success: function (file) {
                        
                        $("#itemField").empty();
                        var itemNames = [];
                          
                         
                          
                        $.each( file, function( i, l ){
                            
                        var item = file[i].task.name; 
                        var start = file[i].startdate;
                        var end = file[i].enddate;
                        //$('#testValue').text("Sample: " + file[0].pwork.name); 
                        
                        var checkinput = $("<input type='checkbox'/>");
                        checkinput.prop("id", "checkboxinput");
                        checkinput.prop("name", "checkboxinput");
                        checkinput.val(file[i].task.id);
                        checkinput.appendTo("#" + "itemField");
                        
                        var label = $("<label/>");
                        label.html(item);
                        label.prop("id", "label-" + i);
                        label.appendTo("#" + "itemField");
                        
                        
                        
                        var label1 = $("<label/>");
                        label1.text("Start date: " + start);
                        label1.prop("id", "label1-" + i);
                        label1.prop("style", "margin-left: 10%");
                        label1.appendTo("#" + "itemField");
                        
                        
                        var label2 = $("<label/>");
                        label2.text("End date: " + end);
                        label2.prop("id", "label2-" + i);
                        label2.prop("style", "margin-left: 10%");
                        label2.appendTo("#" + "itemField");
        
                        /*
                        var input = $("<input type='text'/>");
                        input.prop("id", "input-" + i);
                        input.prop("name", "input-" + i);
                        input.prop("style", "margin-left:5em");
                        
                        input.appendTo("#" + "itemField");
                        
                      
                        
                        itemNames.push(item);
                        
                        $("#workItemNames").val(itemNames);

                          */
                         
                        itemNames.push(file[i].task.id);
                        $("<br>").appendTo("#" + "itemField");
                        
                
                        var input = $("<textarea required rows='5'/>");
                        input.prop("id", "input-" + i);
                        input.prop("name", "input-" + i);
                        input.prop("style", "width: 98%");
                        
                        input.appendTo("#" + "itemField");
                        
                        });

                        $("<br>").appendTo("#" + "itemField");
                        
                        $("#listSize").val(itemNames);
                          
                        $('#inspectionreport').modal();
                        
                        
                        

                    }
                });

            }
        </script>
  
        
        
         <!-- Modal -->
                             
                              <!-- modal -->
        

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
    </body>
</html>
