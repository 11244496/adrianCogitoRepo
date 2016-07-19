/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import DAO.OCPDDAO;
import Entity.Annotation;
import Entity.Project;
import Entity.Schedule;
import Entity.Task;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author RoAnn
 */
public class OCPD_PutOnHold extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            OCPDDAO oc = new OCPDDAO();
            String projId = request.getParameter("projectId");
            Project p = new Project();
            p.setId(projId);

            Annotation an = new Annotation();
            an.setTestimonials(request.getParameter("mainTestTA"));
            an.setProjects(request.getParameter("projectRefTA"));
            an.setDetails(request.getParameter("detailsTA"));
            an.setProgram(request.getParameter("materialsTA"));
            an.setProject(p);
            oc.setAnnotations(an);

            ArrayList<Schedule> sList = new ArrayList();
            Schedule meetingSchedule = new Schedule();
            meetingSchedule.setStartdate(request.getParameter("date"));
            meetingSchedule.setEnddate(request.getParameter("date"));
            meetingSchedule.setTime(request.getParameter("time"));
            meetingSchedule.setRemarks(request.getParameter("addtcomments"));
            meetingSchedule.setStatus("Pending");
            sList.add(meetingSchedule);
            Task meeting = new Task();
            meeting.setName("Meeting with OCPD");
            meeting.setProject(p);
            meeting.setSchedules(sList);
            oc.setMeeting(meeting);
            for (Schedule s : meeting.getSchedules()) {
                oc.insertToSchedule(s);
            }

            oc.changeProjStatus("Pending", p);

            ServletContext context = getServletContext();
            RequestDispatcher dispatch = context.getRequestDispatcher("/OCPD_ViewProjectList");
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

