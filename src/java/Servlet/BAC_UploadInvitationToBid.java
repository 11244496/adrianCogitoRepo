/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import DAO.ActivityDAO;
import DAO.BACDAO;
import DAO.CitizenDAO;
import DAO.NotifDAO;
import DAO.OCPDDAO;
import DAO.ScheduleDAO;
import Entity.Activity;
import Entity.Citizen;
import Entity.Contractor_User;
import Entity.Employee;
import Entity.Files;
import Entity.InvitationToBid;
import Entity.Notification;
import Entity.Project;
import Entity.Schedule;
import Entity.ScheduleCalendar;
import Entity.Testimonial;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Pattern;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author Krist
 */
@WebServlet(name = "BAC_UploadInvitationToBid", urlPatterns = {"/BAC_UploadInvitationToBid"})
public class BAC_UploadInvitationToBid extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        try {
            Employee employee = (Employee) session.getAttribute("user");
            InputStream inputStream = null;
            Project project = null;
            String category = null;

            ArrayList<String> files = new ArrayList<String>();
            String id2 = "";

            ActivityDAO actdao = new ActivityDAO();
            NotifDAO ntDAO = new NotifDAO();
            BACDAO bacdao = new BACDAO();

            boolean isMultipart = ServletFileUpload.isMultipartContent(request);
            if (isMultipart) {
                FileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);

                try {
                    //ArrayList<String> 

                    List items = upload.parseRequest(request);
                    Iterator iterator = items.iterator();

                    String id = null;
                    String title = null;

                    File path = null;
                    File uploadedFiles = null;
                    String fileName = null;

                    while (iterator.hasNext()) {
                        FileItem item = (FileItem) iterator.next();

                        if (item.isFormField()) {

                            //Returns the string inside the field
                            String value = item.getString();
                            //returns the name of the field
                            String value2 = item.getFieldName();

                            if (value2.equals("projectId")) {
                                id = value;
                                id2 = value;
                            }
                            if (value2.equals("projectName")) {
                                title = value;
                            }

                        }

                        if (!item.isFormField()) {
                            fileName = item.getName();
                            String root = getServletContext().getRealPath("/");

                            //path where the file will be stored
                            path = new File("C:\\Users\\AdrianKyle\\Desktop\\Final System Thesis 2\\FinalCogitoRepository\\Upload" + "/Bids and Awards Department" + "/Invitations to bid" + "/" + title + " invitation");
                            if (!path.exists()) {
                                boolean status = path.mkdirs();
                            }

                            uploadedFiles = new File(path + "/" + fileName);
                            item.write(uploadedFiles);
                            files.add(fileName);

                        }
                    }

                    OCPDDAO oc = new OCPDDAO();
                    project = oc.getAllProjectDetails(id);

                    bacdao.changeBACStatus1(id);

                    InvitationToBid invite = new InvitationToBid(0, fileName, null, project, "chrome-extension://cnjcgmljpkljlbhadlljlbhjkcbhlpcc/" + "Bids and Awards Department" + "/Invitations to bid" + "/" + title + " invitation");
                    bacdao.uploadInvitation(invite);

                    //Set Bidding Schedule
                    ScheduleCalendar sc = new ScheduleCalendar();
                    sc.createBiddingSched(oc.getBasicProjectDetails(id));
                    ScheduleDAO sd = new ScheduleDAO();
                    sd.insertBiddingSchedule(sc.getBidding());

                } catch (FileUploadException e) {
                    e.printStackTrace();
                } catch (Exception ex) {
                    Logger.getLogger(BAC_UploadInvitationToBid.class.getName()).log(Level.SEVERE, null, ex);
                }

            }
            
            actdao.addActivity(new Activity(0, "you uploaded invitation to bid", null, employee.getUser()));
            ArrayList<Contractor_User> conuser = bacdao.getAllContractors();
            
//            for(int x = 0; x < conuser.size();x++){
//            ntDAO.addNotification(new Notification(0, "Uploaded invitation to bid for project " + project.getName(), null, conuser.get(x).getUser()));
//            }

            request.setAttribute("success", "Success");
            ServletContext context = getServletContext();
            RequestDispatcher dispatch = context.getRequestDispatcher("/BAC_Home");
            dispatch.forward(request, response);

        } finally {
            out.close();
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(BAC_UploadInvitationToBid.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(BAC_UploadInvitationToBid.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
