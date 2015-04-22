package uta.cse4361.databases;

import java.sql.SQLException;
import uta.cse4361.businessobjects.Student;

/**
 *
 * @author Michael Theriot
 */
public class StudentQuery extends RDBImplCommand {

    private int userId;

    public StudentQuery(int userId) {
        this.sqlQuery = "SELECT DISTINCT studentid, utastudentid, major FROM student_user WHERE userid = ?";
        this.userId = userId;
    }
    
    @Override
    public void queryDB() throws SQLException {
        resultSet = statement.executeQuery();
        processResult();
    }

    @Override
    public void prepareStatement() throws SQLException {
        statement = conn.prepareStatement(sqlQuery);
        statement.setInt(1, userId);
    }

    public void processResult() throws SQLException {
        if(resultSet.next()) {
            result = new Student(resultSet.getInt("studentid"), resultSet.getString("utastudentid"), resultSet.getString("major"));
        }
    }
}
