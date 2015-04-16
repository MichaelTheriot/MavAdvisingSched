package uta.cse4361.databases;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import uta.cse4361.businessobjects.Slots;

/**
 *
 * @author Michael Theriot
 */
public class SlotsDeptQuery extends RDBImplCommand {

    private int dept;
    private String sqlQuery = "SELECT DISTINCT id, dept_id, dept_name, advisor_name, rank, time FROM available_slot WHERE dept_id = ? ORDER BY time";
    private Slots slots;

    public SlotsDeptQuery(int dept) {
        this.dept = dept;
    }
    
    @Override
    public void queryDB() throws SQLException {
        try {
            statement = conn.prepareStatement(sqlQuery);
            statement.setString(1, Integer.toString(dept));
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
                ArrayList<Integer> id = new ArrayList();
                ArrayList<Integer> dept_id = new ArrayList();
                ArrayList<String> dept_name = new ArrayList();
                ArrayList<String> advisor_name = new ArrayList();
                ArrayList<Integer> rank = new ArrayList();
                ArrayList<java.sql.Timestamp> time = new ArrayList();
                while(resultSet.next()) {
                    id.add(resultSet.getInt("id"));
                    dept_id.add(resultSet.getInt("dept_id"));
                    dept_name.add(resultSet.getString("dept_name"));
                    advisor_name.add(resultSet.getString("advisor_name"));
                    rank.add(resultSet.getInt("rank"));
                    time.add(resultSet.getTimestamp("time"));
                }
                if(id.size() > 0) {
                    result = new Slots(id, dept_id, dept_name, advisor_name, rank, time);
                }
            } catch (SQLException e) {
                System.out.println(e);
            }
        }
    }
}
