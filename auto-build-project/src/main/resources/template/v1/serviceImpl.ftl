package ${servicePackage};

import ${modelPackage}.${tableModel.tableName};
import java.util.List;
import java.util.Date;

/**
 *  ${tableModel.tableName}ServiceImpl  <#if tableModel.comment??>${tableModel.comment}实现类</#if>
 *
 *  @author fdh
 */
@Service
@Transaction(propagation=Propagation.SUPPORTS,isolation = Isolation.READ_UNCOMMITTED, readOnly = true)
public class ${tableModel.tableName}ServiceImpl {
    @Autowried
    private ${tableModel.tableName}Dao ${tableModel.tableNameLowFirstChar}Dao;

    /**
     * 新增${tableModel.tableName}
     * @param ${tableModel.tableNameLowFirstChar}
     */
    @Override
    @Transaction(propagation=Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED,readOnly = false)
    void add(${tableModel.tableName} ${tableModel.tableNameLowFirstChar}){
        ${tableModel.tableNameLowFirstChar}.setCreateDate = new Date();
        ${tableModel.tableNameLowFirstChar}.setIsValid(1);
        ${tableModel.tableNameLowFirstChar}Dao.insert(${tableModel.tableNameLowFirstChar});
    }

    /**
     * 根据主键 删除${tableModel.tableName} (逻辑删除)
     * @param ${pkColumnModel.columnName}
     */
    @Override
    @Transaction(propagation=Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED,readOnly = false)
    void remove(${tableModel.tableName} ${tableModel.tableNameLowFirstChar}){
        //${tableModel.tableNameLowFirstChar}Dao.delete(${tableModel.tableNameLowFirstChar}.get${pkColumnModel.columnNameUpFirstChar}());
        ${tableModel.tableNameLowFirstChar}.setIsValid(0);
        ${tableModel.tableNameLowFirstChar}Dao.update(${tableModel.tableNameLowFirstChar});
    }

    /**
     * 修改${tableModel.tableName}
     * @param ${tableModel.tableNameLowFirstChar}
     */
    @Override
    @Transaction(propagation=Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED,readOnly = false)
    void modify(${tableModel.tableName} ${tableModel.tableNameLowFirstChar}){
        ${tableModel.tableNameLowFirstChar}Dao.update(${tableModel.tableNameLowFirstChar});
    }

    /**
     * 根据主键查询${tableModel.tableName}
     * @param ${pkColumnModel.columnName}
     * @return ${tableModel.tableNameLowFirstChar}
     */
    @Override
    ${tableModel.tableName} queryOne(${pkColumnModel.columnType} ${pkColumnModel.columnName}){
        return ${tableModel.tableNameLowFirstChar}Dao.queryOne(${pkColumnModel.columnName});
    }

    /**
     * 根据主键查询${tableModel.tableName}
     * @return ${tableModel.tableNameLowFirstChar}s
     */
    @Override
    List<${tableModel.tableName}> queryAll(){
        return ${tableModel.tableNameLowFirstChar}Dao.queryAll();
    }

    /**
     * 根据字段查询（如需分页请setPageParameter）
     * @param ${tableModel.tableNameLowFirstChar}
     * @return ${tableModel.tableNameLowFirstChar}s
     */
    @Override
    List<${tableModel.tableName}> queryByFieldsAndPage(${tableModel.tableName} ${tableModel.tableNameLowFirstChar}){
        return ${tableModel.tableNameLowFirstChar}Dao.queryByFieldsAndPage(${tableModel.tableNameLowFirstChar});
    }
}