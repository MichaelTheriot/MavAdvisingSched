/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uta.cse4361.databases;

import java.sql.SQLException;
import uta.cse4361.businessobjects.Slot;

/**
 *
 * @author Michael
 */
public class SlotQueryById extends SlotQuery {

    private int id;

    public SlotQueryById(int id) {
        this.sqlQuery = "SELECT DISTINCT id, dept_id, dept_name, advisor_id, advisor_name, advisor_email, advisor_phone, advisor_rank, time, available FROM future_slot WHERE id = ? ORDER BY time";
        this.id = id;
    }

    @Override
    protected void prepareStatement() throws SQLException {
        statement = conn.prepareStatement(sqlQuery);
        statement.setInt(1, id);
    }

    public void processResult() throws SQLException {
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
            result = new Slot(id, departmentId, departmentName, advisorId, advisorName, advisorEmail, advisorPhone, advisorRank, time, available);
        }
    }
}
