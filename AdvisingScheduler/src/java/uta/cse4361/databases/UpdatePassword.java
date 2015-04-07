/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uta.cse4361.databases;

import java.sql.SQLException;

/**
 *
 * @author Michael Theriot
 */
public class UpdatePassword extends RDBImplCommand {
    
    private String email;
    private String oldPassword;
    private String newPassword;
    private String sqlQuery = "UPDATE user SET UserPassword = ? WHERE UserEmail = ? AND UserPassword = ?"; // Disable safe mode in MySQL because not using a key
    
    public UpdatePassword(String email, String oldPassword, String newPassword){
        this.email = email;
        this.oldPassword = oldPassword;
        this.newPassword = newPassword;
    }
    
    public void queryDB() throws SQLException{
        int rows = 0;
        try{
            statement = conn.prepareStatement(sqlQuery);
            statement.setString(1, newPassword);
            statement.setString(2, email);
            statement.setString(3, oldPassword);
            rows = statement.executeUpdate();
        } catch(SQLException e){
            System.out.println("UpdatePassword Failed");
            conn.close();
            result = "Invalid password";
        } finally {
            statement.close();
            if(rows > 0) {
                result = "Password updated";
            } else {
                result = "Invalid password";
            }
        }
    }

    // Required by interface
    public void processResult(){
    }
}
