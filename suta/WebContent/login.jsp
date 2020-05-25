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
<link rel="stylesheet" href="./layui/css/layui.css">
<link rel="stylesheet" href="./css/global.css">
	<link rel="shortcut icon" type="image/x-icon" href="./images/head.png" />
<script type="text/javascript" src="./layui/layui.js"></script>
<script type="text/javascript" src="js/jquery.min.js?v=2.1.4"></script>
<script type="text/javascript" src="js/SysCommon.js" charset="UTF-8"></script>
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
<div class="login_page">
    <img class="logo-login" src="./images/suta.png" alt="logo"><br/>
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
        <div class="layui-form-item">
            <div class="layui-input-inline input-custom-width">
              <span class="layui-btn input-custom-width" onclick="login()">立即登录</span>
            </div>
        </div>
    </form>
</div>
</body>
</html>