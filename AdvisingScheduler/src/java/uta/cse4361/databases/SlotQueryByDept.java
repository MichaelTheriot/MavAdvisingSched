/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uta.cse4361.databases;

import java.sql.SQLException;

/**
 *
 * @author Michael
 */
public class SlotQueryByDept extends SlotQuery {

    protected String sqlQuery = "SELECT DISTINCT id, dept_id, dept_name, advisor_name, rank, time FROM available_slot ORDER BY time";
    private int dept;

    public SlotQueryByDept(int dept) {
        this.dept = dept;
    }

    @Override
    public void queryDB() throws SQLException {
        try {
            statement = conn.prepareStatement(sqlQuery);
            statement.setInt(1, dept);
            resultSet = statement.executeQuery();
            success = 1;
            processResult();
        } catch(SQLException e) {
            success = 0;
            conn.close();
        } finally {
            statement.close();
        }
    }
}
