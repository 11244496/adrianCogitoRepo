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
public class contractortask {
    private int id;
    private String name;
    private String description;
    private String status;
    private Project project;
    private Contractor_User contractor;
    private ArrayList<Schedule> schedules;
    private ArrayList<Agenda> agenda;

    public contractortask() {
    }

    public contractortask(String name, String description, String status, Project project, Contractor_User contractor, ArrayList<Schedule> schedules, ArrayList<Agenda> agenda) {
        this.name = name;
        this.description = description;
        this.status = status;
        this.project = project;
        this.contractor = contractor;
        this.schedules = schedules;
        this.agenda = agenda;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Project getProject() {
        return project;
    }

    public void setProject(Project project) {
        this.project = project;
    }

    public Contractor_User getContractor() {
        return contractor;
    }

    public void setContractor(Contractor_User contractor) {
        this.contractor = contractor;
    }

    public ArrayList<Schedule> getSchedules() {
        return schedules;
    }

    public void setSchedules(ArrayList<Schedule> schedules) {
        this.schedules = schedules;
    }

    public ArrayList<Agenda> getAgenda() {
        return agenda;
    }

    public void setAgenda(ArrayList<Agenda> agenda) {
        this.agenda = agenda;
    }
    
    
    
}
