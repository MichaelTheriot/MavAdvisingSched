/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uta.cse4361.beans;

import java.util.ArrayList;
import uta.cse4361.businessobjects.Department;
import uta.cse4361.databases.DepartmentQuery;

/**
 *
 * @author Michael
 */
public class DepartmentBean {

    public DepartmentBean() {
    }

    public Department[] getDepartments() {
        DepartmentQuery query = new DepartmentQuery();
        query.execute();
        return (Department[]) query.getResult();
    }
}
