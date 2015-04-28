package uta.cse4361.databases;

import java.sql.SQLException;
import java.util.ArrayList;
import uta.cse4361.businessobjects.Appointment;

/**
 *
 * @author Michael Theriot
 */
public class AppointmentByAdvisorIdQuery extends AppointmentQuery {

    private int advisorId;

    public AppointmentByAdvisorIdQuery(int advisorId) {
        this.sqlQuery = "SELECT DISTINCT * FROM any_appointment WHERE advisor_id = ? AND time > now() ORDER BY time";
        this.advisorId = advisorId;
    }

    @Override
    public void prepareStatement() throws SQLException {
        statement = conn.prepareStatement(sqlQuery);
        statement.setInt(1, advisorId);
    }
}
