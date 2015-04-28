package uta.cse4361.databases;

import java.sql.SQLException;
import java.util.ArrayList;
import uta.cse4361.businessobjects.Appointment;

/**
 *
 * @author Michael Theriot
 */
public class AppointmentByStudentIdQuery extends AppointmentQuery {

    private int studentId;

    public AppointmentByStudentIdQuery(int studentId) {
        this.sqlQuery = "SELECT DISTINCT * FROM student_appointment WHERE student_id = ? AND time > now() ORDER BY time";
        this.studentId = studentId;
    }

    @Override
    public void prepareStatement() throws SQLException {
        statement = conn.prepareStatement(sqlQuery);
        statement.setInt(1, studentId);
    }
}
