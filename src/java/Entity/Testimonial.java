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
public class Testimonial {
    
    private int id;
    private String title;
    private String dateUploaded;
    private String message;
    private String folderName;
    private String category;
    private String status;
    private Citizen citizen;
    private ArrayList<TLocation> tlocation;
    private ArrayList<Project> project;
    private ArrayList<Reply> replies;
    private ArrayList<Files> files;
    private ArrayList<TComments> tcomments;
    private ArrayList<Supporter> supporters;

    
    public Testimonial() {
    }

    public Testimonial(int id, String title, String dateUploaded, String message, String folderName, String category, String status, Citizen citizen) {
        this.id = id;
        this.title = title;
        this.dateUploaded = dateUploaded;
        this.message = message;
        this.folderName = folderName;
        this.category = category;
        this.status = status;
        this.citizen = citizen;
    }

    public Testimonial(String title, String dateUploaded, String message, String folderName, String category, String status, Citizen citizen, ArrayList<TLocation> tlocation, ArrayList<Project> project, ArrayList<Reply> replies, ArrayList<Files> files, ArrayList<TComments> tcomments) {
        this.title = title;
        this.dateUploaded = dateUploaded;
        this.message = message;
        this.folderName = folderName;
        this.category = category;
        this.status = status;
        this.citizen = citizen;
        this.tlocation = tlocation;
        this.project = project;
        this.replies = replies;
        this.files = files;
        this.tcomments = tcomments;
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
     * @return the title
     */
    public String getTitle() {
        return title;
    }

    /**
     * @param title the title to set
     */
    public void setTitle(String title) {
        this.title = title;
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
     * @return the message
     */
    public String getMessage() {
        return message;
    }

    /**
     * @param message the message to set
     */
    public void setMessage(String message) {
        this.message = message;
    }

    /**
     * @return the folderName
     */
    public String getFolderName() {
        return folderName;
    }

    /**
     * @param folderName the folderName to set
     */
    public void setFolderName(String folderName) {
        this.folderName = folderName;
    }

    /**
     * @return the category
     */
    public String getCategory() {
        return category;
    }

    /**
     * @param category the category to set
     */
    public void setCategory(String category) {
        this.category = category;
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

    /**
     * @return the tlocation
     */
    public ArrayList<TLocation> getTlocation() {
        return tlocation;
    }

    /**
     * @param tlocation the tlocation to set
     */
    public void setTlocation(ArrayList<TLocation> tlocation) {
        this.tlocation = tlocation;
    }

    /**
     * @return the project
     */
    public ArrayList<Project> getProject() {
        return project;
    }

    /**
     * @param project the project to set
     */
    public void setProject(ArrayList<Project> project) {
        this.project = project;
    }

    /**
     * @return the replies
     */
    public ArrayList<Reply> getReplies() {
        return replies;
    }

    /**
     * @param replies the replies to set
     */
    public void setReplies(ArrayList<Reply> replies) {
        this.replies = replies;
    }

    /**
     * @return the files
     */
    public ArrayList<Files> getFiles() {
        return files;
    }

    /**
     * @param files the files to set
     */
    public void setFiles(ArrayList<Files> files) {
        this.files = files;
    }

    /**
     * @return the tcomments
     */
    public ArrayList<TComments> getTcomments() {
        return tcomments;
    }

    /**
     * @param tcomments the tcomments to set
     */
    public void setTcomments(ArrayList<TComments> tcomments) {
        this.tcomments = tcomments;
    }

    public ArrayList<Supporter> getSupporters() {
        return supporters;
    }

    public void setSupporters(ArrayList<Supporter> supporters) {
        this.supporters = supporters;
    }

    
   
    
}
