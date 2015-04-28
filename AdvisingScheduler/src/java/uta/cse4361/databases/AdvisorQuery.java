package uta.cse4361.databases;

import java.sql.SQLException;
import uta.cse4361.businessobjects.Advisor;

/**
 *
 * @author Michael Theriot
 */
public class AdvisorQuery extends RDBImplCommand {

    private int userId;

    public AdvisorQuery(int userId) {
        this.sqlQuery = "SELECT DISTINCT id, departmentid FROM advisor WHERE userid = ?";
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
            result = new Advisor(resultSet.getInt("id"), resultSet.getInt("departmentid"));
        }
    }
}
