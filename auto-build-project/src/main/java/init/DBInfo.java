package init;

import db.ColumnModel;
import db.TableModel;
import util.ConnectionUtil;
import util.StringUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DBInfo {

    public static Connection conn = ConnectionUtil.getConn();

    public static Configration conf = ConfigReader.getConfig();

    public static TableModel initTableModel(String tableName){
        TableModel tableModel = new TableModel();
        //获取表的表属性 TODO 可优化查询字段
        String sqlForTable = "SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '"+tableName+"' and TABLE_SCHEMA = '"+conf.getDbName()+"'";
        ResultSet rs = null;
        try {
            PreparedStatement pstm = conn.prepareStatement(sqlForTable);
            rs = pstm.executeQuery();
            if(rs.next()){
                String tableComment = rs.getString("TABLE_COMMENT");
                tableModel.setTableNameDB(tableName);
                tableModel.setTableName(StringUtil.noUnderLineAndUpFirstChar(tableName));
                tableModel.setTableNameLowFirstChar(StringUtil.noUnderLineAndLowFirstChar(tableName));
                tableModel.setComment(tableComment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if(rs!=null){ try { rs.close(); } catch (SQLException e) { e.printStackTrace(); } }
        }


        //获取表的列属性 TODO 可优化查询字段
        String sqlForColumn = "SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME ='"+tableName+"' and TABLE_SCHEMA = '"+conf.getDbName()+"'";
        ResultSet res = null;
        try {
            PreparedStatement pstm = conn.prepareStatement(sqlForColumn);
            res = pstm.executeQuery();
            List<ColumnModel> columnModels = new ArrayList<ColumnModel>();
            while(res.next()){
                String columnName = res.getString("COLUMN_NAME");
                String dataType = res.getString("DATA_TYPE");
                String columnComment = res.getString("COLUMN_COMMENT");
                boolean isPrimaryKey = "PRI".equals(res.getString("COLUMN_KEY"));
                ColumnModel columnModel = new ColumnModel(columnName, StringUtil.noUnderLineAndLowFirstChar(columnName),StringUtil.noUnderLineAndUpFirstChar(columnName),dataType,conf.getMysqlToJavaMap().get(dataType),columnComment,isPrimaryKey);
                columnModels.add(columnModel);
            }
            tableModel.setColumnModelList(columnModels);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if(res!=null){ try { res.close(); } catch (SQLException e) { e.printStackTrace(); } }
        }
        return tableModel;
    }
}
