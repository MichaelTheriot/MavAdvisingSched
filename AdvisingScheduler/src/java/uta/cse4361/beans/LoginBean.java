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
import uta.cse4361.businessobjects.User;
import uta.cse4361.databases.UserAddQuery;
import uta.cse4361.databases.UserQuery;
import uta.cse4361.databases.UserUpdateQuery;

/**
 *
 * @author Michael
 */
public class LoginBean {
    private String email;
    private static final AzureClient az = new AzureClient("", "", "http://bartsimpson.uta.edu:8080/AdvisingSchedulerTeam3/login", "http://bartsimpson.uta.edu:8080/AdvisingSchedulerTeam3/logout");

    public LoginBean() {
    }

    public String getAuthUri() {
        return az.getAuthUri();
    }

    public String getDeauthUri() {
        return az.getDeauthUri();
    }

    public User certifyUser(String code) {
        AzureUser azureUser = az.getUser(code);
        User user = null;
        if(azureUser != null) {
            UserQuery query = new UserQuery(azureUser.getEmail());
            query.execute();
            user = (User) query.getResult();
            if(user != null) {
                if(!user.getFname().equals(azureUser.getFirstName())
                || !user.getLname().equals(azureUser.getLastName())) {
                    UserUpdateQuery query2 = new UserUpdateQuery(user.getId(), user.getEmail(), azureUser.getFirstName(), azureUser.getLastName(), user.getPhone());
                    query2.execute();
                    if((boolean) query2.getResult()) {
                        user = new User(user.getId(), user.getEmail(), azureUser.getFirstName(), azureUser.getLastName(), user.getPhone(), user.getRank());
                    }
                }
            } else {
                UserAddQuery query3 = new UserAddQuery(azureUser.getEmail(), azureUser.getFirstName(), azureUser.getLastName());
                query3.execute();
                if((boolean) query3.getResult()) {
                    UserQuery query4 = new UserQuery(azureUser.getEmail());
                    query4.execute();
                    user = (User) query4.getResult();
                }
            }
        }
        return user;
    }

    public User getUser() {
        UserQuery query = new UserQuery(email);
        query.execute();
        return (User) query.getResult();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
