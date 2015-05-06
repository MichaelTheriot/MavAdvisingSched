package uta.cse4361.databases;

import java.sql.SQLException;
import uta.cse4361.businessobjects.Advisor;

/**
 *
 * @author Michael Theriot
 */
public class DeleteAppointmentByStudentIdQuery extends DeleteAppointmentQuery {

    private int studentId;

    public DeleteAppointmentByStudentIdQuery(int apptId, int studentId) {
        super(apptId);
        this.sqlQuery = "DELETE FROM appointment WHERE slotid = ? AND studentid = ?";
        this.studentId = studentId;
    }

    @Override
    public void prepareStatement() throws SQLException {
        statement = conn.prepareStatement(sqlQuery);
        statement.setInt(1, apptId);
        statement.setInt(2, studentId);
    }
}
