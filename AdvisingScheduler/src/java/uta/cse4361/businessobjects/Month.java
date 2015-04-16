/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uta.cse4361.businessobjects;

import java.util.Calendar;

/**
 *
 * @author Michael
 */
public class Month {

    private int firstDay;
    private int days;
    private int year;
    private int month;
    private String name;
    private Calendar cal = Calendar.getInstance();

    public Month(int year, int month) {
        this.year = year;
        this.month = month;
        cal.set(Calendar.YEAR, year);
        cal.set(Calendar.MONTH, month);
        cal.set(Calendar.DAY_OF_MONTH, 1);
        days = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
        firstDay = cal.get(Calendar.DAY_OF_WEEK);
        String months[] = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
        this.name = months[this.month];
    }

    public int getFirstDay() {
        return firstDay;
    }

    public int getDays() {
        return days;
    }

    public int getYear() {
        return year;
    }

    public int getMonth() {
        return month;
    }

    public String getName() {
        return name;
    }
}
