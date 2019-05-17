<#noparse><%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>修改页面</title>
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
<form class="layui-form" id="</#noparse>edit${tableModel.tableName}Form<#noparse>" style="width:80%;"></#noparse>
<#list tableModel.columnModelList as columnModel>
    <#if excludeList?seq_contains(columnModel.columnName)>
    <#else>
    <#if columnModel.isPrimaryKey>
    <#noparse><input type="text" hidden="hidden" name="</#noparse>${columnModel.columnName}<#noparse>" value="${</#noparse>${tableModel.tableNameLowFirstChar}.${columnModel.columnName}<#noparse>}"/></#noparse>
    <#else>
    <div class="layui-form-item layui-row layui-col-xs12">
        <label class="layui-form-label">${columnModel.columnComment}</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="${columnModel.columnName}" value="<#noparse>${</#noparse>${tableModel.tableNameLowFirstChar}.${columnModel.columnName}<#noparse>}</#noparse>"  lay-verify="${columnModel.columnName}" placeholder="请输入${columnModel.columnComment}">
        </div>
    </div>
    </#if>
    </#if>
</#list>

<#noparse>
    <div class="layui-form-item layui-row layui-col-xs12">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit="" lay-filter="</#noparse>edit${tableModel.tableName}<#noparse>">立即修改</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/commonTool.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/modules/</#noparse>${tableModel.tableName ? lower_case}/${tableModel.tableNameLowFirstChar}_edit.js<#noparse>"></script>
</body>
</html></#noparse>