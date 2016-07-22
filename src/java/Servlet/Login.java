/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import DAO.LoginDAO;
import Entity.Employee;
import Entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Lenovo
 */
public class Login extends HttpServlet {

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
            LoginDAO loginDAO = new LoginDAO();

            String username = request.getParameter("username");
            String password = request.getParameter("password");

            User user = new User();
            user.setUsername(username);
            user.setPassword(password);
            user.setType(loginDAO.getType(username));
            if (loginDAO.login(user) == true) {

                if (user.getType().equalsIgnoreCase("Citizen")) {
                    session.setAttribute("user", loginDAO.getCitizenInfo(username));
                    response.sendRedirect("Citizen_Home");

                } else if (user.getType().equalsIgnoreCase("GS")) {
                    session.setAttribute("user", loginDAO.getEmpInfo(username));
                    response.sendRedirect("GS_Home");
                } else if (user.getType().equalsIgnoreCase("OCPD")) {
                    session.setAttribute("user", loginDAO.getEmpInfo(username));
                    response.sendRedirect("OCPD_Home");
                } else if (user.getType().equalsIgnoreCase("BAC")) {
                    session.setAttribute("user", loginDAO.getEmpInfo(username));
                    response.sendRedirect("BAC_Home");
                } else if (user.getType().equalsIgnoreCase("Contractor")) {
                    session.setAttribute("user", loginDAO.getContInfo(username));
                    response.sendRedirect("Contractor_Home");
                }else if (user.getType().equalsIgnoreCase("CityAdmin")) {
                    session.setAttribute("user", loginDAO.getEmpInfo(username));
                    response.sendRedirect("CityAdmin_Home");
                }


//                else if (user.getUser_Type().getDescription().equals("BAC")) {
//                    response.sendRedirect("BAC_Home");
//                    session.setAttribute("user", user.getUsername());
//                    session.setAttribute("position", userType);
//                }
            } else if (loginDAO.login(user) == false) {
                response.sendRedirect("wrong_login.jsp");
            }

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
