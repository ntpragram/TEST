<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>速塔科技官网后台管理中心</title>
<link rel="stylesheet" href="../layui/css/layui.css">
<link rel="stylesheet" href="../css/global.css">
	<link rel="shortcut icon" type="image/x-icon" href="../images/head.png" />
<script type="text/javascript" src="../layui/layui.js"></script>
<script src="../js/jquery.min.js?v=2.1.4"></script>
<script type="text/javascript" src="../js/SysCommon.js" charset="UTF-8"></script>
<script>
function login() {
	$.post('${sysUrl}'+"loginVerify", $("#form").serialize(), function(data) {
		if (data.success) {
			window.location.href = '${sysUrl}'+"index";
		} else {
			alert(data.message);
		}
	});
}
</script>
</head>
<body>
<style type="text/css">html{background: #f3f3f3;}</style>
<div class="login_page">
    <img class="logo-login" src="../images/suta.png" alt="logo"><br/>
 <!--    <h1>速塔科技官网后台管理中心</h1> -->
    <form class="layui-form" id="form">
        <div class="layui-form-item">
            <div class="layui-input-inline input-custom-width">
                <input type="text" name="username" lay-verify="required" placeholder="用户名" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-inline input-custom-width">
                <input type="password" name="password" lay-verify="required" placeholder="密码" autocomplete="off" class="layui-input">
            </div>
        </div>
        <!--<div class="layui-form-item">
            <div class="layui-input-inline input-custom-width">
                <input type="text" name="captcha" lay-verify="required" placeholder="验证码" autocomplete="off" class="layui-input">
                <div class="captcha"><img src="{:captcha_src()}" alt="captche" title='点击切换' onclick="this.src='/captcha?id='+Math.random()"></div>
            </div>
        </div>-->
        <div class="layui-form-item">
            <div class="layui-input-inline input-custom-width">
              <span class="layui-btn input-custom-width" onclick="login()">立即登录</span>
            </div>
        </div>
    </form>
</div>
<script type="text/javascript">
/* layui.use('form',function(){
    var form = layui.form()
    ,jq = layui.jquery;

    //监听提交
      form.on('submit(login)', function(data){
        loading = layer.load(2, {
          shade: [0.2,'#000'] //0.2透明度的白色背景
        });
        var param = data.field;
        jq.post('',param,function(data){
          if(data.code == 200){
            layer.close(loading);
            layer.msg(data.msg, {icon: 1, time: 1000}, function(){
              location.href = '';
            });
          }else{
            layer.close(loading);
            layer.msg(data.msg, {icon: 2, anim: 6, time: 1000});
            jq('.captcha img').attr('src','/captcha?id='+Math.random());
          }
        });
        return false;
      });
}); */
</script>
</body>
</html>