/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uta.cse4361.beans;

import uta.cse4361.businessobjects.Slots;
import uta.cse4361.databases.SlotsDeptQuery;

/**
 *
 * @author Michael
 */
public class SlotsBean {

    private int dept;
    private Slots slots;

    public SlotsBean() {
    }

    public void setDept(int dept) {
        this.dept = dept;
    }

    public int getDept() {
        return dept;
    }

    public Slots getSlots() {
        SlotsDeptQuery query = new SlotsDeptQuery(dept);
        query.execute();
        return (Slots) query.getResult();
    }
}
