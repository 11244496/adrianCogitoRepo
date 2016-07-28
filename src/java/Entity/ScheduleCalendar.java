/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Entity;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

/**
 *
 * @author RoAnn
 */
public class ScheduleCalendar {

    private ArrayList<BiddingSchedule> bidding;
    private DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    private Calendar c = Calendar.getInstance();
    private Project p;
    private BiddingSchedule bs;
    String date;

    public void createBiddingSched(Project p) throws ParseException {
        bidding = new ArrayList<>();

        //Start: Next day | End: Same
        checkWeekend(c);
        bs = new BiddingSchedule("Post Invitation to Bid", dateFormat.format(c.getTime()), dateFormat.format(c.getTime()), "Done", dateFormat.format(c.getTime()), p, null);
        bidding.add(bs);
        String sDates = dateFormat.format(c.getTime());

        //Start: See ITB | End: 5 days
        c.add(Calendar.DATE, 5);
        bs = new BiddingSchedule("Receipt of LOI and Application for Eligibility", sDates, dateFormat.format(c.getTime()), "Current", null, p, null);
        bidding.add(bs);

        //Start: Next day | End: Same Day
        c.add(Calendar.DATE, 1);
        checkWeekend(c);
        bs = new BiddingSchedule("Pre-bid conference", dateFormat.format(c.getTime()), dateFormat.format(c.getTime()), "Current", null, p, null);
        bidding.add(bs);
        c.add(Calendar.DATE, 12);
        String openingDate = dateFormat.format(c.getTime());
        c.add(Calendar.DATE, -12);

        //Start: See ITB | End: Add1
        c.add(Calendar.DATE, 1);
        bs = new BiddingSchedule("Issuance of Bid Documents", sDates, dateFormat.format(c.getTime()), "Current", null, p, null);
        bidding.add(bs);

        //Start: See ITB | End: add 1
        c.add(Calendar.DATE, 1);
        bs = new BiddingSchedule("Issuance of Eligibility Forms", sDates, dateFormat.format(c.getTime()), "Current", null, p, null);
        bidding.add(bs);

        //Start: See ITB | End: get time
        bs = new BiddingSchedule("Receipt of Eligibility Requirements", sDates, dateFormat.format(c.getTime()), "Current", null, p, null);
        bidding.add(bs);

        //Start: See ITB | End: 14 days
        bs = new BiddingSchedule("Notice of Results of Eligibility Check", sDates, addDate(c, 1), "Current", null, p, null);
        bidding.add(bs);

        c.setTime(dateFormat.parse(openingDate));
        checkWeekend(c);
        bs = new BiddingSchedule("Receipt and Opening of Bids", dateFormat.format(c.getTime()), dateFormat.format(c.getTime()), "Current", null, p, null);
        bidding.add(bs);

        c.add(Calendar.DATE, 1);
        bs = new BiddingSchedule("Post Qualification", dateFormat.format(c.getTime()), null, "Current", null, p, null);
        c.add(Calendar.DATE, 7);
        bs.setEnddate(dateFormat.format(c.getTime()));
        bidding.add(bs);

        c.add(Calendar.DATE, 3);
        checkWeekend(c);
         bs = new BiddingSchedule("Awarding", dateFormat.format(c.getTime()), dateFormat.format(c.getTime()), "Current", null, p, null);
        bidding.add(bs);

        c.add(Calendar.DATE, 15);
        checkWeekend(c);
        bs = new BiddingSchedule("Issuance of Notice to Proceed", dateFormat.format(c.getTime()), dateFormat.format(c.getTime()), "Current", null, p, null);
        bidding.add(bs);
    }

    public int convertdays(String label, int number) {
        int days = 0;

        if (label.equalsIgnoreCase("Day/s")) {
            days = number;
        } else if (label.equalsIgnoreCase("Week/s")) {
            days = number * 7;
        } else if (label.equalsIgnoreCase("Month/s")) {
            days = number * 30;
        }

        return days;
    }

    public String addDate(Calendar c, int days) {
        for (int x = 0; x < days; x++) {
            c.add(Calendar.DATE, 1);
        }
        if (c.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY) {
            c.add(Calendar.DATE, 2);
        } else if (c.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY) {
            c.add(Calendar.DATE, 1);

        }
        return dateFormat.format(c.getTime());
    }

    public String reduceDate(Calendar c, int days) {

        for (int x = 0; x < days; x++) {
            int dayOfWeek = c.get(Calendar.DAY_OF_WEEK);

            if (dayOfWeek == Calendar.MONDAY) {
                c.add(Calendar.DATE, -3);
            } else if (dayOfWeek == Calendar.SUNDAY) {
                c.add(Calendar.DATE, -2);
            } else {
                c.add(Calendar.DATE, -1);
            }
        }
        return dateFormat.format(c.getTime());

    }

    public void checkWeekend(Calendar c) {
        int day = c.get(Calendar.DAY_OF_WEEK);
        if (day == Calendar.SATURDAY) {
            c.add(Calendar.DATE, 2);
        } else if (day == Calendar.SUNDAY) {
            c.add(Calendar.DATE, 1);
        }
    }

    public ArrayList<BiddingSchedule> getBidding() {
        return bidding;
    }

}
