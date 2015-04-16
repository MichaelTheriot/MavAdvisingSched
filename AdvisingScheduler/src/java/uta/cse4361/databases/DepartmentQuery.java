package uta.cse4361.databases;

import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Michael Theriot
 */
public class DepartmentQuery extends RDBImplCommand {

    private String sqlQuery = "SELECT DISTINCT id, name FROM department ORDER BY id";

    public DepartmentQuery() {
    }
    
    @Override
    public void queryDB() throws SQLException {
        try {
            statement = conn.prepareStatement(sqlQuery);
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

    public void processResult() throws SQLException {
        if(success == 1) {
            try {
                ArrayList<String> list = new ArrayList<String>();
                while(resultSet.next()) {
                    list.add(Integer.toString(resultSet.getInt("id")));
                    list.add(resultSet.getString("name"));
                }
                if(list.size() > 0) {
                    result = list;
                }
            } catch (SQLException e) {
                System.out.println(e);
            }
        }
    }
}
