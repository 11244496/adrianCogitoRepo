/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DB.ConnectionFactory;
import Entity.Agenda;
import Entity.Annotation;
import Entity.Citizen;
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
        ArrayList<Task> projectTask = new ArrayList<Task>();
        ArrayList<Files> projectFiles = new ArrayList<Files>();
        ArrayList<PWorks> projectPWorks = new ArrayList<PWorks>();
        ArrayList<Project> projectReferencedProject = new ArrayList<Project>();

        PreparedStatement locationS, taskS, filesS, pworksS, referencedtestimonialS, referencedprojectS;

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
                p.setId(project.getId());
                p.setName(project.getName());
                p.setDescription(project.getDescription());
                p.setStatus(project.getStatus());
                p.setFoldername(project.getFoldername());
                p.setDatesubmitted(project.getDatesubmitted());
                p.setCategory(project.getCategory());
                p.setBudget(project.getBudget());
                loc.setProject(p);

                projectLocation.add(loc);
            }
            project.setLocation(projectLocation);

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
                p.setId(project.getId());
                p.setName(project.getName());
                p.setDescription(project.getDescription());
                p.setStatus(project.getStatus());
                p.setFoldername(project.getFoldername());
                p.setDatesubmitted(project.getDatesubmitted());
                p.setCategory(project.getCategory());
                p.setBudget(project.getBudget());
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
            String pworksQuery = ("select * from project_has_works join pworks on PWorks_ID = pworks.ID where Project_ID = ?");
            pworksS = connection.prepareStatement(pworksQuery);
            pworksS.setString(1, id);
            result = pworksS.executeQuery();
            while (result.next()) {

                PWorks pw = new PWorks();
                pw.setId(result.getInt("pworks.ID"));
                pw.setName(result.getString("Name"));
                Project p = new Project();
                p.setId(project.getId());
                p.setName(project.getName());
                p.setDescription(project.getDescription());
                p.setStatus(project.getStatus());
                p.setFoldername(project.getFoldername());
                p.setDatesubmitted(project.getDatesubmitted());
                p.setCategory(project.getCategory());
                p.setBudget(project.getBudget());
                pw.setProject(p);

                projectPWorks.add(pw);
            }

            //Set Components of each Pworks
            for (PWorks pworks : projectPWorks) {
                ArrayList<Component> componentList = new ArrayList<Component>();
                String query = ("select * from components \n"
                        + "join unit on unit_id = unit.id \n"
                        + "join project_has_works on project_has_works.id = project_has_pworks_id\n"
                        + "where project_id = ? and pworks_id = ?");
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setString(1, project.getId());
                statement.setInt(2, pworks.getId());
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

            //Tasks
            String taskQuery = ("SELECT * FROM task where Project_ID = ?");
            taskS = connection.prepareStatement(taskQuery);
            taskS.setString(1, id);
            result = taskS.executeQuery();
            while (result.next()) {
                Task t = new Task();
                t.setId(result.getInt("ID"));
                t.setName(result.getString("Name"));
                t.setDescription(result.getString("Description"));
                Project p = new Project();
                p.setId(project.getId());
                p.setName(project.getName());
                p.setDescription(project.getDescription());
                p.setStatus(project.getStatus());
                p.setFoldername(project.getFoldername());
                p.setDatesubmitted(project.getDatesubmitted());
                p.setCategory(project.getCategory());
                p.setBudget(project.getBudget());
                t.setProject(p);

                projectTask.add(t);
            }
            
            for (Task t : projectTask) {
                ArrayList<Schedule> scheduleList = new ArrayList<Schedule>();
                String query = ("select * from schedule join task on schedule.Task_ID = task.id where Task_ID = ?");
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setInt(1, t.getId());
                result = statement.executeQuery();
                while (result.next()) {
                    Schedule s = new Schedule();
                    s.setId(result.getInt("id"));
                    s.setStartdate(result.getString("StartDate"));
                    s.setEnddate(result.getString("EndDate"));
                    s.setStatus(result.getString("status"));
                    s.setActualenddate(result.getString("ActualEndDate"));
                    s.setRemarks(result.getString("Remarks"));
                    Task task = new Task();
                    task.setId(result.getInt("task.id"));
                    task.setName(result.getString("task.name"));
                    task.setDescription(result.getString("task.description"));
                    s.setTask(task);
                    scheduleList.add(s);
                }
                t.setSchedules(scheduleList);
            }
            project.setTask(projectTask);
            
            
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
    
    public ArrayList<String> getAllFinishedProjectIDs() {
        ArrayList<String> AllProjectID = new ArrayList<String>();

        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();

            String detailsQuery = ("select id from project where status = ?");
            statement = connection.prepareStatement(detailsQuery);
            statement.setString(1, "Finished");
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
    public void setMeeting(Task t) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "insert into task (name, project_id) values (?, ?)";
            statement = connection.prepareStatement(query);
            statement.setString(1, t.getName());
            statement.setString(2, t.getProject().getId());
            statement.executeUpdate();
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in setting meeting", ex);
        }
    }

    public void insertToSchedule(Schedule s) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "insert into schedule (startdate, enddate, status, time, remarks, task_id) values (?,?,?,?,?,?)";
            statement = connection.prepareStatement(query);
            statement.setString(1, s.getStartdate());
            statement.setString(2, s.getEnddate());
            statement.setString(3, s.getStatus());
            statement.setString(4, s.getTime());
            statement.setString(5, s.getRemarks());
            statement.setInt(6, s.getTask().getId());
            statement.executeUpdate();
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in setting meeting", ex);
        }
    }
    
    public void insertAgenda(Agenda a) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "insert into agenda (agenda, task_id) values (?,?)";
            statement = connection.prepareStatement(query);
            statement.setString(1, a.getAgenda());
            statement.setInt(2, a.getTask().getId());
            statement.executeUpdate();
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in setting agenda", ex);
        }
    }

    public ArrayList<Agenda> getAgenda(int id){
        ArrayList<Agenda> aList = new ArrayList<>();
        Agenda a = new Agenda();
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select * from agenda where task_id = ?";
            statement = connection.prepareStatement(query);
            statement.setInt(1, id);
            result = statement.executeQuery();
            while (result.next()){
                a = new Agenda();
                a.setAgenda(result.getString("agenda"));
                aList.add(a);
            }
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in getting agenda", ex);
        }
        return aList;
    }
    
    public Task getMeeting(String status, Project p){
        Task t = null;
        Schedule s = null;
        ArrayList<Schedule> sList = new ArrayList<>();
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "SELECT max(startdate), task.id, task.name, schedule.startdate, schedule.enddate, schedule.time, schedule.remarks, schedule.remarks FROM task join schedule on task.id = task_id where status = ? and project_id = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, status);
            statement.setString(2, p.getId());
            result = statement.executeQuery();
            while(result.next()){
                t = new Task();
                s = new Schedule();
                t.setId(result.getInt("ID"));
                t.setName(result.getString("Name"));
                s.setStartdate(result.getString("startdate"));
                s.setEnddate(result.getString("enddate"));
                s.setTime(result.getString("time"));
                s.setRemarks(result.getString("remarks"));
                s.setStatus(result.getString("status"));
                sList.add(s);
                t.setSchedules(sList);
            }
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in getting meeting", ex);
        }
        return t;
    }
    public Task getMeeting( Project p){
        Task t = null;
        Schedule s = null;
        ArrayList<Schedule> sList = new ArrayList<>();
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "SELECT max(startdate), task.id, task.name, schedule.startdate, schedule.enddate, schedule.time, schedule.remarks, schedule.remarks FROM task join schedule on task.id = task_id where project_id = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, p.getId());
            result = statement.executeQuery();
            while(result.next()){
                t = new Task();
                s = new Schedule();
                t.setId(result.getInt("ID"));
                t.setName(result.getString("Name"));
                s.setStartdate(result.getString("startdate"));
                s.setEnddate(result.getString("enddate"));
                s.setTime(result.getString("time"));
                s.setRemarks(result.getString("remarks"));
                s.setStatus(result.getString("status"));
                sList.add(s);
                t.setSchedules(sList);
            }
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in getting meeting", ex);
        }
        return t;
    }
    //=======================================ALL ANNOTATION CODES=========================================

    public void setAnnotations(Annotation a) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "insert into annotations (details, pworks, schedule, testimonial, files, status, general, project_id, date) values (?,?,?,?,?,?,?,?,now())";
            statement = connection.prepareStatement(query);
            statement.setString(1, a.getDetails());
            statement.setString(2, a.getPworks());
            statement.setString(3, a.getSchedule());
            statement.setString(4, a.getTestimonial());
            statement.setString(5, a.getFiles());
            statement.setString(6, a.getStatus());
            statement.setString(7, a.getGeneral());
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
            String query = "select * from annotations where project_id = ? and status = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, p.getId());
            statement.setString(2, status);
            result = statement.executeQuery();
            while (result.next()) {
                a = new Annotation();
                a.setId(result.getInt("ID"));
                a.setDetails(result.getString("Details"));
                a.setPworks(result.getString("Pworks"));
                a.setSchedule(result.getString("Schedule"));
                a.setTestimonial(result.getString("Testimonial"));
                a.setFiles(result.getString("Files"));
                a.setStatus(result.getString("Status"));
                a.setGeneral(result.getString("General"));
                a.setDate(result.getString("Date"));
            }
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in getting annotations", ex);
        }
        return a;
    }

    public int getTaskID() {
        int x = 0;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select max(id) i from task";
            statement = connection.prepareStatement(query);
            result = statement.executeQuery();
            while (result.next()) {
                x = result.getInt("i");
            }
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in setting meeting", ex);
        }
        return x;
    }

    //FIX
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

    //FIX
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

    //FIX
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
                tList.add(t);
            }
            connection.close();
            return tList;
        } catch (SQLException ex) {
            Logger.getLogger(OCPDDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return tList;
    }

    //FIX
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

    //FIX
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

    //FIX
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
                s = new Schedule();
            }
            connection.close();
            return s;
        } catch (SQLException ex) {
            Logger.getLogger(OCPDDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return s;
    }

    //=======================================UTILITY CODES================================================
    public float getCost(Project p) {
        float cost = 0;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String getID = "select sum(components.quantity*components.unitprice) as cost from components join project_has_works on project_has_works.id = project_has_pworks_id  where project_id = ?";
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

    public void setBudget(Project p, float budget) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "update project set budget = ? where id = ?";
            statement = connection.prepareStatement(query);
            statement.setFloat(1, budget);
            statement.setString(2, p.getId());
            statement.executeUpdate();
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in setting budget", ex);
        }
    }
    
    public Testimonial getTestimonial(int id) {
        Testimonial t = null;
        Citizen c = null;
        User u = null;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select * from testimonial join citizen on citizen.id = citizen_id join users on users.id = users_id where testimonial.ID = ?";

            statement = connection.prepareStatement(query);
            statement.setInt(1, id);
            result = statement.executeQuery();
            while (result.next()) {
                u = new User(result.getInt("users.id"), result.getString("username"));
                c = new Citizen(result.getInt("citizen.id"), result.getString("FirstName"), result.getString("middlename"), u);
                t = new Testimonial(result.getString("testimonial.title"), result.getString("testimonial.dateuploaded"), result.getString("testimonial.message"), result.getString("testimonial.foldername"), result.getString("testimonial.category"), result.getString("testimonial.Status"), c);

            }

            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return t;
    }
}
