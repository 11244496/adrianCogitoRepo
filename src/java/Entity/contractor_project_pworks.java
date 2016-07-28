/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Entity;

import java.util.ArrayList;

/**
 *
 * @author AdrianKyle
 */
public class contractor_project_pworks {
    
    private int id;
    private String status;
    private String datesubmitted;
    private Project p;
    private PWorks pworks;
    private ArrayList<contractorcomponent> components;
    private Contractor_User contractor;

    public contractor_project_pworks(String status, String datesubmitted, Project p, PWorks pworks, Contractor_User contractor) {
        this.status = status;
        this.datesubmitted = datesubmitted;
        this.p = p;
        this.pworks = pworks;
        this.contractor = contractor;
    }

    

    public contractor_project_pworks() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDatesubmitted() {
        return datesubmitted;
    }

    public void setDatesubmitted(String datesubmitted) {
        this.datesubmitted = datesubmitted;
    }

    public Project getP() {
        return p;
    }

    public void setP(Project p) {
        this.p = p;
    }

    public PWorks getPworks() {
        return pworks;
    }

    public void setPworks(PWorks pworks) {
        this.pworks = pworks;
    }

    public Contractor_User getContractor() {
        return contractor;
    }

    public void setContractor(Contractor_User contractor) {
        this.contractor = contractor;
    }

    public ArrayList<contractorcomponent> getComponents() {
        return components;
    }

    public void setComponents(ArrayList<contractorcomponent> components) {
        this.components = components;
    }
    
}
