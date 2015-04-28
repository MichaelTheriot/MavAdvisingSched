/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uta.cse4361.beans;

import uta.cse4361.businessobjects.Advisor;
import uta.cse4361.databases.AdvisorQuery;

/**
 *
 * @author Michael
 */
public class AdvisorBean {
    private int userId;

    public AdvisorBean() {
    }

    public Advisor getAdvisor() {
        AdvisorQuery query = new AdvisorQuery(userId);
        query.execute();
        return (Advisor) query.getResult();
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
}
