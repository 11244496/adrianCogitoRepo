/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DB.ConnectionFactory;
import Entity.Annotation;
import Entity.Component;
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
import Entity.Unit;
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
                Testimonial t = new Testimonial();
                t.setId(result.getInt("Testimonial_ID"));
                project.setMainTestimonial(t);
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

            //Set Components of each Pworks
            for (PWorks pworks : projectPWorks) {
                ArrayList<Component> componentList = new ArrayList<Component>();
                String query = ("select * from components join unit on Unit_ID = unit.id where ProjectHasPWorks_PworksID = ? and ProjectHasPWorks_ProjectID = ?");
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setInt(1, pworks.getId());
                statement.setString(2, project.getId());
                result = statement.executeQuery();
                while (result.next()) {
                    Component component = new Component();
                    component.setId(result.getInt("ID"));
                    component.setName(result.getString("Name"));
                    component.setUnitPrice(result.getFloat("UnitPrice"));
                    component.setQuantity(result.getInt("Quantity"));
                    Unit unit = new Unit();
                    unit.setId(result.getInt("unit.id"));
                    unit.setUnit(result.getString("unit.Unit"));
                    component.setUnit(unit);
                    component.setPworks(pworks);
                    componentList.add(component);
                }
                pworks.setComponents(componentList);
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
    
    public void changeProjStatus(String s, Project p) {
        try {

            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();

            String query = "UPDATE project SET Status = ? WHERE ID = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, s);
            statement.setString(2, p.getId());
            statement.executeUpdate();
            connection.close();

        } catch (SQLException ex) {
            Logger.getLogger(OCPDDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        }

    }


    //=============================ALL SCHEDULE AND TASK RELATED CODES======================================
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

    public int getMeetingID(Project p) {
        int x = 0;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select max(schedule.id) as id from schedule\n"
                    + "join project on project_id = project.ID\n"
                    + "where event = ? and schedule.Status = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, "Meeting with OCPD");
            statement.setString(2, "Unconfirmed");
            result = statement.executeQuery();
            while (result.next()) {
                x = result.getInt("id");
            }
            connection.close();
            return x;
        } catch (SQLException ex) {
            Logger.getLogger(OCPDDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return x;
    }

    public double getPercentage(Project p) {

        PreparedStatement statement2;
        double Percentage = 0;
        try {
            double AllSchedule = 0;
            double DoneSchedule = 0;

            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String getpending = "Select Count(*) as count from schedule where Project_ID = ? and Status = ? and Event != ?";
            statement = connection.prepareStatement(getpending);
            statement.setString(1, p.getId());
            statement.setString(2, "Pending");
            statement.setString(3, "Meeting with OCPD");

            result = statement.executeQuery();
            while (result.next()) {
                AllSchedule = result.getInt("count");
            }
            statement.close();

            String getdone = "Select Count(*) as countdone from schedule where Project_ID = ? and Status = ? and Event != ?";
            statement2 = connection.prepareStatement(getdone);
            statement2.setString(1, p.getId());
            statement2.setString(2, "Done");
            statement2.setString(3, "Meeting with OCPD");
            result = statement2.executeQuery();
            while (result.next()) {
                DoneSchedule = result.getInt("countdone");
            }
            statement2.close();

            connection.close();

            Percentage = (DoneSchedule / AllSchedule) * 100;

            return Percentage;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return Percentage;
    }

    public Schedule getMeeting(Project p, String status) {
        Schedule s = null;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select * from schedule where event = ? and project_id = ? and status = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, "Meeting with OCPD");
            statement.setString(2, p.getId());
            statement.setString(3, status);
            result = statement.executeQuery();
            while (result.next()) {
                s = new Schedule(result.getInt("ID"), result.getString("Event"), result.getString("StartDate"),
                        result.getString("Enddate"), status, result.getString("Department"), result.getString("Time"), result.getString("Stage"), result.getString("Project_ID"), result.getString("ActualEndDate"), result.getString("remarks"));
            }
            connection.close();
            return s;
        } catch (SQLException ex) {
            Logger.getLogger(OCPDDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return s;
    }

    //=======================================ALL ANNOTATION CODES=========================================
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
            while (result.next()) {
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

    //=======================================UTILITY CODES================================================
    public float getCost(Project p) {
        float cost = 0;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String getID = "select sum(components.quantity*components.unitprice) as cost from components join project_has_pworks on project_has_pworks.PWorks_ID = components.ProjectHasPWorks_PworksID and project_has_pworks.Project_ID = components.ProjectHasPWorks_ProjectID where components.ProjectHasPWorks_ProjectID = ?";
            statement = connection.prepareStatement(getID);
            statement.setString(1, p.getId());
            result = statement.executeQuery();
            while (result.next()) {
                cost = result.getFloat("cost");
            }

            statement.close();
            connection.close();
            return cost;
        } catch (SQLException ex) {
            Logger.getLogger(OCPDDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cost;
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
}
