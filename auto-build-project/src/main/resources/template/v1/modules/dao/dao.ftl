package ${daoPackage};

import ${modelPackage}.${tableModel.tableName};
import java.util.List;

/**
 *  ${tableModel.tableName}Dao  <#if tableModel.comment??>${tableModel.comment}接口</#if>
 *
 *  @author fdh
 */
public interface ${tableModel.tableName}Dao {
    /**
     * 新增${tableModel.tableName}
     * @param ${tableModel.tableNameLowFirstChar}
     */
    void insert(${tableModel.tableName} ${tableModel.tableNameLowFirstChar});

    /**
     * 根据主键 删除${tableModel.tableName}
     * @param ${pkColumnModel.columnName}
     */
    void delete(${pkColumnModel.columnType} ${pkColumnModel.columnName});

    /**
     * 修改${tableModel.tableName}
     * @param ${tableModel.tableNameLowFirstChar}
     */
    void update(${tableModel.tableName} ${tableModel.tableNameLowFirstChar});

    /**
     * 根据主键查询${tableModel.tableName}
     * @param ${pkColumnModel.columnName}
     * @return ${tableModel.tableNameLowFirstChar}
     */
    ${tableModel.tableName} queryOne(${pkColumnModel.columnType} ${pkColumnModel.columnName});

    /**
     * 根据主键查询${tableModel.tableName}
     * @return ${tableModel.tableNameLowFirstChar}s
     */
    List<${tableModel.tableName}> queryAll();

    /**
     * 根据字段查询（如需分页请setPageBean）
     * @param ${tableModel.tableNameLowFirstChar}
     * @return ${tableModel.tableNameLowFirstChar}s
     */
    List<${tableModel.tableName}> queryByFieldsAndPage(${tableModel.tableName} ${tableModel.tableNameLowFirstChar});
}