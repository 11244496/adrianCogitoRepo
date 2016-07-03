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
import Entity.Project;
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
    //FIX THIS BASED ON NEW DB MAKE THIS JUST LIKE THE GET PROJECT
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
                t = new Testimonial(result.getInt("testimonial.id"), result.getString("testimonial.title"), result.getString("testimonial.dateuploaded"), result.getString("testimonial.message"), result.getString("testimonial.foldername"), result.getString("testimonial.location"), result.getString("testimonial.locationdetails"), result.getString("testimonial.category"), result.getString("testimonial.concern"), result.getString("testimonial.status"), c);
                Project p = new Project();
                p.setId(result.getString("testimonial.Project_ID"));
                t.setProject(p);
            }

            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.ActivityDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return t;
    }

    //CITIZEN HOME METHODS
    public ArrayList<Integer> gettoptestimonialID() {

        ArrayList<Integer> toptestiID = new ArrayList<Integer>();

        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();

            String query = "SELECT Testimonial_ID, COUNT(*)\n"
                    + "FROM supporters\n"
                    + "Group By Testimonial_ID\n"
                    + "Order By COUNT(*) DESC\n"
                    + "LIMIT 10";

            statement = connection.prepareStatement(query);
            result = statement.executeQuery();

            while (result.next()) {

                int ID = result.getInt("Testimonial_ID");

                toptestiID.add(ID);
            }
            connection.close();
            return toptestiID;

        } catch (SQLException ex) {
            Logger.getLogger(CitizenDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return toptestiID;

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
            Logger.getLogger(CitizenDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return test;
    }

    public int getunlikedtestimonial(Citizen c) {
        int unlinkedtesti = 0;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "SELECT COUNT(*) as c FROM testimonial where Citizen_ID = ? AND Project_ID = ?";

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
