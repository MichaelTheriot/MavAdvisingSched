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
public class Student {
    private int studentId;
    private String utaStudentId;
    private String major;

    public Student(int studentId, String utaStudentId, String major) {
        this.studentId = studentId;
        this.utaStudentId = utaStudentId;
        this.major = major;
    }

    public int getStudentId() {
        return studentId;
    }

    public String getUtaStudentId() {
        return utaStudentId;
    }

    public String getMajor() {
        return major;
    }
}
