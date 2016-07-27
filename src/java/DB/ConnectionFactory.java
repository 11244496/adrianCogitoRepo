/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package DB;

import java.sql.Connection;

public abstract class ConnectionFactory {
    
    private String driverName="com.mysql.jdbc.Driver";
    private String url = "jdbc:mysql://localhost/cogitov5";//localhost:3306
    private String username = "root";
    private String password = "";
    
    public static ConnectionFactory getInstance(){
        return new DBConnectionFactoryImpl();
    }
    
    public abstract Connection getConnection();

    public String getDriverName() {
        return driverName;
    }

    public String getUrl() {
        return url;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }
    
}
