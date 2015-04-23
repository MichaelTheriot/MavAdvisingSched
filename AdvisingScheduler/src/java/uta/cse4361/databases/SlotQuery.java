package uta.cse4361.databases;

import java.sql.SQLException;
import java.util.ArrayList;
import uta.cse4361.businessobjects.Slot;

/**
 *
 * @author Michael Theriot
 */
public class SlotQuery extends RDBImplCommand {

    public SlotQuery() {
        this.sqlQuery = "SELECT DISTINCT id, dept_id, dept_name, advisor_id, advisor_name, advisor_email, advisor_phone, advisor_rank, time, available FROM future_slot ORDER BY time";
    }

    @Override
    public void queryDB() throws SQLException {
        resultSet = statement.executeQuery();
        processResult();
    }

    public void processResult() throws SQLException {
        ArrayList<Slot> slots = new ArrayList();
        while(resultSet.next()) {
            int id = resultSet.getInt("id");
            int departmentId = resultSet.getInt("dept_id");
            String departmentName = resultSet.getString("dept_name");
            int advisorId = resultSet.getInt("advisor_id");
            String advisorName = resultSet.getString("advisor_name");
            String advisorEmail = resultSet.getString("advisor_email");
            String advisorPhone = resultSet.getString("advisor_phone");
            int advisorRank = resultSet.getInt("advisor_rank");
            long time = resultSet.getTimestamp("time").getTime();
            boolean available = resultSet.getBoolean("available");
            Slot slot = new Slot(id, departmentId, departmentName, advisorId, advisorName, advisorEmail, advisorPhone, advisorRank, time, available);
            slots.add(slot);
        }
        if(!slots.isEmpty()) {
            result = slots.toArray(new Slot[slots.size()]);
        }
    }
}
