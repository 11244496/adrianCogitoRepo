/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DB.ConnectionFactory;
import Entity.Address;
import Entity.Barangay;
import Entity.Citizen;
import Entity.Comment;
import Entity.Files;
import Entity.Location;
import Entity.Project;
import Entity.Reply;
import Entity.Supporter;
import Entity.TComments;
import Entity.TLocation;
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
public class CitizenDAO {

    Connection connection;
    PreparedStatement statement;
    ResultSet result;
    ConnectionFactory myFactory;

    //==============================USER RELATED METHODS=========================================================
    public void registerCitizen(String Username, String Password, String FirstName, String MiddleName, String LastName, Address address, Barangay barangay, String type) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            PreparedStatement statement2;
            PreparedStatement statement3;
            PreparedStatement statement4;
            String query = "insert into users (username, password, type) values (?, ?, ?)";
            String query2 = "insert into citizen (firstname, middlename, lastname, users_id) values (?, ?, ?, (select last_insert_id()))";
            String query3 = "insert into address (housenostreet, postalcode, barangay_id)values (?,?,(select id from barangay where barangay = ?))";
            String query4 = "update citizen set address_id = (select max(address.id) from address) where users_id = (select id from users where username = ?)";

            statement = connection.prepareStatement(query);
            statement.setString(1, Username);
            statement.setString(2, Password);
            statement.setString(3, type);
            statement.executeUpdate();
            statement.close();

            statement2 = connection.prepareStatement(query2);
            statement2.setString(1, FirstName);
            statement2.setString(2, MiddleName);
            statement2.setString(3, LastName);
            statement2.executeUpdate();
            statement2.close();

            statement3 = connection.prepareStatement(query3);
            statement3.setString(1, address.getHouseNoStreet());
            statement3.setInt(2, address.getPostalCode());
            statement3.setString(3, barangay.getBarangay());
            statement3.executeUpdate();
            statement3.close();

            statement4 = connection.prepareStatement(query4);
            statement4.setString(1, Username);
            statement4.executeUpdate();
            statement4.close();

            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.CitizenDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public User getUser(Citizen c) {
        User u = null;

        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select * from users where users.ID = ?";

            statement = connection.prepareStatement(query);
            statement.setInt(1, c.getUser().getId());
            result = statement.executeQuery();
            while (result.next()) {
                u = new User(result.getInt("users.id"), result.getString("username"), result.getString("password"), result.getString("type"));

            }

            connection.close();
            return u;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.ActivityDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return u;
    }

    public User getInfo(int id) {
        User u = null;
        Citizen c = null;
        Address a = null;
        Barangay b = null;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select * from users join citizen on users.id = users_id join address on address_id = address.id join barangay on barangay_id = barangay.id";

            statement = connection.prepareStatement(query);
            statement.setInt(1, id);
            result = statement.executeQuery();
            while (result.next()) {
                u = new User(result.getInt("users.id"), result.getString("username"), result.getString("password"), result.getString("type"));
                b = new Barangay(result.getInt("barangay.id"), result.getString("barangay"));
                a = new Address(result.getInt("address.id"), result.getString("HouseNoStreet"), result.getInt("postalcode"), b);
                c = new Citizen(result.getInt("citizen.id"), result.getString("FirstName"), result.getString("MiddleName"), result.getString("LastName"), null, u);
            }

            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.ActivityDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return u;
    }

    //=======================================ALL TESTIMONIAL RELATED CODES=============================================
    //Include all parts of the testimonial
    public Testimonial getTestimonial(int id) {
        Testimonial t = new Testimonial();
        t.setId(id);
        Citizen c;
        User u;

        ArrayList<TLocation> tlocation = new ArrayList<TLocation>();
        ArrayList<Project> mainproject = new ArrayList<Project>();
        ArrayList<Project> referencedproject = new ArrayList<Project>();
        ArrayList<Reply> replies = new ArrayList<Reply>();
        ArrayList<Files> files = new ArrayList<Files>();
        ArrayList<TComments> tcomments = new ArrayList<TComments>();
        ArrayList<Supporter> supporters = new ArrayList<Supporter>();

        PreparedStatement statement1, statement2, statement3, statement4, statement5, statement6, statement7;

        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();

            String locationQuery = ("select * from tlocation where Testimonial_ID = ?");
            statement1 = connection.prepareStatement(locationQuery);
            statement1.setInt(1, id);
            result = statement1.executeQuery();
            while (result.next()) {
                TLocation loc = new TLocation();
                loc.setId(result.getInt("ID"));
                loc.setLatitude(result.getString("latitude"));
                loc.setLongitude(result.getString("longitude"));
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
                replies.add(r);
            }
            t.setReplies(replies);

            String filesQuery = ("select * from files where Testimonial_ID = ?");
            statement4 = connection.prepareStatement(filesQuery);
            statement4.setInt(1, id);
            result = statement4.executeQuery();
            while (result.next()) {
                Files f = new Files();
                f.setId(id);
                f.setFileName(filesQuery);
                f.setDateUploaded(filesQuery);
                f.setType(filesQuery);
                f.setStatus(filesQuery);
                f.setUploader(filesQuery);
                f.setDescription(filesQuery);
                Testimonial testi = new Testimonial();
                t.setId(id);
                Project project = new Project();
                project.setId(result.getString("Project_ID"));
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
                Testimonial ctestimonial = new Testimonial();
                ctestimonial.setId(result.getInt("Testimonial_ID"));
                comment.setTestimonial(ctestimonial);

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
                s.setTestimonial(t);
                Citizen cit = new Citizen();
                cit.setId(result.getInt("Citizen_ID"));
                s.setCitizen(cit);

                supporters.add(s);
            }
            t.setSupporters(supporters);

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
                t = new Testimonial(result.getString("title"), result.getString("dateuploaded"),
                        result.getString("message"), result.getString("foldername"), result.getString("category"),
                        result.getString("status"), c, tlocation, mainproject, referencedproject, replies, files, tcomments, supporters);
                t.setId(result.getInt("testimonial.id"));
            }

            connection.close();
        } catch (SQLException ex) {
            System.out.println("Error in getTestimonial();");
            Logger.getLogger(DAO.ActivityDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return t;
    }

    public int gettestimonialcount(Citizen c) {
        int test = 0;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "SELECT COUNT(*) as c FROM testimonial where Citizen_ID = ?";

            statement = connection.prepareStatement(query);
            statement.setInt(1, c.getId());
            result = statement.executeQuery();
            while (result.next()) {
                test = result.getInt("c");
            }
            connection.close();
        } catch (SQLException ex) {
            System.out.println("Error in gettestimonialcount()");
            Logger.getLogger(CitizenDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return test;
    }

    public int getunlikedtestimonial(Citizen c) {
        int unlinkedtesti = 0;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select count(*) c from project_has_testimonial\n"
                    + "join testimonial on testimonial_id = testimonial.id\n"
                    + "where citizen_id = ? and project_id = ?";

            statement = connection.prepareStatement(query);
            statement.setInt(1, c.getId());
            statement.setInt(2, 0);
            result = statement.executeQuery();
            while (result.next()) {
                unlinkedtesti = result.getInt("c");
            }
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(CitizenDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return unlinkedtesti;
    }

    public int getnumberofsubscribers(Testimonial t) {
        int subscribers = 0;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select count(*) as c from supporters where testimonial_ID = ?";

            statement = connection.prepareStatement(query);
            statement.setInt(1, t.getId());
            result = statement.executeQuery();
            while (result.next()) {
                subscribers = result.getInt("c");
            }
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(CitizenDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return subscribers;
    }

    public ArrayList<Integer> getTestimonials(String query, Citizen c) {
        ArrayList<Integer> testId = new ArrayList<>();
        int id;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String ids = query;

            statement = connection.prepareStatement(ids);
            if (c != null) {
                statement.setInt(1, c.getId());
            }
            result = statement.executeQuery();
            while (result.next()) {
                id = result.getInt("t");
                testId.add(id);
            }
            connection.close();
        } catch (SQLException ex) {
            System.out.println("Error in getTestimonials()");
            Logger.getLogger(CitizenDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return testId;
    }
    
    public void submitTestimonial(Testimonial t) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String ids = "insert into testimonial (title, dateuploaded, category, message, foldername, status, citizen_id) values (?, now(), ?, ?, ?, ?, ?)";
            statement = connection.prepareStatement(ids);
            statement.setString(1, t.getTitle());
            statement.setString(2, t.getCategory());
            statement.setString(3, t.getMessage());
            statement.setString(4, t.getFolderName());
            statement.setString(5, t.getStatus());
            statement.setInt(6, t.getCitizen().getId());
            statement.executeUpdate();
            connection.close();
        } catch (SQLException ex) {
            System.out.println("Error in submitTestimonial()");
            Logger.getLogger(CitizenDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    //========================================ALL FILE RELATED CODES===========================================
    public ArrayList<Files> getFiles(int id, Testimonial t, String type) {

        ArrayList<Files> fl = new ArrayList<Files>();

        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();

            String query = "select * from files where Testimonial_ID = ? and type = ? and status = ?";

            statement = connection.prepareStatement(query);
            statement.setInt(1, id);
            statement.setString(2, type);
            statement.setString(3, "Approved");
            result = statement.executeQuery();

            while (result.next()) {

                Files file = new Files();
                file.setId(result.getInt("ID"));
                file.setFileName(result.getString("FileName"));
                file.setDateUploaded(result.getString("DateUploaded"));
                file.setType(result.getString("Type"));
                file.setStatus(result.getString("Status"));
                file.setDescription(result.getString("Description"));
                file.setUploader(result.getString("Uploader"));
                file.setTestimonial(t);
                fl.add(file);
            }
            connection.close();
            return fl;

        } catch (SQLException ex) {
            Logger.getLogger(CitizenDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return fl;

    }

    public void submitFiles(Files f) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String ids = "insert into files (filename, dateuploaded, type, status, uploader, description, testimonial_id) values (?, now(), ?, ?, ?, ?, ?)";
            statement = connection.prepareStatement(ids);
            statement.setString(1, f.getFileName());
            statement.setString(2, f.getType());
            statement.setString(3, f.getStatus());
            statement.setString(4, f.getUploader());
            statement.setString(5, f.getDescription());
            statement.setInt(6, f.getTestimonial().getId());
            statement.executeUpdate();
            connection.close();
        } catch (SQLException ex) {
            System.out.println("Error in submitFiles()");
            Logger.getLogger(CitizenDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    //========================================ALL LOCATION RELATED CODES===========================================
    public void setLocation(TLocation tl) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String ids = "insert into tlocation (longitude, latitude, testimonial_id) values (?, ?, ?)";
            statement = connection.prepareStatement(ids);
            statement.setString(1, tl.getLongitude());
            statement.setString(2, tl.getLatitude());
            statement.setInt(3, tl.getTestimonial().getId());
            statement.executeUpdate();
            connection.close();
        } catch (SQLException ex) {
            System.out.println("Error in setLocation()");
            Logger.getLogger(CitizenDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    //========================================  ETC ===========================================
    public int lastID() {
        int id = 0;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select max(id) id from testimonial";

            statement = connection.prepareStatement(query);
            result = statement.executeQuery();
            while (result.next()) {
                id = result.getInt("id");
            }
            connection.close();
        } catch (SQLException ex) {
            System.out.println("Error in lastID()");
            Logger.getLogger(CitizenDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return id;
    }
    
    public boolean isSubscribed(Testimonial t, Citizen c) {
        int count = 0;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select count(*) as c from supporters where testimonial_ID = ? and citizen_ID = ?";

            statement = connection.prepareStatement(query);
            statement.setInt(1, t.getId());
            statement.setInt(2, c.getId());
            result = statement.executeQuery();
            while (result.next()) {
                count = result.getInt("c");
            }
            connection.close();

            if (count > 0) {
                return true;
            }

            return false;

        } catch (SQLException ex) {
            Logger.getLogger(DAO.ActivityDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

}
