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
public class Citizen_Report {
    
    
    private int id;
    private String message;
    private String foldername;
    private  String Date;
    private Citizen citizen;
    private Project project;

    public Citizen_Report(int id, String message, String foldername, String Date, Citizen citizen, Project project) {
        this.id = id;
        this.message = message;
        this.foldername = foldername;
        this.Date = Date;
        this.citizen = citizen;
        this.project = project;
    }

    public Citizen_Report() {
       
    }

    public int getId() {
        return id;
    }

    public String getMessage() {
        return message;
    }

    public String getDate() {
        return Date;
    }

    public Citizen getCitizen() {
        return citizen;
    }

    public Project getProject() {
        return project;
    }

    public String getFoldername() {
        return foldername;
    }

    public void setFoldername(String foldername) {
        this.foldername = foldername;
    }
    
    

    public void setId(int id) {
        this.id = id;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public void setDate(String Date) {
        this.Date = Date;
    }

    public void setCitizen(Citizen citizen) {
        this.citizen = citizen;
    }

    public void setProject(Project project) {
        this.project = project;
    }
    
    
    
    
    
    
    
    
}
