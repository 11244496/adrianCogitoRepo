/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import DAO.ActivityDAO;
import DAO.GSDAO;
import DAO.NotifDAO;
import DAO.OCPDDAO;
import Entity.Activity;
import Entity.Employee;
import Entity.Notification;
import Entity.Project;
import Entity.Schedule;
import Entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.logging.Level;
import java.util.logging.Logger;
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
public class OCPD_SetForBidding extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            Employee e = (Employee) session.getAttribute("user");
            OCPDDAO ocpdDao = new OCPDDAO();
            String ID = (request.getParameter("projId"));
            Project p = ocpdDao.getBasicProjectDetails(ID);
            float budget = ocpdDao.getCost(p) + (ocpdDao.getCost(p) * 0.17f) + ((ocpdDao.getCost(p) * 0.17f) * .05f);
            ocpdDao.setBudget(p, budget);

            NotifDAO ndao = new NotifDAO();
            Notification n = null;
            for (User u : ndao.getEmployeePerDept("GS")) {
                n = new Notification();
                n.setNotification("Project " + p.getName() + "has been allocated a budget of PHP " + budget);
                n.setUsers_ID(u);
                ndao.addNotification(n);
            }

            ocpdDao.changeProjStatus("BAC", p);

            ActivityDAO actdao = new ActivityDAO();
            actdao.addActivity(new Activity(0,
                    e.getFirstName() + " " + e.getLastName() + " set a budget of " + budget + " for " + p.getName() + " project.",
                    null, e.getUser()));

            GSDAO gs = new GSDAO();
            request.setAttribute("pList", gs.getProjectsForList());
            ServletContext context = getServletContext();
            RequestDispatcher dispatch = context.getRequestDispatcher("/OCPD_ViewProjectList.jsp");
            dispatch.forward(request, response);
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
            Logger.getLogger(OCPD_SetForBidding.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(OCPD_SetForBidding.class.getName()).log(Level.SEVERE, null, ex);
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
