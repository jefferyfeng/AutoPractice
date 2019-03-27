package ${servicePackage};

import ${modelPackage}.${tableModel.tableName};
import java.util.List;

/**
 *  ${tableModel.tableName}Service  <#if tableModel.comment??>${tableModel.comment}接口</#if>
 *
 *  @author fdh
 */
public interface ${tableModel.tableName}Service {
    /**
     * 新增${tableModel.tableName}
     * @param ${tableModel.tableNameLowFirstChar}
     */
    void add(${tableModel.tableName} ${tableModel.tableNameLowFirstChar});

    /**
     * 根据主键 删除${tableModel.tableName} (物理删除)
     * @param ${pkColumnModel.columnName}
     */
    void delete(${pkColumnModel.columnType} ${pkColumnModel.columnName});

    /**
     * 根据主键 删除${tableModel.tableName} (逻辑删除)
     * @param ${pkColumnModel.columnName}
     */
    void remove(${pkColumnModel.columnType} ${pkColumnModel.columnName});

    /**
     * 修改${tableModel.tableName}
     * @param ${tableModel.tableNameLowFirstChar}
     */
    void modify(${tableModel.tableName} ${tableModel.tableNameLowFirstChar});

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
     * 批量删除${tableModel.tableName}s
     * @param ${pkColumnModel.columnName}s
     */
    void batchRemove(Long[] ${pkColumnModel.columnName}s);

    <#list tableModel.columnModelList as columnModel>
        <#if columnModel.columnName?contains("status")>
    /**
     * 批量修改状态
     * @param ${pkColumnModel.columnName}s 修改的${pkColumnModel.columnName}s
     * @param status 修改的状态
     */
    void batchModifyStatus(Long[] ${pkColumnModel.columnName}s, Integer status);
        </#if>
    </#list>

}