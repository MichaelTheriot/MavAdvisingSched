/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uta.cse4361.beans;

import uta.cse4361.businessobjects.User;
import uta.cse4361.databases.LoginQuery;

/**
 *
 * @author Michael
 */
public class LoginBean {
    private String email;
    private String password;

    public LoginBean() {
    }

    public User getUser() {
        LoginQuery query = new LoginQuery(email, password);
        query.execute();
        return (User) query.getResult();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
