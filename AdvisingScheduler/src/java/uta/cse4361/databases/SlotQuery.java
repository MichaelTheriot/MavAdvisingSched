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
        this.sqlQuery = "SELECT DISTINCT id, dept_id, dept_name, advisor_name, rank, time FROM available_slot ORDER BY time";
    }

    @Override
    public void queryDB() throws SQLException {
        resultSet = statement.executeQuery();
        processResult();
    }

    public void processResult() throws SQLException {
        ArrayList<Slot> slots = new ArrayList();
        while(resultSet.next()) {
            Slot slot = new Slot(resultSet.getInt("id"), resultSet.getInt("advisor_id"), resultSet.getString("advisor_name"), resultSet.getString("advisor_phone"), resultSet.getInt("department_id"), resultSet.getString("departmentName"), resultSet.getTimestamp("time").getTime());
            slots.add(slot);
        }
        if(!slots.isEmpty()) {
            result = slots.toArray(new Slot[slots.size()]);
        }
    }
}
