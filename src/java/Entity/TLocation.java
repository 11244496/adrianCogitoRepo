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
public class TLocation {
    
    private int id;
    private String longitude;
    private String latitude;
    private Testimonial testimonial;

    public TLocation() {
    }

    public TLocation(int id, String longitude, String latitude, Testimonial testimonial) {
        this.id = id;
        this.longitude = longitude;
        this.latitude = latitude;
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
     * @return the longitude
     */
    public String getLongitude() {
        return longitude;
    }

    /**
     * @param longitude the longitude to set
     */
    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    /**
     * @return the latitude
     */
    public String getLatitude() {
        return latitude;
    }

    /**
     * @param latitude the latitude to set
     */
    public void setLatitude(String latitude) {
        this.latitude = latitude;
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
