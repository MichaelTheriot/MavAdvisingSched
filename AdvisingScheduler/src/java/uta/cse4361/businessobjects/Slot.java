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
    private int departmentId;
    private String departmentName;
    private int advisorId;
    private String advisorName;
    private String advisorEmail;
    private String advisorPhone;
    private int advisorRank;
    private long time;
    private boolean available;

    public int getId() {
        return id;
    }

    public int getDepartmentId() {
        return departmentId;
    }

    public String getDepartmentName() {
        return departmentName;
    }

    public int getAdvisorId() {
        return advisorId;
    }

    public String getAdvisorName() {
        return advisorName;
    }

    public String getAdvisorEmail() {
        return advisorEmail;
    }

    public String getAdvisorPhone() {
        return advisorPhone;
    }

    public int getAdvisorRank() {
        return advisorRank;
    }

    public long getTime() {
        return time;
    }

    public boolean getAvailable() {
        return available;
    }

    public Slot(int id, int departmentId, String departmentName, int advisorId, String advisorName, String advisorEmail, String advisorPhone, int advisorRank, long time, boolean available) {
        this.id = id;
        this.departmentId = departmentId;
        this.departmentName = departmentName;
        this.advisorId = advisorId;
        this.advisorName = advisorName;
        this.advisorEmail = advisorEmail;
        this.advisorPhone = advisorPhone;
        this.advisorRank = advisorRank;
        this.time = time;
        this.available = available;
    }

    public Slot(int id, int departmentId, String departmentName, int advisorId, String advisorName, String advisorEmail, String advisorPhone, int advisorRank, java.sql.Timestamp timestamp, boolean available) {
        this.id = id;
        this.departmentId = departmentId;
        this.departmentName = departmentName;
        this.advisorId = advisorId;
        this.advisorName = advisorName;
        this.advisorEmail = advisorEmail;
        this.advisorPhone = advisorPhone;
        this.advisorRank = advisorRank;
        this.time = timestamp.getTime();
        this.available = available;
    }

    public String getTimeStamp() {
        SimpleDateFormat df = new SimpleDateFormat("hh:mm a");
        return df.format(time);
    }
}
