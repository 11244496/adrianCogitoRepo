/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import DAO.CitizenDAO;
import Entity.Citizen;
import Entity.TLocation;
import Entity.Testimonial;
import com.google.gson.Gson;
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

            String getSubscribedQ = "select testimonial_id as t from supporters where citizen_id = ?";
            String getAllQ = "select id as t from testimonial";
            String getTrendingQ = "select testimonial_id as t from supporters group by testimonial_id order by count(*) desc";
            String getMineQ = "select id as t from testimonial where citizen_id = ?";

            ArrayList<Integer> subscribedId = c.getTestimonials(getSubscribedQ, citizen);
            ArrayList<Integer> allTestId = c.getTestimonials(getAllQ, null);
            ArrayList<Integer> trendingTestId = c.getTestimonials(getTrendingQ, null);
            ArrayList<Integer> myTestId = c.getTestimonials(getMineQ, citizen);

            ArrayList<Testimonial> subscribedTestimonials = new ArrayList<Testimonial>();
            ArrayList<Testimonial> allTestimonials = new ArrayList<Testimonial>();
            ArrayList<Testimonial> trendingTestimonials = new ArrayList<Testimonial>();
            ArrayList<Testimonial> myTestimonials = new ArrayList<Testimonial>();

            ArrayList<TLocation> allLocation = new ArrayList<TLocation>();
            ArrayList<TLocation> myLocation = new ArrayList<TLocation>();
            ArrayList<TLocation> subscribedLocation = new ArrayList<TLocation>();
            ArrayList<TLocation> trendingLocation = new ArrayList<TLocation>();

            Testimonial t;

            //Get the testimonials based on the ID
            for (int id : subscribedId) {
                t = c.getTestimonial(id);
                subscribedTestimonials.add(t);
            }
            for (int id : allTestId) {
                t = c.getTestimonial(id);
                allTestimonials.add(t);
            }

            for (int id : trendingTestId) {
                t = c.getTestimonial(id);
                trendingTestimonials.add(t);
            }
            for (int id : myTestId) {
                t = c.getTestimonial(id);
                myTestimonials.add(t);
            }

            //SET ALL LOCATIONS
            for (Testimonial testi : allTestimonials) {
                for (TLocation l : testi.getTlocation()) {
                    allLocation.add(l);
                }
            }

            for (Testimonial testi : myTestimonials) {
                for (TLocation l : testi.getTlocation()) {
                    myLocation.add(l);
                }
            }

            for (Testimonial testi : trendingTestimonials) {
                for (TLocation l : testi.getTlocation()) {
                    trendingLocation.add(l);
                }
            }

            for (Testimonial testi : subscribedTestimonials) {
                for (TLocation l : testi.getTlocation()) {
                    subscribedLocation.add(l);
                }
            }

            request.setAttribute("allTestimonials", allTestimonials);
            request.setAttribute("myTestimonials", myTestimonials);
            request.setAttribute("subscribedTestimonials", subscribedTestimonials);
            request.setAttribute("trendingTestimonials", trendingTestimonials);

            String location = new Gson().toJson(allLocation);
            request.setAttribute("allLocation", location);
            String mylocation = new Gson().toJson(allLocation);
            request.setAttribute("myLocation", mylocation);
            String Tlocation = new Gson().toJson(allLocation);
            request.setAttribute("TLocation", Tlocation);
            String Slocation = new Gson().toJson(allLocation);
            request.setAttribute("SLocation", Slocation);

            ServletContext context = getServletContext();
            String success = (String) request.getAttribute("success");

            request.setAttribute("success", success);

            RequestDispatcher dispatch = context.getRequestDispatcher("/Citizen_SearchTestimonial.jsp");
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
