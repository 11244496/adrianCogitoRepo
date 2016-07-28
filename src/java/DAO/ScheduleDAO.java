/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DB.ConnectionFactory;
import Entity.BiddingSchedule;
import Entity.Project;
import Entity.Schedule;
import Entity.ScheduleCalendar;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.Calendar;

/**
 *
 * @author RoAnn
 */
public class ScheduleDAO {

    Connection connection;
    PreparedStatement statement;
    ResultSet result;
    ConnectionFactory myFactory;
    ArrayList<BiddingSchedule> dbList;
    Calendar c = Calendar.getInstance();
    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");

    public BiddingSchedule updateSchedule(BiddingSchedule CurrentSchedule) throws ParseException {
        Calendar c = Calendar.getInstance();
        Date d = new Date();
        c.setTime(d);

        CurrentSchedule.setActualenddate(df.format(c.getTime()));

        Date start = df.parse(CurrentSchedule.getStartdate());
        Date end = df.parse(CurrentSchedule.getEnddate());
        int length = daysBetween(start, end);
        if (start.after(df.parse(CurrentSchedule.getActualenddate()))) {
            start = new Date();
            c.setTime(start);
            if (length < 0) {
                length = length * -1;
            }
            c.add(Calendar.DATE, length);
            end = c.getTime();
            CurrentSchedule.setStartdate(df.format(start));
            CurrentSchedule.setEnddate(df.format(end));
            updateScheduleStart(CurrentSchedule);
        }
        updateScheduleStatus(CurrentSchedule, "Done");
        return CurrentSchedule;
    }

    public void reschedITB(ArrayList<BiddingSchedule> pSched, String start) throws ParseException {

        ArrayList<BiddingSchedule> bidding = pSched;
        ArrayList<Schedule> newBidding = new ArrayList<>();
        c.setTime(df.parse(start));
        BiddingSchedule bs = null;
        int length = 0;
        for (int x = 1; x < bidding.size();) {
            bs = bidding.get(x);

            if (bs.getEvent().equalsIgnoreCase("Post Invitation to Bid")) {
                bs.setStartdate(start);
                bs.setEnddate(start);
                changeStatus(bs, "Pending");

            } else {
                length = daysBetween(df.parse(bs.getStartdate()), df.parse(bs.getEnddate()));
                c.add(Calendar.DATE, 1);
                bs.setStartdate(df.format(c.getTime()));
                if (length == 0) {
                    bs.setEnddate(df.format(c.getTime()));
                } else {
                    if (length < 0) {
                        length = length * -1;
                    }
                    c.add(Calendar.DATE, length);
                    bs.setEnddate(df.format(c.getTime()));

                }
            }

            updateScheduleDate(bs);
        }

    }

    public void adjust(BiddingSchedule s, ArrayList<BiddingSchedule> sList) throws ParseException {
        ArrayList<BiddingSchedule> newSched = new ArrayList<>();
        int index = 0;
        BiddingSchedule s2 = null;
        c.setTime(df.parse(s.getActualenddate()));

        int length = 0;
        for (int x = index + 1; x < sList.size();) {
            //as long as event is not meeting with ocpd or implementation event
            s2 = new BiddingSchedule();
            s2 = sList.get(x);
            length = daysBetween(df.parse(sList.get(x).getStartdate()), df.parse(sList.get(x).getEnddate()));
            c.add(Calendar.DATE, 1);
            s2.setStartdate(df.format(c.getTime()));

            if (length == 0) {
                s2.setEnddate(df.format(c.getTime()));
            } else {
                c.add(Calendar.DATE, length);
                s2.setEnddate(df.format(c.getTime()));
            }
            newSched.add(s2);
            x++;

        }

        for (BiddingSchedule sc : newSched) {
            updateScheduleDate(sc);
        }

    }

    public void changeStartDate(int id, String start, String end) {
        BiddingSchedule s = new BiddingSchedule();
        s.setId(id);
        s.setStartdate(start);
        s.setEnddate(end);
        updateScheduleDate(s);
    }

    public int daysBetween(Date d1, Date d2) {
        return (int) ((d2.getTime() - d1.getTime()) / (1000 * 60 * 60 * 24));
    }

    //WHEN ENDING AN ACTIVITY
    public void updateScheduleStatus(BiddingSchedule s, String stat) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "update biddingschedule set actualenddate = now(), status = ? where id = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, stat);
            statement.setInt(2, s.getId());
            statement.executeUpdate();
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void changeStatus(BiddingSchedule s, String stat) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "update biddingschedule set status = ? where id = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, stat);
            statement.setInt(2, s.getId());
            statement.executeUpdate();
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateBiddingStatus(BiddingSchedule s, String stat) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "update biddingschedule set actualenddate = ?, status = ? where id = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, s.getEnddate());
            statement.setString(2, stat);
            statement.setInt(3, s.getId());
            statement.executeUpdate();
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateScheduleStart(BiddingSchedule bs) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "update biddingschedule set StartDate = ? where ID = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, bs.getStartdate());
            statement.setInt(2, bs.getId());
            statement.executeUpdate();
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    //ADJUST THE FOLLOWING EVENTS
    public void updateScheduleDate(BiddingSchedule s) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "update biddingschedule set startdate = ?, enddate = ? where ID = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, s.getStartdate());
            statement.setString(2, s.getEnddate());
            statement.setInt(3, s.getId());
            statement.executeUpdate();
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateStart(BiddingSchedule s) {
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String query = "update biddingschedule set StartDate = ? where ID = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, s.getStartdate());
            statement.setInt(2, s.getId());
            statement.executeUpdate();
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    //======================================ALL BIDDING SCHEULD CODES==========================================
    public void insertBiddingSchedule(ArrayList<BiddingSchedule> bs) {

        try {

            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();

            String query = "insert into biddingschedule (event,startdate,enddate,actualenddate,status,reasonfordelay,projectID) values (?,?,?,?,?,?,?);";

            for (int x = 0; x < bs.size(); x++) {
                statement = connection.prepareStatement(query);
                statement.setString(1, bs.get(x).getEvent());
                statement.setString(2, bs.get(x).getStartdate());
                statement.setString(3, bs.get(x).getEnddate());
                statement.setString(4, bs.get(x).getActualenddate());
                statement.setString(5, bs.get(x).getStatus());
                statement.setString(6, bs.get(x).getReasonfordelay());
                statement.setString(7, bs.get(x).getProject().getId());
                statement.executeUpdate();
                statement.close();
            }
            connection.close();

        } catch (SQLException ex) {
            Logger.getLogger(DAO.BACDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public BiddingSchedule getSchedDetails(String id) {
        BiddingSchedule s = null;
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String schedule = "select * from schedule where projectid = ?";

            statement = connection.prepareStatement(schedule);
            statement.setString(1, id);
            result = statement.executeQuery();

            while (result.next()) {
                s = new BiddingSchedule();
                s.setId(result.getInt("ID"));
                s.setEvent(result.getString("Event"));
                s.setStartdate(result.getString("Startdate"));
                s.setEnddate(result.getString("Enddate"));
                s.setActualenddate(result.getString("ActualEndDate"));
                s.setStatus(result.getString("Status"));
                s.setReasonfordelay(result.getString("reasonfordelay"));
                Project p = new Project();
                p.setId(result.getString("projectID"));
                s.setProject(p);
            }

            statement.close();

            connection.close();
            return s;
        } catch (SQLException ex) {
            Logger.getLogger(GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return s;
    }

    public ArrayList<BiddingSchedule> getallSched(String id) {
        ArrayList<BiddingSchedule> bsList = new ArrayList<BiddingSchedule>();
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String schedule = "select * from biddingschedule where projectid = ?";

            statement = connection.prepareStatement(schedule);
            statement.setString(1, id);
            result = statement.executeQuery();

            while (result.next()) {
                BiddingSchedule s = new BiddingSchedule();
                s.setId(result.getInt("ID"));
                s.setEvent(result.getString("Event"));
                s.setStartdate(result.getString("Startdate"));
                s.setEnddate(result.getString("Enddate"));
                s.setActualenddate(result.getString("ActualEndDate"));
                s.setStatus(result.getString("Status"));
                s.setReasonfordelay(result.getString("reasonfordelay"));
                Project p = new Project();
                p.setId(result.getString("projectID"));
                s.setProject(p);
                bsList.add(s);
            }

            statement.close();

            connection.close();
            return bsList;
        } catch (SQLException ex) {
            Logger.getLogger(GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return bsList;
    }
    
    public void removeallBiddingSchedule(String ProjectID){
        try {
            myFactory = ConnectionFactory.getInstance();
            connection = myFactory.getConnection();
            String schedule = "delete from biddingschedule where projectID = ?";

            statement = connection.prepareStatement(schedule);
            statement.setString(1, ProjectID);
            statement.executeUpdate();
            statement.close();
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(GSDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    

}
