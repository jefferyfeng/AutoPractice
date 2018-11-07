package ${controllerPackage};

import ${modelPackage}.${tableModel.tableName};
import ${servicePackage}.${tableModel.tableName}Service;
import java.util.List;

/**
 *  ${tableModel.tableName}Controller  <#if tableModel.comment??>${tableModel.comment}控制器</#if>
 *
 *  @author fdh
 */
@RequestMapping("/permission")
@RestController
public class ${tableModel.tableName}Controller {
    @Autowried
    private ${tableModel.tableName}Service ${tableModel.tableNameLowFirstChar}Service;
    /**
     * 新增${tableModel.tableName}
     * @param ${tableModel.tableNameLowFirstChar}
     */
    @RequestMapping(value="/add",method=RequestMethod.POST)
    void add(${tableModel.tableName} ${tableModel.tableNameLowFirstChar}){
        ${tableModel.tableNameLowFirstChar}Service.add(${tableModel.tableNameLowFirstChar});
    }

    /**
     * 删除${tableModel.tableName}
     * @param ${pkColumnModel.columnName}
     */
    @RequestMapping(value="/remove/{${pkColumnModel.columnName}}",method=RequestMethod.DELETE)
    void remove((@PathVariable(value="${pkColumnModel.columnName}")${pkColumnModel.columnType} ${pkColumnModel.columnName}){
        ${tableModel.tableNameLowFirstChar}Service.remove(${pkColumnModel.columnName});
    }

    /**
     * 修改${tableModel.tableName}
     * @param ${tableModel.tableNameLowFirstChar}
     */
    @RequestMapping(value="/modify/{${pkColumnModel.columnName}}",method=RequestMethod.PUT)
    void modify(${tableModel.tableName} ${tableModel.tableNameLowFirstChar}){
        ${tableModel.tableNameLowFirstChar}Service.update(${pkColumnModel.columnName});
    }

    /**
     * 查询单个${tableModel.tableName}
     * @param ${pkColumnModel.columnName}
     * @return ${tableModel.tableNameLowFirstChar}
     */
    @RequestMapping(value="/queryOne/{${pkColumnModel.columnName}}",method=RequestMethod.GET)
    ${tableModel.tableName} queryOne(@PathVariable(value="${pkColumnModel.columnName}")${pkColumnModel.columnType} ${pkColumnModel.columnName}){
        return ${tableModel.tableNameLowFirstChar}Service.queryOne(${pkColumnModel.columnName});
    }

    /**
     * 查全部${tableModel.tableName}
     * @return ${tableModel.tableNameLowFirstChar}s
     */
    @RequestMapping(value="/queryAll}",method=RequestMethod.GET)
    List<${tableModel.tableName}> queryAll(){
        return ${tableModel.tableNameLowFirstChar}Service.queryAll();
    }

    /**
     * 根据字段查询（如需分页请setPageParameter）
     * @param ${tableModel.tableNameLowFirstChar}
     * @return ${tableModel.tableNameLowFirstChar}s
     */
    @RequestMapping(value="/queryByFieldsAndPage}",method=RequestMethod.GET)
    List<${tableModel.tableName}> queryByFieldsAndPage(${tableModel.tableName} ${tableModel.tableNameLowFirstChar}){
        return ${tableModel.tableNameLowFirstChar}Service.queryByFieldsAndPage(${tableModel.tableNameLowFirstChar});
    }
}