/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import DAO.BACDAO;
import DAO.ContractorDAO;
import DAO.LoginDAO;
import Entity.Contractor_User;
import Entity.Eligibility_Document;
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

/**
 *
 * @author Krist
 */
public class BAC_ViewEligibilityDocuments extends HttpServlet {

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

        try {

            BACDAO bacdao = new BACDAO();
            LoginDAO lDAO = new LoginDAO();
            ContractorDAO cdao = new ContractorDAO();
            
            int id = Integer.parseInt(request.getParameter("contractor_has_projectID"));
            String projID = request.getParameter("projID");
            
            
            ArrayList<Eligibility_Document> documents = bacdao.getEligibilityDocuments(id);
            Eligibility_Document doc = bacdao.getDocumentStat(id);

            //Get contractor
            Contractor_User cu = lDAO.getContInfobyCHPID(id);
            request.setAttribute("contractor", cu);
            ArrayList<Project> pList = cdao.getProjectHistoryList("Finished",cu.getID());
            request.setAttribute("contractorPList", pList);
            
            request.setAttribute("projID", projID);
            request.setAttribute("documents", documents);
            request.setAttribute("doc", doc);

            ServletContext context = getServletContext();
            RequestDispatcher dispatch = context.getRequestDispatcher("/BAC_ViewEligibilityDocuments.jsp");
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
