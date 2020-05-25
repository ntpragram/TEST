<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
			
			String basePaths="http://121.43.188.172:8019/ZhangShangYunShanPic/";	
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
							<input type="hidden" name="panId" id="panId" value="${panId}" title=" ">

								
								<div class="layui-form-item" style="margin-top: 30px">
									<label class="layui-form-label">标题</label>
									<div class="layui-input-block">
										<input type="text" name="title" id="title" 
											value="${title}" placeholder="请输入标题"  lay-verify="" autocomplete="off"
											class="layui-input">
									</div>
								</div>
								
																
							
							
								<div class="layui-form-item">
									<label class="layui-form-label">图片</label>
									<div class="layui-input-block">
										<a href="javascript:$('#typePicApp').click();" class="layui-btn layui-btn-primary">上传图片</a>
									</div>
								</div>
								
								
								<div class="layui-form-item">
									<label class="layui-form-label">图片展示</label>
									<div class="layui-input-block">
										<img alt="暂无图片" src="<%=basePaths%>${pic}" id="pic_app" style="width: 20%;">
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
								  	$('#pic_app').attr("src","http://121.43.188.172:8019/ZhangShangYunShanPic/"+res.data.img);
								  }
								});  
								
								
							
								
							
								var form = layui.form();
								//监听提交
								form.on('submit(form)', function(data) {
									var title = $("#title").val();
								
									var pic =$('#pic_app').attr("src");	
									
									if(title==""){
										layer.msg("请输入标题", {icon: 2,anim: 6, time: 1000});
										return;
									}
									
									if(pic==""){
										layer.msg("请添加图片", {icon: 2,anim: 6, time: 1000});
										return;
									}
									
									
									data.field.pic = $('#pic_app').attr("src");
									
									var json = {where:JSON.stringify(data.field),modelName:'${modelName}'};
									jq.post(sysUrl+'sort/modifySortTwoSubmit',json,function(data){
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
