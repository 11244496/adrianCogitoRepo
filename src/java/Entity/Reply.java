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
public class Reply {
    
    private int id;
    private String message;
    private User sender;
    private String dateSent;
    
    private Testimonial testimonial;

    public Reply() {
    }

    public Reply(int id, String message, User sender, Testimonial testimonial_, String dateSent) {
        this.id = id;
        this.message = message;
        this.sender = sender;
        this.testimonial = testimonial;
        this.dateSent = dateSent;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public User getSender() {
        return sender;
    }

    public void setSender(User sender) {
        this.sender = sender;
    }

    public Testimonial getTestimonial() {
        return testimonial;
    }

    public void setTestimonial(Testimonial testimonial) {
        this.testimonial = testimonial;
    }

    public String getDateSent() {
        return dateSent;
    }

    public void setDateSent(String dateSent) {
        this.dateSent = dateSent;
    }

    
    
    
}
