/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uta.cse4361.beans;

import uta.cse4361.businessobjects.Student;
import uta.cse4361.databases.StudentQuery;

/**
 *
 * @author Michael
 */
public class StudentBean {
    private int userId;

    public StudentBean() {
    }

    public Student getStudent() {
        StudentQuery query = new StudentQuery(userId);
        query.execute();
        return (Student) query.getResult();
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
}
