/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DB.ConnectionFactory;
import Entity.Annotation;
import Entity.Citizen;
import Entity.Citizen_Report;
import Entity.Component;
import Entity.Contractor_User;
import Entity.Employee;
import Entity.Feedback;
import Entity.Files;
import Entity.Inspection_Report;
import Entity.Location;
import Entity.PComments;
import Entity.PWorks;
import Entity.PlanningDocument;
import Entity.Progress_Report;
import Entity.Project;
import Entity.Project_Inspection;
import Entity.Project_has_Pwork;
import Entity.Reply;
import Entity.Report_File;
import Entity.Schedule;
import Entity.Supporter;
import Entity.TComments;
import Entity.TLocation;
import Entity.Task;
import Entity.Testimonial;
import Entity.Timeline_Update;
import Entity.Unit;
import Entity.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
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
        Project mainproject = new Project();
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

            String mainprojectQuery = ("select * from project where Testimonial_ID = ?");
            statement2 = connection.prepareStatement(mainprojectQuery);
            statement2.setInt(1, id);
            result = statement2.executeQuery();
            while (result.next()) {
                mainproject.setId(result.getString("ID"));
            }
            t.setMainproject(mainproject);

            String repliesQuery = ("select * from reply where Testimonial_ID = ?");
            statement3 = connection.prepareStatement(repliesQuery);
            statement3.setInt(1, id);
            result = statement3.executeQuery();
            while (result.next()) {
                Reply r = new Reply();
                r.setId(result.getInt("ID"));
                r.setMessage(result.getString("Message"));
                User user = new User();
                user.setUsername(result.getString("Sender"));
                r.setSender(user);
                r.setDateSent(result.getString("Datesent"));
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
                r.setTestimonial(testi);
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
                    + "join users on users_id = users.id where status != ? and status != ?";

            statement = connection.prepareStatement(testimonialquery);
            statement.setString(1, "Pending");
            statement.setString(2, "Rejected");

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
            String getID = "select * from testimonial join citizen on citizen_id = citizen.id join users on users.id = users_id where testimonial.id not in (select testimonial_id from reply) where testimonial.status != ? and testimonial.status != ?";
            statement = connection.prepareStatement(getID);
            statement.setString(1, "Pending");
            statement.setString(2, "Rejected");
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

            String query = "select distinct(testimonial.id) from testimonial join reply on testimonial_id = testimonial.id where testimonial.status != ? and testimonial.status != ?";

            statement = connection.prepareStatement(query);
            statement.setString(1, "Pending");
            statement.setString(2, "Rejected");
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

            String query = "select * from project join testimonial on project.Testimonial_ID = testimonial.id  where testimonial.status != ? and testimonial.status != ?";

            statement = connection.prepareStatement(query);
            statement.setString(1, "Pending");
            statement.setString(2, "Rejected");
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

    public Project getMainProjectOnTestimonial(int id) {
        Project mainproject = new Project();
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String mainprojectQuery = ("select * from project where Testimonial_ID = ?");
            statement = connection.prepareStatement(mainprojectQuery);
            statement.setInt(1, id);
            result = statement.executeQuery();
            while (result.next()) {
                mainproject.setId(result.getString("ID"));
            }

            statement.close();
            connection.close();
            return mainproject;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return mainproject;
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

    public boolean hasNoReply(Testimonial t) {
        boolean b = true;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select count(*) c from reply where testimonial_id = ?";
            statement = connection.prepareStatement(query);
            statement.setInt(1, t.getId());
            result = statement.executeQuery();
            while (result.next()) {
                if (result.getInt("c") > 0) {
                    b = false;
                }
            }
            statement.close();
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return b;
    }

    //================================ALL CODES ON PROJECT PROPOSALS===============================================
    public void createNewProject(Project p) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();            // insert basic details
            insertProjectDetails(p);
            // get project details + id
            changeTestStatus(p.getMainTestimonial(), "Linked");

            for (Location l : p.getLocation()) {
                insertLocationDetails(l, p);
            }

            connection.close();

        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in inserting project details", ex);
        }

        //call all methods
    }

    public void insertProjectDetails(Project p) {
        try {
            String insertProjectDetails = "insert into project (id, name, description, status, foldername, datesubmitted, category, employee_id, testimonial_id) values (?,?,?,?,?,now(),?,?,?)";
            statement = connection.prepareStatement(insertProjectDetails);
            statement.setString(1, p.getId());
            statement.setString(2, p.getName());
            statement.setString(3, p.getDescription());
            statement.setString(4, p.getStatus());
            statement.setString(5, p.getFoldername());
            statement.setString(6, p.getCategory());
            statement.setInt(7, p.getEmployee().getId());
            statement.setInt(8, p.getMainTestimonial().getId());
            statement.executeUpdate();
            statement.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in inserting project details", ex);
        }
    }

    public void changeTestStatus(Testimonial t, String status) {
        try {
            String insertProjectDetails = "update testimonial set status = ? where id = ?";
            statement = connection.prepareStatement(insertProjectDetails);
            statement.setString(1, status);
            statement.setInt(2, t.getId());
            statement.executeUpdate();
            statement.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in inserting project details", ex);
        }
    }

    public void insertLocationDetails(Location l, Project p) {
        try {
            String insertLocationDetails = "insert into location (longitude, latitude, project_id) values (?,?,?)";
            statement = connection.prepareStatement(insertLocationDetails);
            statement.setString(1, l.getLongs());
            statement.setString(2, l.getLats());
            statement.setString(3, p.getId());
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
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
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

    public PWorks getPWork(PWorks pw) {
        PWorks p = null;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select * from pworks where name = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, pw.getName());
            result = statement.executeQuery();
            while (result.next()) {
                p = new PWorks(result.getInt("ID"), result.getString("Name"));
            }
            statement.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in getting existing program works", ex);
        }
        return p;

    }

    public void insertNewPWorks(PWorks pw) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "insert into pworks (name) values (?)";
            statement = connection.prepareStatement(query);
            statement.setString(1, pw.getName());
            statement.executeUpdate();
            statement.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in inserting new program works", ex);
        }
    }

    public int getPHPWID(){
            int x = 0;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select max(id) i from project_has_works";
            statement = connection.prepareStatement(query);
            result = statement.executeQuery();
            while (result.next()) {
                x = result.getInt("i");
            }
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in getting id phpworks", ex);
        }
        return x;
    }

    public void insertComponents(Component c, int id, Project p) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "insert into components (name, unitprice, quantity, unit_id, project_has_pworks_id) values (?,?,?,?,?)";
            statement = connection.prepareStatement(query);
            statement.setString(1, c.getName());
            statement.setFloat(2, c.getUnitPrice());
            statement.setInt(3, c.getQuantity());
            statement.setInt(4, c.getUnit().getId());
            statement.setInt(5, id);
            statement.executeUpdate();
            statement.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in inserting components", ex);
        }
    }

    public void insertUnit(Unit u) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "insert into unit (name) values (?)";
            statement = connection.prepareStatement(query);
            statement.setString(1, u.getUnit());
            statement.executeUpdate();
            statement.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in inserting components", ex);
        }
    }

    public ArrayList<Unit> getAllUnits() {
        ArrayList<Unit> uList = new ArrayList<>();
        Unit u = null;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select * from unit";
            statement = connection.prepareStatement(query);
            result = statement.executeQuery();
            while (result.next()) {
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

    public void insertReferencedTestimonials(Testimonial ref, Project main) {
        try {
            myFactory = ConnectionFactory.getInstance();
            String query = "insert into project_has_reference (testimonial_id, project_id) values (?,?)";
            statement = connection.prepareStatement(query);
            statement.setInt(1, ref.getId());
            statement.setString(2, main.getId());
            statement.executeUpdate();
            statement.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in inserting new program works", ex);
        }
    }

    public void insertReferencedProjects(Project ref, Project main) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "insert into project_has_reference (otherProject_ID, project_id) values (?,?)";
            statement = connection.prepareStatement(query);
            statement.setString(1, ref.getId());
            statement.setString(2, main.getId());
            statement.executeUpdate();
            statement.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in inserting referenced projects", ex);
        }
    }

    public void insertWorksPerProject(PWorks pw, Project p) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "insert into project_has_works (pworks_id, project_id) values (?,?)";
            statement = connection.prepareStatement(query);
            statement.setInt(1, pw.getId());
            statement.setString(2, p.getId());
            statement.executeUpdate();
            statement.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in inserting pworks per project", ex);
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

    public ArrayList<Project> getProjectsForList() {
        Project p = null;
        ArrayList<Project> pList = new ArrayList<>();
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();

            String detailsQuery = ("select id, name, category, description, budget, datesubmitted, status from project");
            statement = connection.prepareStatement(detailsQuery);
            result = statement.executeQuery();
            while (result.next()) {
                p = new Project();
                p.setId(result.getString("id"));
                p.setName(result.getString("name"));
                p.setDescription(result.getString("description"));
                p.setCategory(result.getString("project.category"));
                p.setStatus(result.getString("status"));
                p.setDatesubmitted(result.getString("datesubmitted"));
                p.setBudget(result.getFloat("Budget"));
                pList.add(p);
            }
        } catch (SQLException ex) {
            Logger.getLogger(GSDAO.class.getName()).log(Level.SEVERE, "Error in getting basic details for project list", ex);
        }
        return pList;
    }

    public ArrayList<PWorks> getWorks() {
        Collection<PWorks> wList = new ArrayList<>();
        PWorks works = null;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();

            String detailsQuery = "select * from pworks";
            statement = connection.prepareStatement(detailsQuery);
            result = statement.executeQuery();
            while (result.next()) {
                works = new PWorks(result.getInt("ID"), result.getString("Name"));
                wList.add(works);
            }
        } catch (SQLException ex) {
            Logger.getLogger(GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return new ArrayList(wList);
    }

    //================================ALL CODES ON MEETINGS========================================================
    
    public ArrayList<Task> getAllMeetings(String status) {
        ArrayList<Task> meetingList = new ArrayList<>();
        ArrayList<Schedule> sList = new ArrayList<>();
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String getID = "select project.id, project.name, startdate, time, remarks, task.id, schedule.id from project join task on project_id = project.id join schedule on task_id = task.id where schedule.status = ? and task.name = ?";
            statement = connection.prepareStatement(getID);
            statement.setString(1, status);
            statement.setString(2, "Meeting with OCPD");
            result = statement.executeQuery();
            while (result.next()) {
                Project p = new Project();
                Task t = new Task();
                Schedule s = new Schedule();
                p.setId(result.getString("project.id"));
                p.setName(result.getString("project.name"));
                t.setId(result.getInt("task.id"));
                s.setId(result.getInt("schedule.id"));
                s.setStartdate(result.getString("startdate"));
                s.setTime(result.getString("time"));
                s.setRemarks(result.getString("remarks"));
                sList.add(s);
                t.setProject(p);
                t.setSchedules(sList);
                meetingList.add(t);
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
    
    public void insertTask(Task t, Project p) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "insert into task (name, project_id) values (?,?)";
            statement = connection.prepareStatement(query);
            statement.setString(1, t.getName());
            statement.setString(2, p.getId());
            statement.executeUpdate();
            statement.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in inserting pworks per project", ex);
        }
    }

    public void insertSchedule(Task t, Schedule s) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "insert into schedule (startdate, enddate, status, task_id) values (?,?,?,?)";
            statement = connection.prepareStatement(query);
            statement.setString(1, s.getStartdate());
            statement.setString(2, s.getEnddate());
            statement.setString(3, s.getStatus());
            statement.setInt(4, t.getId());
            statement.executeUpdate();
            statement.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in inserting pworks per project", ex);
        }
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

    //===============================ALL CODES ON DOCUMENTS================================================
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

    public void editProposal() {

    }

    public void replyToTestimonial(Reply r) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "insert into reply (message, sender, datesent, testimonial_id) values (?,?,now(),?)";
            statement = connection.prepareStatement(query);
            statement.setString(1, r.getMessage());
            statement.setString(2, r.getSender().getUsername());
            statement.setInt(3, r.getTestimonial().getId());
            statement.executeUpdate();
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in updating meeting status", ex);
        }
    }

    public Reply getReply(Testimonial t) {
        Reply r = null;
        Employee e;
        User u;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select message, firstname, lastname, username, datesent from reply join users on sender = username join employee on users.id = users_id where testimonial_id = ?";
            statement = connection.prepareStatement(query);
            statement.setInt(1, t.getId());
            result = statement.executeQuery();
            while (result.next()) {
                r = new Reply();
                r.setDateSent(result.getString("datesent"));
                r.setMessage(result.getString("message"));
                u = new User();
                e = new Employee();
                u.setUsername(result.getString("username"));
                e.setFirstName(result.getString("firstname"));
                e.setLastName(result.getString("lastname"));
                e.setUser(u);
                r.setSender(u);
            }
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in getting reply", ex);
        }
        return r;
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

    public ArrayList<Project> getImplementedProjects() {
        ArrayList<Project> plist = new ArrayList<Project>();
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String getID = "select * from project where status = ?";
            statement = connection.prepareStatement(getID);
            statement.setString(1, "Implementation");
            result = statement.executeQuery();
            while (result.next()) {

                Project p = new Project();

                p.setId(result.getString("ID"));
                p.setName(result.getString("Name"));
                p.setDescription(result.getString("Description"));
                p.setCategory(result.getString("Category"));

                plist.add(p);
            }

            statement.close();
            connection.close();
            return plist;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return plist;
    }

    public ArrayList<Project> getFinishedProjects() {
        ArrayList<Project> plist = new ArrayList<Project>();
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String getID = "select * from project where status = ?";
            statement = connection.prepareStatement(getID);
            statement.setString(1, "Finished");
            result = statement.executeQuery();
            while (result.next()) {

                Project p = new Project();

                p.setId(result.getString("ID"));
                p.setName(result.getString("Name"));
                p.setDescription(result.getString("Description"));
                p.setCategory(result.getString("Category"));

                plist.add(p);
            }

            statement.close();
            connection.close();
            return plist;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return plist;
    }
    
    public boolean isEditable(Project p) {
        boolean isEditable = false;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select max(startdate), status from schedule join task on task_id = task.id where project_id = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, p.getId());
            result = statement.executeQuery();
            while (result.next()) {
                if (result.getString("status").equalsIgnoreCase("Done")) {
                    isEditable = true;
                }
            }
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in getting latest meeting", ex);
        }
        return isEditable;
    }

    public ArrayList<Project_Inspection> getInspection(Project p) {
        ArrayList<Project_Inspection> projectinspection = new ArrayList<Project_Inspection>();
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();

            String getID = "SELECT * FROM project_inspection join task on Task_ID = task.id join schedule on Schedule_ID = schedule.id where task.Project_ID = ?;";
            statement = connection.prepareStatement(getID);
            statement.setString(1, p.getId());
            result = statement.executeQuery();
            while (result.next()) {
                Schedule s = new Schedule();
                s.setId(result.getInt("schedule.ID"));
                s.setStartdate(result.getString("schedule.StartDate"));
                s.setEnddate(result.getString("schedule.EndDate"));
                s.setStatus(result.getString("schedule.Status"));
                s.setTime(result.getString("schedule.Time"));
                s.setActualenddate(result.getString("schedule.ActualEndDate"));

                Task t = new Task();
                t.setId(result.getInt("task.ID"));
                t.setName(result.getString("task.Name"));
                t.setDescription(result.getString("task.description"));

                Project_Inspection pi = new Project_Inspection();
                pi.setID(result.getInt("project_inspection.ID"));
                pi.setDateOfInspection(result.getString("project_inspection.DateOfInspection"));
                pi.setTask(t);
                pi.setRemark(result.getString("project_inspection.Remark"));
                pi.setStatus(result.getString("project_inspection.Status"));

                projectinspection.add(pi);
            }

            statement.close();
            connection.close();
            return projectinspection;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return projectinspection;
    }

 
        public ArrayList<Project_has_Pwork> getProject_has_PworkList(Project project) {

        ArrayList<Project_has_Pwork> reportList = new ArrayList<Project_has_Pwork>();
        Project_has_Pwork proj_pwork;
        PWorks pwork;
        Inspection_Report inspection;
        
        
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select DISTINCT DateUploaded from project_has_works \n" +
"join pworks on PWorks_ID = pworks.id\n" +
"join inspection_report on proj_pworks_id = project_has_works.id where Project_ID = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, project.getId());

            result = statement.executeQuery();

            while (result.next()) {
                
                pwork = new PWorks();
                //pwork.setId(result.getInt("PWork_ID"));
                //proj_pwork = new Project_has_Pwork(result.getInt("project_has_pworks.ID"), project, pwork, result.getString("Remark"), result.getString("Date_Inspected"));
                proj_pwork = new Project_has_Pwork();
                inspection = new Inspection_Report();
                inspection.setDateUploaded(result.getString("DateUploaded"));
                proj_pwork.setInspection(inspection);
                proj_pwork.setPwork(pwork);
                proj_pwork.setProject(project);
                reportList.add(proj_pwork);
                
            }
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return reportList;
    }





       public ArrayList<Project_has_Pwork> getProject_has_PworkInfo(String id, String date) {

        ArrayList<Project_has_Pwork> reportList = new ArrayList<Project_has_Pwork>();
        Project_has_Pwork proj_pwork;
        PWorks pwork;
        Inspection_Report inspection;
        Project p;
        
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select * from project_has_works \n" +
"join pworks on Pworks_ID = pworks.id\n" +
"join inspection_report on proj_pworks_id = project_has_works.id\n" +
"where project_has_works.Project_ID = ? AND DateUploaded = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, id);
            statement.setString(2, date);
            

            result = statement.executeQuery();

            while (result.next()) {
                pwork = new PWorks();
                pwork.setId(result.getInt("pworks.ID"));
                pwork.setName(result.getString("pworks.Name"));
                p = new Project();
                p.setId(id);
                
                inspection = new Inspection_Report(result.getInt("inspection_report.ID"), result.getString("Remark"), result.getString("DateUploaded"));
                
                
                proj_pwork = new Project_has_Pwork(result.getInt("project_has_works.ID"), p, pwork);
                proj_pwork.setInspection(inspection);
                reportList.add(proj_pwork);
                
            }
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return reportList;
    }


          public ArrayList<Project_has_Pwork> getWorkItems(String id) {

        ArrayList<Project_has_Pwork> reportList = new ArrayList<Project_has_Pwork>();
        Project_has_Pwork proj_pwork;
        PWorks pwork;
        
        
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "SELECT DISTINCT Name FROM project_has_works JOIN pworks on pworks.ID = project_has_works.Pworks_ID \n" +
"where Project_ID = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, id);
            

            result = statement.executeQuery();

            while (result.next()) {
                pwork = new PWorks();
                pwork.setName(result.getString("Name"));
                
                proj_pwork = new Project_has_Pwork(0, null, pwork);
                reportList.add(proj_pwork);
                
            }
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return reportList;
    }

        public int getWorkItemId(String name) {
        int id = 0;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String getID = "select ID from pworks where Name = ?";
            statement = connection.prepareStatement(getID);
            statement.setString(1,name);
            result = statement.executeQuery();
            while (result.next()) {
                id = result.getInt("ID");
            }

            statement.close();
            connection.close();
            return id;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return id;
    }


        public Project_has_Pwork getProject_has_pWork(String projID, int itemId) {
       
        Project_has_Pwork projectpwork = null;    
        Project project;
        PWorks pwork;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select * from project_has_works where Project_ID = ? AND PWorks_ID = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, projID);
            statement.setInt(2, itemId);
            
            result = statement.executeQuery();
            while (result.next()) {
                project = new Project();
                project.setId(result.getString("Project_ID"));
                pwork = new PWorks();
                pwork.setId(result.getInt("Pworks_ID"));
                
                projectpwork = new Project_has_Pwork(result.getInt("ID"),project, pwork);
                
            }
            statement.close();
            connection.close();
            return projectpwork;
        } catch (SQLException ex) {
            Logger.getLogger(GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return projectpwork;
    }


        public void addEngInspection(String remark, int id) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "INSERT INTO inspection_report (Remark, DateUploaded, proj_pworks_id) VALUES (?, now(), ?);";
            statement = connection.prepareStatement(query);
            statement.setString(1, remark);
            statement.setInt(2, id);
            
            
            
            statement.executeUpdate();
            statement.close();
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

        public ArrayList<Progress_Report> getProgress_ReportList(Project project) {

        ArrayList<Progress_Report> progress_reports = new ArrayList<Progress_Report>();
        Progress_Report progress_report;

        try {

            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();

            String query = "SELECT * FROM progress_report where Project_ID = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, project.getId());
            
            result = statement.executeQuery();

            while (result.next()) {

                progress_report = new Progress_Report(result.getInt("ID"), result.getString("Message"),result.getString("FileName"), result.getString("FolderName"), result.getString("DateUploaded"), project, null);
                progress_reports.add(progress_report);

            }
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.ContractorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return progress_reports;
    }

        public ArrayList<Citizen_Report> getCitizenReports(String projectId) {
        ArrayList<Citizen_Report> cRepList = new ArrayList<>();
        Citizen_Report citreport = null;
        Citizen citizen = null;
        Project project = null;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select * from citizen_report join citizen on citizen_ID = citizen.id join address on address_id =  address.ID join barangay on barangay_ID = barangay.ID  where citizen_report.Project_ID = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, projectId);
            result = statement.executeQuery();
            while (result.next()) {
                citizen = new Citizen();
                citizen.setId(result.getInt("Citizen_ID"));
                citizen.setFirstName(result.getString("FirstName"));
                citizen.setMiddleName(result.getString("MiddleName"));
                citizen.setLastName(result.getString("LastName"));

                project = new Project();
                project.setId(result.getString("Project_ID"));
                
                citreport = new Citizen_Report(result.getInt("ID"), result.getString("Message"), result.getString("FolderName"), result.getString("Date_Uploaded"), citizen, project);
                cRepList.add(citreport);
            }
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return cRepList;
    }
      public ArrayList<Report_File> getCitizen_ReportFiles(int id) {

        ArrayList<Report_File> reportList = new ArrayList<Report_File>();
        Report_File report;
        
        Citizen_Report creport;
        Project project;
        
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select * from citizen_report join report_file on report_file.Citizen_Report_ID = citizen_report.ID where citizen_Report_ID = ?";
            statement = connection.prepareStatement(query);
            statement.setInt(1, id);

            result = statement.executeQuery();

            while (result.next()) {
                
                creport = new Citizen_Report();
                creport.setId(result.getInt("Citizen_Report_ID"));
                creport.setMessage(result.getString("Message"));
                creport.setDate(result.getString("citizen_report.Date_Uploaded"));
                creport.setFoldername(result.getString("FolderName"));
                
                project = new Project();
                project.setId(result.getString("Project_ID"));
                
                report = new Report_File(result.getInt("report_file.ID"), result.getString("FileName"), result.getString("report_file.Date_Uploaded"), result.getString("Type"), result.getString("Uploader"), result.getString("Description"), creport, project);
                
                
                reportList.add(report);
            }
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.ContractorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return reportList;
    }
      
      
    public Project getProjectInfo(String id) {

        Project project = null;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select * from project where ID = ?";

            statement = connection.prepareStatement(query);
            statement.setString(1, id);

            result = statement.executeQuery();

            while (result.next()) {

                project = new Project();
                project.setId(result.getString("ID"));
                project.setName(result.getString("Name"));
                project.setDescription(result.getString("Description"));
                project.setCategory(result.getString("Category"));
                project.setStatus(result.getString("Status"));

            }
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.ContractorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return project;
    }
    
    
    
    
        public ArrayList<Inspection_Report> getInspectionDate(Project project) {
       
        ArrayList<Inspection_Report> list = new ArrayList<Inspection_Report>();
        Inspection_Report inspectionDate = null;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select DISTINCT DateUploaded from task join schedule on task.ID = Task_ID\n" +
"join inspection_report on inspection_report.Task_ID = task.ID\n" +
"where Project_ID = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, project.getId());
            
            result = statement.executeQuery();
            while (result.next()) {
                
                
                inspectionDate = new Inspection_Report();
                inspectionDate.setDateUploaded(result.getString("DateUploaded"));
                list.add(inspectionDate);
                
            }
            statement.close();
            connection.close();
            return list;
            
        } catch (SQLException ex) {
            Logger.getLogger(GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    
    public ArrayList<Schedule> getTaskSchedule(String id) {

        ArrayList<Schedule> reportList = new ArrayList<Schedule>();
        Schedule schedule;
        Task task;
        
        
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select task.ID,Name, min(StartDate) as StartDate,max(EndDate) as EndDate from task join schedule on schedule.Task_ID = task.ID\n" +
"where schedule.Status = 'Pending' AND task.Project_ID = ? group by Name";
            statement = connection.prepareStatement(query);
            statement.setString(1, id);
            

            result = statement.executeQuery();

            while (result.next()) {
                
                schedule = new Schedule();
                task = new Task();
                
                task.setId(result.getInt("ID"));
                task.setName(result.getString("Name"));
                
                
                schedule.setStartdate(result.getString("StartDate"));                
                schedule.setEnddate(result.getString("EndDate"));
                schedule.setTask(task);
                
                reportList.add(schedule);

                
                
            }
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return reportList;
    }
    
    
    
    public void addInspection_Report(String remark, int taskid) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "INSERT INTO inspection_report (Remark, DateUploaded, Task_ID) VALUES (?, now(), ?);";
            statement = connection.prepareStatement(query);
            statement.setString(1, remark);
            statement.setInt(2, taskid);
            
            
            
            statement.executeUpdate();
            statement.close();
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

    }
    
    
            public ArrayList<Inspection_Report> getInspectionPerDate(String projectid, String date) {
       
        ArrayList<Inspection_Report> list = new ArrayList<Inspection_Report>();
        Inspection_Report inspection = null;
        Task task;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select Name, Remark,DateUploaded from inspection_report join task on Task_ID = task.id where task.Project_ID = ? AND DateUploaded = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, projectid);
            statement.setString(2, date);
            
            result = statement.executeQuery();
            while (result.next()) {
                
                task = new Task();
                task.setName(result.getString("Name"));
                inspection = new Inspection_Report();
                inspection.setRemark(result.getString("Remark"));
                inspection.setDateUploaded(result.getString("DateUploaded"));
                inspection.setTask(task);
                
                list.add(inspection);
                
                
                
            }
            statement.close();
            connection.close();
            return list;
            
        } catch (SQLException ex) {
            Logger.getLogger(GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    
        public void finishTask(int id) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "UPDATE schedule SET Status = 'Finished', ActualEndDate = now() WHERE Task_ID = ?";
            statement = connection.prepareStatement(query);
            statement.setInt(1, id);
            
            
            statement.executeUpdate();
            statement.close();
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

    }
        
        
    public void finishProjects() {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "UPDATE project SET Status = 'Finished' WHERE ID not in (Select Project_ID from task join schedule on task.id = schedule.Task_ID where schedule.Status = 'Pending')";
            statement = connection.prepareStatement(query);
            
            
            statement.executeUpdate();
            statement.close();
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

    }
    
    
    
            public ArrayList<Timeline_Update> getTimeline_UpdateList(Project project) {

        ArrayList<Timeline_Update> timeline_updates = new ArrayList<Timeline_Update>();
        Timeline_Update update;
        User user;

        try {

            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();

            String query = "select * from timeline_update JOIN users on users.ID = Users_ID\n" +
"where Project_ID = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, project.getId());
            
            result = statement.executeQuery();

            while (result.next()) {
                user = new User(result.getInt("Users.ID"), result.getString("Username"));
                update = new Timeline_Update(result.getInt("timeline_update.ID"), result.getString("Message"), project, user);
                timeline_updates.add(update);
                
            }
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.ContractorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return timeline_updates;
    }    
            
            
            
        public User getUser(Employee emp) {
        User u = null;

        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select * from users where users.ID = ?";

            statement = connection.prepareStatement(query);
            statement.setInt(1, emp.getUser().getId());
            result = statement.executeQuery();
            while (result.next()) {
                u = new User(result.getInt("users.id"), result.getString("username"), result.getString("password"), result.getString("type"));

            }

            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.ActivityDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return u;
    }
        
        
        
        public void submitTimelineUpdate(Timeline_Update timelineupdate) {

        try {

            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();

            String query = "INSERT INTO timeline_update (Message, Project_ID, Users_ID) VALUES (?,?,?);";

            statement = connection.prepareStatement(query);

            statement.setString(1, timelineupdate.getMessage());
            statement.setString(2, timelineupdate.getProject().getId());
            statement.setInt(3, timelineupdate.getUser().getId());

            statement.executeUpdate();
            statement.close();
            connection.close();

        } catch (SQLException ex) {
            Logger.getLogger(DAO.ContractorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }    
        
        
        
        
    public ArrayList<Schedule> getCompletedTaskReport(String id) {

        ArrayList<Schedule> reportList = new ArrayList<Schedule>();
        Schedule schedule;
        Task task;
        
        
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select task.Name, Description, min(StartDate), max(EndDate), ActualEndDate from task join schedule on task.ID = schedule.Task_ID where Project_ID = ?\n" +
"group by Name";
            statement = connection.prepareStatement(query);
            statement.setString(1, id);
            

            result = statement.executeQuery();

            while (result.next()) {
                
                schedule = new Schedule();
                task = new Task();
                
                task.setName(result.getString("Name"));
                task.setDescription(result.getString("Description"));
                
                schedule.setStartdate(result.getString("min(StartDate)"));                
                schedule.setEnddate(result.getString("max(EndDate)"));
                schedule.setActualenddate(result.getString("ActualEndDate"));
                schedule.setTask(task);
                
                reportList.add(schedule);

                
                
            }
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return reportList;
    }

}
