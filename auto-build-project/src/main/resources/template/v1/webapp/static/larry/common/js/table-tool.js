/**
 * Created by lishuang on 2017/2/27 .
 */
(function ($) {
    $.rbc = function (options) {
        var defaults = {
            searchForm: "#searchForm", // 搜索表单
            searchBtn: "#searchBtn", // 搜索按钮
            searchResetBtn : "#searchResetBtn", // 搜索重置
            targetTable: null, // 表格ID
            checkAll : "#checkAll", // 表头中的checkbox
            tableColumns : [],
            tableDataUrl : null,
            dataTableObj : null,
            tableHeaderOpers : null,
            checkMaxItem :null
        };
        options = $.extend({}, defaults, options);
        var getCheckArray = function() {
            var tempArray = new Array();
            $("input:checkbox:checked", options.dataTableObj.fnGetNodes()).each(function(i){
                tempArray[i] = $(this).val();
            });
            return tempArray;
        };
        var reloadTable = function() {
            options.dataTableObj.fnClearTable(0);
            options.dataTableObj.fnDraw();
        };

        options.dataTableObj = $(options.targetTable).dataTable({
            "bProcessing" : true,
            "bServerSide" : true,
            "sServerMethod" : 'post',
            "bPaginate" : true,
            "bSort" : true,
            "bFilter" : false,
            "bJQueryUI" : false,
            "sPaginationType" : "full_numbers",
            "sDom" : 'rt <"dongao_page"flpi>',
            "iDisplayLength" : 10,
            "aaData" : "list",
            "aLengthMenu" : [ [ 10, 50, 100], [ 10, 50, 100 ] ],
            "aoColumns" : options.tableColumns,
            "sAjaxSource" : options.tableDataUrl + "?" + $(options.searchForm).serialize(),
            "fnDrawCallback":function(){
                JXJY.dataTableCallback();
            },
            "oLanguage" : {
                "sLengthMenu" : "每页 _MENU_ 条",
                "sZeroRecords" : "",
                "sInfo" : "当前从 _START_ 到 _END_ 条,共 _TOTAL_ 条记录",
                "sInfoEmpty" : "没有找到记录",
                "oPaginate" : {
                    "sFirst" : "首页",
                    "sPrevious" : "上一页",
                    "sNext" : "下一页",
                    "sLast" : "尾页"
                }
            }
        });
        $(options.checkAll).live('click', function() {
           // debugger;
            $(".chk_list", options.dataTableObj.fnGetNodes()).prop("checked", $(this).prop("checked"));
        });

        $(options.searchBtn).click(function() {
            var oSettings = options.dataTableObj.fnSettings();
            oSettings._iDisplayStart = 0;
            oSettings.sAjaxSource = options.tableDataUrl + "?" + $(options.searchForm).serialize();
            options.dataTableObj.fnPageChange("first", true);
        });
        $(options.searchResetBtn).click(function(){
            $(options.searchForm)[0].reset();
            $('.chosen').val('').trigger('chosen:updated');
        });
    };
})(jQuery);

    // 表格选中
/*$('#dateTable tbody').live('click', 'tr input[type="checkbox"]', function () {
    var obj = $(this).parent().parent();
    if (this.checked) {
        obj.addClass('selected');
    } else {
        obj.removeClass('selected');
    }
});


// 全选和反选
$('#dateTable thead').on('click', 'tr input[type="checkbox"]', function () {
    var obj = $("#dateTable tbody input[type='checkbox']:checkbox");
    var allTr = $("#dateTable tbody tr");
    if (this.checked) {
        obj.prop("checked", true);
        allTr.addClass('selected');
    } else {
        obj.prop("checked", false);
        allTr.removeClass('selected');
    }
});*/

//弹出层  用于新增 和 修改等页面操作
function layerBox(title, url, id, w, h) {
    if(title == null || title == '') {
        title = false;
    };
    if(w == null || w == '') {
        w = 800;
    };

    h =  Math.min($(window).height() - 60,~~h);

    var index_ = layer.open({
        type: 2,
        area: [w + 'px', h + 'px'],
        fix: false,
        maxmin: true,
        title: title,
        content: url
    });
    return index_;
};

// 批量操作公共方法   optAll(ids,status,请求url,跳转url,操作名称)
function optAll(params,url,optName){
        layer.confirm('确认'+optName+'选中数据?', {
            title: optName,
            btn: ['确认', '取消'] // 可以无限个按钮
        }, function(index, layero){
            $.ajax({
                type: 'post',
                url: url,
                dataType: "json",
                data: params,
                success: function (data) {
                    if(data.code == "1"){
                        layer.msg(data.msg,{time:2000},function(){
                            search();
                          /*  parent.layer.close(index);*/
                        })
                    }else{
                        layer.msg(data.msg, function(){
                            search();
                           /* parent.layer.close(index);*/
                        });
                    }
                },
                error: function () {
                    layer.msg(data.msg, function(){
                        search();
                       /* parent.layer.close(index);*/
                    });
                }
            })
        });

}
// 异步提交，通用方法
function ajaxSubmit(url,params,type) {
    //获取当前窗口的索引
    var index = parent.layer.getFrameIndex(window.name);
    $.ajax({
        type: type,
        url: url,
        dataType: "json",
        data: params,
        success: function (data) {
            layuiRemoveLoading();
            if(data.code == "1"){
                layer.msg(data.msg,{time:2000},function(){
                    parent.search();
                    parent.layer.close(index);
                })
            }else{
                layer.msg(data.msg, function(){
                   /* parent.search();
                    parent.layer.close(index);*/
                });
            }
        },
        error: function (data) {
            layer.msg(data.msg, function(){
                parent.search();
                parent.layer.close(index);
            });
        }
    });
}

// 转换时间戳为日期时间(时间戳,显示年月日时分,加8小时显示正常时间区)
function UnixToDate(unixTime, isFull, timeZone) {
    if (unixTime == '' || unixTime == null) {
        return '';
    }
    if (typeof (timeZone) == 'number') {
        unixTime = parseInt(unixTime) + parseInt(timeZone) * 60 * 60;
    }
    var time = new Date(unixTime * 1000);
    var ymdhis = "";
    var year, month, date, hours, minutes, seconds;
    if (time.getUTCFullYear() < 10) {
        year = '0' + time.getUTCFullYear();
    } else {
        year = time.getUTCFullYear();
    }
    if ((time.getUTCMonth() + 1) < 10) {
        month = '0' + (time.getUTCMonth() + 1);
    } else {
        month = (time.getUTCMonth() + 1);
    }
    if (time.getUTCDate() < 10) {
        date = '0' + time.getUTCDate();
    } else {
        date = time.getUTCDate();
    }
    ymdhis += year + "-";
    ymdhis += month + "-";
    ymdhis += date;
    if (isFull === true) {
        if (time.getUTCHours() < 10) {
            hours = '0' + time.getUTCHours();
        } else {
            hours = time.getUTCHours();
        }
        if (time.getUTCMinutes() < 10) {
            minutes = '0' + time.getUTCMinutes();
        } else {
            minutes = time.getUTCMinutes();
        }
        if (time.getUTCSeconds() < 10) {
            seconds = '0' + time.getUTCSeconds();
        } else {
            seconds = time.getUTCSeconds();
        }
        ymdhis += " " + hours + ":";
        ymdhis += minutes;
        // ymdhis += seconds;
    }
    return ymdhis;
}

// 批量删除 返回需要的 ids
function getIds(o,str){
    var obj = o.find('tbody tr td:first-child input[type="checkbox"]:checked');
    var list = '';
    obj.each(function(index,elem){
        list += $(elem).attr(str)+',';
    });
    // 去除最后一位逗号
    list = list.substr(0,(list.length-1));
    return list;
}

function genStrYesNo(data) {
    if (data == 0) {
        return "<font color='red'>否</font>";
    } else if (data == 1) {
        return "<font color='green'>是</font>";
    }else{
        return "<font color='#c2c2c2'>--</font>";
    }
}
function genStatus(data){
    if(data == 0){
        return "<font color='#FF5722'>禁用</font>";
    }else if(data == 1){
        return "<font color='#5FB878'>启用</font>";
    }
}

function genExamStatus(data){
	if(data == 0){
		return "未开始";
	}else if(data == 1){
		return "进行中";
	}else if(data == 2){
		return "已结束";
	}else if(data == 3){
		return "收卷失败";
	}else if(data == 4){
		return "已过期";
	}else if(data == 5){
		return "未开始";
	}
}
function studentExamStatus(data){
	if(data == 0){
		return "<font color='#FF5722' >缺考</font>";
	}else if(data == 1){
		return "正常";
	}else if(data == 2){
		return "<font color='#5FB878'>强制提交</font>";
	}
}

function genValid(data){
    if(data == 1){
        return "<font color='#FF5722'>新建</font>";
    }else if(data == 2){
        return "<font color='#5FB878'>激活</font>";
    }else if(data == 3){
        return "<font color='#c2c2c2'>隐藏</font>";
    }
}

function formatDate(value,format){
    if(value){
        var d = new Date();
        d.setTime(value);
        return d.format(format);
    }else{
        return '--';
    }
}

function divNum(exp1, exp2) {  //整除
    var n1 = Math.round(exp1); //四舍五入
    var n2 = Math.round(exp2); //四舍五入

    var rslt = n1 / n2; //除
    if (rslt >= 0) {
        rslt = Math.floor(rslt); //返回小于等于原rslt的最大整数。
    }
    else {
        rslt = Math.ceil(rslt); //返回大于等于原rslt的最小整数。
    }
    return rslt;
}
var index = -1;
function layuiLoading(){
    layui.use(['layer', 'form'], function(){
        //index = layer.load(1, {shade: [0.2, '#393D49']});
        index = layer.msg('正在加载请稍后...',{
            icon:16,
            time: 0,
            shade: [0.2, '#393D49']
        });
    });
}
function layuiRemoveLoading(){
    layui.use(['layer', 'form'], function(){
        var layer = layui.layer;
        layer.close(index);
        //调用close方法,关闭全局变量index对应的加载效果
    });
}
var $$bar = -1;
function layuiLoadingProgressBar (path,title,sessionName) {
    layui.use(['layer', 'form'], function() {
        var layer = layui.layer;
        $$bar = layer.open({
            type: 2,
            title: title,
            shadeClose: false,
            shade: 0.8,
            closeBtn: 0, //不显示关闭按钮
            area: ['380px', '80px'],
            anim: 5,
            content: path + '/login/getProgressBar?sessionName=' + sessionName //iframe的url
        });
    });
    return $$bar;
}
function layuiRemoveParentLoadingProgressBar(){
    layui.use(['layer', 'form'], function(){
        //var layer = layui.layer;
        parent.layer.close(parent.$$bar);
        //调用close方法,关闭全局变量index对应的加载效果
    });
}
function layuiRemoveLoadingProgressBar(){
    layui.use(['layer', 'form'], function(){
        //var layer = layui.layer;
        setTimeout(layer.close($$bar),5000);
        //调用close方法,关闭全局变量index对应的加载效果
    });
}
function getBar(){
    return $$bar;
}
/*
* 下载文件，已post的方式
* */
function downFileAll(url){
    var form = '<form id="downFile" style="display: none" method="post" action="'+ url +'"></form>';
    if (typeof($('body #downFile')[0]) != 'undefined') {
        $('body #downFile').remove();
        $('body').eq(0).append(form);
    } else {
        $('body').eq(0).append(form);
    }
    $('body #downFile').submit();
    //$(form).submit();
}
layui.use(['element','form','layer'], function(){
    var $ = layui.jquery,element = layui.element,form = layui.form,layer = layui.layer;
    // 单选
    form.on('checkbox(oneChoose)', function(data){
        var tr = $(this).parents();
        if(this.checked){
            tr.addClass('selected');
        }else{
            tr.removeClass('selected');
        }
        form.render('checkbox');
    });

    // 全选和反选
    form.on('checkbox(allChoose)', function(data){
        var child = $(data.elem).parents('table').find('tbody tr td:first-child input[type="checkbox"]');
        child.each(function(index, item){
            item.checked = data.elem.checked;
        });
        form.render('checkbox');
    });

})
