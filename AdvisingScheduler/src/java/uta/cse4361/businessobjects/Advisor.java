/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uta.cse4361.businessobjects;

/**
 *
 * @author Michael
 */
public class Advisor {
    private int advisorId;
    private int dept;

    public int getAdvisorId() {
        return advisorId;
    }

    public int getDept() {
        return dept;
    }
    
    public Advisor(int advisorId, int dept) {
        this.advisorId = advisorId;
        this.dept = dept;
    }
}
