/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import DAO.ActivityDAO;
import DAO.BACDAO;
import DAO.NotifDAO;
import DAO.OCPDDAO;
import Entity.Activity;
import Entity.Contractor;
import Entity.Contractor_Has_Project;
import Entity.Contractor_User;
import Entity.Employee;
import Entity.Notification;
import Entity.Project;
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
@WebServlet(name = "BAC_PlaceAward", urlPatterns = {"/BAC_PlaceAward"})
public class BAC_PlaceAward extends HttpServlet {

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

//           <input type="hidden" name="contractor_has_projectID" value="<%=idd%>">
//           <input type="hidden" name="projID" value="<%=projID%>">
            BACDAO bacdao = new BACDAO();
            OCPDDAO oc = new OCPDDAO();
            ActivityDAO actdao = new ActivityDAO();
            NotifDAO ntDAO = new NotifDAO();
            int id = Integer.parseInt(request.getParameter("contractor_has_projectID"));
            String id2 = request.getParameter("projID");

            Project projectDetails = oc.getBasicProjectDetails(id2);
            int contractorID = bacdao.getContractorID(id);
            Contractor contractor = bacdao.getContractorInfo(contractorID);

            request.setAttribute("projectDetails", projectDetails);
            request.setAttribute("cont_has_proj_id", id);
            request.setAttribute("contractorID", contractor);
            Employee employee = (Employee) session.getAttribute("user");

            actdao.addActivity(new Activity(0, "you confirmed " + contractor.getName() + " as the winning bidder", null, employee.getUser()));
            ArrayList<Contractor_User> conuser = bacdao.getAllContractors(id);

//            for (int x = 0; x < conuser.size(); x++) {
//                ntDAO.addNotification(new Notification(0, employee.getFirstName() + " " + employee.getLastName() + " confirmed " + contractor.getName() + " contractor ", null, conuser.get(x).getUser()));
//            }

            ServletContext context = getServletContext();
            RequestDispatcher dispatch = context.getRequestDispatcher("/BAC_PlaceAward.jsp");
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
