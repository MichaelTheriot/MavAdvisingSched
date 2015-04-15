/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uta.cse4361.databases;

import java.sql.ResultSet;

/**
 *
 * @author Michael
 */
public interface ResultProcessor<T> {
    public T processResult(ResultSet resultSet);
}
