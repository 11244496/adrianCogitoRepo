/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import DAO.BACDAO;
import DAO.GSDAO;
import DAO.OCPDDAO;
import Entity.Annotation;
import Entity.Files;
import Entity.Location;
import Entity.Project;
import Entity.Task;
import Entity.Testimonial;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author RoAnn
 */
public class GS_ViewProjectDetails extends HttpServlet {

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
        try {
            GSDAO gdao = new GSDAO();
            OCPDDAO oc = new OCPDDAO();
            
            
            String id = request.getParameter("projid");

            Project project = oc.getAllProjectDetails(id);
            ArrayList<Location> projectLocation = project.getLocation();
            String location = new Gson().toJson(projectLocation);
            session.setAttribute("location", location);
            session.setAttribute("cost", oc.getCost(project));

            Testimonial mainTesti = gdao.getTestimonial(project.getMainTestimonial().getId());
            project.setMainTestimonial(mainTesti);
            
            //References
            ArrayList<Project> referencedPList = new ArrayList<Project>();
            for(int x = 0; x < project.getReferredProjects().size();x++){
                Project p = oc.getAllProjectDetails(project.getReferredProjects().get(x).getId());
                referencedPList.add(p);
            }
            project.setReferredProjects(referencedPList);
            
            //Set new arraylist of proposal files
            ArrayList<Files> projectFiles = project.getFiles();
            session.setAttribute("pFiles", projectFiles);
            session.setAttribute("project", project);
            ServletContext context = getServletContext();
            RequestDispatcher dispatch;
            if (project.getStatus().equalsIgnoreCase("On-hold")) {
                project.setAnnotation(oc.getAnnotations(project, "Pending"));
                Annotation a = oc.getAnnotations(project, "Pending");
                Task t = new Task();
                if (oc.getMeeting("Pending", project) != null) {
                    t.setAgenda(oc.getAgenda(t.getId()));
                }
                session.setAttribute("annotations", a);
                session.setAttribute("meeting", t);
                session.setAttribute("isEditable", gdao.isEditable(project));
                dispatch = context.getRequestDispatcher("/GS_ViewProjectDetailsOnHold.jsp");
            } else {
                dispatch = context.getRequestDispatcher("/GS_ViewProjectDetails.jsp");
            }
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
