/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uta.cse4361.businessobjects;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.SortedSet;
import java.util.TreeSet;

/**
 *
 * @author Michael
 */
public class SlotMonth extends Month {

    private int[] slotDays;

    public SlotMonth(int year, int month, ArrayList<java.sql.Timestamp> timeslots) {
        super(year, month);
        Calendar cal = Calendar.getInstance();
        SortedSet<Integer> days = new TreeSet();
        for(int i = 0; i < timeslots.size(); i++) {
            cal.setTimeInMillis(timeslots.get(i).getTime());
            if(cal.get(Calendar.YEAR) == this.getYear() && cal.get(Calendar.MONTH) == this.getMonth()) {
                days.add(cal.get(Calendar.DAY_OF_MONTH));
            }
        }
        slotDays = new int[days.size()];
        int i = 0;
        for(int day : days) {
            slotDays[i++] = day;
        }
    }

    public int[] getSlotDays() {
        return slotDays;
    }
}
