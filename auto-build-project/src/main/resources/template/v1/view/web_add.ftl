<#noparse><%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>添加页面</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/public.css" media="all" />
</head>

<!-- 页面隐藏域 -->
<input id="contextPath" type="hidden" value="${pageContext.request.contextPath}" />

<body class="childrenBody">
<form class="layui-form" id="</#noparse>add${tableModel.tableName}Form<#noparse>" style="width:80%;"></#noparse>
<#list tableModel.columnModelList as columnModel>
    <#if excludeList?seq_contains(columnModel.columnName)>
    <#else>
    <#if columnModel.isPrimaryKey>
    <#else>
    <div class="layui-form-item layui-row layui-col-xs12">
        <label class="layui-form-label">${columnModel.columnComment}</label>
        <div class="layui-input-block">
        <#if columnModel.columnName?contains("status")>
            <select name="${columnModel.columnName}" >
                <option value="" selected="selected">请选择状态</option>
                <option value="0">禁用</option>
                <option value="1">启用</option>
            </select>
        <#else>
            <input type="text" class="layui-input" name="${columnModel.columnName}" lay-verify="${columnModel.columnName}" placeholder="请输入${columnModel.columnComment}" <#if columnModel.columnType == "java.util.Date">id="${columnModel.columnName}" readonly</#if> />
        </#if>
        </div>
    </div>
    </#if>
    </#if>
</#list>

<#noparse>
    <div class="layui-form-item layui-row layui-col-xs12">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit="" lay-filter="</#noparse>add${tableModel.tableName}<#noparse>">立即添加</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/commonTool.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/modules/</#noparse>${tableModel.tableName ? lower_case}/${tableModel.tableNameLowFirstChar}_add.js<#noparse>"></script>
</body>
</html></#noparse>