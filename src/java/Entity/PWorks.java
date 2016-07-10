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
public class PWorks {
    
    private int id;
    private String name;
    private ArrayList<Component> components;
    private ArrayList<Project> project;
    
    public PWorks() {
    }

    public PWorks(int id, String name, ArrayList<Component> components, ArrayList<Project> project) {
        this.id = id;
        this.name = name;
        this.components = components;
        this.project = project;
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
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
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
     * @return the components
     */
    public ArrayList<Component> getComponents() {
        return components;
    }

    /**
     * @param components the components to set
     */
    public void setComponents(ArrayList<Component> components) {
        this.components = components;
    }
    
    
}
