package uta.cse4361.databases;

import java.sql.SQLException;
import uta.cse4361.businessobjects.Advisor;

/**
 *
 * @author Michael Theriot
 */
public class DeleteAppointmentUnregisteredByDeptIdQuery extends DeleteAppointmentByDeptIdQuery {

    public DeleteAppointmentUnregisteredByDeptIdQuery(int apptId, int deptId) {
        super(apptId, deptId);
        this.sqlQuery = "DELETE FROM appointment_unregistered WHERE slotid = ? AND slotid IN (SELECT DISTINCT slot.id FROM slot, advisor WHERE slot.advisorid = advisor.id AND advisor.departmentid = ?)";
    }
}
