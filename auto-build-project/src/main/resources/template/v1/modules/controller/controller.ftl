package ${controllerPackage};

import ${modelPackage}.${tableModel.tableName};
import ${servicePackage}.${tableModel.tableName}Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 *  ${tableModel.tableName}Controller  <#if tableModel.comment??>${tableModel.comment}控制器</#if>
 *
 *  @author fdh
 */
@RequestMapping("/${tableModel.tableNameLowFirstChar}")
@RestController
public class ${tableModel.tableName}Controller {
    @Autowired
    private ${tableModel.tableName}Service ${tableModel.tableNameLowFirstChar}Service;
    /**
     * 新增${tableModel.tableName}
     * @param ${tableModel.tableNameLowFirstChar}
     */
    @RequestMapping(value="/add",method=RequestMethod.POST)
    public void add(${tableModel.tableName} ${tableModel.tableNameLowFirstChar}){
        ${tableModel.tableNameLowFirstChar}Service.add(${tableModel.tableNameLowFirstChar});
    }

    /**
     * 删除${tableModel.tableName}
     * @param ${tableModel.tableNameLowFirstChar}
     */
    @RequestMapping(value="/remove",method=RequestMethod.DELETE)
    public void remove(${tableModel.tableName} ${tableModel.tableNameLowFirstChar}){
        ${tableModel.tableNameLowFirstChar}Service.remove(${tableModel.tableNameLowFirstChar});
    }

    /**
     * 修改${tableModel.tableName}
     * @param ${tableModel.tableNameLowFirstChar}
     */
    @RequestMapping(value="/modify",method=RequestMethod.PUT)
    public void modify(${tableModel.tableName} ${tableModel.tableNameLowFirstChar}){
        ${tableModel.tableNameLowFirstChar}Service.modify(${tableModel.tableNameLowFirstChar});
    }

    /**
     * 查询单个${tableModel.tableName}
     * @param ${pkColumnModel.columnName}
     * @return ${tableModel.tableNameLowFirstChar}
     */
    @RequestMapping(value="/queryOne/{${pkColumnModel.columnName}}",method=RequestMethod.GET)
    public ${tableModel.tableName} queryOne(@PathVariable(value="${pkColumnModel.columnName}")${pkColumnModel.columnType} ${pkColumnModel.columnName}){
        return ${tableModel.tableNameLowFirstChar}Service.queryOne(${pkColumnModel.columnName});
    }

    /**
     * 查全部${tableModel.tableName}
     * @return ${tableModel.tableNameLowFirstChar}s
     */
    @RequestMapping(value="/queryAll",method=RequestMethod.GET)
    public List<${tableModel.tableName}> queryAll(){
        return ${tableModel.tableNameLowFirstChar}Service.queryAll();
    }

    /**
     * 根据字段查询（如需分页请setPageBean）
     * @param ${tableModel.tableNameLowFirstChar}
     * @return ${tableModel.tableNameLowFirstChar}s
     */
    @RequestMapping(value="/queryByFieldsAndPage",method=RequestMethod.GET)
    public List<${tableModel.tableName}> queryByFieldsAndPage(${tableModel.tableName} ${tableModel.tableNameLowFirstChar}){
        return ${tableModel.tableNameLowFirstChar}Service.queryByFieldsAndPage(${tableModel.tableNameLowFirstChar});
    }
}