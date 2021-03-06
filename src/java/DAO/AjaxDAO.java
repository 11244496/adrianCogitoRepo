/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DB.ConnectionFactory;
import Entity.Agenda;
import Entity.Citizen;
import Entity.Component;
import Entity.Contractor;
import Entity.Files;
import Entity.Location;
import Entity.PWorks;
import Entity.Project;
import Entity.Schedule;
import Entity.TLocation;
import Entity.Task;
import Entity.Testimonial;
import Entity.Unit;
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
            String query = "select id from project where category = ?";
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

    public ArrayList<TLocation> getSearchedTestimonial(String searchQuery) {

        ArrayList<TLocation> tlocation = new ArrayList<TLocation>();

        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "SELECT * FROM testimonial join TLocation on testimonial.ID = tlocation.Testimonial_ID join Citizen on Citizen_ID = citizen.id where Title like \"%" + searchQuery + "%\" or Category like \"%" + searchQuery + "%\" or Message like \"%" + searchQuery + "%\";";
            statement = connection.prepareStatement(query);
            result = statement.executeQuery();
            while (result.next()) {
                TLocation loc = new TLocation();
                loc.setId(result.getInt("tlocation.ID"));
                loc.setLatitude(result.getString("latitude"));
                loc.setLongitude(result.getString("longitude"));
                Testimonial testi = new Testimonial();
                testi.setId(result.getInt("testimonial.id"));
                testi.setTitle(result.getString("Title"));
                testi.setDateUploaded(result.getString("dateuploaded"));
                testi.setMessage(result.getString("message"));
                testi.setCategory(result.getString("category"));
                testi.setFolderName(result.getString("foldername"));
                Citizen c = new Citizen();
                c.setId(result.getInt("Citizen_ID"));
                c.setFirstName(result.getString("citizen.FirstName"));
                c.setMiddleName(result.getString("citizen.MiddleName"));
                c.setLastName(result.getString("citizen.LastName"));
                testi.setCitizen(c);
                testi.setStatus(result.getString("Status"));
                loc.setTestimonial(testi);

                tlocation.add(loc);
            }

            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in retrieving IDs", ex);
        }

        return tlocation;
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

    public ArrayList<Agenda> getAgenda(int id) {
        ArrayList<Agenda> aList = new ArrayList<>();
        Agenda a = null;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select * from agenda where task_id = ?";
            statement = connection.prepareStatement(query);
            statement.setInt(1, id);
            result = statement.executeQuery();
            while (result.next()) {
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

    public void updateMeeting(int s, String status) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "update schedule set status = ? where id = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, status);
            statement.setInt(2, s);
            statement.executeUpdate();
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in updating meeting schedule", ex);
        }
    }

    public void updateMeeting(int s, String status, Schedule sc) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "update schedule set status = ?, startdate = ?, enddate = ?, time = ?, remarks = ? where id = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, status);
            statement.setString(2, sc.getStartdate());
            statement.setString(3, sc.getEnddate());
            statement.setString(4, sc.getTime());
            statement.setString(5, sc.getRemarks());
            statement.setInt(6, s);
            statement.executeUpdate();
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in updating meeting schedule", ex);
        }
    }
    
    public ArrayList<PWorks> getPworks(String id) {
        ArrayList<PWorks> pList = new ArrayList<>();
        PWorks p = null;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select * from project_has_works join pworks on pworks_id = pworks.id where project_id = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, id);
            result = statement.executeQuery();
            while (result.next()) {
                p = new PWorks();
                p.setId(result.getInt("pworks.ID"));
                p.setName(result.getString("Name"));
                pList.add(p);
            }
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in getting agenda", ex);
        }
        return pList;
    }

    public ArrayList<Component> getComponent(int pid, String projId) {
        ArrayList<Component> cList = new ArrayList<>();
        Component c = null;
        Unit u = null;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select * from components join unit on unit_id = unit.id join Project_has_works on project_has_works.id = project_has_pworks_id\n"
                    + "where project_id = ? and pworks_id = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, projId);
            statement.setInt(2, pid);
            result = statement.executeQuery();
            while (result.next()) {
                c = new Component();
                c.setId(result.getInt("components.id"));
                c.setName(result.getString("components.name"));
                c.setUnitPrice(result.getFloat("unitprice"));
                c.setQuantity(result.getInt("quantity"));
                u = new Unit();
                u.setId(result.getInt("unit.id"));
                u.setUnit(result.getString("unit"));
                c.setUnit(u);
                cList.add(c);
            }
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in getting components", ex);
        }
        return cList;
    }

    public ArrayList<Task> getTask(String id) {
        ArrayList<Task> tList = new ArrayList<>();
        Task t = null;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select * from task where project_id = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, id);
            result = statement.executeQuery();
            while (result.next() && !result.getString("Name").equalsIgnoreCase("Meeting with OCPD")) {
                t = new Task();
                t.setId(result.getInt("ID"));
                t.setName(result.getString("Name"));
                tList.add(t);
            }
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in getting agenda", ex);
        }
        return tList;
    }

    public ArrayList<Schedule> getSchedule(int id) {
        ArrayList<Schedule> sList = new ArrayList<>();
        Schedule s = null;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select * from schedule where task_id = ?";
            statement = connection.prepareStatement(query);
            statement.setInt(1, id);
            result = statement.executeQuery();
            while (result.next()) {
                s = new Schedule();
                s.setId(result.getInt("ID"));
                s.setStartdate(result.getString("Startdate"));
                s.setEnddate(result.getString("Enddate"));
                sList.add(s);
            }
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in getting agenda", ex);
        }
        return sList;
    }

    public ArrayList<PWorks> powTemplate(String[] ids) {
        ArrayList<PWorks> pList = new ArrayList<>();
        PWorks p = null;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "select pworks.id, pworks.name from project_has_works join pworks on pworks.id = PWorks_ID where project_id=? ";
            for (int x = 1; x < ids.length; x++) {
                query += "or project_id = ? ";
            }
            query += " group by name";
            statement = connection.prepareStatement(query);
            for (int x = 0; x < ids.length; x++) {
                statement.setString(x + 1, ids[x]);
            }
            result = statement.executeQuery();

            while (result.next()) {
                p = new PWorks();
                p.setId(result.getInt("pworks.id"));
                p.setName(result.getString("pworks.name"));
                pList.add(p);
            }

            for (PWorks pw : pList) {
                pw.setComponents(getComponentsForTemplate(ids, pw.getName()));
            }

            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.GSDAO.class.getName()).log(Level.SEVERE, "Error in getting works for template", ex);
        }
        return pList;
    }

    public ArrayList<Component> getComponentsForTemplate(String[] id, String work) throws SQLException {
        ArrayList<Component> cList = new ArrayList<>();
        Component c = new Component();
        String query = "select * from components \n"
                + "join project_has_works on project_has_pworks_id = project_has_works.id\n"
                + "join pworks on pworks.id = pworks_id\n"
                + "where pworks.name=? and (project_id = ? ";

        for (int x = 1; x < id.length; x++) {
            query += "or project_id = ?";
        }
        query += ") group by components.name";
        statement = connection.prepareStatement(query);
        statement.setString(1, work);
        for (int x = 0; x < id.length; x++) {
            statement.setString(x + 2, id[x]);
        }
        result = statement.executeQuery();
        while (result.next()) {
            c = new Component();
            c.setId(result.getInt("components.id"));
            c.setName(result.getString("components.name"));
            cList.add(c);
        }
        return cList;
    }

}
