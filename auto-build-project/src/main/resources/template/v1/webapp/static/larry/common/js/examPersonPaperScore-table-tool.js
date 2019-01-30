/**
 * Created by dongao on 2018/2/12.
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
            "aLengthMenu" : [ [ 10, 500, 1000], [ 10, 500, 1000 ] ],
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