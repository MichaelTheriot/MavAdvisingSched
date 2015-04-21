package uta.cse4361.databases;

import java.sql.SQLException;
import java.util.ArrayList;
import uta.cse4361.businessobjects.Department;

/**
 *
 * @author Michael Theriot
 */
public class DepartmentQuery extends RDBImplCommand {

    public DepartmentQuery() {
        this.sqlQuery = "SELECT DISTINCT id, name FROM department ORDER BY id";
    }
    
    @Override
    public void queryDB() throws SQLException {
        resultSet = statement.executeQuery();
        processResult();
    }

    public void processResult() throws SQLException {
        ArrayList<Department> depts = new ArrayList();
        while(resultSet.next()) {
            depts.add(new Department(resultSet.getInt("id"), resultSet.getString("name")));
        }
        if(!depts.isEmpty()) {
            result = depts.toArray(new Department[depts.size()]);
        }
    }
}
