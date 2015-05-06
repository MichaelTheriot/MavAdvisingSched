package uta.cse4361.databases;

import java.sql.SQLException;
import uta.cse4361.businessobjects.Advisor;

/**
 *
 * @author Michael Theriot
 */
public class DeleteAppointmentUnregisteredByAdvisorIdQuery extends DeleteAppointmentByAdvisorIdQuery {

    public DeleteAppointmentUnregisteredByAdvisorIdQuery(int apptId, int advisorId) {
        super(apptId, advisorId);
        this.sqlQuery = "DELETE FROM appointment_unregistered WHERE slotid = ? AND slotid IN (SELECT DISTINCT id FROM slot WHERE advisorid = ?)";
    }

}
