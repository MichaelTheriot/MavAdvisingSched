/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uta.cse4361.beans;

import java.util.Calendar;
import java.util.GregorianCalendar;
import uta.cse4361.databases.ScheduleAppointmentQuery;
import uta.cse4361.databases.ScheduleAppointmentUnregisteredQuery;
import uta.cse4361.databases.SlotCreateQuery;

/**
 *
 * @author Michael
 */
public class SlotCreateBean {

    public SlotCreateBean() {
    }

    public boolean createSlot(int advisorId, long startTime) {
        SlotCreateQuery query = new SlotCreateQuery(advisorId, startTime);
        query.execute();
        return (boolean) query.getResult();
    }

    public boolean createSlot(int advisorId, int startYear, int startMonth, int startDate, int startHour, int startMinute) {
        GregorianCalendar cal = new GregorianCalendar(startYear, startMonth, startDate, startHour, startMinute);
        return createSlot(advisorId, cal.getTimeInMillis());
    }
}
