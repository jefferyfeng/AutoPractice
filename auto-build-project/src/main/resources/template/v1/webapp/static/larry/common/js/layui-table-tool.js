/**
 * Created by lishuang on 2017/2/27 .
 */

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

    layer.open({
        type: 2,
        area: [w + 'px', h + 'px'],
        fix: false,
        maxmin: true,
        title: title,
        content: url
    });
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
//时间戳的处理
layui.use('laytpl', function(){
	layui.laytpl.toDateString = function(d, format){
	  var date = new Date(d || new Date())
	  ,ymd = [
	    this.digit(date.getFullYear(), 4)
	    ,this.digit(date.getMonth() + 1)
	    ,this.digit(date.getDate())
	  ]
	  ,hms = [
	    this.digit(date.getHours())
	    ,this.digit(date.getMinutes())
	    ,this.digit(date.getSeconds())
	  ];

	  format = format || 'yyyy-MM-dd HH:mm';

	  return format.replace(/yyyy/g, ymd[0])
	  .replace(/MM/g, ymd[1])
	  .replace(/dd/g, ymd[2])
	  .replace(/HH/g, hms[0])
	  .replace(/mm/g, hms[1])
	  .replace(/ss/g, hms[2]);
	};
	
	//数字前置补零
	layui.laytpl.digit = function(num, length, end){
	  var str = '';
	  num = String(num);
	  length = length || 2;
	  for(var i = num.length; i < length; i++){
	    str += '0';
	  }
	  return num < Math.pow(10, length) ? str + (num|0) : num;
	};
});

