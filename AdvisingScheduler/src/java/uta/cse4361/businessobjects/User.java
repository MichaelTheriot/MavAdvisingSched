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
public class User {
    private int id;
    private String email;
    private String fname;
    private String lname;
    private String phone;
    private String major;
    private int rank;

    public User(int id, String email, String fname, String lname, String phone, int rank) {
        this.id = id;
        this.email = email;
        this.fname = fname;
        this.lname = lname;
        this.phone = phone;
        this.rank = rank;
    }

    public int getId() {
        return id;
    }

    public String getEmail() {
        return email;
    }

    public String getFname() {
        return fname;
    }

    public String getLname() {
        return lname;
    }

    public String getPhone() {
        return phone;
    }

    public int getRank() {
        return rank;
    }
}
