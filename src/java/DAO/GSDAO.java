/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DB.ConnectionFactory;
import Entity.Annotation;
import Entity.Citizen;
import Entity.Component;
import Entity.Contractor_User;
import Entity.Employee;
import Entity.Feedback;
import Entity.Files;
import Entity.Location;
import Entity.Material;
import Entity.PComments;
import Entity.PWorks;
import Entity.Project;
import Entity.Project_Inspection;
import Entity.Reply;
import Entity.Schedule;
import Entity.SubCategory;
import Entity.Supporter;
import Entity.TComments;
import Entity.TLocation;
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
public class GSDAO {

    Connection connection;
    PreparedStatement statement;
    ResultSet result;
    ConnectionFactory myFactory;

    public Employee getInfo(int id) {
        Employee e = null;
        User u = null;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select * from employee join users on users.id = users_id where id = ?";

            statement = connection.prepareStatement(query);
            statement.setInt(1, id);
            result = statement.executeQuery();
            while (result.next()) {
                u = new User(result.getInt("users.id"), result.getString("username"));
                e = new Employee(result.getInt("employee.id"), result.getString("firstname"), result.getString("middlename"),
                        result.getString("lastname"), result.getString("position"), result.getString("department"), u);
            }
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return e;
    }

    //================================ALL CODES ON CITITIZEN TESTIMONIALS===============================================
    //Include all parts of the testimonial
    public Testimonial getTestimonial(int id) {
        Testimonial t = new Testimonial();
        Citizen c = null;
        User u;

        ArrayList<TLocation> tlocation = new ArrayList<TLocation>();
        ArrayList<Project> mainproject = new ArrayList<Project>();
        ArrayList<Project> referencedproject = new ArrayList<Project>();
        ArrayList<Reply> replies = new ArrayList<Reply>();
        ArrayList<Files> files = new ArrayList<Files>();
        ArrayList<TComments> tcomments = new ArrayList<TComments>();
        ArrayList<Supporter> supporters = new ArrayList<Supporter>();

        PreparedStatement statement1, statement2, statement3, statement4, statement5, statement6, statement7, statement8;

        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();

            //Get Testimonial Info
            String testimonialquery = "select * from testimonial \n"
                    + "join citizen on citizen_id = citizen.ID\n"
                    + "join users on users_id = users.id"
                    + " where testimonial.ID = ?";

            statement = connection.prepareStatement(testimonialquery);
            statement.setInt(1, id);
            result = statement.executeQuery();
            while (result.next()) {
                u = new User(result.getInt("users.id"), result.getString("username"));
                c = new Citizen(result.getInt("citizen.id"), result.getString("FirstName"), result.getString("lastname"), u);
                t.setId(result.getInt("testimonial.id"));
                t.setTitle(result.getString("title"));
                t.setDateUploaded(result.getString("dateuploaded"));
                t.setMessage(result.getString("message"));
                t.setFolderName(result.getString("foldername"));
                t.setCategory(result.getString("category"));
                t.setStatus(result.getString("status"));
                t.setCitizen(c);
            }

            String locationQuery = ("select * from tlocation where Testimonial_ID = ?");
            statement1 = connection.prepareStatement(locationQuery);
            statement1.setInt(1, id);
            result = statement1.executeQuery();
            while (result.next()) {
                TLocation loc = new TLocation();
                loc.setId(result.getInt("ID"));
                loc.setLatitude(result.getString("latitude"));
                loc.setLongitude(result.getString("longitude"));
                Testimonial testi = new Testimonial();
                testi.setId(t.getId());
                testi.setTitle(t.getTitle());
                testi.setDateUploaded(t.getDateUploaded());
                testi.setMessage(t.getMessage());
                testi.setCategory(t.getCategory());
                testi.setFolderName(t.getFolderName());
                testi.setCitizen(t.getCitizen());
                testi.setStatus(t.getStatus());
                testi.setCitizen(c);
                loc.setTestimonial(testi);
                tlocation.add(loc);
            }
            t.setTlocation(tlocation);

            String mainprojectQuery = ("select * from project_has_testimonial where Testimonial_ID = ?");
            statement2 = connection.prepareStatement(mainprojectQuery);
            statement2.setInt(1, id);
            result = statement2.executeQuery();
            while (result.next()) {
                Project p = new Project();
                p.setId(result.getString("Project_ID"));
                mainproject.add(p);
            }
            t.setMainproject(mainproject);

            String referencedprojectQuery = ("select * from project_has_testimonial where Testimonial_ID = ?");
            statement7 = connection.prepareStatement(referencedprojectQuery);
            statement7.setInt(1, id);
            result = statement7.executeQuery();
            while (result.next()) {
                Project p = new Project();
                p.setId(result.getString("otherProject_ID"));
                referencedproject.add(p);
            }
            t.setReferencedproject(referencedproject);

            String repliesQuery = ("select * from reply where Testimonial_ID = ?");
            statement3 = connection.prepareStatement(repliesQuery);
            statement3.setInt(1, id);
            result = statement3.executeQuery();
            while (result.next()) {
                Reply r = new Reply();
                r.setId(result.getInt("ID"));
                r.setMessage(result.getString("Message"));
                r.setSender(result.getString("Sender"));
                r.setDateSent(result.getString("Datesend"));
                Testimonial testi = new Testimonial();
                testi.setId(t.getId());
                testi.setTitle(t.getTitle());
                testi.setDateUploaded(t.getDateUploaded());
                testi.setMessage(t.getMessage());
                testi.setCategory(t.getCategory());
                testi.setFolderName(t.getFolderName());
                testi.setCitizen(t.getCitizen());
                testi.setStatus(t.getStatus());
                testi.setCitizen(c);
                r.setTestimonial_ID(testi);
                replies.add(r);
            }
            t.setReplies(replies);

            String filesQuery = ("select * from files where Testimonial_ID = ?");
            statement4 = connection.prepareStatement(filesQuery);
            statement4.setInt(1, id);
            result = statement4.executeQuery();
            while (result.next()) {
                Files f = new Files();
                f.setId(result.getInt("ID"));
                f.setFileName(result.getString("FileName"));
                f.setDateUploaded(result.getString("DateUploaded"));
                f.setType(result.getString("Type"));
                f.setStatus(result.getString("Status"));
                f.setUploader(result.getString("Uploader"));
                f.setDescription(result.getString("Description"));
                Project project = new Project();
                project.setId(result.getString("Project_ID"));
                Testimonial testi = new Testimonial();
                testi.setId(t.getId());
                testi.setTitle(t.getTitle());
                testi.setDateUploaded(t.getDateUploaded());
                testi.setMessage(t.getMessage());
                testi.setCategory(t.getCategory());
                testi.setFolderName(t.getFolderName());
                testi.setCitizen(t.getCitizen());
                testi.setStatus(t.getStatus());
                testi.setCitizen(c);
                f.setTestimonial(testi);
                f.setProject(project);
                files.add(f);
            }
            t.setFiles(files);

            String commentsQuery = ("select * from tcomments where Testimonial_ID = ?");
            statement5 = connection.prepareStatement(commentsQuery);
            statement5.setInt(1, id);
            result = statement5.executeQuery();
            while (result.next()) {
                TComments comment = new TComments();
                comment.setId(result.getInt("ID"));
                comment.setComment(result.getString("Comment"));
                comment.setDateSent(result.getString("DateSent"));
                Citizen citizen = new Citizen();
                citizen.setId(result.getInt("Citizen_ID"));
                comment.setCitizen(citizen);
                Testimonial testi = new Testimonial();
                testi.setId(t.getId());
                testi.setTitle(t.getTitle());
                testi.setDateUploaded(t.getDateUploaded());
                testi.setMessage(t.getMessage());
                testi.setCategory(t.getCategory());
                testi.setFolderName(t.getFolderName());
                testi.setCitizen(t.getCitizen());
                testi.setStatus(t.getStatus());
                testi.setCitizen(c);
                comment.setTestimonial(testi);

                tcomments.add(comment);
            }
            t.setTcomments(tcomments);

            String supportersQuery = ("select * from supporters where Testimonial_ID = ?");
            statement6 = connection.prepareStatement(commentsQuery);
            statement6.setInt(1, id);
            result = statement6.executeQuery();
            while (result.next()) {
                Supporter s = new Supporter();
                s.setId(result.getInt("ID"));
                Testimonial testi = new Testimonial();
                testi.setId(t.getId());
                testi.setTitle(t.getTitle());
                testi.setDateUploaded(t.getDateUploaded());
                testi.setMessage(t.getMessage());
                testi.setCategory(t.getCategory());
                testi.setFolderName(t.getFolderName());
                testi.setCitizen(t.getCitizen());
                testi.setStatus(t.getStatus());
                testi.setCitizen(c);
                s.setTestimonial(testi);
                Citizen cit = new Citizen();
                cit.setId(result.getInt("Citizen_ID"));
                s.setCitizen(cit);

                supporters.add(s);
            }
            t.setSupporters(supporters);

            connection.close();
        } catch (SQLException ex) {
            System.out.println("Error in getTestimonial();");
            Logger.getLogger(DAO.ActivityDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return t;
    }

    public ArrayList<Testimonial> getAllTestimonials() {
        ArrayList<Testimonial> allTesti = new ArrayList<Testimonial>();
        Citizen c = null;
        User u = null;
        Testimonial t = null;
        PreparedStatement statement1;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String testimonialquery = "select * from testimonial \n"
                    + "join citizen on citizen_id = citizen.ID\n"
                    + "join users on users_id = users.id";

            statement = connection.prepareStatement(testimonialquery);
            result = statement.executeQuery();
            while (result.next()) {
                u = new User(result.getInt("users.id"), result.getString("username"));
                c = new Citizen(result.getInt("citizen.id"), result.getString("FirstName"), result.getString("lastname"), u);
                t = new Testimonial();
                t.setId(result.getInt("testimonial.id"));
                t.setTitle(result.getString("title"));
                t.setDateUploaded(result.getString("dateuploaded"));
                t.setMessage(result.getString("message"));
                t.setFolderName(result.getString("foldername"));
                t.setCategory(result.getString("category"));
                t.setStatus(result.getString("status"));
                t.setCitizen(c);

                allTesti.add(t);
            }

            statement.close();
            connection.close();
            return allTesti;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return allTesti;
    }

    public ArrayList<Testimonial> getTestimonialsNR() {
        ArrayList<Testimonial> NRtesti = new ArrayList<Testimonial>();
        Citizen c = null;
        User u = null;
        Testimonial t = null;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String getID = "select * from testimonial join citizen on citizen_id = citizen.id join users on users.id = users_id where testimonial.id not in (select testimonial_id from reply)";
            statement = connection.prepareStatement(getID);
            result = statement.executeQuery();
            while (result.next()) {
                u = new User(result.getInt("users.id"), result.getString("username"));
                c = new Citizen();
                t = new Testimonial();
                c.setId(result.getInt("citizen.id"));
                c.setFirstName(result.getString("FirstName"));
                c.setUser(u);
                t.setId(result.getInt("testimonial.id"));
                t.setTitle(result.getString("title"));
                t.setDateUploaded(result.getString("dateuploaded"));
                t.setMessage(result.getString("message"));
                t.setFolderName(result.getString("foldername"));
                t.setCategory(result.getString("category"));
                t.setStatus(result.getString("testimonial.status"));
                t.setCitizen(c);

                NRtesti.add(t);
            }

            statement.close();
            connection.close();
            return NRtesti;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return NRtesti;
    }

    public ArrayList<Integer> getTestimonialsWR() {

        ArrayList<Integer> test = new ArrayList<Integer>();

        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();

            String query = "select distinct(testimonial.id) from testimonial join reply on testimonial_id = testimonial.id";

            statement = connection.prepareStatement(query);
            result = statement.executeQuery();

            while (result.next()) {
                int id = result.getInt("testimonial.id");
                test.add(id);
            }
            connection.close();
            return test;

        } catch (SQLException ex) {
            Logger.getLogger(CitizenDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return test;
    }

    public ArrayList<Integer> getLinkedTestimonials() {

        ArrayList<Integer> test = new ArrayList<Integer>();

        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();

            String query = "select distinct(testimonial.id) from testimonial join files on testimonial_id = testimonial.id\n"
                    + "join project on project.id = files.project_id";

            statement = connection.prepareStatement(query);
            result = statement.executeQuery();

            while (result.next()) {
                int id = result.getInt("testimonial.id");
                test.add(id);
            }
            connection.close();
            return test;

        } catch (SQLException ex) {
            Logger.getLogger(CitizenDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return test;
    }

    public ArrayList<Project> getMainProjectOnTestimonial(int id) {
        ArrayList<Project> mainproject = new ArrayList<Project>();
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String mainprojectQuery = ("select * from project_has_testimonial where Testimonial_ID = ?");
            statement = connection.prepareStatement(mainprojectQuery);
            statement.setInt(1, id);
            result = statement.executeQuery();
            while (result.next()) {
                Project p = new Project();
                p.setId(result.getString("Project_ID"));
                mainproject.add(p);
            }

            statement.close();
            connection.close();
            return mainproject;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return mainproject;
    }

    public ArrayList<Project> getReferenceProjectOnTestimonial(int id) {
        ArrayList<Project> referencedproject = new ArrayList<Project>();
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String referencedprojectQuery = ("select * from project_has_testimonial where Testimonial_ID = ?");
            statement = connection.prepareStatement(referencedprojectQuery);
            statement.setInt(1, id);
            result = statement.executeQuery();
            while (result.next()) {
                Project p = new Project();
                p.setId(result.getString("otherProject_ID"));
                referencedproject.add(p);
            }

            statement.close();
            connection.close();
            return referencedproject;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return referencedproject;
    }

    public void changeTestiStatus(Testimonial t) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "update testimonial set status = ? where id = ?;";
            statement = connection.prepareStatement(query);
            statement.setString(1, t.getStatus());
            statement.setInt(2, t.getId());
            statement.executeUpdate();
            statement.close();
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    //================================ALL CODES ON PROJECT PROPOSALS===============================================
    public void createNewProject(Project p) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            // insert basic details
            // get project details + id
            // insert locations
            // get works from jsp check if it is existing if not, add to pworks table
            // insert pworks into project has pworks
            // assign pwork in components
            // insert components 
            // set main testimonial
            // insert referenced testimonial/s
            // insert referenced project/s

            connection.close();

        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in inserting project details", ex);
        }

        //call all methods
    }

    public void insertProjectDetails(Project p) {
        try {
            String insertProjectDetails = "insert into project (name, description, type, status, foldername, datesubmitted, category, employee_id) values (?,?,?,?,?,now(),?,?)";
            statement = connection.prepareStatement(insertProjectDetails);
            statement.setString(1, p.getName());
            statement.setString(2, p.getDescription());
            statement.setString(3, p.getType());
            statement.setString(4, p.getStatus());
            statement.setString(5, p.getFoldername());
            statement.setString(6, p.getCategory());
            statement.setInt(7, p.getEmployee().getId());
            statement.executeUpdate();
            statement.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in inserting project details", ex);
        }
    }

    public void insertLocationDetails(Location l) {
        try {
            String insertLocationDetails = "insert into location (longitude, latitude, project_id) values (?,?,?)";
            statement = connection.prepareStatement(insertLocationDetails);
            statement.setString(1, l.getLongs());
            statement.setString(2, l.getLats());
            statement.setString(3, l.getProject().getId());
            statement.executeUpdate();
            statement.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in inserting location details", ex);
        }
    }

    public ArrayList<PWorks> getExistingPWorks() {
        ArrayList<PWorks> pList = new ArrayList<>();
        PWorks p = null;
        try {
            String query = "select * from pworks";
            statement = connection.prepareStatement(query);
            result = statement.executeQuery();
            while (result.next()) {
                p = new PWorks(result.getInt("ID"), result.getString("Name"));
                pList.add(p);
            }
            statement.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in getting existing program works", ex);
        }
        return pList;
    }

    public void insertNewPWorks(PWorks pw) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String insertLocationDetails = "insert into pworks (name) values (?)";
            statement = connection.prepareStatement(insertLocationDetails);
            statement.setString(1, pw.getName());
            statement.executeUpdate();
            statement.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in inserting new program works", ex);
        }
    }

    public void insertComponents(Component c) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String insertLocationDetails = "insert into components (name, unitprice, quantity, type, unit_id, pworks_id) values (?,?,?,?,?)";
            statement = connection.prepareStatement(insertLocationDetails);
            statement.setString(1, pw.getName());
            statement.executeUpdate();
            statement.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in inserting new program works", ex);
        }
    }

    public ArrayList<Unit> getAllUnits() {
        ArrayList<Unit> uList = new ArrayList<>();
        Unit u = null;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String insertLocationDetails = "select * from unit";
            statement = connection.prepareStatement(insertLocationDetails);
            result = statement.executeQuery();
            while (result.next()){
                u = new Unit();
                u.setId(result.getInt("ID"));
                u.setUnit(result.getString("Unit"));
                uList.add(u);
            }
            statement.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in inserting new program works", ex);
        }
        return uList;
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

    //================================ALL CODES ON MEETINGS========================================================
    public ArrayList<Schedule> getAllMeetings(String status) {
        ArrayList<Schedule> meetingList = new ArrayList<Schedule>();
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String getID = "select * from schedule where Event = ? and Status = ?";
            statement = connection.prepareStatement(getID);
            statement.setString(1, "Meeting with OCPD");
            statement.setString(2, status);
            result = statement.executeQuery();
            while (result.next()) {
                Schedule s = new Schedule();
                s.setId(result.getInt("ID"));
                s.setEvent(result.getString("Event"));
                s.setStartdate(result.getString("StartDate"));
                s.setEnddate(result.getString("EndDate"));
                s.setStatus(result.getString("Status"));
                s.setStage(result.getString("Stage"));
                s.setDept(result.getString("Department"));
                s.setTime(result.getString("Time"));
                s.setProjectID(result.getString("Project_ID"));
                s.setRemarks(result.getString("Remarks"));
                meetingList.add(s);
            }

            statement.close();
            connection.close();
            return meetingList;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return meetingList;
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

    //===============================ALL COUNT CODES=======================================================
    public int getProjectCount(String status) {
        int PPCount = 0;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String getcount = "Select Count(*) as count from project where Status = ?";
            statement = connection.prepareStatement(getcount);
            statement.setString(1, status);
            result = statement.executeQuery();
            while (result.next()) {
                PPCount = result.getInt("count");
            }

            statement.close();
            connection.close();
            return PPCount;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return PPCount;
    }

}
