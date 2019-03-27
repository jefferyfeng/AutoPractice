package ${daoPackage};

import ${modelPackage}.${tableModel.tableName};
import org.apache.ibatis.annotations.Param;
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

    /**
     * 批量删除（逻辑删除）
     * @param ids 操作的ids
     */
    void batchRemove(@Param("${pkColumnModel.columnName}s") Long[] ${pkColumnModel.columnName}s);

    <#list tableModel.columnModelList as columnModel>
        <#if columnModel.columnName?contains("status")>
    /**
     * 批量修改状态
     * @param ids
     * @param status
     */
    void batchModifyStatus(@Param("${pkColumnModel.columnName}s") Long[] ${pkColumnModel.columnName}s, @Param("status") Integer status);
        </#if>
    </#list>
}