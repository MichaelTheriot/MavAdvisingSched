package uta.cse4361.databases;

import java.sql.SQLException;

/**
 *
 * @author Michael Theriot
 */
public class DeleteAppointmentQuery extends RDBImplCommand {

    protected int apptId;

    public DeleteAppointmentQuery(int apptId) {
        this.sqlQuery = "DELETE FROM appointment WHERE slotid = ?";
        this.apptId = apptId;
    }
    
    @Override
    public void queryDB() throws SQLException {
        int rows = statement.executeUpdate();
        result = rows > 0;
    }

    @Override
    public void prepareStatement() throws SQLException {
        statement = conn.prepareStatement(sqlQuery);
        statement.setInt(1, apptId);
    }
}
