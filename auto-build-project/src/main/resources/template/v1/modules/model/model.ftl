package ${modelPackage};

import com.fasterxml.jackson.annotation.JsonFormat;
import ${basePackage}.BasePojo;
import org.springframework.format.annotation.DateTimeFormat;

/**
 *  ${tableModel.tableName}  <#if tableModel.comment??>${tableModel.comment}</#if>
 *
 *  @author fdh
 */
public class ${tableModel.tableName} extends BasePojo{
<#list tableModel.columnModelList as columnModel>
    <#if columnModel.columnComment??>
    /**${columnModel.columnComment}*/
    </#if>
    <#if columnModel.columnType=="java.util.Date">
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")//前端To后端
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")//后端To前端
    private ${columnModel.columnType} ${columnModel.columnName};
    <#else>
    private ${columnModel.columnType} ${columnModel.columnName};
    </#if>
</#list>

<#--get and set-->
<#list tableModel.columnModelList as columnModel>
    public ${columnModel.columnType} get${columnModel.columnNameUpFirstChar}() {
        return ${columnModel.columnName};
    }

    public void set${columnModel.columnNameUpFirstChar}(${columnModel.columnType} ${columnModel.columnName}) {
        this.${columnModel.columnName} = ${columnModel.columnName};
    }

</#list>
}