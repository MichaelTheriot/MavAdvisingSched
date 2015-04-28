/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uta.cse4361.beans;

import uta.cse4361.businessobjects.Appointment;
import uta.cse4361.businessobjects.Department;
import uta.cse4361.databases.AppointmentByAdvisorIdQuery;
import uta.cse4361.databases.AppointmentByDeptIdQuery;
import uta.cse4361.databases.AppointmentByStudentIdQuery;
import uta.cse4361.databases.AppointmentQuery;
import uta.cse4361.databases.DepartmentQuery;

/**
 *
 * @author Michael
 */
public class AppointmentBean {

    public AppointmentBean() {
    }

    public Appointment[] getAppointments() {
        AppointmentQuery query = new AppointmentQuery();
        query.execute();
        return (Appointment[]) query.getResult();
    }

    public Appointment[] getAppointmentsByStudentId(int studentId) {
        AppointmentByStudentIdQuery query = new AppointmentByStudentIdQuery(studentId);
        query.execute();
        return (Appointment[]) query.getResult();
    }

    public Appointment[] getAppointmentsByAdvisorId(int advisorId) {
        AppointmentByAdvisorIdQuery query = new AppointmentByAdvisorIdQuery(advisorId);
        query.execute();
        return (Appointment[]) query.getResult();
    }

    public Appointment[] getAppointmentsByDeptId(int deptId) {
        AppointmentByDeptIdQuery query = new AppointmentByDeptIdQuery(deptId);
        query.execute();
        return (Appointment[]) query.getResult();
    }
}
