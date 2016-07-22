/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Entity;

/**
 *
 * @author Krist
 */
public class Project_has_Pwork {
    
    
    private int ID;
    private Project project;
    private PWorks pwork;
    
   
    
    
    private Inspection_Report inspection;

    public Project_has_Pwork(int ID, Project project, PWorks pwork) {
        this.ID = ID;
        this.project = project;
        this.pwork = pwork;
    }
    
        public Project_has_Pwork() {
        
    }

    public int getID() {
        return ID;
    }

    public Project getProject() {
        return project;
    }

    public PWorks getPwork() {
        return pwork;
    }



    public void setID(int ID) {
        this.ID = ID;
    }

    public void setProject(Project project) {
        this.project = project;
    }

    public void setPwork(PWorks pwork) {
        this.pwork = pwork;
    }

    public Inspection_Report getInspection() {
        return inspection;
    }

    public void setInspection(Inspection_Report inspection) {
        this.inspection = inspection;
    }

  
    
    
    
}
