/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import DAO.GSDAO;
import Entity.Component;
import Entity.Employee;
import Entity.Location;
import Entity.PWorks;
import Entity.Project;
import Entity.TLocation;
import Entity.Testimonial;
import Entity.Unit;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import json.JSONArray;
import json.JSONObject;
import org.apache.commons.fileupload.FileUploadException;

/**
 *
 * @author RoAnn
 */
public class GS_SubmitProposal extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    GSDAO gs = new GSDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        Employee e = (Employee) session.getAttribute("user");

        try {

            Project p = projectDetails(e, request);
            gs.createNewProject(p);
            ArrayList<PWorks> pWorksFromJSP = new ArrayList<>();
            ArrayList<Component> componentFromJSP;
            ArrayList<Unit> unitsFromDB = gs.getAllUnits();

            JSONArray materialstable = new JSONArray(request.getParameter("pworks"));
            Component c = null;
            Unit u = null;
            PWorks pw = null;

            for (Object obj : materialstable) {
                pw = new PWorks();
                JSONObject j = new JSONObject(obj.toString());
                pw.setName(j.getString("name"));
                JSONArray ja = j.getJSONArray("component");
                componentFromJSP = new ArrayList<>();
                for (int x = 0; x < ja.length(); x++) {
                    JSONObject co = ja.getJSONObject(x);
                    c = new Component();
                    u = new Unit();
                    c.setName(co.getString("cname"));
                    c.setQuantity(Integer.parseInt(co.getString("qty")));
                    u.setUnit(co.getString("unit"));
                    for (Unit un : unitsFromDB) {
                        if (un.getUnit().equalsIgnoreCase(u.getUnit())) {
                            c.setUnit(un);
                        }
                    }
                    c.setUnitPrice(Float.parseFloat(co.getString("cost")));
                    System.out.println(c.getName());
                    componentFromJSP.add(c);
                }
                pw.setComponents(componentFromJSP);
                pWorksFromJSP.add(pw);
            }

            boolean existsInDB;

            ArrayList<PWorks> existingPWorks = gs.getExistingPWorks();
            for (PWorks pow : pWorksFromJSP) {
                existsInDB = false;
                for (PWorks pow2 : existingPWorks) {
                    if (pow.getName().equalsIgnoreCase(pow2.getName())) {
                        existsInDB = true;
                    }
                }
                if (!existsInDB) {
                    gs.insertNewPWorks(pw);
                }
            }
            for (PWorks pw2 : pWorksFromJSP) {
                componentFromJSP = pw2.getComponents();
                pw2 = gs.getPWork(pw2);
                gs.insertWorksPerProject(pw2, p);
                pw2.setComponents(componentFromJSP);
                for (Component com : pw2.getComponents()) {
                    gs.insertComponents(com, pw2, p);
                }
            }

            ServletContext context = getServletContext();
            RequestDispatcher dispatch = context.getRequestDispatcher("/GS_ViewProjectList");
            dispatch.forward(request, response);

        } catch (Exception ex) {
            Logger.getLogger(GS_SubmitProposal.class.getName()).log(Level.SEVERE, "Error in submit proposal servlet", ex);
        }
    }

    private Project projectDetails(Employee e, HttpServletRequest request) {
        Project p = new Project();
        p.setId(request.getParameter("projectid"));
        p.setName(request.getParameter("projectname"));
        p.setDescription(request.getParameter("projectdescription"));
        p.setStatus("Pending");
        p.setCategory(request.getParameter("maincategory"));
        p.setEmployee(e);
        Testimonial t = new Testimonial();
        t.setId(Integer.parseInt(request.getParameter("maintestimonial")));
        p.setMainTestimonial(t);

        String[] loc = request.getParameter("hiddenlocation").split(",");
        setProjectLocation(loc, p);
//        setPWorks(p, request);

        //GETTING PWORKS AND COMPONENTS
        return p;
    }

    private void setProjectLocation(String[] loc, Project p) {
        ArrayList<Location> locList = new ArrayList<>();
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
            Location l = new Location();
            l.setLongs(longitude.get(x));
            l.setLats(latitude.get(x));
            l.setProject(p);
            locList.add(l);
        }

        p.setLocation(locList);
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
