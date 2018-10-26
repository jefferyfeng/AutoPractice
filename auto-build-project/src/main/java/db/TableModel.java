package db;

import init.ConfigReader;
import init.Configration;

import java.util.List;

/**
 * 表实体
 *
 * @author fdh
 */
public class TableModel {
    private String tableName;
    //表的列字段集合
    private List<ColumnModel> columnModelList;
    //表的注释
    private String Comment;
    //去除下划线驼峰命名  首字符小写
    private String firstLowerCaseTableName;
    //去除下划线驼峰命名  首字符大写
    private String baseTableName;

    //配置类
    private Configration config = ConfigReader.getConfig();

    public String getTableName() {
        return config.getTableName();
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

    public String getFirstLowerCaseTableName() {
        return firstLowerCaseTableName;
    }

    public void setFirstLowerCaseTableName(String firstLowerCaseTableName) {
        this.firstLowerCaseTableName = firstLowerCaseTableName;
    }

    public String getBaseTableName() {
        return baseTableName;
    }

    public void setBaseTableName(String baseTableName) {
        this.baseTableName = baseTableName;
    }
}
