<?xml version="1.0" encoding="UTF-8" ?>
<#noparse><!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" ></#noparse>
<mapper namespace="${daoPackage}.${tableModel.tableName}Dao">
    <!--表名-->
    <sql id="table_name">${tableModel.tableNameDB}</sql>

    <!--插入字段集合-->
    <sql id="Base_Column_List">
        <#list tableModel.columnModelList as columnModel>
        ${columnModel.columnDBName}<#if columnModel_has_next>, </#if>
        </#list>
    </sql>
    <!--查询字段集合-->
    <sql id="Base_Column_List_AsType">
        <#list tableModel.columnModelList as columnModel>
        ${columnModel.columnDBName} as ${columnModel.columnName}<#if columnModel_has_next>, </#if>
        </#list>
    </sql>

    <!-- 增加一个实体 -->
    <insert id="insert" parameterType="${modelPackage}.${tableModel.tableName}">
        <!-- 针对mysql使用-->
        <#if config.dbType=="mysql">
        <selectKey keyProperty="${pkColumnModel.columnName}" order="AFTER" resultType="${pkColumnModel.columnType}">
            select LAST_INSERT_ID()
        </selectKey>
        <#elseif config.dbType=="oracle">
        <selectKey keyProperty="${pkColumnModel.columnName}" order="BEFORE" resultType="${pkColumnModel.columnType}">
            <!-- oracle要自己创建序列，后续完成 -->
        </selectKey>
        </#if>
        insert into <include refid="table_name" />
        <trim prefix="(" suffix=")" suffixOverrides=",">
        <#list tableModel.columnModelList as columnModel>
            <#if columnModel.isPrimaryKey>
            <#else>
            <if test="${columnModel.columnName} != null">
                ${columnModel.columnDBName}<#if columnModel_has_next>,<#else></#if>
            </if>
            </#if>
        </#list>
        </trim>
        values
        <trim prefix="(" suffix=")" suffixOverrides=",">
        <#list tableModel.columnModelList as columnModel>
            <#if columnModel.isPrimaryKey>
            <#else>
            <if test="${columnModel.columnName} != null">
                <#noparse>#{</#noparse>${columnModel.columnName}<#noparse>}</#noparse>,<#--<#if columnModel_has_next>,<#else></#if>-->
            </if>
            </#if>
        </#list>
        </trim>
    </insert>

    <!-- 根据主键删除一个实体 -->
    <delete id="delete" parameterType="${pkColumnModel.columnType}">
        delete from <include refid="table_name" />
        where ${pkColumnModel.columnDBName} = ${"#"}{${pkColumnModel.columnName}}
    </delete>

    <!-- 更新一个实体 -->
    <update id="update" parameterType="${modelPackage}.${tableModel.tableName}">
        update <include refid="table_name" />
        set
        <trim suffixOverrides=",">
        <#list tableModel.columnModelList as columnModel>
            <#if columnModel.isPrimaryKey>
            <#else>
        <if test="${columnModel.columnName} != null">
            ${columnModel.columnDBName} = ${"#"}{${columnModel.columnName}},W<#--<#if columnModel_has_next>,</#if>-->
        </if>
            </#if>
        </#list>
        </trim>
        where ${pkColumnModel.columnDBName} = ${"#"}{${pkColumnModel.columnName}}
    </update>

    <!-- 根据主键查询一个实体 -->
    <select id="queryOne" parameterType="${pkColumnModel.columnType}"  resultType="${modelPackage}.${tableModel.tableName}">
        select
        <include refid="Base_Column_List_AsType" />
        from <include refid="table_name" />
        where ${pkColumnModel.columnDBName} = ${"#"}{${pkColumnModel.columnName}}
    </select>

    <!-- 查询全部 -->
    <select id="queryAll" resultType="${modelPackage}.${tableModel.tableName}">
        select
        <include refid="Base_Column_List_AsType" />
        from <include refid="table_name" />
        where is_valid = '1'
    </select>

    <!-- 根据字段查询 带分页 -->
    <select id="queryByFieldsAndPage" resultType="${modelPackage}.${tableModel.tableName}">
        select
        <include refid="Base_Column_List_AsType" />
        from <include refid="table_name" />
        where is_valid = '1'
        <#list tableModel.columnModelList as columnModel>
        <if test="${columnModel.columnName} != null">
            and ${columnModel.columnDBName} = ${"#"}{${columnModel.columnName}}
        </if>
        </#list>
        <if test="${tableModel.tableName} != null">
            limit ${"#"}{pageBean.begin} , ${"#"}{pageBean.pageSize}
        </if>
    </select>

    <!-- 批量删除（逻辑删除） -->
    <update id="batchRemove">
        update <include refid="table_name"></include>
        set
        <trim suffixOverrides=",">
            is_valid = 0,
            update_date = now(),
        </trim>
        where ${pkColumnModel.columnDBName} in
        <foreach collection="${pkColumnModel.columnName}s" item="${pkColumnModel.columnName}" open="(" close=")" separator=",">
        <#noparse>#{</#noparse>${pkColumnModel.columnName}<#noparse>}</#noparse>
        </foreach>
    </update>

    <#list tableModel.columnModelList as columnModel>
        <#if columnModel.columnName?contains("status")>
    <!-- 批量修改状态 -->
    <update id="batchModifyStatus">
        update <include refid="table_name"></include>
        set
        <trim suffixOverrides=",">
            <if test="status != null">
                status = <#noparse>#{status},</#noparse>
            </if>
            update_date = now(),
        </trim>
        where ${pkColumnModel.columnDBName} in
        <foreach collection="${pkColumnModel.columnName}s" item="${pkColumnModel.columnName}" open="(" close=")" separator=",">
        <#noparse>#{</#noparse>${pkColumnModel.columnName}<#noparse>}</#noparse>
        </foreach>
    </update>
        </#if>
    </#list>
</mapper>

