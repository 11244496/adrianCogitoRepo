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
public class Schedule {

    private int id;
    private String startdate;
    private String enddate;
    private String status;
    private String time;
    private String actualenddate;
    private String remarks;
    private Task task;

    public Schedule() {
    }

    public Schedule(int id, String startdate, String enddate, String status, String time, String actualenddate, String remarks, Task task) {
        this.id = id;
        this.startdate = startdate;
        this.enddate = enddate;
        this.status = status;
        this.time = time;
        this.actualenddate = actualenddate;
        this.remarks = remarks;
        this.task = task;
    }
    /**
     * @return the id
     */
    public int getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * @return the startdate
     */
    public String getStartdate() {
        return startdate;
    }

    /**
     * @param startdate the startdate to set
     */
    public void setStartdate(String startdate) {
        this.startdate = startdate;
    }

    /**
     * @return the enddate
     */
    public String getEnddate() {
        return enddate;
    }

    /**
     * @param enddate the enddate to set
     */
    public void setEnddate(String enddate) {
        this.enddate = enddate;
    }

    /**
     * @return the status
     */
    public String getStatus() {
        return status;
    }

    /**
     * @param status the status to set
     */
    public void setStatus(String status) {
        this.status = status;
    }

    /**
     * @return the time
     */
    public String getTime() {
        return time;
    }

    /**
     * @param time the time to set
     */
    public void setTime(String time) {
        this.time = time;
    }

    /**
     * @return the actualenddate
     */
    public String getActualenddate() {
        return actualenddate;
    }

    /**
     * @param actualenddate the actualenddate to set
     */
    public void setActualenddate(String actualenddate) {
        this.actualenddate = actualenddate;
    }

    /**
     * @return the remarks
     */
    public String getRemarks() {
        return remarks;
    }

    /**
     * @param remarks the remarks to set
     */
    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    /**
     * @return the task
     */
    public Task getTask() {
        return task;
    }

    /**
     * @param task the task to set
     */
    public void setTask(Task task) {
        this.task = task;
    }

}