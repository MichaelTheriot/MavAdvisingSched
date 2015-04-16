/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uta.cse4361.businessobjects;

import java.time.YearMonth;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.SortedSet;
import java.util.TreeSet;

/**
 *
 * @author Michael
 */
public class Slots {
    private ArrayList<Integer> id;
    private ArrayList<Integer> dept_id;
    private ArrayList<String> dept_name;
    private ArrayList<String> advisor_name;
    private ArrayList<Integer> rank;
    private ArrayList<java.sql.Timestamp> time;
    private YearMonth[] yearMonths;

    public Slots(ArrayList id, ArrayList dept_id, ArrayList dept_name, ArrayList advisor_name, ArrayList rank, ArrayList time) {
        this.id = id;
        this.dept_id = dept_id;
        this.dept_name = dept_name;
        this.advisor_name = advisor_name;
        this.rank = rank;
        this.time = time;
        SortedSet<YearMonth> yearMonthsSet = new TreeSet<YearMonth>();
        Calendar cal = Calendar.getInstance();
        java.sql.Timestamp ts;
        int i;
        for(i = 0; i < time.size(); i++) {
            ts = (java.sql.Timestamp) time.get(i);
            cal.setTimeInMillis(ts.getTime());
            yearMonthsSet.add(YearMonth.of(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH) + 1));
        }
        yearMonths = yearMonthsSet.toArray(new YearMonth[yearMonthsSet.size()]);
    }

    public ArrayList<Integer> getId() {
        return id;
    }

    public ArrayList<Integer> getDept_id() {
        return dept_id;
    }

    public ArrayList<String> getAdvisor_name() {
        return advisor_name;
    }

    public ArrayList<Integer> getRank() {
        return rank;
    }

    public ArrayList<java.sql.Timestamp> getTime() {
        return time;
    }

    public YearMonth[] getYearMonths() {
        return yearMonths;
    }
}
