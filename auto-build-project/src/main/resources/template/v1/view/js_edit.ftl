//获取隐藏域的值
var contextPath = document.getElementById('contextPath').value;

layui.use(['form','layer','jquery','laydate'],function(){
    var form = layui.form
        layer = parent.layer === undefined ? layui.layer : top.layer,
        laydate = layui.laydate,
        $ = layui.jquery;

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

    //自定义验证规则
    form.verify({
    });

    //提交修改
    form.on("submit(edit${tableModel.tableName})",function(data){
        $.ajax({
            type : 'POST',
            url : contextPath + '/${tableModel.tableNameLowFirstChar}/modify',
            async : false,
            data : data.field,
            dataType : 'json',
            success : function (result) {
                if(result.code === 1 || result.code === '1'){
                    layer.msg('修改成功！',{
                        icon : 6,
                        time: 2000
                    },function () {

                        parent.searchReload();
                        //关闭当前iframe
                        var index = parent.layer.getFrameIndex(window.name);
                        parent.layer.close(index);
                    });
                }else{
                    layer.msg('网络繁忙，请稍后再试！',{
                        icon : 5,
                        time: 2000
                    },function () {
                        //回调
                    });
                }
            }
        });
        return false;
    });
})