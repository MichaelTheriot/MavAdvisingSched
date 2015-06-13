package uta.cse4361.databases;

import java.sql.SQLException;
import java.util.ArrayList;
import uta.cse4361.businessobjects.Slot;

/**
 *
 * @author Michael Theriot
 */
public class UserAddQuery extends RDBImplCommand {

    private String email;
    private String fname;
    private String lname;
    //private String phone;

    public UserAddQuery(String email, String fname, String lname) {
        this.sqlQuery = "INSERT INTO user(email, fname, lname) VALUES(?, ?, ?)";
        this.email = email.substring(0, Math.min(85, email.length()));
        this.fname = fname.substring(0, Math.min(35, fname.length()));
        this.lname = lname.substring(0, Math.min(35, lname.length()));
    }

    @Override
    public void queryDB() throws SQLException {
        result = statement.executeUpdate() > 0;
    }

    @Override
    public void prepareStatement() throws SQLException {
        statement = conn.prepareStatement(sqlQuery);
        statement.setString(1, email);
        statement.setString(2, fname);
        statement.setString(3, lname);
    }
}
