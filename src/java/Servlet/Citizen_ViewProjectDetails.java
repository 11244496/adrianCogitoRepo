/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import DAO.CitizenDAO;
import DAO.ContractorDAO;
import DAO.GSDAO;
import DAO.LoginDAO;
import DAO.OCPDDAO;
import Entity.Citizen;
import Entity.Contractor_User;
import Entity.Files;
import Entity.Location;
import Entity.Project;
import Entity.Schedule;
import Entity.Testimonial;
import Entity.User;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Krist
 */
@WebServlet(name = "Citizen_ViewProjectDetails", urlPatterns = {"/Citizen_ViewProjectDetails"})
public class Citizen_ViewProjectDetails extends HttpServlet {

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
            CitizenDAO ct = new CitizenDAO();
            ContractorDAO contdao = new ContractorDAO();
            LoginDAO lDAO = new LoginDAO();
            
            
            String id = request.getParameter("projid");

            Project project = oc.getAllProjectDetails(id);
            ArrayList<Location> projectLocation = project.getLocation();
            String location = new Gson().toJson(projectLocation);
            session.setAttribute("location", location);

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
            session.setAttribute("feedback", ct.getAverage(project));

            //Get contractor
            Contractor_User cu = lDAO.getContInfobyID(project.getContractorUser().getID());
            session.setAttribute("contractor", cu);
            ArrayList<Project> pList = contdao.getProjectHistoryList("Finished",cu.getID());
            session.setAttribute("contractorPList", pList);
            
            //Schedule
            ArrayList<Schedule> completedDatesReport = gdao.getCompletedTaskReport(id);
            session.setAttribute("completedDatesReport", completedDatesReport);
            
            ServletContext context = getServletContext();
            RequestDispatcher dispatch;
            if (project.getStatus().equalsIgnoreCase("Finished")) {
                dispatch = context.getRequestDispatcher("/Citizen_ViewProjectDetails.jsp");
            } else {
                dispatch = context.getRequestDispatcher("/Citizen_ViewProjectDetailsN.jsp");
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
