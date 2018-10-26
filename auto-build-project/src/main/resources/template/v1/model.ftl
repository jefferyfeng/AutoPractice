package ${package};

import ${pojoPackage};

/**
 *  ${tableModel.tableName}<#if tableModel.comment??>${tableModel.comment}</#if>
 *
 *  @author fdh
 */
public class ${tableModel.tableName} extends BasePojo{
<#list tableModel.columnModelList as columnModel>
    <#if columnModel.columnComment??>
    /**${columnModel.columnComment}*/
    </#if>
    private ${columnModel.columnType} ${columnModel.columnName};
</#list>

<#--get and set-->
<#list tableModel.columnModelList as columnModel>
    public ${columnModel.columnType} get${columnModel.columnNameUpFirstChar}() {
        return ${columnModel.columnName};
    }

    public void set ${columnModel.columnNameUpFirstChar}(${columnModel.columnType} ${columnModel.columnName}) {
        this.${columnModel.columnName} = ${columnModel.columnName};
    }

</#list>
}