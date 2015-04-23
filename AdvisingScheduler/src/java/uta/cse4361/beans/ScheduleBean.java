/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uta.cse4361.beans;

import uta.cse4361.businessobjects.Department;
import uta.cse4361.databases.ScheduleAppointmentQuery;
import uta.cse4361.databases.ScheduleAppointmentUnregisteredQuery;

/**
 *
 * @author Michael
 */
public class ScheduleBean {

    public ScheduleBean() {
    }

    public boolean scheduleAppointment(int slotId, int studentId, String reason, String description) {
        ScheduleAppointmentQuery query = new ScheduleAppointmentQuery(slotId, studentId, reason, description);
        query.execute();
        if(query.getResult() == null) {
            return false;
        }
        return (boolean) query.getResult();
    }

    public boolean scheduleAppointment(int slotId, String email, String fname, String lname, String phone, String reason, String description) {
        ScheduleAppointmentUnregisteredQuery query = new ScheduleAppointmentUnregisteredQuery(slotId, email, fname, lname, phone, reason, description);
        query.execute();
        if(query.getResult() == null) {
            return false;
        }
        return (boolean) query.getResult();
    }
}
