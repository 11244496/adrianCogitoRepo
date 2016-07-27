/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Entity;

/**
 *
 * @author Krist
 */
public class Inspection_Report {
    
    
    private int ID;
    private String Remark;
    private String DateUploaded;
    private Task task;

    public Inspection_Report(int ID, String Remark, String DateUploaded) {
        this.ID = ID;
        this.Remark = Remark;
        this.DateUploaded = DateUploaded;
    }
    
    
    public Inspection_Report() {
    }

    public int getID() {
        return ID;
    }

    public String getRemark() {
        return Remark;
    }

    public String getDateUploaded() {
        return DateUploaded;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public void setRemark(String Remark) {
        this.Remark = Remark;
    }

    public void setDateUploaded(String DateUploaded) {
        this.DateUploaded = DateUploaded;
    }

    public Task getTask() {
        return task;
    }

    public void setTask(Task task) {
        this.task = task;
    }
    
    
    
}
