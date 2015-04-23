package uta.cse4361.databases;

import java.sql.SQLException;
import java.util.ArrayList;
import uta.cse4361.businessobjects.Slot;

/**
 *
 * @author Michael Theriot
 */
public class ScheduleAppointmentQuery extends RDBImplCommand {

    private int slotId;
    private int studentId;
    private String reason;
    private String description;

    public ScheduleAppointmentQuery(int slotId, int studentId, String reason, String description) {
        this.sqlQuery = "INSERT INTO appointment VALUES(?, ?, ?, ?)";
        this.slotId = slotId;
        this.studentId = studentId;
        this.reason = reason;
        this.description = description;
    }

    @Override
    public void queryDB() throws SQLException {
        result = statement.executeUpdate() > 0;
    }

    @Override
    public void prepareStatement() throws SQLException {
        statement.setInt(1, slotId);
        statement.setInt(2, studentId);
        statement.setString(3, reason);
        statement.setString(4, description);
    }
}
