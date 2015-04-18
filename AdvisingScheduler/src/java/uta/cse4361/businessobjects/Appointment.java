/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uta.cse4361.businessobjects;

/**
 *
 * @author Michael
 */
public class Appointment extends Slot {
    private int studentId;
    private String studentName;
    private String utaStudentId;
    private String studentPhone;
    private String reason;
    private String description;

    public Appointment(int id, int advisorId, String advisorName, String advisorPhone, int departmentId, String departmentName, java.sql.Timestamp timestamp, int studentId, String studentName, String utaStudentId, String studentPhone, String reason, String description) {
        super(id, advisorId, advisorName, advisorPhone, departmentId, departmentName, timestamp.getTime());
        this.studentId = studentId;
        this.studentName = studentName;
        this.utaStudentId = utaStudentId;
        this.studentPhone = studentPhone;
        this.reason = reason;
        this.description = description;
    }

    public Appointment(int id, int advisorId, String advisorName, String advisorPhone, int departmentId, String departmentName, long time, int studentId, String studentName, String utaStudentId, String studentPhone, String reason, String description) {
        super(id, advisorId, advisorName, advisorPhone, departmentId, departmentName, time);
        this.studentId = studentId;
        this.studentName = studentName;
        this.utaStudentId = utaStudentId;
        this.studentPhone = studentPhone;
        this.reason = reason;
        this.description = description;
    }

    public int getStudentId() {
        return studentId;
    }

    public String getStudentName() {
        return studentName;
    }

    public String getUtaStudentId() {
        return utaStudentId;
    }

    public String getStudentPhone() {
        return studentPhone;
    }

    public String getReason() {
        return reason;
    }

    public String getDescription() {
        return description;
    }
}
