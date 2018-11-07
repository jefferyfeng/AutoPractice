package db;

import java.util.List;

/**
 * 表实体
 *
 * @author fdh
 */
public class TableModel {
    //数据库表名
    private String tableNameDB;
    //数据库表映射到程序中表名
    private String tableName;
    private String tableNameLowFirstChar;
    //表的列字段集合
    private List<ColumnModel> columnModelList;
    //表的注释
    private String Comment;

    public TableModel() {
    }

    public TableModel(String tableNameDB, String tableName, String tableNameLowFirstChar, List<ColumnModel> columnModelList, String comment) {
        this.tableNameDB = tableNameDB;
        this.tableName = tableName;
        this.tableNameLowFirstChar = tableNameLowFirstChar;
        this.columnModelList = columnModelList;
        Comment = comment;
    }

    public String getTableNameDB() {
        return tableNameDB;
    }

    public void setTableNameDB(String tableNameDB) {
        this.tableNameDB = tableNameDB;
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public String getTableNameLowFirstChar() {
        return tableNameLowFirstChar;
    }

    public void setTableNameLowFirstChar(String tableNameLowFirstChar) {
        this.tableNameLowFirstChar = tableNameLowFirstChar;
    }

    public List<ColumnModel> getColumnModelList() {
        return columnModelList;
    }

    public void setColumnModelList(List<ColumnModel> columnModelList) {
        this.columnModelList = columnModelList;
    }

    public String getComment() {
        return Comment;
    }

    public void setComment(String comment) {
        Comment = comment;
    }
}
