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
        ${tableModel.tableNameLowFirstChar}.setCreateDate(new Date());
        ${tableModel.tableNameLowFirstChar}.setIsValid(1);
        ${tableModel.tableNameLowFirstChar}Dao.insert(${tableModel.tableNameLowFirstChar});
    }

    /**
     * 根据主键 删除${tableModel.tableName} (逻辑删除)
     * @param ${tableModel.tableNameLowFirstChar}
     */
    @Override
    @Transactional(propagation=Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED,readOnly = false)
    public void remove(${tableModel.tableName} ${tableModel.tableNameLowFirstChar}){
        //${tableModel.tableNameLowFirstChar}Dao.delete(${tableModel.tableNameLowFirstChar}.get${pkColumnModel.columnNameUpFirstChar}());
        ${tableModel.tableNameLowFirstChar}.setIsValid(0);
        ${tableModel.tableNameLowFirstChar}Dao.update(${tableModel.tableNameLowFirstChar});
    }

    /**
     * 修改${tableModel.tableName}
     * @param ${tableModel.tableNameLowFirstChar}
     */
    @Override
    @Transactional(propagation=Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED,readOnly = false)
    public void modify(${tableModel.tableName} ${tableModel.tableNameLowFirstChar}){
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
     * 根据字段查询（如需分页请setPageParameter）
     * @param ${tableModel.tableNameLowFirstChar}
     * @return ${tableModel.tableNameLowFirstChar}s
     */
    @Override
    public List<${tableModel.tableName}> queryByFieldsAndPage(${tableModel.tableName} ${tableModel.tableNameLowFirstChar}){
        return ${tableModel.tableNameLowFirstChar}Dao.queryByFieldsAndPage(${tableModel.tableNameLowFirstChar});
    }
}