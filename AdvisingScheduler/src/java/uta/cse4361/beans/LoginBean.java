/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uta.cse4361.beans;

import auth.AzureClient;
import auth.AzureUser;
import java.io.UnsupportedEncodingException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Pattern;
import uta.cse4361.businessobjects.User;
import uta.cse4361.databases.LoginQuery;

/**
 *
 * @author Michael
 */
public class LoginBean {
    private String email;
    private String password;
    private final AzureClient az = new AzureClient("859a762f-a5c7-4bca-9615-4f7fd2534857", "OClH5LuRoQMBk7LW921Fx4jNAGmbDJ/5Ru60Pt26JmY=", "http://bartsimpson.uta.edu:8084/AdvisingSchedulerTeam3/login", "http://bartsimpson.uta.edu:8084/AdvisingSchedulerTeam3/logout");

    public LoginBean() {
    }

    public String getAuthUri() {
        return az.getAuthUri();
    }

    public String getDeauthUri() {
        return az.getDeauthUri();
    }

    public User getUser(String code) {
        AzureUser azureUser = az.getUser(code);
        User user = null;
        if(azureUser != null) {
            boolean universityEmail = Pattern.matches(".*[^\\w]uta\\.edu", azureUser.getEmail());
            if(universityEmail) {
                user = new User(0, azureUser.getEmail(), azureUser.getFirstName(), azureUser.getLastName(), "000", 0);
            } else {
                System.out.println("NOT UNI EMAIL");
            }
        }
        return user;
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
