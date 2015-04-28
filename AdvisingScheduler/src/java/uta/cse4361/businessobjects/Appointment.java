// extend slot...

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uta.cse4361.businessobjects;

import java.text.SimpleDateFormat;

/**
 *
 * @author Michael
 */
public class Appointment {
    private int apptId;
    private int advisorId;
    private String advisor;
    private String advisorPhone;
    private String advisorEmail;
    private int advisorRank;
    private int studentId;
    private String student;
    private String utaStudentId;
    private String studentEmail;
    private String studentPhone;
    private String reason;
    private String description;
    private long time;

    public int getApptId() {
        return apptId;
    }

    public int getAdvisorId() {
        return advisorId;
    }

    public String getAdvisor() {
        return advisor;
    }

    public String getAdvisorPhone() {
        return advisorPhone;
    }

    public String getAdvisorEmail() {
        return advisorEmail;
    }

    public int getAdvisorRank() {
        return advisorRank;
    }

    public int getStudentId() {
        return studentId;
    }

    public String getStudent() {
        return student;
    }

    public String getUtaStudentId() {
        return utaStudentId;
    }

    public String getStudentEmail() {
        return studentEmail;
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

    public long getTime() {
        return time;
    }

    public Appointment(int apptId, int advisorId, String advisor, String advisorPhone, String advisorEmail, int advisorRank, int studentId, String student, String utaStudentId, String studentEmail, String studentPhone, String reason, String description, long time) {
        this.apptId = apptId;
        this.advisorId = advisorId;
        this.advisor = advisor;
        this.advisorPhone = advisorPhone;
        this.advisorEmail = advisorEmail;
        this.advisorRank = advisorRank;
        this.studentId = studentId;
        this.student = student;
        this.utaStudentId = utaStudentId;
        this.studentEmail = studentEmail;
        this.studentPhone = studentPhone;
        this.reason = reason;
        this.description = description;
        this.time = time;
    }

    public String getTimestamp(String fmt) {
        SimpleDateFormat df = new SimpleDateFormat(fmt);
        return df.format(time);
    }
}
