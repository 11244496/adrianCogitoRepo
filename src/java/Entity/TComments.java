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
public class TComments {
    
    private int id;
    private String comment;
    private String dateSent;
    private Citizen citizen;
    private Testimonial testimonial;

    public TComments() {
    }

    
    
    public TComments(int id, String comment, String dateSent, Citizen citizen, Testimonial testimonial) {
        this.id = id;
        this.comment = comment;
        this.dateSent = dateSent;
        this.citizen = citizen;
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
     * @return the comment
     */
    public String getComment() {
        return comment;
    }

    /**
     * @param comment the comment to set
     */
    public void setComment(String comment) {
        this.comment = comment;
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
