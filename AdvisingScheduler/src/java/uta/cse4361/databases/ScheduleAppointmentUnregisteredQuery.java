package uta.cse4361.databases;

import java.sql.SQLException;

/**
 *
 * @author Michael Theriot
 */
public class ScheduleAppointmentUnregisteredQuery extends RDBImplCommand {

    private int slotId;
    private String email;
    private String fname;
    private String lname;
    private String phone;
    private String reason;
    private String description;

    public ScheduleAppointmentUnregisteredQuery(int slotId, String email, String fname, String lname, String phone, String reason, String description) {
        this.sqlQuery = "INSERT INTO appointment_unregistered VALUES(?, ?, ?, ?, ?, ?, ?)";
        this.slotId = slotId;
        this.email = email;
        this.fname = fname;
        this.lname = lname;
        this.phone = phone;
        this.reason = reason;
        this.description = description;
    }

    @Override
    public void queryDB() throws SQLException {
        result = statement.executeUpdate() > 0;
    }

    @Override
    public void prepareStatement() throws SQLException {
        statement = conn.prepareStatement(sqlQuery);
        statement.setInt(1, slotId);
        statement.setString(2, email);
        statement.setString(3, fname);
        statement.setString(4, lname);
        statement.setString(5, phone);
        statement.setString(6, reason);
        statement.setString(7, description);
    }
}
