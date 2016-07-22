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
public class Report_File {
    
    
    private int id;
    private String filename;
    private String date_uploaded;
    private String type;
    private String uploader;
    private String description;
    private Citizen_Report citizenReport;
    private Project project;

     public Report_File(){
     
     
     }
    
    
    public Report_File(int id, String filename, String date_uploaded, String type, String uploader, String description, Citizen_Report citizenReport, Project project) {
        this.id = id;
        this.filename = filename;
        this.date_uploaded = date_uploaded;
        this.type = type;
        this.uploader = uploader;
        this.description = description;
        this.citizenReport = citizenReport;
        this.project = project;
    }

    
    
    
    public int getId() {
        return id;
    }

    public String getFilename() {
        return filename;
    }

    public String getDate_uploaded() {
        return date_uploaded;
    }

    public String getType() {
        return type;
    }

    public String getUploader() {
        return uploader;
    }

    public String getDescription() {
        return description;
    }

    public Citizen_Report getCitizenReport() {
        return citizenReport;
    }

    public Project getProject() {
        return project;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    public void setDate_uploaded(String date_uploaded) {
        this.date_uploaded = date_uploaded;
    }

    public void setType(String type) {
        this.type = type;
    }

    public void setUploader(String uploader) {
        this.uploader = uploader;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setCitizenReport(Citizen_Report citizenReport) {
        this.citizenReport = citizenReport;
    }

    public void setProject(Project project) {
        this.project = project;
    }
    
    
    
    
    
    
    
}
