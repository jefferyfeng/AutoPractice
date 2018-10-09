package util;

import init.ConfigReader;
import init.Configration;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * 数据库连接工具类
 */
public class ConnectionUtil {
    private static Connection conn;
    private static Configration config;
    private static ThreadLocal<Connection> tl = new ThreadLocal<>();

    static {
        config = ConfigReader.getConfig();
        try {
            if("mysql".equals(config.getDbType())){
                Class.forName("com.mysql.jdbc.Driver");
            }else if("oracle".equals(config.getDbType())){
                Class.forName("oracle.jdbc.driver.OracleDriver");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConn(){
        try {
            if(tl.get()==null){
                conn = DriverManager.getConnection(config.getDbUrl(),config.getUsername(),config.getPassword());
                tl.set(conn);
            }
            conn = tl.get();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return conn;
    }

    public static void realseConn(){
        try {
            tl.remove();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
