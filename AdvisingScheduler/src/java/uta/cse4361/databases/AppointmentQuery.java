package uta.cse4361.databases;

import java.sql.SQLException;
import java.util.ArrayList;
import uta.cse4361.businessobjects.Appointment;

/**
 *
 * @author Michael Theriot
 */
public class AppointmentQuery extends RDBImplCommand {

    private int studentId;

    public AppointmentQuery(int studentId) {
            this.sqlQuery = "SELECT DISTINCT * FROM student_appointment WHERE student_id = ? AND time > now() ORDER BY time";
        this.studentId = studentId;
    }
    
    @Override
    public void queryDB() throws SQLException {
        resultSet = statement.executeQuery();
        processResult();
    }

    @Override
    public void prepareStatement() throws SQLException {
        statement = conn.prepareStatement(sqlQuery);
        statement.setInt(1, studentId);
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
                            resultSet.getLong("time")
                    )
            );
        }
        if(!appts.isEmpty()) {
            result = appts.toArray(new Appointment[appts.size()]);
        }
    }
}
