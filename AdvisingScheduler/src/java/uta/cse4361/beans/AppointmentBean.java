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
import uta.cse4361.databases.DeleteAppointmentByAdvisorIdQuery;
import uta.cse4361.databases.DeleteAppointmentByDeptIdQuery;
import uta.cse4361.databases.DeleteAppointmentByStudentIdQuery;
import uta.cse4361.databases.DeleteAppointmentQuery;
import uta.cse4361.databases.DeleteAppointmentUnregisteredByAdvisorIdQuery;
import uta.cse4361.databases.DeleteAppointmentUnregisteredByDeptIdQuery;
import uta.cse4361.databases.DeleteAppointmentUnregisteredQuery;
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

    public Boolean cancelAppointmentAdvisor(int apptId, int advisorId) {
        DeleteAppointmentByAdvisorIdQuery query1 = new DeleteAppointmentByAdvisorIdQuery(apptId, advisorId);
        query1.execute();
        Boolean deleted1 = (Boolean) query1.getResult();
        DeleteAppointmentUnregisteredByAdvisorIdQuery query2 = new DeleteAppointmentUnregisteredByAdvisorIdQuery(apptId, advisorId);
        query2.execute();
        Boolean deleted2 = (Boolean) query2.getResult();
        return (deleted1 || deleted2);
    }

    public Boolean cancelAppointmentDepartment(int apptId, int deptId) {
        DeleteAppointmentByDeptIdQuery query1 = new DeleteAppointmentByDeptIdQuery(apptId, deptId);
        query1.execute();
        Boolean deleted1 = (Boolean) query1.getResult();
        DeleteAppointmentUnregisteredByDeptIdQuery query2 = new DeleteAppointmentUnregisteredByDeptIdQuery(apptId, deptId);
        query2.execute();
        Boolean deleted2 = (Boolean) query2.getResult();
        return (deleted1 || deleted2);
    }

    public Boolean cancelAppointmentStudent(int apptId, int studentId) {
        DeleteAppointmentByStudentIdQuery query1 = new DeleteAppointmentByStudentIdQuery(apptId, studentId);
        query1.execute();
        return (Boolean) query1.getResult();
    }

    public Boolean cancelAppointment(int apptId) {
        DeleteAppointmentQuery query1 = new DeleteAppointmentQuery(apptId);
        query1.execute();
        Boolean deleted1 = (Boolean) query1.getResult();
        DeleteAppointmentUnregisteredQuery query2 = new DeleteAppointmentUnregisteredQuery(apptId);
        query2.execute();
        Boolean deleted2 = (Boolean) query2.getResult();
        return (deleted1 || deleted2);
    }
}
