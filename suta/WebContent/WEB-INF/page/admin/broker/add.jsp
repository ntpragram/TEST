<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
	.layui-form-select{
		display:none;
	}
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
							<input type="hidden" name="type" id="type" value="${type}" title=" ">
								
				
								<div class="layui-form-item" style="margin-top: 30px">
									<label class="layui-form-label">工号</label>
									<div class="layui-input-block">
										<input type="text" name="workNumber" id="workNumber" 
											value="" placeholder="请输入工号"  lay-verify="" autocomplete="off"
											class="layui-input">
									</div>
								</div>
						
						
						<div class="layui-form-item" style="margin-top: 30px">
									<label class="layui-form-label">姓名</label>
									<div class="layui-input-block">
										<input type="text" name="realName" id="realName" 
											value="" placeholder="请输入姓名"  lay-verify="" autocomplete="off"
											class="layui-input">
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

								var form = layui.form();
								//监听提交
								form.on('submit(form)', function(data) {

									
									var workNumber = $("#workNumber").val();
									var realName = $("#realName").val();

								
									if(workNumber==""){
										layer.msg("请输入工号", {icon: 2,anim: 6, time: 1000});
										return;
									}
									if(realName==""){
										layer.msg("请输入姓名", {icon: 2,anim: 6, time: 1000});
										return;
									}

									var json = {where:JSON.stringify(data.field),modelName:'${modelName}'};
									jq.post(sysUrl+'broker/addBroker',json,function(data){
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
