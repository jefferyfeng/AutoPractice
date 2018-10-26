package init;

import util.ConnectionUtil;

import java.sql.Connection;

public class DBInfo {

    public static Connection conn = ConnectionUtil.getConn();

    public static Configration conf = ConfigReader.getConfig();

    public static void initTableModel(String tableName){

    }
}
