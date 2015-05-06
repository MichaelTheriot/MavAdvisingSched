package uta.cse4361.databases;

import java.sql.SQLException;
import java.util.ArrayList;
import uta.cse4361.businessobjects.Appointment;

/**
 *
 * @author Michael Theriot
 */
public class AppointmentQuery extends RDBImplCommand {

    public AppointmentQuery() {
        this.sqlQuery = "SELECT DISTINCT * FROM any_appointment WHERE time > now() ORDER BY time";
    }
    
    @Override
    public void queryDB() throws SQLException {
        resultSet = statement.executeQuery();
        processResult();
    }

    public void processResult() throws SQLException {
        ArrayList<Appointment> appts = new ArrayList();
        while(resultSet.next()) {
            appts.add(
                    new Appointment(
                            resultSet.getInt("appt_id"),
                            resultSet.getInt("advisor_id"),
                            resultSet.getString("advisor"),
                            resultSet.getString("advisor_phone"),
                            resultSet.getString("advisor_email"),
                            resultSet.getInt("advisor_rank"),
                            resultSet.getInt("student_id"),
                            resultSet.getString("student"),
                            resultSet.getString("uta_student_id"),
                            resultSet.getString("student_email"),
                            resultSet.getString("student_phone"),
                            resultSet.getString("reason"),
                            resultSet.getString("description"),
                            resultSet.getTimestamp("time").getTime()
                    )
            );
        }
        if(!appts.isEmpty()) {
            result = appts.toArray(new Appointment[appts.size()]);
        }
    }
}
