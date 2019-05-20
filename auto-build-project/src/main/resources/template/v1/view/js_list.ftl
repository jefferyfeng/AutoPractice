//获取隐藏域的值
var contextPath = document.getElementById('contextPath').value;

var _tool = null;

layui.use(['form','layer','table','laytpl','laydate'],function(){
    var form = layui.form,
        layer = parent.layer === undefined ? layui.layer : top.layer,
        $ = layui.jquery,
        laytpl = layui.laytpl,
        laydate = layui.laydate,
        table = layui.table;

    var index = layer.load(1);

    <#list tableModel.columnModelList as columnModel>
    <#if excludeList?seq_contains(columnModel.columnName)>
    <#else>
    <#if columnModel.columnType == "java.util.Date">
    //初始化时间控件
    var ${columnModel.columnName} = laydate.render({
        elem: '#${columnModel.columnName}', //指定元素
        type: 'datetime',
        format : 'yyyy-MM-dd HH:mm:ss'
    });
    </#if>
    </#if>
    </#list>

    //渲染数据表格${tableModel.comment}列表
    var tableIns = table.render({
        elem: '#${tableModel.tableNameLowFirstChar}List',
        url : contextPath + '/${tableModel.tableNameLowFirstChar}/list${tableModel.tableName}s',
        cellMinWidth : 150,
        page : true,
        /*height : "full-200",*/
        limits : [10,15,20,25],
        limit : 15,
        id : '${tableModel.tableNameLowFirstChar}ListTable',
        method : 'get',
        request : {
            pageName : 'currentPage',
            limitName : 'pageSize'
        },
        response: {
            statusCode: 1 //重新规定成功的状态码为 1，table 组件默认为 0
        },
        done : function () {
            layer.close(index);
        },
        cols : [[
            {type: "checkbox", fixed:"left", width:50},
            <#list tableModel.columnModelList as columnModel>
            <#if excludeList?seq_contains(columnModel.columnName)>
            <#else>
            {field: '${columnModel.columnName}', title: '${columnModel.columnComment}', width:200, align:"center", <#if columnModel.columnName?contains("status")>templet:function(data){ return formatStatus(data.status); }</#if>},
            </#if>
            </#list>
            {title: '操作', width:220, fixed:"right", templet:'#${tableModel.tableNameLowFirstChar}ListBar',align:"center"}
        ]]
    });

    //顶部查询
    form.on('submit(searchBtn)', function(data){
        var index = layer.load(1);
        //重新渲染数据表格
        table.reload("${tableModel.tableNameLowFirstChar}ListTable",{
            page: {
                curr : 1 //layui此处有点bug 前一步已经把curr改为currentPage了，但此处仍为curr
            },
            where: data.field,
            done : function () {
                layer.close(index);
            }
        });
        //禁止表单提交
        return false;
    });

    //toolbar事件
    table.on('tool(${tableModel.tableNameLowFirstChar}List)',function (obj) {
        var event = obj.event;
        var data = obj.data;
        if(event === 'edit'){//修改按钮
            layerBox({
                title : '修改${tableModel.comment}',
                url : contextPath + "/${tableModel.tableNameLowFirstChar}/toEdit${tableModel.tableName}?${pkColumnModel.columnName}="+data.${pkColumnModel.columnName}
            });
        }else if(event === 'delete'){//删除按钮
            layer.confirm('你确定删除吗?', {icon: 3, title:'提示'}, function(index){
                var loading = layer.load(1);
                $.ajax({
                    type : 'post',
                    url : contextPath + '/${tableModel.tableNameLowFirstChar}/remove',
                    data : {
                        "${pkColumnModel.columnName}": data.${pkColumnModel.columnName}
                    },
                    dataType : 'json',
                    success : function (result) {
                        if(resSuccess(result.code)){
                            layer.close(loading);
                            layer.close(index);
                            //重新渲染数据表格
                            reloadTable(1);

                            succMsg('删除成功！');
                        }else{
                            layer.close(loading);
                            layer.close(index);
                            failMsg();
                        }
                    },
                    error : function () {
                        layer.close(loading);
                        layer.close(index);
                        failMsg();
                    }
                })
            });
        }else if(event === 'other'){//其他按钮
            layer.msg("无其他事件~~~");
        }
    });

    //添加${tableModel.comment}
    $('#btn_add').on('click',function () {
        layerBox({
            title : '添加${tableModel.comment}',
            url : contextPath + "/${tableModel.tableNameLowFirstChar}/toAdd${tableModel.tableName}"
        })
    });


    <#list tableModel.columnModelList as columnModel>
        <#if columnModel.columnName?contains("status")>
    //批量启用
    $('#btn_start_all').on('click',function () {
        //获取选中行数据
        var datas = table.checkStatus('${tableModel.tableNameLowFirstChar}ListTable').data;
        if(datas.length <= 0){
            warnMsg('请先选择数据！');
        }else{
            layer.confirm('你确定启用选中的数据吗?', {icon: 3, title:'提示'}, function(index){
                var loading = layer.load(1);
                var ${pkColumnModel.columnName}s = "";
                datas.forEach(function (data) {
                    ${pkColumnModel.columnName}s = ${pkColumnModel.columnName}s + data.${pkColumnModel.columnName} + ','
                });
                ${pkColumnModel.columnName}s = ${pkColumnModel.columnName}s.substring(0,${pkColumnModel.columnName}s.length-1);

                $.ajax({
                    type : 'post',
                    url : contextPath + '/${tableModel.tableNameLowFirstChar}/batchModifyStatus',
                    data : {
                        "${pkColumnModel.columnName}s[]": ${pkColumnModel.columnName}s,
                        status : 1
                    },
                    dataType : 'json',
                    success : function (result) {
                        layer.close(index);
                        //关闭loading
                        layer.close(loading);
                        //重新渲染数据表格
                        reloadTable();
                        if(resSuccess(result.code)){
                            succMsg('批量启用成功！');
                        }else{
                            failMsg();
                        }
                    },
                    error : function () {
                        //关闭loading
                        layer.close(index);
                        layer.close(loading);
                        failMsg();
                    }
                })
            });
        }
    });

    //批量禁用
    $('#btn_stop_all').on('click',function () {
        //获取选中行数据
        var datas = table.checkStatus('${tableModel.tableNameLowFirstChar}ListTable').data;
        if(datas.length <= 0){
            warnMsg('请先选择数据！');
        }else{
            layer.confirm('你确定禁用选中的数据吗?', {icon: 3, title:'提示'}, function(index){
                var loading = layer.load(1);
                var ${pkColumnModel.columnName}s = "";
                datas.forEach(function (data) {
                    ${pkColumnModel.columnName}s = ${pkColumnModel.columnName}s + data.${pkColumnModel.columnName} + ','
                });
                ${pkColumnModel.columnName}s = ${pkColumnModel.columnName}s.substring(0,${pkColumnModel.columnName}s.length-1);

                $.ajax({
                    type : 'post',
                    url : contextPath + '/${tableModel.tableNameLowFirstChar}/batchModifyStatus',
                    data : {
                        "${pkColumnModel.columnName}s[]": ${pkColumnModel.columnName}s,
                        status : 0
                    },
                    dataType : 'json',
                    success : function (result) {
                        layer.close(index);
                        //关闭loading
                        layer.close(loading);
                        //重新渲染数据表格
                        reloadTable();
                        if(resSuccess(result.code)){
                            succMsg('批量禁用成功！');
                        }else{
                            failMsg();
                        }
                    },
                    error : function () {
                        //关闭loading
                        layer.close(index);
                        layer.close(loading);
                        failMsg();
                    }
                })
            });
        }
    });
        </#if>
    </#list>

    //批量删除
    $('#btn_delete_all').on('click',function () {
        var datas = table.checkStatus('${tableModel.tableNameLowFirstChar}ListTable').data;
        if(datas.length <= 0){
            warnMsg('请先选择数据！');
        }else{
            layer.confirm('你确定删除选中的数据吗?', {icon: 3, title:'提示'}, function(index){
                var loading = layer.load(1);
                var ${pkColumnModel.columnName}s = "";
                datas.forEach(function (data) {
                    ${pkColumnModel.columnName}s = ${pkColumnModel.columnName}s + data.${pkColumnModel.columnName} + ','
                });
                ${pkColumnModel.columnName}s = ${pkColumnModel.columnName}s.substring(0,${pkColumnModel.columnName}s.length-1);

                $.ajax({
                    type : 'post',
                    url : contextPath + '/${tableModel.tableNameLowFirstChar}/batchRemove',
                    data : {
                        "${pkColumnModel.columnName}s[]": ${pkColumnModel.columnName}s
                    },
                    dataType : 'json',
                    success : function (result) {
                        if(resSuccess(result.code)){
                            layer.close(loading);
                            layer.close(index);
                            //重新渲染数据表格
                            reloadTable(1);

                            succMsg('批量删除成功！');
                        }else{
                            layer.close(loading);
                            layer.close(index);
                            failMsg();
                        }
                    },
                    error : function () {
                        layer.close(loading);
                        layer.close(index);
                        failMsg();
                    }
                })
            });
        }
    });

    //其他${tableModel.comment}
    $('#btn_other_all').on('click',function () {
        layer.msg("其他");
    });
    
    //刷新数据表格
    function reloadTable(currentPage) {
        var searchForm  = $('#searchForm').serializeArray();

        //重新渲染数据表格
        if(currentPage != null){
            table.reload("${tableModel.tableNameLowFirstChar}ListTable",{
                page: {
                    currentPage : currentPage
                },
                where: {
                    <#assign currentIndex = 0>
                    <#list tableModel.columnModelList as columnModel>
                    <#if excludeList?seq_contains(columnModel.columnName)>
                    <#else>
                    ${columnModel.columnName} : searchForm[${currentIndex}].value,
                    <#assign currentIndex = currentIndex+1>
                    </#if>
                    </#list>
                    time : new Date().getTime()
                },
                done : function () {
                    layer.close(index);
                }
            });
        }else{
            table.reload("${tableModel.tableNameLowFirstChar}ListTable",{
                where: {
                    <#assign currentIndex = 0>
                    <#list tableModel.columnModelList as columnModel>
                    <#if excludeList?seq_contains(columnModel.columnName)>
                    <#else>
                    ${columnModel.columnName} : searchForm[${currentIndex}].value,
                    <#assign currentIndex = currentIndex+1>
                    </#if>
                    </#list>
                    time : new Date().getTime()
                },
                done : function () {
                    layer.close(index);
                }
            });
        }
    }

    //用于子iframe刷新数据表格
    window.searchReload = function (currentPage) {
        reloadTable(currentPage);
    }
});
