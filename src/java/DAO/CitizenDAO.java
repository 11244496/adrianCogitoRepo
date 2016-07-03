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
import Entity.Files;
import Entity.Location;
import Entity.Project;
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
    public Testimonial getTestimonial(int id) {
        Testimonial t = null;
        Citizen c = null;
        User u = null;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select testimonial.id, title, dateuploaded, \n"
                    + "category, message, foldername, status, citizen.id, \n"
                    + "firstname, lastname, users.id, username from testimonial \n"
                    + "join citizen on citizen_id = citizen.ID\n"
                    + "join users on users_id = users.id"
                    + " where testimonial.ID = ?";

            statement = connection.prepareStatement(query);
            statement.setInt(1, id);
            result = statement.executeQuery();
            while (result.next()) {
                u = new User(result.getInt("users.id"), result.getString("username"));
                c = new Citizen(result.getInt("citizen.id"), result.getString("FirstName"), result.getString("lastname"), u);
                t = new Testimonial(result.getInt("testimonial.id"), result.getString("title"), result.getString("dateuploaded"),
                        result.getString("message"), result.getString("foldername"), result.getString("category"),
                        result.getString("status"), c);
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

    public ArrayList<TLocation> getLocation(Testimonial t) {
        ArrayList<TLocation> locList = new ArrayList<>();
        TLocation loc;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String ids = "select * from tlocation where testimonial_id = ?";

            statement = connection.prepareStatement(ids);
            statement.setInt(1, t.getId());

            result = statement.executeQuery();
            while (result.next()) {
                loc = new TLocation(result.getInt("id"), result.getString("longitude"), result.getString("latitude"), t);
                locList.add(loc);
            }
            connection.close();
        } catch (SQLException ex) {
            System.out.println("Error in getLocation()");
            Logger.getLogger(CitizenDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return locList;
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

}
