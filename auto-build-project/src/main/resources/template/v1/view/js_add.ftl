//获取隐藏域的值
var contextPath = document.getElementById('contextPath').value;

layui.use(['form','layer','jquery'],function(){
    var form = layui.form
        layer = parent.layer === undefined ? layui.layer : top.layer,
        $ = layui.jquery;

    //自定义验证规则
    form.verify({

    });

    //提交添加
    form.on("submit(add${tableModel.tableName})",function(data){
        $.ajax({
            type : 'post',
            url : contextPath + '/${tableModel.tableNameLowFirstChar}/add',
            async : false,
            data : data.field,
            dataType : 'json',
            success : function (result) {
                if(result.code === 1 || result.code === '1'){
                    layer.msg('添加成功！',{
                        icon : 6,
                        time: 2000
                    },function () {
                        //关闭当前iframe
                        var index = parent.layer.getFrameIndex(window.name);
                        window.parent.searchReload();
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