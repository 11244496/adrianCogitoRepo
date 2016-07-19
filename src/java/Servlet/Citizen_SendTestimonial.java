/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import DAO.ActivityDAO;
import DAO.CitizenDAO;
import Entity.Activity;
import Entity.Citizen;
import Entity.Files;
import Entity.TLocation;
import Entity.Testimonial;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Pattern;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
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
 * @author RoAnn
 */
public class Citizen_SendTestimonial extends HttpServlet {

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
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();

        try {
            ActivityDAO actdao = new ActivityDAO();

            CitizenDAO citizenDAO = new CitizenDAO();
            InputStream inputStream = null;
            Citizen c = (Citizen) session.getAttribute("user");
            ArrayList<String> files = new ArrayList<String>();

            String category = null;

            boolean isMultipart = ServletFileUpload.isMultipartContent(request);
            if (isMultipart) {
                FileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);

                try {
                    //ArrayList<String> 

                    List items = upload.parseRequest(request);
                    Iterator iterator = items.iterator();

                    String title = null;
                    String message = null;
                    String location = null;
                    String videoD = null;
                    String imageD = null;
                    String documentD = null;

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

                            if (value2.equals("testimonialtitle")) {
                                title = value;
                            }
                            if (value2.equals("testimonialtype")) {
                                category = value;
                            }
                            if (value2.equals("testimonialdescription")) {
                                message = value;
                            }
                            if (value2.equals("hiddenlocation")) {
                                location = value;
                            }
                            if (value2.equals("videodescription")) {
                                videoD = value;
                            }
                            if (value2.equals("imagedescription")) {
                                imageD = value;
                            }
                            if (value2.equals("documentdescription")) {
                                documentD = value;
                            }
                        }

                        if (!item.isFormField()) {
                            fileName = item.getName();
                            if (!fileName.isEmpty()) {
                                String root = getServletContext().getRealPath("/");

                                //path where the file will be stored
                                path = new File("D:\\Development\\NetBeans\\Projects\\Cogito\\Upload" + "/Citizen/" + title);
                                if (!path.exists()) {
                                    boolean status = path.mkdirs();
                                }

                                uploadedFiles = new File(path + "/" + fileName);
                                item.write(uploadedFiles);
                                files.add(fileName);
                            } else {

                            }
                        }
                    }

                    //For testimonial category
//                    for (int x = 0; x < files.size(); x++) {
//
//                        String filename = files.get(x);
//                        if (!filename.isEmpty()) {
//                            String[] parts = filename.split(Pattern.quote("."));
//                            String extension = parts[1];
//                            //Videos
//                            if (extension.equalsIgnoreCase("mp4") || extension.equalsIgnoreCase("avi") || extension.equalsIgnoreCase("3gp") || extension.equalsIgnoreCase("flv") || extension.equalsIgnoreCase("wmv")) {
//                                category = "video";
//                                break;
//                            } //Images
//                            else if (extension.equalsIgnoreCase("png") || extension.equalsIgnoreCase("jpeg") || extension.equalsIgnoreCase("jpg") || extension.equalsIgnoreCase("bmp")) {
//                                category = "image";
//                                break;
//                            }
//                        }
//                    }
                    Testimonial t = new Testimonial(title, null, message, "chrome-extension://nhcgkapmceenhknicldaiaplpkpmicmc/Citizen/", category, "Unlinked", c);
                    //Upload testimonial
                    citizenDAO.submitTestimonial(t);
                    t.setId(citizenDAO.lastID());

                    //Add activity
                    actdao.addActivity(new Activity(0, "you have submitted a testimonial entitled " + title, null, c.getUser()));

                    //set location
                    String[] loc = location.split(",");
                    ArrayList<TLocation> tLoc = new ArrayList<>();
                    ArrayList<String> longitude = new ArrayList<>();
                    ArrayList<String> latitude = new ArrayList<>();

                    for (int x = 0; x < loc.length; x++) {
                        String[] latlong = loc[x].split("&");
                        String thislat = latlong[0];
                        String thislong = latlong[1];
                        longitude.add(thislong);
                        latitude.add(thislat);
                    }

                    for (int x = 0; x < loc.length; x++) {
                        TLocation l = new TLocation();
                        l.setLongitude(longitude.get(x));
                        l.setLatitude(latitude.get(x));
                        l.setTestimonial(t);
                        tLoc.add(l);
                    }

                    for (TLocation tl : tLoc) {
                        citizenDAO.setLocation(tl);
                    }
                    //Place in appropriate tables
                    for (int x = 0; x < files.size(); x++) {

                        String filename = files.get(x);
                        if (!filename.isEmpty()) {

                            String[] parts = filename.split(Pattern.quote("."));
                            String extension = parts[1];
                            //Videos
                            if (extension.equalsIgnoreCase("mp4") || extension.equalsIgnoreCase("avi") || extension.equalsIgnoreCase("3gp") || extension.equalsIgnoreCase("flv") || extension.equalsIgnoreCase("wmv") || extension.equalsIgnoreCase("mkv")) {
                                Files f = new Files();
                                f.setFileName(files.get(x));
                                f.setType("Video");
                                f.setTestimonial(t);
                                f.setStatus("Approved");
                                f.setDescription(videoD);
                                f.setUploader(c.getUser().getUsername());
                                citizenDAO.submitFiles(f);

                            } //Images
                            else if (extension.equalsIgnoreCase("png") || extension.equalsIgnoreCase("jpeg") || extension.equalsIgnoreCase("jpg") || extension.equalsIgnoreCase("bmp")) {
                                Files f = new Files();
                                f.setFileName(files.get(x));
                                f.setType("Image");
                                f.setTestimonial(t);
                                f.setStatus("Approved");
                                f.setDescription(imageD);
                                f.setUploader(c.getUser().getUsername());
                                citizenDAO.submitFiles(f);
                            } //Documents 
                            else if (extension.equalsIgnoreCase("pdf") || extension.equalsIgnoreCase("docx") || extension.equalsIgnoreCase("doc") || extension.equalsIgnoreCase("pptx") || extension.equalsIgnoreCase("txt") || extension.equalsIgnoreCase("xlsx")) {
                                Files f = new Files();
                                f.setFileName(files.get(x));
                                f.setType("Document");
                                f.setTestimonial(t);
                                f.setStatus("Approved");
                                f.setDescription(documentD);
                                f.setUploader(c.getUser().getUsername());
                                citizenDAO.submitFiles(f);
                            }

                        }
                    }
                } catch (FileUploadException e) {
                    e.printStackTrace();
                } catch (Exception ex) {
                    Logger.getLogger(Citizen_SendTestimonial.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            request.setAttribute("success", category + "Success");
            ServletContext context = getServletContext();
            RequestDispatcher dispatch = context.getRequestDispatcher("/Citizen_SearchTestimonial");
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
