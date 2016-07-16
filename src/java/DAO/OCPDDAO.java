/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DB.ConnectionFactory;
import Entity.Annotation;
import Entity.Meeting;
import Entity.Project;
import Entity.Schedule;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author AdrianKyle
 */
public class OCPDDAO {

    Connection connection;
    PreparedStatement statement;
    ResultSet result;
    ConnectionFactory myFactory;

    public void changeProjectStatus(Project p, String status) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "update project set status = ? where id = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, status);
            statement.setString(1, p.getId());
            statement.executeUpdate();
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in updating project status", ex);
        }
    }

    public void setMeeting(Schedule s) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "insert into meeting (event, startdate, enddate, status, time, project_id) values (?,?,?,?,?,?)";
            statement = connection.prepareStatement(query);
            statement.setString(1, s.getEvent());
            statement.setString(2, s.getStartdate());
            statement.setString(3, s.getEnddate());
            statement.setString(4, s.getStatus());
            statement.setString(5, s.getTime());
            statement.setString(5, s.getProject().getId());
            statement.executeUpdate();
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in setting meeting", ex);
        }
    }

    public void rescheduleMeeting(Schedule s) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "update meeting set startdate = ?, enddate = ?, status = ?, time = ? where id = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, s.getStartdate());
            statement.setString(2, s.getEnddate());
            statement.setString(3, s.getStatus());
            statement.setString(4, s.getTime());
            statement.setInt(5, s.getId());
            statement.executeUpdate();
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in rescheduling meeting", ex);
        }
    }

    public void updateMeetingStatus(Schedule s, String status) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "update meeting set status = ? where id = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, status);
            statement.setInt(2, s.getId());
            statement.executeUpdate();
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in updating meeting status", ex);
        }
    }

    public void setBudget(Project p) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "update project set budget = ? where id = ?";
            statement = connection.prepareStatement(query);
            statement.setFloat(1, p.getBudget());
            statement.setString(2, p.getId());
            statement.executeUpdate();
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in setting budget", ex);
        }
    }

    public Project getProjectDetails(String id) {
        Project p = new Project();
        return p;
    }

    public void setAnnotations(Annotation a) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "insert into annotations (testimonials, projects, details, program, general, status, date, project_id) values (?,?,?,?,?,?,?,?)";
            statement = connection.prepareStatement(query);
            statement.setString(1, a.getTestimonials());
            statement.setString(2, a.getProjects());
            statement.setString(3, a.getDetails());
            statement.setString(4, a.getProgram());
            statement.setString(5, a.getGeneral());
            statement.setString(6, a.getStatus());
            statement.setString(7, a.getDate());
            statement.setString(8, a.getProject().getId());
            statement.executeUpdate();
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in setting annotations", ex);
        }
    }

    public Annotation getAnnotations(Project p, String status) {
        Annotation a = null;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select * from annotation where project_id = ? and status = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, a.getProject().getId());
            statement.setString(2, status);
            result = statement.executeQuery();
            while (result.next()){
                a = new Annotation();
                a.setId(result.getInt("ID"));
                a.setTestimonials(result.getString("Testimonials"));
                a.setProjects(result.getString("Projects"));
                a.setDetails(result.getString("Details"));
                a.setProgram(result.getString("Program"));
                a.setGeneral(result.getString("General"));
                a.setStatus(status);
                a.setDate(result.getString("Date"));
                a.setProject(p);
            }
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in getting annotations", ex);
        }
        return a;
    }
}
