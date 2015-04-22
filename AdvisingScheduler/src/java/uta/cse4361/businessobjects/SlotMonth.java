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
public class SlotMonth {
    private int year;
    private int month;
    private long time;
    private int days;
    private Slot[] slots;
    private Slot[][] dateSlots;

    public int getYear() {
        return year;
    }

    public int getMonth() {
        return month;
    }

    public long getTime() {
        return time;
    }

    public int getDays() {
        return days;
    }

    public Slot[] getSlots() {
        return slots;
    }

    public SlotMonth(int year, int month, Slot[] slots, Slot[][] dateSlots) {
        this.year = year;
        this.month = month;
        this.slots = slots;
        Calendar cal = new GregorianCalendar(year, month, 1);
        this.time = cal.getTimeInMillis();
        this.days = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
        this.dateSlots = dateSlots;
    }

    public int getCalendarDate(int i) {
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.YEAR, year);
        cal.set(Calendar.MONTH, month);
        cal.set(Calendar.DATE, 1);
        cal.set(Calendar.DATE, 1 - cal.get(Calendar.DAY_OF_WEEK) + 1 + i);
        return cal.get(Calendar.DATE);
    }

    public boolean getCalendarDateInMonth(int i) {
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.YEAR, year);
        cal.set(Calendar.MONTH, month);
        cal.set(Calendar.DATE, 1);
        int cMonth = cal.get(Calendar.MONTH);
        cal.set(Calendar.DATE, 1 - cal.get(Calendar.DAY_OF_WEEK) + 1 + i);
        return cal.get(Calendar.MONTH) == cMonth;
    }

    public Slot[] getSlotsOnDate(int date) {
        if(date - 1 > days || date - 1 < 0) {
            return new Slot[0];
        }
        return this.dateSlots[date - 1];
    }
}
