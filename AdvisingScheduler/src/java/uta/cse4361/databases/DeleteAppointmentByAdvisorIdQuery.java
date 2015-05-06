package uta.cse4361.databases;

import java.sql.SQLException;
import uta.cse4361.businessobjects.Advisor;

/**
 *
 * @author Michael Theriot
 */
public class DeleteAppointmentByAdvisorIdQuery extends DeleteAppointmentQuery {

    private int advisorId;

    public DeleteAppointmentByAdvisorIdQuery(int apptId, int advisorId) {
        super(apptId);
        this.sqlQuery = "DELETE FROM appointment WHERE slotid = ? AND slotid IN (SELECT DISTINCT id FROM slot WHERE advisorid = ?)";
        this.advisorId = advisorId;
    }

    @Override
    public void prepareStatement() throws SQLException {
        statement = conn.prepareStatement(sqlQuery);
        statement.setInt(1, apptId);
        statement.setInt(2, advisorId);
    }
}
