package uta.cse4361.databases;

import java.sql.SQLException;
import uta.cse4361.businessobjects.Advisor;

/**
 *
 * @author Michael Theriot
 */
public class DeleteAppointmentUnregisteredQuery extends DeleteAppointmentQuery {

    public DeleteAppointmentUnregisteredQuery(int apptId) {
        super(apptId);
        this.sqlQuery = "DELETE FROM appointment_unregistered WHERE slotid = ?";
    }
}
