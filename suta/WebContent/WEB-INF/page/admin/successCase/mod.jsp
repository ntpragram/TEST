﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
			
				
			
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<link rel="stylesheet" href="layui/css/layui.css">
<link rel="stylesheet" href="css/global.css">
<script src="js/jquery.min.js?v=2.1.4"></script>
<script type="text/javascript" src="layui/layui.js"></script>
<script type="text/javascript" src="js/SysCommon.js"></script>
<link rel="stylesheet" href="css/sweetalert.css" >
<script type="text/javascript" src="js/sweetalert.min.js"></script>

</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content layui-form">
						<div class="layui-form" action="">
							<input type="hidden" name="id" id="id" value="${id}" title=" ">

								
								<div class="layui-form-item" style="margin-top: 30px">
									<label class="layui-form-label">标题</label>
									<div class="layui-input-block">
										<input type="text" name="title" id="title" 
											value="${title}" placeholder="请输入标题"  readonly="readonly" lay-verify="" autocomplete="off"
											class="layui-input">
									</div>
								</div>

							
								<div class="layui-form-item">
									<label class="layui-form-label">展示图</label>
									<div class="layui-input-block">
										<a href="javascript:$('#typePicApp').click();" class="layui-btn layui-btn-primary">上传图片</a>
									</div>
								</div>
								
								
								<div class="layui-form-item">
									<label class="layui-form-label">展示图</label>
									<div class="layui-input-block">
										<img alt="暂无图片" src="<%=basePath%>${pic}" id="pic_app" style="width: 20%;">
									</div>
								</div>
								
								
								
								<div class="layui-form-item">
									<label class="layui-form-label">详情页首图</label>
									<div class="layui-input-block">
										<a href="javascript:$('#typePicAppBig').click();" class="layui-btn layui-btn-primary">上传图片</a>
									</div>
								</div>
								
								
								<div class="layui-form-item">
									<label class="layui-form-label">详情页首图</label>
									<div class="layui-input-block">
										<img alt="暂无图片" src="<%=basePath%>${bigPic}" id="pic_appBig" style="width: 20%;">
									</div>
								</div>
								
								
								<div class="layui-form-item">
									<label class="layui-form-label">资讯内容</label>
									<div class="layui-input-block">
										<textarea id="content" name="content" id="content" lay-verify="layedit" autocomplete="off" placeholder="请输入内容" class="layui-textarea layui-hide">${content}</textarea>
									</div>
								</div>

								<div class="layui-form-item">
									<div class="layui-input-block">
										<button class="layui-btn" lay-submit lay-filter="form">立即提交</button>
										<!-- <button type="reset" class="layui-btn layui-btn-primary">重置</button> -->
									</div>
								</div>

						</div>
						<div style="display: none;">
							<input type="file" id="typePicApp" accept="image/jpg,image/png,image/jpeg" name="pic_app" >
							<input type="file" id="typePicAppBig" accept="image/jpg,image/png,image/jpeg" name="pic_appBig" >
						</div>

						<script type="text/javascript">
							//Demo
							layui.use(['element','form','upload','layedit'], function() {

								var element = layui.element()
  								,form = layui.form()
  								,layedit = layui.layedit
  								,laydate = layui.laydate
  								,jq = layui.jquery;

								layui.upload({
								  elem:'#typePicApp',
								  url: sysUrl+'file/uploadImg',
								  ext: 'jpg|png|jpeg',
								  success: function(res){
								  	$('#pic_app').attr("src",'<%=basePath%>'+res.data.img);
								  	//$('#pic_app').attr("src",res.data.img);
								  }
								});  
								
								layui.upload({
									  elem:'#typePicAppBig',
									  url: sysUrl+'file/uploadImg',
									  ext: 'jpg|png|jpeg',
									  success: function(res){
									  	$('#pic_appBig').attr("src",'<%=basePath%>'+res.data.img);
									  	//$('#pic_appBig').attr("src",res.data.img);
									  }
									}); 
								
								
								var content = layedit.build('content', {
									tool: [
										'strong' //加粗
										,'italic' //斜体
										,'underline' //下划线
										,'del' //删除线
										,'|' //分割线
										,'left' //左对齐
										,'center' //居中对齐
										,'right' //右对齐
										// ,'link' //超链接
										// ,'unlink' //清除链接
										// ,'face' //表情
										,'image' //插入图片
										// ,'help' //帮助
									],
									uploadImage: {
										url: sysUrl+'file/uploadImage',
										type: 'post'
									},
									height: 300
								});
								
								//表单验证
								form.verify({
									//编辑器数据同步
									layedit: function(value) {
										layedit.sync(content);
									}
								});

								var form = layui.form();
								//监听提交
								form.on('submit(form)', function(data) {

									
									var title = $("#title").val();
									var remark = $("#remark").val();
									var picSmall =$("#pic_app").attr("src");
									var picBig =$('#pic_appBig').attr("src");
									var content = $("#content").val();

									
										if(title==""){
											layer.msg("请输入标题", {icon: 2,anim: 6, time: 1000});
											return;
										}
										if(remark==""){
											layer.msg("请输入摘要", {icon: 2,anim: 6, time: 1000});
											return;
										}
										if(picSmall==""){
											layer.msg("请添加展示图", {icon: 2,anim: 6, time: 1000});
											return;
										}
										if(picBig==""){
											layer.msg("请添加详情页首图", {icon: 2,anim: 6, time: 1000});
											return;
										}
										if(content==""){
											layer.msg("请输入内容", {icon: 2,anim: 6, time: 1000});
											return;
										}
									
									data.field.picSmall = $('#pic_app').attr("src");
									data.field.picBig = $('#pic_appBig').attr("src");
									var json = {where:JSON.stringify(data.field),modelName:'${modelName}'};
									console.log(json);
									jq.post(sysUrl+'level/modifySuccessCase',json,function(data){
										//console.log("data:"+JSON.stringify(data));
										if(data.code==200){
											layer.msg(data.message, {icon: 1, time: 1000}, function(){
												var index = parent.layer.getFrameIndex(window.name);
												window.parent.layer.close(index);
												parent.location.reload(); 
												
											});
										}else{
											layer.msg(data.message, {icon: 2,anim: 6, time: 1000});
										}
                					});
								});
							});

							var ajaxPOST = function(url,data,callback){
							var json = {
								type : "POST",
								url : sysUrl+url,
								dataType : "json",
								cache: false,
								timeout:30000,
								contentType : "application/x-www-form-urlencoded; charset=UTF-8",
								data : data,
								success : function(data) {
									callback(data);
								},
								error  :function(data){
								}
							};
							$.ajax(json);
						}
						</script>

					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
