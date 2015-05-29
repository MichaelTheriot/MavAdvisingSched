/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package auth;

import com.github.kevinsawicki.http.HttpRequest;
import com.google.gson.JsonNull;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

/**
 *
 * @author Michael
 */
public class AzureClient {

    private String clientId;
    private final String clientSecret;
    private final String baseUri;
    private final String authUri;
    private final String deauthUri;
    private final String redirectUri;
    private String encodedClientId;
    private String encodedRedirectUri;

    public AzureClient(String clientId, String clientSecret, String redirectUri, String logoutUri) { // should be updated to throw encoding errors
        try {
            this.encodedClientId = URLEncoder.encode(clientId, "UTF-8");
            this.encodedRedirectUri = URLEncoder.encode(redirectUri, "UTF-8");
        } catch (UnsupportedEncodingException ex) {
            this.encodedClientId = "";
            this.encodedRedirectUri = "";
        }
        this.baseUri = "https://login.windows.net/common/oauth2";
        this.clientId = clientId;
        this.clientSecret = clientSecret;
        this.authUri = baseUri + "/authorize"
            + "?response_type=code"
            + "&client_id=" + encodedClientId
            + "&redirect_uri=" + encodedRedirectUri;
        this.deauthUri = "https://login.microsoftonline.com/common/oauth2/logout?post_logout_redirect_uri=" + logoutUri;
        this.redirectUri = redirectUri;
    }

    public String getAuthUri() {
        return authUri;
    }

    public String getDeauthUri() {
        return deauthUri;
    }

    public AzureUser getUser(String code) { // should be updated to throw errors not return null
        try {
            String body = HttpRequest.get(baseUri + "/token")
                .accept("application/json")
                .part("grant_type", "authorization_code")
                .part("client_id", clientId)
                .part("client_secret", clientSecret)
                .part("resource", "https://graph.windows.net")
                .part("code", code)
                .part("redirect_uri", redirectUri)
                .body();
            JsonObject rawJson = new JsonParser().parse(body).getAsJsonObject();
            String accessToken = rawJson.getAsJsonPrimitive("access_token").getAsString();
            body = HttpRequest.get("https://graph.windows.net/me?api-version=1.5")
                .accept("application/json")
                .header("Authorization", "Bearer " + accessToken)
                .body();
            rawJson = new JsonParser().parse(body).getAsJsonObject();
            if(rawJson.get("mail") instanceof JsonNull
            || rawJson.get("givenName") instanceof JsonNull
            || rawJson.get("surname") instanceof JsonNull) {
                return null;
            }
            String email = rawJson.getAsJsonPrimitive("mail").getAsString();
            String firstName = rawJson.getAsJsonPrimitive("givenName").getAsString();
            String lastName = rawJson.getAsJsonPrimitive("surname").getAsString();
            String jobTitle = null;
            if(!(rawJson.get("jobTitle") instanceof JsonNull)) {
                jobTitle = rawJson.getAsJsonPrimitive("jobTitle").getAsString();
            }
            return new AzureUser(email, firstName, lastName, jobTitle);
        } catch(Exception e) {
            System.out.println(e);
            return null;
        }
    }

    // destroy session...
}