/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DB.ConnectionFactory;
import Entity.Activity;
import Entity.Citizen;
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
 * @author RoAnn
 */
/**
 *
 * @author AdrianKyle
 */
public class CityAdminDAO {

    Connection connection;
    PreparedStatement statement;
    ResultSet result;
    ConnectionFactory myFactory;

    public void changeStatus(Testimonial t, String status) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "update Testimonial set status = ? where id = ?";

            statement = connection.prepareStatement(query);
            statement.setString(1, status);
            statement.setInt(2, t.getId());
            statement.executeUpdate();
            statement.close();

            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.CityAdminDAO.class.getName()).log(Level.SEVERE, "Error updating testimonial status", ex);
        }
    }
        //=====================================ALL TESTIMONIAL CODES====================================================

    public ArrayList<Testimonial> getAllTestimonialsforApproval() {
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
                    + "join users on users_id = users.id where status = ?";

            statement = connection.prepareStatement(testimonialquery);
            statement.setString(1, "Pending");
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
            Logger.getLogger(DAO.CityAdminDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return allTesti;
    }

}
