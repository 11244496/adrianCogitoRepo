/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DB.ConnectionFactory;
import Entity.Annotation;
import Entity.Contractor_User;
import Entity.Employee;
import Entity.Feedback;
import Entity.Files;
import Entity.Location;
import Entity.PComments;
import Entity.PWorks;
import Entity.PlanningDocument;
import Entity.Project;
import Entity.Project_Inspection;
import Entity.Schedule;
import Entity.Task;
import Entity.Testimonial;
import Entity.User;
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
public class OCPDDAO {

    Connection connection;
    PreparedStatement statement;
    ResultSet result;
    ConnectionFactory myFactory;

    //================================ALL PLANNINGDOCUMENT RELATED CODES====================================
    public void uploadDocument(PlanningDocument pd) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "insert into planningdocument (type, name, url, year, dateuploaded, employee_id) values (?,?,?,YEAR(now()),now(),?);";
            statement = connection.prepareStatement(query);
            statement.setString(1, pd.getType());
            statement.setString(2, pd.getName());
            statement.setString(3, pd.getUrl());
            statement.setInt(4, pd.getEmployee().getId());

            statement.executeUpdate();
            statement.close();

            connection.close();

        } catch (SQLException ex) {
            Logger.getLogger(DAO.OCPDDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public ArrayList<PlanningDocument> getDocuments() {
        ArrayList<PlanningDocument> documents = new ArrayList<>();
        PlanningDocument d;
        Employee e;

        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = ("select * from planningdocument");

            statement = connection.prepareStatement(query);
            result = statement.executeQuery();

            while (result.next()) {
                d = new PlanningDocument();
                e = new Employee();
                e.setId(result.getInt("Employee_ID"));
                d.setId(result.getInt("ID"));
                d.setType(result.getString("Type"));
                d.setDateUploaded(result.getString("DateUploaded"));
                d.setUrl(result.getString("URL"));
                d.setYear(result.getInt("Year"));
                d.setName(result.getString("Name"));
                d.setEmployee(e);
                documents.add(d);
            }
            connection.close();

            return documents;

        } catch (SQLException ex) {
            Logger.getLogger(GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;

    }

    //===============================ALL PROJECT RELATED CODES================================================
    public Project getBasicProjectDetails(String id) {
        Project p = new Project();
        Employee e;
        User u;

        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();

            String detailsQuery = ("select * from project join employee on employee.id = employee_id join users on users.id = users_id where project.id = ?");
            statement = connection.prepareStatement(detailsQuery);
            statement.setString(1, id);
            result = statement.executeQuery();
            while (result.next()) {
                u = new User();
                e = new Employee();
                p.setId(result.getString("project.ID"));
                p.setName(result.getString("name"));
                p.setDescription(result.getString("description"));
                p.setType(result.getString("project.type"));
                p.setStatus(result.getString("status"));
                p.setFoldername(result.getString("FolderName"));
                p.setDatesubmitted(result.getString("datesubmitted"));
                e.setId(result.getInt("employee.id"));
                u.setUsername(result.getString("username"));
                p.setEmployee(e);
                p.setCategory(result.getString("Category"));
                p.setBudget(result.getFloat("budget"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return p;
    }

    public Project getAllProjectDetails(String id) {
        Project project = new Project();

        //List of Entities Involved
        Testimonial mainTestimonial = new Testimonial();
        Employee e;
        User u;
        Contractor_User assignedContractor = new Contractor_User();

        //List of ArrayList
        ArrayList<Location> projectLocation = new ArrayList<Location>();
        ArrayList<Schedule> projectSchedule = new ArrayList<Schedule>();
        ArrayList<Files> projectFiles = new ArrayList<Files>();
        ArrayList<PWorks> projectPWorks = new ArrayList<PWorks>();
        ArrayList<Testimonial> projectReferencedTestimonial = new ArrayList<Testimonial>();
        ArrayList<Project> projectReferencedProject = new ArrayList<Project>();

        PreparedStatement locationS, scheduleS, filesS, pworksS, referencedtestimonialS, referencedprojectS;

        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();

            //Basic Details
            String detailsQuery = ("select * from project join employee on employee.id = employee_id join users on users.id = users_id where project.id = ?");
            statement = connection.prepareStatement(detailsQuery);
            statement.setString(1, id);
            result = statement.executeQuery();
            while (result.next()) {
                u = new User();
                e = new Employee();
                project.setId(result.getString("project.ID"));
                project.setName(result.getString("name"));
                project.setDescription(result.getString("description"));
                project.setType(result.getString("project.type"));
                project.setStatus(result.getString("status"));
                project.setFoldername(result.getString("FolderName"));
                project.setDatesubmitted(result.getString("datesubmitted"));
                e.setId(result.getInt("employee.id"));
                u.setUsername(result.getString("username"));
                project.setEmployee(e);
                project.setCategory(result.getString("Category"));
                project.setBudget(result.getFloat("budget"));
            }

            //Location
            String locationQuery = ("select * from location where Project_ID = ?");
            locationS = connection.prepareStatement(locationQuery);
            locationS.setString(1, id);
            result = locationS.executeQuery();
            while (result.next()) {

                Location loc = new Location();
                loc.setId(result.getInt("ID"));
                loc.setLats(result.getString("latitude"));
                loc.setLongs(result.getString("Longitude"));
                Project p = new Project();
                p.setId(p.getId());
                p.setName(p.getName());
                p.setDescription(p.getDescription());
                p.setType(p.getType());
                p.setStatus(p.getStatus());
                p.setFoldername(p.getFoldername());
                p.setDatesubmitted(p.getDatesubmitted());
                p.setCategory(p.getCategory());
                p.setBudget(p.getBudget());
                loc.setProject(p);

                projectLocation.add(loc);
            }
            project.setLocation(projectLocation);

            //Scheule            
            String scheduleQuery = ("SELECT * FROM schedule where project_id = ? order by startdate asc");
            scheduleS = connection.prepareStatement(scheduleQuery);
            scheduleS.setString(1, id);
            result = scheduleS.executeQuery();
            while (result.next()) {
                Schedule sc = new Schedule();
                sc.setId(result.getInt("id"));
                sc.setEvent(result.getString("event"));
                sc.setStartdate(result.getString("startdate"));
                sc.setEnddate(result.getString("enddate"));
                sc.setStatus(result.getString("status"));
                sc.setStage(result.getString("stage"));
                sc.setDept(result.getString("department"));
                sc.setActualenddate(result.getString("actualenddate"));
                sc.setRemarks(result.getString("Remarks"));
                sc.setTime(result.getString("Time"));
                Project p = new Project();
                p.setId(p.getId());
                p.setName(p.getName());
                p.setDescription(p.getDescription());
                p.setType(p.getType());
                p.setStatus(p.getStatus());
                p.setFoldername(p.getFoldername());
                p.setDatesubmitted(p.getDatesubmitted());
                p.setCategory(p.getCategory());
                p.setBudget(p.getBudget());
                sc.setProject(p);

                projectSchedule.add(sc);
            }
            project.setSchedule(projectSchedule);

            //Files
            String filesQuery = ("select * from files where project_id = ?");
            filesS = connection.prepareStatement(filesQuery);
            filesS.setString(1, id);
            result = filesS.executeQuery();
            while (result.next()) {
                Files f = new Files();
                f.setId(result.getInt("id"));
                f.setFileName(result.getString("FileName"));
                f.setDateUploaded(result.getString("DateUploaded"));
                f.setType(result.getString("type"));
                f.setDescription(result.getString("description"));
                Project p = new Project();
                p.setId(p.getId());
                p.setName(p.getName());
                p.setDescription(p.getDescription());
                p.setType(p.getType());
                p.setStatus(p.getStatus());
                p.setFoldername(p.getFoldername());
                p.setDatesubmitted(p.getDatesubmitted());
                p.setCategory(p.getCategory());
                p.setBudget(p.getBudget());
                f.setProject(p);
                f.setStatus(result.getString("status"));
                f.setUploader(result.getString("uploader"));
                if (result.getString("Testimonial_ID") != null) {
                    Testimonial t = new Testimonial();
                    t.setId(result.getInt("Testimonial_ID"));
                    f.setTestimonial(t);
                } else if (result.getString("Testimonial_ID") == null) {
                    Testimonial t = new Testimonial();
                    t.setId(0);
                    f.setTestimonial(t);
                }

                projectFiles.add(f);
            }
            project.setFiles(projectFiles);

            //Pworks
            String pworksQuery = ("select * from project_has_pworks join pworks on PWorks_ID = pworks.ID where Project_ID = ?");
            pworksS = connection.prepareStatement(pworksQuery);
            pworksS.setString(1, id);
            result = pworksS.executeQuery();
            while (result.next()) {

                PWorks pw = new PWorks();
                pw.setId(result.getInt("pworks.ID"));
                pw.setName(result.getString("Name"));
                Project p = new Project();
                p.setId(p.getId());
                p.setName(p.getName());
                p.setDescription(p.getDescription());
                p.setType(p.getType());
                p.setStatus(p.getStatus());
                p.setFoldername(p.getFoldername());
                p.setDatesubmitted(p.getDatesubmitted());
                p.setCategory(p.getCategory());
                p.setBudget(p.getBudget());
                pw.setProject(p);

                projectPWorks.add(pw);
            }
            project.setpWorks(projectPWorks);

            //Referenced Testimonial
            String ReferencedT = ("select Testimonial_ID from project_has_reference where Project_ID = ?");
            referencedtestimonialS = connection.prepareStatement(ReferencedT);
            referencedtestimonialS.setString(1, id);
            result = referencedtestimonialS.executeQuery();
            while (result.next()) {

                Testimonial t = new Testimonial();
                t.setId(result.getInt("Testimonial_ID"));

                projectReferencedTestimonial.add(t);
            }
            project.setReferredTestimonials(projectReferencedTestimonial);

            //Referenced Testimonial
            String ReferencedP = ("select otherProject_ID from project_has_reference where Project_ID = ?");
            referencedprojectS = connection.prepareStatement(ReferencedP);
            referencedprojectS.setString(1, id);
            result = referencedprojectS.executeQuery();
            while (result.next()) {

                Project p = new Project();
                p.setId(result.getString("otherProject_ID"));
                projectReferencedProject.add(p);
            }
            project.setReferredProjects(projectReferencedProject);

            //End of Method
        } catch (SQLException ex) {
            Logger.getLogger(GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return project;
    }

    public ArrayList<String> getAllProjectIDs() {
        ArrayList<String> AllProjectID = new ArrayList<String>();

        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();

            String detailsQuery = ("select id from project");
            statement = connection.prepareStatement(detailsQuery);
            result = statement.executeQuery();
            while (result.next()) {
                String id = result.getString("id");
                AllProjectID.add(id);
            }
        } catch (SQLException ex) {
            Logger.getLogger(GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return AllProjectID;
    }
    
    //=============================ALL SCHEDULE AND TASK RELATED CODES======================================

    public ArrayList<Task> getAgenda(Schedule s) {
        ArrayList<Task> tList = new ArrayList<>();
        Task t;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select Description from task where schedule_id = ?";
            statement = connection.prepareStatement(query);
            statement.setInt(1, s.getId());
            result = statement.executeQuery();
            while (result.next()) {
                t = new Task();
                t.setDescription(result.getString("Description"));
                tList.add(t);
            }
            connection.close();
            return tList;
        } catch (SQLException ex) {
            Logger.getLogger(OCPDDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return tList;
    }
}
