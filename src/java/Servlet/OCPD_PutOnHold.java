/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import DAO.OCPDDAO;
import Entity.Agenda;
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
            String projId = request.getParameter("projectid");
            System.out.println(projId);
            Project p = new Project(projId);
            
            Annotation an = new Annotation();
            an.setDetails(request.getParameter("detailsTA"));
            an.setPworks(request.getParameter("pworksTA"));
            an.setSchedule(request.getParameter("scheduleTA"));
            an.setTestimonial(request.getParameter("testimonialTA"));
            an.setFiles(request.getParameter("filesTA"));
            an.setGeneral(request.getParameter("general"));
            an.setProject(p);
            an.setStatus("Pending");
            oc.setAnnotations(an);

            
            ArrayList<Schedule> sList = new ArrayList();
            Schedule meetingSchedule = new Schedule();
            meetingSchedule.setStartdate(request.getParameter("date"));
            meetingSchedule.setEnddate(request.getParameter("date"));
            meetingSchedule.setTime(request.getParameter("time"));
            meetingSchedule.setRemarks(request.getParameter("remarks"));
            meetingSchedule.setStatus("GSPending");
            sList.add(meetingSchedule);
            
            Task meeting = new Task();
            meeting.setName("Meeting with OCPD");
            meeting.setProject(p);
            meeting.setSchedules(sList);
            oc.setMeeting(meeting);
            meeting.setId(oc.getTaskID());
            for (Schedule s : meeting.getSchedules()) {
                s.setTask(meeting);
                oc.insertToSchedule(s);
            }
            
            Agenda a = null;
            String[] aList = request.getParameterValues("meetingagenda");
            for (String a2 : aList){
                a = new Agenda();
                a.setAgenda(a2);
                a.setTask(meeting);
                oc.insertAgenda(a);
            }

            oc.changeProjStatus("On-Hold", p);

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

