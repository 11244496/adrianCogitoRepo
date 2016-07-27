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
public class Timeline_Update {
    
   
    private int ID;
    private String message;
    private Project project;
    private User user;

    public Timeline_Update(int ID, String message, Project project, User user) {
        this.ID = ID;
        this.message = message;
        this.project = project;
        this.user = user;
    }
    
    public Timeline_Update() {
        
    }
    

    public int getID() {
        return ID;
    }

    public String getMessage() {
        return message;
    }

    public Project getProject() {
        return project;
    }

    public User getUser() {
        return user;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public void setProject(Project project) {
        this.project = project;
    }

    public void setUser(User user) {
        this.user = user;
    }
    
}
