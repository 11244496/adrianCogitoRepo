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
public class Progress_Report {
    
    
    private int ID;
    private String Message;
    
    private String FileName;
    private String FolderName;
    private String DateUploaded;
    private Project project;
    private Contractor_User contractor_user;

    public Progress_Report(int ID, String Message,String FileName, String FolderName, String DateUploaded, Project project, Contractor_User contractor_user) {
        this.ID = ID;
        this.Message = Message;
        this.FileName = FileName;
        this.FolderName = FolderName;
        this.DateUploaded = DateUploaded;
        this.project = project;
        this.contractor_user = contractor_user;
    }
    
    public Progress_Report(){
    
    
    
    }

    public int getID() {
        return ID;
    }

    public String getFileName() {
        return FileName;
    }

    public String getFolderName() {
        return FolderName;
    }

    public String getDateUploaded() {
        return DateUploaded;
    }

    public Project getProject() {
        return project;
    }

    public Contractor_User getContractor_user() {
        return contractor_user;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public void setFileName(String FileName) {
        this.FileName = FileName;
    }

    public void setFolderName(String FolderName) {
        this.FolderName = FolderName;
    }

    public void setDateUploaded(String DateUploaded) {
        this.DateUploaded = DateUploaded;
    }

    public void setProject(Project project) {
        this.project = project;
    }

    public void setContractor_user(Contractor_User contractor_user) {
        this.contractor_user = contractor_user;
    }

    public String getMessage() {
        return Message;
    }

    public void setMessage(String Message) {
        this.Message = Message;
    }
    
    
    
    
    
}
