/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import DAO.ActivityDAO;
import DAO.CitizenDAO;
import DAO.OCPDDAO;
import Entity.Activity;
import Entity.Citizen;
import Entity.Citizen_Report;
import Entity.Files;
import Entity.Project;
import Entity.Report_File;
import Entity.Testimonial;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import static java.lang.System.out;
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
@WebServlet(name = "Citizen_SubmitReport", urlPatterns = {"/Citizen_SubmitReport"})
public class Citizen_SubmitReport extends HttpServlet {

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
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        ActivityDAO actdao = new ActivityDAO();
        try {
            CitizenDAO citizenDAO = new CitizenDAO();
            OCPDDAO oc = new OCPDDAO();
            InputStream inputStream = null;
            Citizen c = (Citizen) session.getAttribute("user");

            String category = null;

            ArrayList<String> files = new ArrayList<String>();

            boolean isMultipart = ServletFileUpload.isMultipartContent(request);
            if (isMultipart) {
                FileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);

                try {
                    //ArrayList<String> 

                    List items = upload.parseRequest(request);
                    Iterator iterator = items.iterator();

                    
                    String message = null;
                    

                    File path = null;
                    File uploadedFiles = null;
                    String fileName = null;
                    Citizen user = (Citizen) session.getAttribute("user");
                    String projectId = null;
                    String projectName = null;
                    
                    Project proj = null;
                    
                    while (iterator.hasNext()) {
                        FileItem item = (FileItem) iterator.next();

                        if (item.isFormField()) {

                            //Returns the string inside the field
                            String value = item.getString();
                            //returns the name of the field
                            String value2 = item.getFieldName();

                           
                            if (value2.equals("reportdescription")) {
                                message = value;
                            }
                            if (value2.equals("projectID")) {
                                projectId = value;
                                proj = oc.getBasicProjectDetails(projectId);
                            }
                            if (value2.equals("projectName")) {
                                projectName = value;
                            }
                            

                        }
                        
                        
                        
                        if (!item.isFormField()) {
                            fileName = item.getName();
                            if (!fileName.isEmpty()) {
                                String root = getServletContext().getRealPath("/");
                                
                                
                                
                                //path where the file will be stored
                                path = new File("C:\\Users\\AdrianKyle\\Desktop\\Final System Thesis 2\\FinalCogitoRepository\\Upload" + "/" + projectName + " - " + user.getFirstName() + user.getLastName() + "'s report");
                                if (!path.exists()) {
                                    boolean status = path.mkdirs();
                                }

                                uploadedFiles = new File(path + "/" + fileName);
                                item.write(uploadedFiles);
                                files.add(fileName);
                            }else{
                                
                            }
                        }
                    }

                    
                    for (int x = 0; x < files.size(); x++) {

                        String filename = files.get(x);
                        if (!filename.isEmpty()) {
                            String[] parts = filename.split(Pattern.quote("."));
                            String extension = parts[1];
                            //Videos
                            if (extension.equalsIgnoreCase("mp4") || extension.equalsIgnoreCase("avi") || extension.equalsIgnoreCase("3gp") || extension.equalsIgnoreCase("flv") || extension.equalsIgnoreCase("wmv")) {
                                category = "video";
                                break;
                            } //Images
                            else if (extension.equalsIgnoreCase("png") || extension.equalsIgnoreCase("jpeg") || extension.equalsIgnoreCase("jpg") || extension.equalsIgnoreCase("bmp")) {
                                category = "image";
                                break;
                            }
                        }
                    }
                        
                        //citizenDAO.uploadReport(r);
                        //Testimonial t = new Testimonial(0, title, null, description, "chrome-extension://pediieahejagkkidddjjbiaocanpcjik/Citizen/" + title, location, locationdetails, category, null,"Pending", user);
                        //Testimonial t = new Testimonial(0, title, null, description, "chrome-extension://hjllakiciieioomhnnoiljeofbacabpc/" + title, location, locationdetails, category, null, user);
                        //Upload testimonial
                        //citizenDAO.uploadTestimonial(t);
                        
                        Citizen_Report report = new Citizen_Report(0, message, "chrome-extension://cnjcgmljpkljlbhadlljlbhjkcbhlpcc/"+projectName + " - " + user.getFirstName() + user.getLastName() + "'s report" ,null, user, proj);
                        
                        citizenDAO.uploadCitizenReport(report);
                        int id = citizenDAO.getRecentPostid(user, message);
                        report.setId(id);
                       
                        //Add activity
                        actdao.addActivity(new Activity(0, "you have submitted a report", null, user.getUser()));

                        //Place in appropriate tables
                        for (int x = 0; x < files.size(); x++) {

                            String filename = files.get(x);
                            if (!filename.isEmpty()) {

                                String[] parts = filename.split(Pattern.quote("."));
                                String extension = parts[1];
                                //Videos
                                if (extension.equalsIgnoreCase("mp4") || extension.equalsIgnoreCase("avi") || extension.equalsIgnoreCase("3gp") || extension.equalsIgnoreCase("flv") || extension.equalsIgnoreCase("wmv") || extension.equalsIgnoreCase("mkv")) {
                                    Report_File rf = new Report_File();
                                    rf.setFilename(files.get(x));
                                    rf.setType("Video");
                                    
                                    rf.setCitizenReport(report);
                                    rf.setUploader(c.getFirstName());
                                    rf.setDescription("Submitted video");
                                    //Get the project
                                    rf.setProject(proj);
                                    //rf.setStatus("Approved");
                                    
                                    //upload report files
                                    citizenDAO.uploadFiles(rf);
                                    

                                } //Images
                                else if (extension.equalsIgnoreCase("png") || extension.equalsIgnoreCase("jpeg") || extension.equalsIgnoreCase("jpg") || extension.equalsIgnoreCase("bmp")) {
                                    Report_File rf = new Report_File();
                                    rf.setFilename(files.get(x));
                                    rf.setType("Image");
                                    rf.setCitizenReport(report);
                                    rf.setUploader(c.getFirstName());
                                    rf.setDescription("Submitted image");
                                    //Get the project
                                    rf.setProject(proj);
                                    //rf.setStatus("Approved");
                                    
                                    //upload report files
                                    citizenDAO.uploadFiles(rf);
                                }

                            }
                        }
                    }catch (FileUploadException e) {
                    e.printStackTrace();
                }catch (Exception ex) {
                    Logger.getLogger(Citizen_SubmitReport.class.getName()).log(Level.SEVERE, null, ex);
                }

                }

                request.setAttribute("success", category + "Success");
                ServletContext context = getServletContext();
                RequestDispatcher dispatch = context.getRequestDispatcher("/Citizen_Home");
                dispatch.forward(request, response);

            }finally {
        
        
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
        processRequest(request, response);
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
        processRequest(request, response);
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
