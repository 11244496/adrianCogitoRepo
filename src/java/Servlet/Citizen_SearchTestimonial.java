/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import DAO.CitizenDAO;
import Entity.Citizen;
import Entity.Testimonial;
import java.io.IOException;
import java.io.PrintWriter;
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
public class Citizen_SearchTestimonial extends HttpServlet {

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

            CitizenDAO c = new CitizenDAO();
            Citizen citizen = (Citizen) session.getAttribute("user");
            
            String getSubscribedQ = "select testimonial_id t from supporters where citizen_id = ?";
            String getAllQ = "select id from testimonial";
            String getTrendingQ = "select testimonial_id from supporters group by testimonial_id order by count(*) desc";
            String getMineQ = "select id from testimonial where citizen_id = ?";

            ArrayList<Integer> subscribedId = c.getTestimonials(getSubscribedQ, citizen);
            ArrayList<Integer> allTestId = c.getTestimonials(getAllQ, null);
            ArrayList<Integer> trendingTestId = c.getTestimonials(getTrendingQ, null);
            ArrayList<Integer> myTestId = c.getTestimonials(getMineQ, citizen);

            ArrayList<Testimonial> subscribedTestimonials = new ArrayList<Testimonial>();
            ArrayList<Testimonial> allTestimonials = new ArrayList<Testimonial>();
            ArrayList<Testimonial> trendingTestimonials = new ArrayList<Testimonial>();
            ArrayList<Testimonial> myTestimonials = new ArrayList<Testimonial>();
            Testimonial t;
            
            for (int id : subscribedId) {
                t = c.getTestimonial(id);
                t.setTlocation(c.getLocation(t));
                subscribedTestimonials.add(t);
            }

            for (int id : allTestId) {
                t = c.getTestimonial(id);
                t.setTlocation(c.getLocation(t));
                allTestimonials.add(t);
            }

            for (int id : trendingTestId) {
                t = c.getTestimonial(id);
                t.setTlocation(c.getLocation(t));
                trendingTestimonials.add(t);
            }

            for (int id : myTestId) {
                t = c.getTestimonial(id);
                t.setTlocation(c.getLocation(t));
                myTestimonials.add(t);
            }

            request.setAttribute("allTestimonials", allTestimonials);
            request.setAttribute("myTestimonials", myTestimonials);
            request.setAttribute("subscribedTestimonials", subscribedTestimonials);
            request.setAttribute("trendingTestimonials", trendingTestimonials);

            ServletContext context = getServletContext();
            String success = (String) request.getAttribute("success");

            request.setAttribute("success", success);
            RequestDispatcher dispatch = context.getRequestDispatcher("/Citizen_SearchTestimonial2.jsp");
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
