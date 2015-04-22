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
public class Slot {
    private int id;
    private int advisorId;
    private String advisorName;
    private String advisorPhone;
    private int departmentId;
    private String departmentName;
    private long time;

    public int getId() {
        return id;
    }

    public int getAdvisorId() {
        return advisorId;
    }

    public String getAdvisorName() {
        return advisorName;
    }

    public String getAdvisorPhone() {
        return advisorPhone;
    }

    public int getDepartmentId() {
        return departmentId;
    }

    public String getDepartmentName() {
        return departmentName;
    }

    public long getTime() {
        return time;
    }

    public Slot(int id, int advisorId, String advisorName, String advisorPhone, int departmentId, String departmentName, long time) {
        this.id = id;
        this.advisorId = advisorId;
        this.advisorName = advisorName;
        this.advisorPhone = advisorPhone;
        this.departmentId = departmentId;
        this.departmentName = departmentName;
        this.time = time;
    }

    public Slot(int id, int advisorId, String advisorName, String advisorPhone, int departmentId, String departmentName, java.sql.Timestamp timestamp) {
        this.id = id;
        this.advisorId = advisorId;
        this.advisorName = advisorName;
        this.advisorPhone = advisorPhone;
        this.departmentId = departmentId;
        this.departmentName = departmentName;
        this.time = timestamp.getTime();
    }

    public String getTimeStamp() {
        SimpleDateFormat df = new SimpleDateFormat("hh:mm a");
        return df.format(time);
    }
}
