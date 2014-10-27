/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uta.cse4361.databases;
import java.util.*;
import java.sql.*;
import uta.cse4361.businessobjects.AvailableSlot;
import uta.cse4361.businessobjects.Slot;

/**
 *
 * @author Andrew
 */
public class GetAllSlots extends RDBImplCommand{
    String sqlQuery = "SELECT * FROM \"SLOT\"";
    
    public GetAllSlots(){}
    
    public void queryDB() throws SQLException{
        try {
            statement = conn.prepareStatement(sqlQuery);
            resultSet = statement.executeQuery();
            processResult();
        } catch (SQLException e) {
            System.out.println("failed");
            conn.close();
        } finally {
            if (statement != null) {
                statement.close();
            }
        }
    }
    public void processResult(){
        try {
            result = new ArrayList<Slot>();
            while (resultSet.next()) {
                int id = resultSet.getInt(1);
                java.util.Date d = new java.util.Date(((java.sql.Date)resultSet.getDate(2)).getTime());
                int startHour = resultSet.getInt(3);
                int startMin = resultSet.getInt(4);
                Slot s = new AvailableSlot(d, startHour, startMin, id);
                ((ArrayList<Slot>) result).add(s);
            }
        } catch (SQLException e) {
            System.out.println("Get Slotsa Failed");
            result = null;
        }
    }
    
}
