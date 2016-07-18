/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DB.ConnectionFactory;
import Entity.Contractor;
import Entity.Files;
import Entity.Project;
import Entity.Schedule;
import Entity.Testimonial;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author AdrianKyle
 */
public class AjaxDAO {

    Connection connection;
    PreparedStatement statement;
    ResultSet result;
    ConnectionFactory myFactory;

    public String createProjectID(String category) {
        ArrayList<String> idList = getProjectIDsPerCategory(category);
        String id = generateNewIfExisting(category);
        while (idList.contains(id)) {
            id = generateNewIfExisting(category);
        }
        return id;
    }

    public ArrayList<String> getProjectIDsPerCategory(String category) {
        Collection<String> idList = new ArrayList<>();
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select * id from project where category = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, category);
            result = statement.executeQuery();
            while (result.next()) {
                idList.add(result.getString("ID"));
            }
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in retrieving IDs", ex);
        }

        return new ArrayList(idList);
    }

    public String generateNewIfExisting(String category) {
        Random r = new Random();
        int num = r.nextInt(8999);
        String id = "";
        LocalDate ld = LocalDate.now();
        String month = ld.getMonth().getValue() + "";
        String year = ("" + ld.getYear()).substring(2, 4);

        switch (category) {
            case "Maintenance": {
                id += "MA";
                break;
            }
            case "Vertical": {
                id += "VE";
                break;
            }
            case "Horizontal": {
                id += "HO";
            }
        }

        if (ld.getMonth().getValue() < 10) {
            month = "0" + month;
        }
        id += month + year + num;

        return id;
    }
    
    public Files getFile(int id) {
        Files f = null;
        Testimonial t;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String filesQuery = ("select * from files where id = ?");
            statement = connection.prepareStatement(filesQuery);
            statement.setInt(1, id);
            result = statement.executeQuery();
            while (result.next()) {
                f = new Files();
                f.setId(id);
                f.setFileName(result.getString("FileName"));
                f.setDateUploaded(result.getString("DateUploaded"));
                f.setType(result.getString("type"));
                f.setStatus(result.getString("status"));
                f.setUploader(result.getString("uploader"));
                t = new Testimonial();
                t.setId(result.getInt("Testimonial_ID"));
                f.setTestimonial(t);
            }
            connection.close();
            return f;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return f;

    }
    
    

    public Files getProjectFile(int id) {
        Files f = null;
        Testimonial t;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String filesQuery = ("select * from files where id = ?");
            statement = connection.prepareStatement(filesQuery);
            statement.setInt(1, id);
            result = statement.executeQuery();
            while (result.next()) {
                f = new Files();
                f.setId(id);
                f.setFileName(result.getString("FileName"));
                f.setDateUploaded(result.getString("DateUploaded"));
                f.setType(result.getString("type"));
                f.setStatus(result.getString("status"));
                f.setUploader(result.getString("uploader"));
            }
            connection.close();
            return f;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return f;

    }
    
    public ArrayList<Contractor> getIdle() {
        ArrayList<Contractor> cList = new ArrayList<>();
        Contractor c;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select * from contractor";
            statement = connection.prepareStatement(query);
            result = statement.executeQuery();
            while (result.next()) {
                c = new Contractor();
                c.setID(result.getInt("contractor.id"));
                c.setName(result.getString("contractor.name"));
                cList.add(c);
            }
            connection.close();
            return cList;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cList;

    }




//        Random r = new Random();
//        int num = r.nextInt(8999);
//        ArrayList<String> ids = new ArrayList<>();
//        String finalid = null;
//        String category = null;
//
//        Date d = new Date();
//        Calendar cal = Calendar.getInstance();
//        cal.setTime(d);
//        int year = cal.get(Calendar.YEAR);
//        int month = cal.get(Calendar.MONTH);
//
//        String finalyear = Integer.toString(year).substring(2, 4);
//        String finalmonth;
//        String finaldate;
//
//        if (month < 10) {
//            finalmonth = "0" + Integer.toString(month + 1);
//        } else {
//            finalmonth = Integer.toString(month + 1);
//        }
//
//        finaldate = finalmonth + finalyear;
//
//        if (Maincategory.equalsIgnoreCase("Vertical")) {
//            category = "VE";
//        } else if (Maincategory.equalsIgnoreCase("Horizontal")) {
//            category = "HO";
//        } else if (Maincategory.equalsIgnoreCase("Maintenance")) {
//            category = "MA";
//        }
//
//        finalid = category + finaldate + (num + 1000);
//
//        try {
//            myFactory = ConnectionFactory.getInstance();
//            connection = myFactory.getConnection();
//            String query = "select id from project";
//            statement = connection.prepareStatement(query);
//            result = statement.executeQuery();
//            while (result.next()) {
//                ids.add(result.getString("id"));
//            }
//            statement.close();
//            connection.close();
//
//            while (ids.contains(finalid)) {
//                num = r.nextInt(8999);
//                finalid = category + finaldate + (num + 1000);
//            }
//
//            return finalid;
}
