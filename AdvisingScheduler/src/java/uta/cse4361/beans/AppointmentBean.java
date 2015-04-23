/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uta.cse4361.beans;

import uta.cse4361.businessobjects.Appointment;
import uta.cse4361.businessobjects.Department;
import uta.cse4361.databases.AppointmentQuery;
import uta.cse4361.databases.DepartmentQuery;

/**
 *
 * @author Michael
 */
public class AppointmentBean {

    public AppointmentBean() {
    }

    public Appointment[] getAppointmentsByStudentId(int studentId) {
        AppointmentQuery query = new AppointmentQuery(studentId);
        query.execute();
        return (Appointment[]) query.getResult();
    }
}
