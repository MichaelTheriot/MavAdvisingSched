package uta.cse4361.databases;

import java.sql.SQLException;
import uta.cse4361.businessobjects.User;

/**
 *
 * @author Michael Theriot
 */
public class UserQuery extends RDBImplCommand {

    private String email;
    
    public UserQuery(String email) {
        this.sqlQuery = "SELECT DISTINCT COUNT(*) AS NUM, id, fname, lname, email, phone, rank FROM ranked_user WHERE email = ?";
        this.email = email;
    }
    
    @Override
    public void queryDB() throws SQLException {
        resultSet = statement.executeQuery();
        processResult();
    }

    @Override
    public void prepareStatement() throws SQLException {
        statement = conn.prepareStatement(sqlQuery);
        statement.setString(1, email);
    }

    public void processResult() throws SQLException {
        if(resultSet.next()) {
            if(resultSet.getInt("NUM") > 0) {
                result = new User(resultSet.getInt("id"), resultSet.getString("email"), resultSet.getString("fname"), resultSet.getString("lname"), resultSet.getString("phone"), resultSet.getInt("rank"));
            }
        }
    }
}
