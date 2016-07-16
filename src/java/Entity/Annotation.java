/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Entity;

/**
 *
 * @author RoAnn
 */
public class Annotation {
    private int id;
    private String testimonials;
    private String projects;
    private String details;
    private String program;
    private String general;
    private String status;
    private String date;
    private Project project;

    public Annotation() {
    }
    
    public String getGeneral() {
        return general;
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
     * @return the testimonials
     */
    public String getTestimonials() {
        return testimonials;
    }

    /**
     * @param testimonials the testimonials to set
     */
    public void setTestimonials(String testimonials) {
        this.testimonials = testimonials;
    }

    /**
     * @return the projects
     */
    public String getProjects() {
        return projects;
    }

    /**
     * @param projects the projects to set
     */
    public void setProjects(String projects) {
        this.projects = projects;
    }

    /**
     * @return the details
     */
    public String getDetails() {
        return details;
    }

    /**
     * @param details the details to set
     */
    public void setDetails(String details) {
        this.details = details;
    }

    /**
     * @return the program
     */
    public String getProgram() {
        return program;
    }

    /**
     * @param program the program to set
     */
    public void setProgram(String program) {
        this.program = program;
    }

    /**
     * @param general the general to set
     */
    public void setGeneral(String general) {
        this.general = general;
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
     * @return the date
     */
    public String getDate() {
        return date;
    }

    /**
     * @param date the date to set
     */
    public void setDate(String date) {
        this.date = date;
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

}