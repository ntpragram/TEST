<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://"
+ request.getServerName() + ":" + request.getServerPort()
+ path + "/";
%>
<style>

.layui-nav-tree .layui-this, .layui-nav-itemed {
 background: #4f666f;
 
}

</style>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>速塔科技官网后台管理中心</title>
	<link rel="stylesheet" href="../layui/css/layui.css">
	<link rel="stylesheet" href="../css/global.css">
	<link rel="stylesheet" href="../css/add.css">
	<link rel="stylesheet" href="../css/controller.css">
	<link rel="shortcut icon" type="image/x-icon" href="../images/head.png" />
	<script type="text/javascript" src="../layui/layui.js"></script>
	<script src="../js/jquery.min.js?v=2.1.4"></script>
	<script>
	function logout(){
		window.location.href='loginOut';
	}
	</script>
</head>
<body>
<div class="layui-layout layui-layout-admin">
	<div class="layui-header header">
		<div class="layui-main">
			<a class="logo" href="#">
				<img src="../images/suta.png" alt="Lz_CMS">
			</a>
			<ul class="layui-nav top-nav-container">
				<li class="layui-nav-item layui-this">
					<a href="../home.jsp" target="main">首页</a>
				</li>
				<!--
				<li class="layui-nav-item">
				<a href="member.html" target="main">内容</a>
				</li>
				<li class="layui-nav-item">
				<a href="memberNew.html" target="main">会员</a>
				</li>
				<li class="layui-nav-item">
				<a href="javascript:void(0)">设置</a>
				</li>
				-->
			</ul>
			<div class="top_admin_user site-demo-button">
				<input type="hidden" id="id" name="id" value="${resultData.id}" title=" ">
				<a  href="javascript:void(0)" >管理员账号：${resultData.username}</a>
				<a href="passwd?id=${resultData.id}" target="main">修改密码</a>
				<a data-method="offset" data-type="auto" class="exit" data-class="exit" title="" href="javascript:;" onclick="logout()">退出登录</a>
			</div>
		</div>
	</div>
	<div class="layui-side layui-bg-black">
		<div class="layui-side-scroll">
			<ul class="layui-nav layui-nav-tree left_menu_ul">
			<c:forEach items="${menuList}" var="v">
				<li class="layui-nav-item layui-this">
					<a href="javascript:;" onclick="return false;">${v.fname }</a>
					<dl class="layui-nav-child">
						<c:forEach items="${menuSecList }" var="c">
							<c:if test="${c.fbh eq v.fbh }">
								<dd ><a href="${c.sweb}" target="main">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${c.sname}</a></dd>
							</c:if>
						</c:forEach>
					</dl>
				</li>
			</c:forEach>
				
			</ul>
			<!--
			<ul class="layui-nav layui-nav-tree left_menu_ul hide">
				<li class="layui-nav-item layui-nav-itemed layui-this">
					<a class="layui-nav-title" href="javascript:;">内容发布管理</a>
					<dl class="layui-nav-child">
						<dd><a href="memberNew.html" target="main">banner图</a></dd>
						<dd><a href="member.html" target="main">文章信息</a></dd>
					</dl>
				</li>
				<li class="layui-nav-item">
					<a href="javascript:;">表格-版2</a>
					<dl class="layui-nav-child">
						<dd><a href="member.html" target="main">新聞中心</a></dd>
						<dd><a href="memberNew.html" target="main">今日热门</a></dd>
					</dl>
				</li>
			</ul>
			<ul class="layui-nav layui-nav-tree left_menu_ul hide">
				<li class="layui-nav-item layui-nav-itemed layui-this">
					<a class="layui-nav-title" href="javascript:;">会员管理</a>
					<dl class="layui-nav-child">
						<dd><a href="member.html" target="main">会员列表</a></dd>
						<dd><a href="memberNew.html" target="main">新增会员</a></dd>
					</dl>
				</li>
				<li class="layui-nav-item">
					<a href="javascript:;">会员列表</a>
					<dl class="layui-nav-child">
						<dd><a href="">南京</a></dd>
						<dd><a href="">北京</a></dd>
					</dl>
				</li>
				<li class="layui-nav-item">
					<a href="javascript:;">新增会员</a>
					<dl class="layui-nav-child">
						<dd><a href="">南京</a></dd>
						<dd><a href="">北京</a></dd>
					</dl>
				</li>
			</ul>
			-->
			<ul class="layui-nav layui-nav-tree left_menu_ul setting_ul hide">
				<li class="layui-nav-item layui-nav-title layui-this">
					<a>相关设置</a>
				</li>
				<li class="layui-nav-item first-item ">
					<a href="<?php echo url('setting/base','tab=1') ?>" target="main">
						<i class="layui-icon">&#xe620;</i>
						<cite>站点设置</cite>
					</a>
				</li>
				<li class="layui-nav-item">
					<a href="<?php echo url('setting/base','tab=2') ?>" target="main">
						<i class="layui-icon">&#xe612;</i>
						<cite>站长信息</cite>
					</a>
				</li>
				<li class="layui-nav-item">
					<a href="<?php echo url('setting/base','tab=3') ?>" target="main">
						<i class="layui-icon"></i>
						<cite>SEO设置</cite>
					</a>
				</li>
				<li class="layui-nav-item">
					<a href="<?php echo url('setting/base','tab=4') ?>" target="main">
						<i class="layui-icon">&#xe634;</i>
						<cite>水印设置</cite>
					</a>
				</li>
				<li class="layui-nav-item">
					<a href="<?php echo url('setting/base','tab=5') ?>" target="main">
						<i class="layui-icon">&#xe63a;</i>
						<cite>畅言评论设置</cite>
					</a>
				</li>
				<li class="layui-nav-item">
					<a href="<?php echo url('setting/base','tab=6') ?>" target="main">
						<i class="layui-icon">&#xe611;</i>
						<cite>QQ登陆设置</cite>
					</a>
				</li>
				<li class="layui-nav-item">
					<a href="<?php echo url('setting/links') ?>" target="main">
						<i class="layui-icon">&#xe62c;</i>
						<cite>友情连接</cite>
					</a>
				</li>
				<li class="layui-nav-item">
					<a href="<?php echo url('setting/sitemap') ?>" target="main">
						<i class="layui-icon">&#xe60d;</i>
						<cite>Sitemap</cite>
					</a>
				</li>

			</ul>
			<div class="content_manage_container left_menu_ul hide">
				<div class="content_manage_title">内容管理</div>
				<div id="content_manage_tree"></div>
			</div>
		</div>



	</div>

	<div class="layui-body iframe-container">
		<iframe class="admin-iframe" id="admin-iframe" name="main" src="../home.jsp"></iframe>
	</div>

	<div class="layui-footer footer">
		<div class="layui-main">
			<p>2018 © <a href="http://yunshan99.com">速塔科技</a></p>
		</div>
	</div>
</div>

<script type="text/javascript">
    layui.use(['layer', 'element','jquery','tree'], function(){
        var layer = layui.layer
            ,element = layui.element() //导航的hover效果、二级菜单等功能，需要依赖element模块
            ,jq = layui.jquery

        var active = {
            offset: function(othis){
                var type = othis.data('class');
                console.log(type)
                layer.open({
                    type: 1
                    ,offset: type //具体配置参考：http://www.layui.com/doc/modules/layer.html#offset
                    ,id: 'LAY_demo'+type //防止重复弹出
                    ,content: '<div style="padding: 20px 100px;">您要退出吗？</div>'
                    ,btn: ['确认退出','取消']
                    ,btnAlign: 'c' //按钮居中
                    ,shade: 0 //不显示遮罩
                    ,yes: function(){
                        layer.msg('您已退出！',
                            {time:1000},
                            function(){
                                layer.closeAll();
                                $('.site-demo-button .exit').hide();
                                $('.site-demo-button .login').show()
                            });
                    }
                    ,btn2: function(){
                        layer.closeAll();
                    }
                });
                layer.open({
                    type: 1
                    ,offset: type //具体配置参考：http://www.layui.com/doc/modules/layer.html#offset
                    ,id: 'LAY_demo'+type //防止重复弹出
                    ,content: '<div style="padding: 20px 100px;">您要退出吗？</div>'
                    ,btn: ['确认登录','取消']
                    ,btnAlign: 'c' //按钮居中
                    ,shade: 0 //不显示遮罩
                    ,yes: function(){
                        layer.msg('您已退出！',
                            {time:1000},
                            function(){
                                layer.closeAll();
                                $('.site-demo-button .exit').hide();
                                $('.site-demo-button .login').show()
                            });
                    }
                    ,btn2: function(){
                        layer.closeAll();
                    }
                });
            }
        };

        $('.site-demo-button .exit').on('click', function(){
            var othis = $(this), method = othis.data('method');
            active[method] ? active[method].call(this, othis) : '';
        });
        $('.site-demo-button .login').on('click', function(){
            var othis = $(this), method = othis.data('method');
            active[method] ? active[method].call(this, othis) : '';
        });

//头部菜单切换
        jq('.top-nav-container .layui-nav-item').click(function(){
            var menu_index = jq(this).index('.top-nav-container .layui-nav-item');
            jq('.top-nav-container .layui-nav-item').removeClass('layui-this');
            jq(this).addClass('layui-this');
            jq('.left_menu_ul').addClass('hide');
            jq('.left_menu_ul:eq('+menu_index+')').removeClass('hide');
            jq('.left_menu_ul .layui-nav-item').removeClass('layui-this');
            jq('.left_menu_ul:eq('+menu_index+')').find('.first-item').addClass('layui-this');
            var url = jq('.left_menu_ul:eq('+menu_index+')').find('.first-item a').attr('href');
            jq('.admin-iframe').attr('src',url);
//出现遮罩层
            jq("#iframe-mask").show();
//遮罩层消失
            jq("#admin-iframe").load(function(){
                jq("#iframe-mask").fadeOut(100);
            });
        });
//左边菜单点击
        jq('.left_menu_ul .layui-nav-item').click(function(){
            jq('.left_menu_ul .layui-nav-item').removeClass('layui-this');
            jq(this).addClass('layui-this');
//出现遮罩层
            jq("#iframe-mask").show();
//遮罩层消失
            jq("#admin-iframe").load(function(){
                jq("#iframe-mask").fadeOut(100);
            });
        });

//点击回到内容页面
        jq('.content_manage_title').click(function(){
            jq('.left_menu_ul .layui-nav-item').removeClass('layui-this');
            jq(this).parent().addClass('hide');
            jq('.content_put_manage').find('.first-item').addClass('layui-this');
            var url = jq('.content_put_manage').find('.first-item a').attr('href');
            jq('.admin-iframe').attr('src',url);
            jq('.content_put_manage').removeClass('hide');

        });
//内容管理树
        jq('.content_manage').click(function(){
            loading = layer.load(2, {
                shade: [0.2,'#000'] //0.2透明度的白色背景
            });
            jq('#content_manage_tree').empty();
            layui.tree({
                elem: '#content_manage_tree' //传入元素选择器
                ,skin: 'white'
                ,target: 'main'
                ,nodes: [{"id":1,"name":"学无止境","children":[{"id":8,"name":"杂谈","children":[],"href":"\/admin\/article\/index\/category_id\/8.html"},{"id":9,"name":"PHP","children":[],"href":"\/admin\/article\/index\/category_id\/9.html"},{"id":10,"name":"建站","children":[],"href":"\/admin\/article\/index\/category_id\/10.html"},{"id":11,"name":"WEB前端","children":[],"href":"\/admin\/article\/index\/category_id\/11.html"}],"spread":true},{"id":2,"name":"分享无价","children":[{"id":13,"name":"源码分享","children":[],"href":"\/admin\/download\/index\/category_id\/13.html"},{"id":14,"name":"jQuery特效","children":[],"href":"\/admin\/download\/index\/category_id\/14.html"}],"spread":true},{"id":3,"name":"日记","children":[],"spread":true,"href":"\/admin\/link\/index\/category_id\/3.html"},{"id":4,"name":"关于","children":[{"id":5,"name":"关于老张","children":[],"href":"\/admin\/page\/edit\/category_id\/5.html"},{"id":6,"name":"关于LzCMS","children":[],"href":"\/admin\/page\/edit\/category_id\/6.html"}],"spread":true,"href":"\/admin\/link\/index\/category_id\/3.html"}]
            });
            jq('.left_menu_ul').addClass('hide');
            jq('.content_manage_container').removeClass('hide');
            layer.close(loading);
        });

//更新缓存
        jq('.update_cache').click(function(){
            loading = layer.load(2, {
                shade: [0.2,'#000'] //0.2透明度的白色背景
            });
            jq.getJSON('',function(data){
                if(data.code == 200){
                    layer.close(loading);
                    layer.msg(data.msg, {icon: 1, time: 1000}, function(){
                        location.reload();//do something
                    });
                }else{
                    layer.close(loading);
                    layer.msg(data.msg, {icon: 2, anim: 6, time: 1000});
                }
            });
        });

//退出登陆
        jq('.logout_btn').click(function(){
            loading = layer.load(2, {
                shade: [0.2,'#000'] //0.2透明度的白色背景
            });
            jq.getJSON('',function(data){
                if(data.code == 200){
                    layer.close(loading);
                    layer.msg(data.msg, {icon: 1, time: 1000}, function(){
                        location.reload();//do something
                    });
                }else{
                    layer.close(loading);
                    layer.msg(data.msg, {icon: 2, anim: 6, time: 1000});
                }
            });
        });


    });


</script>

</body>
</html>