/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Entity;

/**
 *
 * @author AdrianKyle
 */
public class PComments {

    private int id;
    private String comments;
    private String dateSent;
    private Project project;
    private Employee employee;
    private Citizen citizen;

    public PComments() {
    }

    public PComments(int id, String comments, String dateSent, Project project, Employee employee, Citizen citizen) {
        this.id = id;
        this.comments = comments;
        this.dateSent = dateSent;
        this.project = project;
        this.employee = employee;
        this.citizen = citizen;
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
     * @return the comments
     */
    public String getComments() {
        return comments;
    }

    /**
     * @param comments the comments to set
     */
    public void setComments(String comments) {
        this.comments = comments;
    }

    /**
     * @return the dateSent
     */
    public String getDateSent() {
        return dateSent;
    }

    /**
     * @param dateSent the dateSent to set
     */
    public void setDateSent(String dateSent) {
        this.dateSent = dateSent;
    }

    /**
     * @return the project
     */
    public Project getProject() {
        return project;
    }

    /**
     * @param project the project to set
     */
    public void setProject(Project project) {
        this.project = project;
    }

    /**
     * @return the employee
     */
    public Employee getEmployee() {
        return employee;
    }

    /**
     * @param employee the employee to set
     */
    public void setEmployee(Employee employee) {
        this.employee = employee;
    }

    /**
     * @return the citizen
     */
    public Citizen getCitizen() {
        return citizen;
    }

    /**
     * @param citizen the citizen to set
     */
    public void setCitizen(Citizen citizen) {
        this.citizen = citizen;
    }
    
    
}
