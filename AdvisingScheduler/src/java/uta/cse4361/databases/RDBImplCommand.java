/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uta.cse4361.databases;

import java.sql.*;

/**
 *
 * @author Han
 */
public abstract class RDBImplCommand {

    static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://localhost:3306/advising";

    //  Database credentials
    static final String USER = "root";
    static final String PASS = "er1ja@18xs@3";

    protected String sqlQuery;
    protected Connection conn;
    protected PreparedStatement statement;
    protected ResultSet resultSet;
    protected boolean success;
    protected Object result;

    public void execute() {
        success = false;
        try {
            connectDB();
            try {
                prepareStatement();
                try {
                    queryDB();
                    success = true;
                } catch(Exception e) {
                    e.printStackTrace(System.err);
                } finally {
                    statement.close();
                }
            } catch(Exception e) {
                e.printStackTrace(System.err);
            } finally {
                disconnectDB();
            }
        } catch(Exception e) {
            e.printStackTrace(System.err);
        }
    }

    private void connectDB() throws Exception {
        System.out.println("Connecting MySQL DB");
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(DB_URL, USER, PASS);
    }

    private void disconnectDB() {
        try {
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
    }

    public boolean succeeded() {
        return success;
    }

    public Object getResult() {
        return result;
    }

    protected void prepareStatement() throws SQLException {
        statement = conn.prepareStatement(sqlQuery);
    }

    public abstract void queryDB() throws SQLException;

    //public abstract void processResult();
}
