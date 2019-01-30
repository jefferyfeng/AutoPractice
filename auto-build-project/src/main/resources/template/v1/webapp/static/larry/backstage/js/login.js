layui.use(['jquery','common','layer','form','larryMenu'],function(){
    var $ = layui.$,
        layer = layui.layer,
        form = layui.form,
        common = layui.common;
    // 页面上下文菜单
    var larryMenu = layui.larryMenu();

    var mar_top = ($(document).height()-$('#larry_login').height())/2.5;
    $('#larry_login').css({'margin-top':mar_top});
    var placeholder = '';
    $("#larry_form input[type='text'],#larry_form input[type='password']").on('focus',function(){
        placeholder = $(this).attr('placeholder');
        $(this).attr('placeholder','');
    });
    $("#larry_form input[type='text'],#larry_form input[type='password']").on('blur',function(){
        $(this).attr('placeholder',placeholder);
    });

    common.larryCmsLoadJq('../larry/common/plus/jquery.supersized.min.js', function() {
        $.supersized({
            // 功能
            slide_interval: 3000,
            transition: 1,
            transition_speed: 1000,
            performance: 1,
            // 大小和位置
            min_width: 0,
            min_height: 0,
            vertical_center: 1,
            horizontal_center: 1,
            fit_always: 0,
            fit_portrait: 1,
            fit_landscape: 0,
            // 组件
            slide_links: 'blank',
            slides: [{
                image: '../larry/backstage/images/login/1.jpg'
            }, {
                image: '../larry/backstage/images/login/2.jpg'
            }, {
                image: '../larry/backstage/images/login/3.jpg'
            }]
        });
    });
});
    