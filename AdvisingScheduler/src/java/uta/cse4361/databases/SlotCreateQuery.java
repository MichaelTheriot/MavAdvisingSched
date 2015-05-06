package uta.cse4361.databases;

import java.sql.SQLException;
import java.sql.Timestamp;

/**
 *
 * @author Michael Theriot
 */
public class SlotCreateQuery extends RDBImplCommand {

    protected int advisorId;
    protected Timestamp startTime;

    public SlotCreateQuery(int advisorId, long startTime) {
        this.sqlQuery = "INSERT INTO slot(advisorid, starttime) VALUES(?, ?)";
        this.advisorId = advisorId;
        this.startTime = new Timestamp(startTime);
    }

    @Override
    public void queryDB() throws SQLException {
        int rows = statement.executeUpdate();
        result = rows > 0;
    }

    @Override
    public void prepareStatement() throws SQLException {
        statement = conn.prepareStatement(sqlQuery);
        statement.setInt(1, advisorId);
        statement.setTimestamp(2, startTime);
    }
}
