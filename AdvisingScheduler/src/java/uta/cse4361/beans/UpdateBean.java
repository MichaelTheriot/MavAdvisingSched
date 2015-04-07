/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uta.cse4361.beans;

import uta.cse4361.businessobjects.AdvisorAccount;
import uta.cse4361.databases.DatabaseManager;
import uta.cse4361.interfaces.Constants;

/**
 *
 * @author Michael Theriot
 */
public class UpdateBean implements Constants{
    private String email= null;
    private String oldPassword= null;
    private String newPassword= null;

    public UpdateBean() {
    }

    public String Update(){
        String Msg = SUCCESS_MESSAGE;
        DatabaseManager DM = new DatabaseManager();
        Msg = DM.update(this.email, this.oldPassword, this.newPassword);           
        return Msg;
    }
    public String getEmail() {
        return email;
    }

    public String getNewPassword() {
        return newPassword;
    }

    public String getOldPassword() {
        return oldPassword;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setOldPassword(String password) {
        this.oldPassword = AdvisorAccount.hashPassword(password);
    }
    
    public void setNewPassword(String password) {
        this.newPassword = AdvisorAccount.hashPassword(password);
    }
    
    
}
