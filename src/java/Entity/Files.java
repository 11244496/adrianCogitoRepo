/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Entity;

/**
 *
 * @author Lenovo
 */
public class Files {
    
    private int id;
    private String fileName;
    private String dateUploaded;
    private String type;
    private String status;
    private String uploader;
    private String description;
    private Project project;
    private Testimonial testimonial;

    public Files() {
    }

    public Files(int id, String fileName, String dateUploaded, String type, String status, String uploader, String description, Project project, Testimonial testimonial) {
        this.id = id;
        this.fileName = fileName;
        this.dateUploaded = dateUploaded;
        this.type = type;
        this.status = status;
        this.uploader = uploader;
        this.description = description;
        this.project = project;
        this.testimonial = testimonial;
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
     * @return the fileName
     */
    public String getFileName() {
        return fileName;
    }

    /**
     * @param fileName the fileName to set
     */
    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    /**
     * @return the dateUploaded
     */
    public String getDateUploaded() {
        return dateUploaded;
    }

    /**
     * @param dateUploaded the dateUploaded to set
     */
    public void setDateUploaded(String dateUploaded) {
        this.dateUploaded = dateUploaded;
    }

    /**
     * @return the type
     */
    public String getType() {
        return type;
    }

    /**
     * @param type the type to set
     */
    public void setType(String type) {
        this.type = type;
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
     * @return the uploader
     */
    public String getUploader() {
        return uploader;
    }

    /**
     * @param uploader the uploader to set
     */
    public void setUploader(String uploader) {
        this.uploader = uploader;
    }

    /**
     * @return the description
     */
    public String getDescription() {
        return description;
    }

    /**
     * @param description the description to set
     */
    public void setDescription(String description) {
        this.description = description;
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
     * @return the testimonial
     */
    public Testimonial getTestimonial() {
        return testimonial;
    }

    /**
     * @param testimonial the testimonial to set
     */
    public void setTestimonial(Testimonial testimonial) {
        this.testimonial = testimonial;
    }

    
    
}
