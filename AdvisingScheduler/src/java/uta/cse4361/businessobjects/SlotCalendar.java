/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uta.cse4361.businessobjects;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;

/**
 *
 * @author Michael
 */
public class SlotCalendar {
    public SlotCalendar() {}

    public SlotMonth getRelativeMonthBySlot(Slot[] slots, int month) {
        Calendar cal = Calendar.getInstance();
        if(slots.length > 0) {
            cal.setTimeInMillis(slots[0].getTime());
        }
        cal.set(Calendar.MONTH, cal.get(Calendar.MONTH) + month);
        return getMonth(slots, cal.get(Calendar.YEAR), cal.get(Calendar.MONTH));
    }

    public SlotMonth getRelativeMonth(Slot[] slots, int month) {
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.MONTH, cal.get(Calendar.MONTH) + month);
        return getMonth(slots, cal.get(Calendar.YEAR), cal.get(Calendar.MONTH));
    }

    public SlotMonth getMonth(Slot[] slots, int year, int month) {
        ArrayList<Slot> aSlots = new ArrayList();
        Calendar cal = new GregorianCalendar(year, month, 1);        
        int days = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
        Slot[][] dateSlots = new Slot[days][];
        ArrayList<Slot>[] dateArrayLists = new ArrayList[days];
        for(int d = 0; d < days; d++) {
            dateArrayLists[d] = new ArrayList();
        }
        for(int i = 0; i < slots.length; i++) {
            cal.setTimeInMillis(slots[i].getTime());
            int cDate = cal.get(Calendar.DATE);
            if(cal.get(Calendar.MONTH) == month && cal.get(Calendar.YEAR) == year) {
                dateArrayLists[cDate - 1].add(slots[i]);
                aSlots.add(slots[i]);
            }
        }
        for(int d = 0; d < days; d++) {
            dateSlots[d] = dateArrayLists[d].toArray(new Slot[dateArrayLists[d].size()]);
        }
        return new SlotMonth(year, month, aSlots.toArray(new Slot[aSlots.size()]), dateSlots);
    }

    /*public SlotMonth getPage(Slot[] slots, int page) {
        if(slots.length == 0) {
            return null;
        }
        Calendar cal = Calendar.getInstance();
        int cPage = 0;
        int slotIndex = 0;
        cal.setTimeInMillis(slots[0].getTime());
        int cMonth = cal.get(Calendar.MONTH);
        int cYear = cal.get(Calendar.YEAR);
        for(int i = 0; i < slots.length && cPage < page; i++) {
            cal.setTimeInMillis(slots[i].getTime());
            int iMonth = cal.get(Calendar.MONTH);
            int iYear = cal.get(Calendar.YEAR);
            if(iMonth != cMonth || iYear != cYear) {
                cMonth = iMonth;
                cYear = iYear;
                slotIndex = i;
                cPage++;
            }
        }
        ArrayList<Slot> aSlots = new ArrayList();
        for(int i = slotIndex; i < slots.length; i++) {
            cal.setTimeInMillis(slots[i].getTime());
            int iMonth = cal.get(Calendar.MONTH);
            int iYear = cal.get(Calendar.YEAR);
            if(iMonth != cMonth || iYear != cYear) {
                break;
            }
            aSlots.add(slots[i]);
        }
        Slot[] cSlots = aSlots.toArray(new Slot[aSlots.size()]);
        cal.setTimeInMillis(cSlots[0].getTime());
        return new SlotMonth(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH), cSlots);
    }*/
}
