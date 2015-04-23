/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uta.cse4361.beans;

import uta.cse4361.businessobjects.Slot;
import uta.cse4361.databases.SlotQuery;
import uta.cse4361.databases.SlotQueryByDept;
import uta.cse4361.databases.SlotQueryById;

/**
 *
 * @author Michael
 */
public class SlotsBean {

    public SlotsBean() {
    }

    public Slot[] getSlots() {
        SlotQuery query = new SlotQuery();
        query.execute();
        return (Slot[]) query.getResult();
    }

    public Slot[] getSlotsByDept(int dept) {
        SlotQuery query = new SlotQueryByDept(dept);
        query.execute();
        return (Slot[]) query.getResult();
    }

    public Slot getSlotById(int id) {
        SlotQuery query = new SlotQueryById(id);
        query.execute();
        return (Slot) query.getResult();
    }
}
