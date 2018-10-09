package test;

import init.ConfigReader;
import init.Configration;
import util.ConnectionUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * 自动构建项目入口
 */
public class AutoBuilderFactory {
    private static Configration config = ConfigReader.getConfig();
    public static void main(String[] args) throws SQLException {
        Connection conn = ConnectionUtil.getConn();
        PreparedStatement ps = conn.prepareStatement("SHOW CREATE TABLE "
                + config.getTableName());
        ResultSet rs = ps.executeQuery();
        if(rs.next()){
            System.out.println(rs.getString("CREATE TABLE"));
        }
    }
}
