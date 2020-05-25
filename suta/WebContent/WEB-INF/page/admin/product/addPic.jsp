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
	<meta charset="UTF-8">
	<style>
	
	.backgroud-gray{
		background-color: #999 !important;
	}
	select{
		border: 1px solid #e6e6e6;
	}
	</style>

</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content layui-form">
						<div class="layui-form" action="">
 							<input type="hidden" id="pid" name="pid"  value="${pid}" >
								<div class="layui-form-item">
									<label class="layui-form-label">图1：</label>
									<div class="layui-input-block">
										<a href="javascript:$('#typePicApp').click();" class="layui-btn layui-btn-primary">上传图片</a>
									</div>
								</div>

								<div class="layui-form-item">
									<label class="layui-form-label">图1展示：</label>
									<div class="layui-input-block">
										<img alt="暂无图片" src="" id="pic_app" style="width: 20%;">
									</div>
								</div>
								
										<label class="layui-form-label">图2</label>
									<div class="layui-input-block">
										<a href="javascript:$('#typePicAppBig').click();" class="layui-btn layui-btn-primary">上传图片</a>
									</div>
								</div>
														
								<div class="layui-form-item">
									<label class="layui-form-label">图2展示</label>
									<div class="layui-input-block">
										<img alt="暂无图片" src="" id="pic_appBig" style="width: 20%;">
									</div>
								</div>
							
									<label class="layui-form-label">图3</label>
									<div class="layui-input-block">
										<a href="javascript:$('#typePicAppThree').click();" class="layui-btn layui-btn-primary">上传图片</a>
									</div>
								</div>
														
								<div class="layui-form-item">
									<label class="layui-form-label">图3展示</label>
									<div class="layui-input-block">
										<img alt="暂无图片" src="" id="pic_appThree" style="width: 20%;">
									</div>
								</div>
							
							
							
								<label class="layui-form-label">图4</label>
									<div class="layui-input-block">
										<a href="javascript:$('#typePicAppFour').click();" class="layui-btn layui-btn-primary">上传图片</a>
									</div>
								</div>
														
								<div class="layui-form-item">
									<label class="layui-form-label">图4展示</label>
									<div class="layui-input-block">
										<img alt="暂无图片" src="" id="pic_appFour" style="width: 20%;">
									</div>
								</div>
								
								<label class="layui-form-label">图5</label>
									<div class="layui-input-block">
										<a href="javascript:$('#typePicAppFive').click();" class="layui-btn layui-btn-primary">上传图片</a>
									</div>
								</div>
														
								<div class="layui-form-item">
									<label class="layui-form-label">图5展示</label>
									<div class="layui-input-block">
										<img alt="暂无图片" src="" id="pic_appFive" style="width: 20%;">
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
							<input type="file" id="typePicAppThree" accept="image/jpg,image/png,image/jpeg" name="pic_appThree" >
							<input type="file" id="typePicAppFour" accept="image/jpg,image/png,image/jpeg" name="pic_appFour" >
							<input type="file" id="typePicAppFive" accept="image/jpg,image/png,image/jpeg" name="pic_appFive" >
						</div>

						<script type="text/javascript">

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
								  	$('#pic_app').attr("pic_src",res.data.img);
								
								  }
								});  
								layui.upload({
									  elem:'#typePicAppBig',
									  url: sysUrl+'file/uploadImg',
									  ext: 'jpg|png|jpeg',
									  success: function(res){
									  	$('#pic_appBig').attr("src","http://121.43.188.172:8019/ZhangShangYunShanPic/"+res.data.img);
									  	$('#pic_appBig').attr("pic_src",res.data.img);
									
									  }
									});
								
								layui.upload({
									  elem:'#typePicAppThree',
									  url: sysUrl+'file/uploadImg',
									  ext: 'jpg|png|jpeg',
									  success: function(res){
									  	$('#pic_appThree').attr("src","http://121.43.188.172:8019/ZhangShangYunShanPic/"+res.data.img);
									  	$('#pic_appThree').attr("pic_src",res.data.img);
									
									  }
									});
								
								layui.upload({
									  elem:'#typePicAppFour',
									  url: sysUrl+'file/uploadImg',
									  ext: 'jpg|png|jpeg',
									  success: function(res){
									  	$('#pic_appFour').attr("src","http://121.43.188.172:8019/ZhangShangYunShanPic/"+res.data.img);
									  	$('#pic_appFour').attr("pic_src",res.data.img);
									  }
									});
								
								
								layui.upload({
									  elem:'#typePicAppFive',
									  url: sysUrl+'file/uploadImg',
									  ext: 'jpg|png|jpeg',
									  success: function(res){
									  	$('#pic_appFive').attr("src","http://121.43.188.172:8019/ZhangShangYunShanPic/"+res.data.img);
									  	$('#pic_appFive').attr("pic_src",res.data.img);
									
									  }
									});
								
								
								var form = layui.form();
								//监听提交
								form.on('submit(form)', function(data) {

								
								
									
									data.field.pic = $('#pic_app').attr("pic_src");
									data.field.bigPic = $('#pic_appBig').attr("pic_src");
									data.field.ThreePic = $('#pic_appThree').attr("pic_src");
									data.field.FourPic = $('#pic_appFour').attr("pic_src");
									data.field.FivePic = $('#pic_appFive').attr("pic_src");
									data.field.pid=$("#pid").val();
									
									var json = {where:JSON.stringify(data.field),modelName:'${modelName}'};
									jq.post(sysUrl+'product/addPicSubmit',json,function(data){
										
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
