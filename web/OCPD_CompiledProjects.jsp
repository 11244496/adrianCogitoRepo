<%-- 
    Document   : OCPD_CompiledProjects
    Created on : 03 17, 16, 2:29:25 AM
    Author     : RoAnn
--%>

<%@page import="DAO.OCPDDAO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Entity.Project"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="Mosaddek">
        <meta name="keyword" content="FlatLab, Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
        <link rel="shortcut icon" href="img/favicon.png">

        <title>Compiled Proposals</title>

        <!-- Bootstrap core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap-reset.css" rel="stylesheet">
        <!--external css-->
        <link href="assets/font-awesome/css/font-awesome.css" rel="stylesheet" />

        <!-- Custom styles for this template -->
        <link href="css/style.css" rel="stylesheet">

        <!-- HTML5 shim and Respond.js IE8 support of HTML5 tooltipss and media queries -->
        <!--[if lt IE 9]>
          <script src="js/html5shiv.js"></script>
          <script src="js/respond.min.js"></script>
        <![endif]-->
    </head>

    <style type='text/css'>
        #rnd_container {background: #FFFFFF; margin:1px;}  


        @media print
        {
            #header {display: none}
            #cssmenu { display: none; }
            #printpage { display: none; }
            #pageHeader{display: none;}
        }

    </style>

    <body>


        <!-- page start-->

        <%
            ArrayList<Project> pList = (ArrayList<Project>) request.getAttribute("pList");
            OCPDDAO oc = new OCPDDAO();
        %>

        <%DecimalFormat df = new DecimalFormat("#,###.00");%>
        <section class="panel">
            <center>
                <br><br>
                <img src="img/icon_lpc.png">
                <header class="panel-heading">
                    <h3>City Government of Las Pinas</h3>
                </header><br>



                <section class="panel">

                    <%for (Project p : pList) {
                            int x = 0;
                    %>

                    <strong><%=p.getName()%></strong>

                    <div class="panel-body bio-graph-info">
                        <!--<h1>New Dashboard BS3 </h1>-->
                        <br>
                        <div>
                            <p><span class="bold">Description </span>: <%=p.getDescription()%></p>
                        </div><br>
                        <div>
                            <p><span class="bold">Category </span>: <%=p.getCategory()%></p>
                        </div><br>
                        <div>
                            <p><span class="bold">Date Submitted</span> : <%=p.getDatesubmitted()%></p>
                        </div>
                        <br>

                        <div class="col-lg-12">
                            
                                <strong>Program of Works</strong>
                            
                            <section class="panel">
                                <div class="panel-body">
                                    <table class="table" style="width:100%; text-align: center">
                                        <%for (int y = 0; y < p.getpWorks().size(); y++) {%>

                                        <tr>
                                            <th colspan="6"><%=p.getpWorks().get(y).getName()%></th>
                                        </tr>
                                        <tr>
                                            <th><center>Name</center></th>
                                        <th><center>Quantity</center></th>
                                        <th><center>Unit</center></th>
                                        <th><center>Unit Price</center></th>
                                        <th><center>Total</center></th>
                                        </tr>
                                        <%for (int z = 0; z < p.getpWorks().get(y).getComponents().size(); z++) {%>
                                        <tr>
                                            <td><%=p.getpWorks().get(y).getComponents().get(z).getName()%></td>
                                            <td><%=p.getpWorks().get(y).getComponents().get(z).getQuantity()%></td>
                                            <td><%=p.getpWorks().get(y).getComponents().get(z).getUnit().getUnit()%></td>
                                            <td><%=p.getpWorks().get(y).getComponents().get(z).getUnitPrice()%></td>
                                            <td><%=p.getpWorks().get(y).getComponents().get(z).getUnitPrice() * p.getpWorks().get(y).getComponents().get(z).getQuantity()%></td>
                                        </tr>


                                        <%}%>

                                        <%}%>

                                    </table>
                                    <br> 
                                    <table class="table" style="width:100%; text-align: center">    
                                        <tr>
                                            <td colspan="4">Total cost: </td>
                                            <td>PHP <%=df.format(oc.getCost(p))%></td>
                                        </tr>

                                        <tr>
                                            <td colspan="4">Indirect Cost 17% of Total Cost: </td>
                                            <td>PHP <%=df.format(oc.getCost(p) * 0.17)%></td>
                                        </tr>

                                        <tr>
                                            <td colspan="4">Tax 5% of Total Cost + Indirect Cost: </td>
                                            <td>PHP <%=df.format((oc.getCost(p) * 0.17) * .05)%></td>
                                        </tr>

                                        <tr>
                                            <td colspan="4">Estimated cost: </td>
                                            <td>PHP <%=df.format(oc.getCost(p) + (oc.getCost(p) * 0.17) + ((oc.getCost(p) * 0.17) * .05))%></td>
                                        </tr>

                                    </table>
                                </div>
                            </section>
                        </div>

                    </div>
                    <%}%>
                </section>
                <div id="printpage">
                    <button onclick="myFunction()">Print</button>
                    <button onclick="cancel()">Cancel</button> <br>
                </div>
            </center>

        </section>
        <!-- page end-->

        <!--main content end-->
        <script>
            function myFunction() {
                window.print();
            }

            function cancel() {
                window.close();
            }
        </script>

    </body>



</html>
