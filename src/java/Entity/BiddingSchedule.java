/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Entity;

import java.util.ArrayList;

/**
 *
 * @author RoAnn
 */
public class BiddingSchedule {

    private int id;
    private String event;
    private String startdate;
    private String enddate;
    private String status;
    private String actualenddate;
    private Project project;
    private String reasonfordelay;

    public BiddingSchedule() {
    }

    public BiddingSchedule(String event, String startdate, String enddate, String status, String actualenddate, Project project, String reasonfordelay) {
        this.event = event;
        this.startdate = startdate;
        this.enddate = enddate;
        this.status = status;
        this.actualenddate = actualenddate;
        this.project = project;
        this.reasonfordelay = reasonfordelay;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEvent() {
        return event;
    }

    public void setEvent(String event) {
        this.event = event;
    }

    public String getStartdate() {
        return startdate;
    }

    public void setStartdate(String startdate) {
        this.startdate = startdate;
    }

    public String getEnddate() {
        return enddate;
    }

    public void setEnddate(String enddate) {
        this.enddate = enddate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getActualenddate() {
        return actualenddate;
    }

    public void setActualenddate(String actualenddate) {
        this.actualenddate = actualenddate;
    }

    public Project getProject() {
        return project;
    }

    public void setProject(Project project) {
        this.project = project;
    }

    public String getReasonfordelay() {
        return reasonfordelay;
    }

    public void setReasonfordelay(String reasonfordelay) {
        this.reasonfordelay = reasonfordelay;
    }

    
    
}
