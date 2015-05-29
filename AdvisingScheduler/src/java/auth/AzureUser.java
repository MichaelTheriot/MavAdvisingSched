/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package auth;

/**
 *
 * @author Michael
 */
public class AzureUser {

    private final String email;
    private final String firstName;
    private final String lastName;
    private final String jobTitle;

    public AzureUser(String email, String firstName, String lastName, String jobTitle) {
        this.email = email;
        this.firstName = firstName;
        this.lastName = lastName;
        this.jobTitle = jobTitle;
    }

    public String getEmail() {
        return email;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getJobTitle() {
        return jobTitle;
    }

}