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

    private int dept;

    public SlotQueryByDept(int dept) {
        this.sqlQuery = "SELECT DISTINCT id, dept_id, dept_name, advisor_name, rank, time FROM available_slot WHERE department = ? ORDER BY time";
        this.dept = dept;
    }

    @Override
    protected void prepareStatement() throws SQLException {
        statement.setInt(1, dept);
    }
}
