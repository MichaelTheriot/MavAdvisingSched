package uta.cse4361.databases;

import java.sql.SQLException;
import java.util.ArrayList;
import uta.cse4361.businessobjects.Appointment;

/**
 *
 * @author Michael Theriot
 */
public class AppointmentByDeptIdQuery extends AppointmentQuery {

    private int deptId;

    public AppointmentByDeptIdQuery(int deptId) {
        this.sqlQuery = "SELECT DISTINCT * FROM any_appointment WHERE advisor_dept = ? AND time > now() ORDER BY time";
        this.deptId = deptId;
    }

    @Override
    public void prepareStatement() throws SQLException {
        statement = conn.prepareStatement(sqlQuery);
        statement.setInt(1, deptId);
    }
}
