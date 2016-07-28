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
public class contractorcomponent {
    private int id;
    private String name;
    private float unitPrice;
    private int quantity;
    private Unit unit;
    private contractor_project_pworks cpp;

    public contractorcomponent(String name, float unitPrice, int quantity, Unit unit, contractor_project_pworks cpp) {
        this.name = name;
        this.unitPrice = unitPrice;
        this.quantity = quantity;
        this.unit = unit;
        this.cpp = cpp;
    }

    public contractorcomponent() {
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

    public float getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(float unitPrice) {
        this.unitPrice = unitPrice;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Unit getUnit() {
        return unit;
    }

    public void setUnit(Unit unit) {
        this.unit = unit;
    }

    public contractor_project_pworks getCpp() {
        return cpp;
    }

    public void setCpp(contractor_project_pworks cpp) {
        this.cpp = cpp;
    }
    
    
}
