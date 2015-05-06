package uta.cse4361.databases;

import java.sql.SQLException;
import uta.cse4361.businessobjects.Advisor;

/**
 *
 * @author Michael Theriot
 */
public class DeleteAppointmentByDeptIdQuery extends DeleteAppointmentQuery {

    private int deptId;

    public DeleteAppointmentByDeptIdQuery(int apptId, int deptId) {
        super(apptId);
        this.sqlQuery = "DELETE FROM appointment WHERE slotid = ? AND slotid IN (SELECT DISTINCT slot.id FROM slot, advisor WHERE slot.advisorid = advisor.id AND advisor.departmentid = ?)";
        this.deptId = deptId;
    }

    @Override
    public void prepareStatement() throws SQLException {
        statement = conn.prepareStatement(sqlQuery);
        statement.setInt(1, apptId);
        statement.setInt(2, deptId);
    }
}
