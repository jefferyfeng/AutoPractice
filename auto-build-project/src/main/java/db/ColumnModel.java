package db;

/**
 * 表的字段列
 */
public class ColumnModel {
    /**数据库字段名*/
    private String columnDBName;
    /**映射到程序中属性名*/
    private String columnName;
    private String columnNameUpFirstChar;
    /**数据库字段类型*/
    private String columnDBType;
    /**映射到程序中属性类型*/
    private String columnType;
    /**注释*/
    private String columnComment;

    public ColumnModel() {
    }

    public ColumnModel(String columnDBName, String columnName, String columnNameUpFirstChar, String columnDBType, String columnType, String columnComment) {
        this.columnDBName = columnDBName;
        this.columnName = columnName;
        this.columnNameUpFirstChar = columnNameUpFirstChar;
        this.columnDBType = columnDBType;
        this.columnType = columnType;
        this.columnComment = columnComment;
    }

    public String getColumnDBName() {
        return columnDBName;
    }

    public void setColumnDBName(String columnDBName) {
        this.columnDBName = columnDBName;
    }

    public String getColumnName() {
        return columnName;
    }

    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }

    public String getColumnNameUpFirstChar() {
        return columnNameUpFirstChar;
    }

    public void setColumnNameUpFirstChar(String columnNameUpFirstChar) {
        this.columnNameUpFirstChar = columnNameUpFirstChar;
    }

    public String getColumnDBType() {
        return columnDBType;
    }

    public void setColumnDBType(String columnDBType) {
        this.columnDBType = columnDBType;
    }

    public String getColumnType() {
        return columnType;
    }

    public void setColumnType(String columnType) {
        this.columnType = columnType;
    }

    public String getColumnComment() {
        return columnComment;
    }

    public void setColumnComment(String columnComment) {
        this.columnComment = columnComment;
    }
}
