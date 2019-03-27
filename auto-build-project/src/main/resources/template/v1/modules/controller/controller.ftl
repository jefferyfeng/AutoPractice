package ${controllerPackage};

import ${config.groupId}.core.base.BaseResult;
import ${config.groupId}.core.util.ResultUtil;
import ${config.groupId}.core.constants.Constants;
import ${config.groupId}.core.constants.ResultConstants;
import ${modelPackage}.${tableModel.tableName};
import ${servicePackage}.${tableModel.tableName}Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    @RequestMapping(value="/add", produces = MediaType.APPLICATION_JSON_UTF8_VALUE, method=RequestMethod.POST)
    public BaseResult add(${tableModel.tableName} ${tableModel.tableNameLowFirstChar}){
        ${tableModel.tableNameLowFirstChar}Service.add(${tableModel.tableNameLowFirstChar});
        return ResultUtil.result(ResultConstants.SUCCESS);
    }

    /**
     * 删除${tableModel.tableName} (物理删除)
     * @param ${pkColumnModel.columnName}
     */
    /*
    @RequestMapping(value="/delete", produces = MediaType.APPLICATION_JSON_UTF8_VALUE, method=RequestMethod.POST)
    public BaseResult delete(${pkColumnModel.columnType} ${pkColumnModel.columnName}){
        ${tableModel.tableNameLowFirstChar}Service.delete(${pkColumnModel.columnName});
        return ResultUtil.result(ResultConstants.SUCCESS);
    }
    */

    /**
     * 删除${tableModel.tableName} (逻辑删除)
     * @param ${pkColumnModel.columnName}
     */
    @RequestMapping(value="/remove", produces = MediaType.APPLICATION_JSON_UTF8_VALUE, method=RequestMethod.POST)
    public BaseResult remove(${pkColumnModel.columnType} ${pkColumnModel.columnName}){
        ${tableModel.tableNameLowFirstChar}Service.remove(${pkColumnModel.columnName});
        return ResultUtil.result(ResultConstants.SUCCESS);
    }

    /**
     * 修改${tableModel.tableName}
     * @param ${tableModel.tableNameLowFirstChar}
     */
    @RequestMapping(value="/modify", produces = MediaType.APPLICATION_JSON_UTF8_VALUE, method=RequestMethod.POST)
    public BaseResult modify(${tableModel.tableName} ${tableModel.tableNameLowFirstChar}){
        ${tableModel.tableNameLowFirstChar}Service.modify(${tableModel.tableNameLowFirstChar});
        return ResultUtil.result(ResultConstants.SUCCESS);
    }

    /**
     * 查询单个${tableModel.tableName}
     * @param ${pkColumnModel.columnName}
     */
    @RequestMapping(value="/queryOne/{${pkColumnModel.columnName}}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE, method=RequestMethod.GET)
    public BaseResult queryOne(@PathVariable(value="${pkColumnModel.columnName}")${pkColumnModel.columnType} ${pkColumnModel.columnName}){
        Map<String,Object> bodyMap = new HashMap<String,Object>();
        ${tableModel.tableName} ${tableModel.tableNameLowFirstChar} = ${tableModel.tableNameLowFirstChar}Service.queryOne(${pkColumnModel.columnName});
        bodyMap.put("${tableModel.tableNameLowFirstChar}",${tableModel.tableNameLowFirstChar});
        return ResultUtil.result(ResultConstants.SUCCESS,bodyMap);
    }

    /**
     * 查全部${tableModel.tableName}
     */
    @RequestMapping(value="/queryAll", produces = MediaType.APPLICATION_JSON_UTF8_VALUE, method=RequestMethod.GET)
    public BaseResult queryAll(){
        Map<String,Object> bodyMap = new HashMap<String,Object>();
        List<${tableModel.tableName}> ${tableModel.tableNameLowFirstChar}s = ${tableModel.tableNameLowFirstChar}Service.queryAll();
        bodyMap.put("${tableModel.tableNameLowFirstChar}s",${tableModel.tableNameLowFirstChar}s);
        return ResultUtil.result(ResultConstants.SUCCESS,bodyMap);
    }

    /**
     * 根据字段查询（如需分页请setPageBean）
     * @param ${tableModel.tableNameLowFirstChar}
     */
    @RequestMapping(value="/queryByFieldsAndPage", produces = MediaType.APPLICATION_JSON_UTF8_VALUE, method=RequestMethod.GET)
    public BaseResult queryByFieldsAndPage(${tableModel.tableName} ${tableModel.tableNameLowFirstChar}){
        Map<String,Object> bodyMap = new HashMap<String,Object>();
        List<${tableModel.tableName}> ${tableModel.tableNameLowFirstChar}s = ${tableModel.tableNameLowFirstChar}Service.queryByFieldsAndPage(${tableModel.tableNameLowFirstChar});
        bodyMap.put("${tableModel.tableNameLowFirstChar}s",${tableModel.tableNameLowFirstChar}s);
        bodyMap.put("pageBean",${tableModel.tableNameLowFirstChar}.getPageBean());
        return ResultUtil.result(ResultConstants.SUCCESS,bodyMap);
    }

    /**
     * 批量删除
     * @param ${pkColumnModel.columnName}s
     */
    @RequestMapping(value="/batchRemove", produces = MediaType.APPLICATION_JSON_UTF8_VALUE, method=RequestMethod.POST)
    public BaseResult batchRemove(@RequestParam("${pkColumnModel.columnName}s[]") Long[] ${pkColumnModel.columnName}s){
        ${tableModel.tableNameLowFirstChar}Service.batchRemove(${pkColumnModel.columnName}s);
        return ResultUtil.result(ResultConstants.SUCCESS);
    }

    <#list tableModel.columnModelList as columnModel>
        <#if columnModel.columnName?contains("status")>
    /**
     * 批量状态修改
     * @return
     */
    @RequestMapping(value="/batchModifyStatus", produces = MediaType.APPLICATION_JSON_UTF8_VALUE, method=RequestMethod.POST)
    public BaseResult batchModifyStatus(@RequestParam("${pkColumnModel.columnName}s[]") Long[] ${pkColumnModel.columnName}s,@RequestParam(value = "status",required = true)Integer status){
        ${tableModel.tableNameLowFirstChar}Service.batchModifyStatus(${pkColumnModel.columnName}s,status);
        return ResultUtil.result(ResultConstants.SUCCESS);
    }
        </#if>
    </#list>

}