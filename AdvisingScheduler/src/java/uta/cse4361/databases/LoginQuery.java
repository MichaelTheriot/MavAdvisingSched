package uta.cse4361.databases;

import java.sql.SQLException;
import java.util.concurrent.Callable;
import java.util.logging.Level;
import java.util.logging.Logger;
import uta.cse4361.businessobjects.Account;

/**
 *
 * @author Michael Theriot
 */
public class LoginQuery extends RDBImplCommand {

    private String email;
    private String password;
    private String sqlQuery = "SELECT DISTINCT COUNT(*) AS NUM, id, fname, lname, email, phone, rank FROM user WHERE email = ? AND password = ?";
    
    public LoginQuery(String email, String password) {
        this.email = email;
        this.password = password;
    }
    
    @Override
    public void queryDB() throws SQLException {
        try {
            statement = conn.prepareStatement(sqlQuery);
            statement.setString(1, email);
            statement.setString(2, password);
            resultSet = statement.executeQuery();
            success = 1;
            processResult();
        } catch(SQLException e) {
            success = 0;
            conn.close();
        } finally {
            statement.close();
        }
    }

    public void processResult() {
        if(success == 1) {
            try {
                while(resultSet.next()) {
                    result = new Account(resultSet.getInt("id"), resultSet.getString("email"), resultSet.getString("fname"), resultSet.getString("lname"), resultSet.getString("phone"), resultSet.getInt("rank"));
                }
            } catch (SQLException e) {
                System.out.println(e);
            }
        }
    }
}
