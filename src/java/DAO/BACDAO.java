/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DB.ConnectionFactory;
import Entity.Contractor;
import Entity.Contractor_User;
import Entity.InvitationToBid;
import Entity.Project;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author AdrianKyle
 */
public class BACDAO {

    Connection connection;
    PreparedStatement statement;
    ResultSet result;
    ConnectionFactory myFactory;

    //====================================ALL PROJECT RELATED CODES=========================================
    public ArrayList<Project> getProjects(String input) {
        ArrayList<Project> projects = new ArrayList<Project>();
        Project project;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select * from project where Status = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, input);

            result = statement.executeQuery();

            while (result.next()) {

                project = new Project();
                project.setId(result.getString("ID"));
                project.setName(result.getString("Name"));
                project.setDescription(result.getString("Description"));
                project.setType(result.getString("Type"));
                project.setStatus(result.getString("Status"));
                project.setBudget(result.getFloat("Budget"));
                projects.add(project);

            }
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.BACDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return projects;
    }

    public ArrayList<Project> getProjectsWithInvitation() {

        ArrayList<Project> projects = new ArrayList<Project>();
        Project project;

        try {

            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();

            String query = "SELECT *,\n"
                    + "(select count(*) from contractor_has_project where contractor_has_project.Project_ID = project.ID) as Submissions,\n"
                    + "(select count(*) from contractor_has_project where contractor_has_project.Project_ID = project.ID AND contractor_has_project.Status =\"Eligible to bid\") as Confirmed\n"
                    + "FROM project where project.status = \"Posted Invitation\"";
            statement = connection.prepareStatement(query);

            result = statement.executeQuery();

            while (result.next()) {

                project = new Project();
                project.setId(result.getString("ID"));
                project.setName(result.getString("Name"));
                project.setDescription(result.getString("Description"));
                project.setType(result.getString("Type"));
                project.setStatus(result.getString("Status"));
                project.setResponses(result.getInt("Submissions"));
                project.setConfirmed(result.getInt("Confirmed"));
                project.setBudget(result.getFloat("Budget"));
                projects.add(project);

            }
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.BACDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return projects;
    }

    public ArrayList<Project> getNegotiatedProjects() {

        ArrayList<Project> projects = new ArrayList<Project>();
        Project project;

        try {

            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();

            String query = "SELECT *,\n"
                    + "(select count(*) from contractor_has_project where contractor_has_project.Project_ID = project.ID) as Submissions,\n"
                    + "(select count(*) from contractor_has_project where contractor_has_project.Project_ID = project.ID AND contractor_has_project.Status =\"Eligible to bid\") as Confirmed\n"
                    + "FROM project where project.status = \"For Negotiation\"";
            statement = connection.prepareStatement(query);

            result = statement.executeQuery();

            while (result.next()) {

                project = new Project();
                project.setId(result.getString("ID"));
                project.setName(result.getString("Name"));
                project.setDescription(result.getString("Description"));
                project.setType(result.getString("Type"));
                project.setStatus(result.getString("Status"));
                project.setResponses(result.getInt("Submissions"));
                project.setConfirmed(result.getInt("Confirmed"));
                project.setBudget(result.getFloat("Budget"));
                projects.add(project);

            }
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.BACDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return projects;
    }

    public ArrayList<Project> getProjectsForImplementation(String input) {
        ArrayList<Project> projects = new ArrayList<Project>();
        Project project;
        Contractor_User contractor;
        Contractor con;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select * from project JOIN contractorusers ON project.Contractor_ID = contractorusers.ID join contractor on company_id = contractor.id where status = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, input);

            result = statement.executeQuery();

            while (result.next()) {
                project = new Project();
                con = new Contractor();
                con.setID(result.getInt("Company_ID"));
                con.setName(result.getString("contractor.name"));
                project.setContractor(con);
                project.setId(result.getString("ID"));
                project.setName(result.getString("Name"));
                project.setDescription(result.getString("Description"));
                project.setType(result.getString("Type"));
                project.setStatus(result.getString("Status"));
                project.setBudget(result.getFloat("Budget"));
                projects.add(project);

            }
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.BACDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return projects;
    }

    //======================================ALL INVITATION CODES=========================================
    public void uploadInvitation(InvitationToBid inv) {

        try {

            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();

            String query = "insert into invitationtobid (FileName,DateUploaded,Project_ID,FolderName,Status) values (?,now(),?,?,?);";

            statement = connection.prepareStatement(query);

            statement.setString(1, inv.getFileName());
            statement.setString(2, inv.getProjectID().getId());
            statement.setString(3, inv.getFolderName());
            statement.setString(4, "pending");

            statement.executeUpdate();
            statement.close();
            connection.close();

        } catch (SQLException ex) {
            Logger.getLogger(DAO.BACDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    
    //=======================================Utility Codes===============================================
    public boolean hasITB(Project p) {
        boolean hasitb = false;
        int count = 0;
        try {

            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();

            String query = "select count(*) as c from invitationtobid where project_id = ? and status != ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, p.getId());
            statement.setString(2, "Fail");

            result = statement.executeQuery();

            while (result.next()) {
                count = result.getInt("c");
            }

            if (count > 0) {
                hasitb = true;
            }
            connection.close();
            return hasitb;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.BACDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return hasitb;
    }

    public void changeBACStatus1(String id) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "UPDATE cogito.project SET Status = 'Posted Invitation' WHERE ID = ?";
            statement = connection.prepareStatement(query);

            statement.setString(1, id);

            statement.executeUpdate();
            statement.close();

            connection.close();

        } catch (SQLException ex) {
            Logger.getLogger(DAO.BACDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
