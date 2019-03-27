package ${servicePackage};

import ${modelPackage}.${tableModel.tableName};
import ${daoPackage}.${tableModel.tableName}Dao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.Date;

/**
 *  ${tableModel.tableName}ServiceImpl  <#if tableModel.comment??>${tableModel.comment}实现类</#if>
 *
 *  @author fdh
 */
@Service
@Transactional(propagation=Propagation.SUPPORTS,isolation = Isolation.READ_UNCOMMITTED, readOnly = true)
public class ${tableModel.tableName}ServiceImpl implements ${tableModel.tableName}Service{
    @Autowired
    private ${tableModel.tableName}Dao ${tableModel.tableNameLowFirstChar}Dao;

    /**
     * 新增${tableModel.tableName}
     * @param ${tableModel.tableNameLowFirstChar}
     */
    @Override
    @Transactional(propagation=Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED,readOnly = false)
    public void add(${tableModel.tableName} ${tableModel.tableNameLowFirstChar}){
        Date date = new Date();
        ${tableModel.tableNameLowFirstChar}.setCreateDate(date);
        ${tableModel.tableNameLowFirstChar}.setUpdateDate(date);
        ${tableModel.tableNameLowFirstChar}.setIsValid(1);
        ${tableModel.tableNameLowFirstChar}Dao.insert(${tableModel.tableNameLowFirstChar});
    }

    /**
     * 根据主键 删除${tableModel.tableName} (物理删除)
     * @param ${pkColumnModel.columnName}
     */
    @Override
    @Transactional(propagation=Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED,readOnly = false)
    public void delete(${pkColumnModel.columnType} ${pkColumnModel.columnName}){
        ${tableModel.tableNameLowFirstChar}Dao.delete(${tableModel.tableNameLowFirstChar});
    }

    /**
     * 根据主键 删除${tableModel.tableName} (逻辑删除)
     * @param ${pkColumnModel.columnName}
     */
    @Transactional(propagation=Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED,readOnly = false)
    void remove(${pkColumnModel.columnType} ${pkColumnModel.columnName}){
        ${tableModel.tableName} ${tableModel.tableNameLowFirstChar} = new ${tableModel.tableName}();
        ${tableModel.tableNameLowFirstChar}.setId(${pkColumnModel.columnName});
        ${tableModel.tableNameLowFirstChar}.setIsValid(0);
        ${tableModel.tableNameLowFirstChar}.setUpdateDate(new Date());
        ${tableModel.tableNameLowFirstChar}Dao.update(${tableModel.tableNameLowFirstChar});
    }

    /**
     * 修改${tableModel.tableName}
     * @param ${tableModel.tableNameLowFirstChar}
     */
    @Override
    @Transactional(propagation=Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED,readOnly = false)
    public void modify(${tableModel.tableName} ${tableModel.tableNameLowFirstChar}){
        ${tableModel.tableNameLowFirstChar}.setUpdateDate(new Date());
        ${tableModel.tableNameLowFirstChar}Dao.update(${tableModel.tableNameLowFirstChar});
    }

    /**
     * 根据主键查询${tableModel.tableName}
     * @param ${pkColumnModel.columnName}
     * @return ${tableModel.tableNameLowFirstChar}
     */
    @Override
    public ${tableModel.tableName} queryOne(${pkColumnModel.columnType} ${pkColumnModel.columnName}){
        return ${tableModel.tableNameLowFirstChar}Dao.queryOne(${pkColumnModel.columnName});
    }

    /**
     * 根据主键查询${tableModel.tableName}
     * @return ${tableModel.tableNameLowFirstChar}s
     */
    @Override
    public List<${tableModel.tableName}> queryAll(){
        return ${tableModel.tableNameLowFirstChar}Dao.queryAll();
    }

    /**
     * 根据字段查询（如需分页请setPageBean）
     * @param ${tableModel.tableNameLowFirstChar}
     * @return ${tableModel.tableNameLowFirstChar}s
     */
    @Override
    public List<${tableModel.tableName}> queryByFieldsAndPage(${tableModel.tableName} ${tableModel.tableNameLowFirstChar}){
        return ${tableModel.tableNameLowFirstChar}Dao.queryByFieldsAndPage(${tableModel.tableNameLowFirstChar});
    }

    /**
     * 批量删除
     * @param ids
     */
    @Override
    @Transactional(propagation=Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED,readOnly = false)
    public void batchRemove(Long[] ${pkColumnModel.columnName}s) {
        ${tableModel.tableNameLowFirstChar}Dao.batchRemove(${pkColumnModel.columnName}s);
    }

    <#list tableModel.columnModelList as columnModel>
        <#if columnModel.columnName?contains("status")>
    /**
     * 批量修改状态
     * @param ${pkColumnModel.columnName}s 修改的${pkColumnModel.columnName}s
     * @param status 修改的状态
     */
    @Override
    public void batchModifyStatus(Long[] ${pkColumnModel.columnName}s, Integer status) {
        ${tableModel.tableNameLowFirstChar}Dao.batchModifyStatus(${pkColumnModel.columnName}s,status);
    }
        </#if>
    </#list>
}