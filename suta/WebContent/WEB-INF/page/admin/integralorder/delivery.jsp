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
									<label class="layui-form-label">订单号</label>
									<div class="layui-input-block">
										<input type="text" name="title" 
											value="${onumber}" placeholder="请输入标题" required readonly lay-verify="" autocomplete="off"
											class="layui-input">
									</div>
								</div>	

								<div class="layui-form-item" style="margin-top: 30px">
									<label class="layui-form-label">快递公司</label>
									<div class="layui-input-block">
									<select id="courier" name="courier">
										<option value="">请选择</option>
										<c:forEach items="${courierList}" var="v">
										<option value="${v.introduce}">${v.title}</option>
										</c:forEach>
									</select>
									</div>
								</div>	
								<div class="layui-form-item" style="margin-top: 30px">
									<label class="layui-form-label">快递单号</label>
									<div class="layui-input-block">
										<input type="text" name="courierNumber"  id="courierNumber"
											value="" placeholder="请输入单号" required  lay-verify="" autocomplete="off"
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
					
						<script type="text/javascript">

							layui.use(['form','upload'], function() {;  				
								var form = layui.form();
								//监听提交
								form.on('submit(form)', function(data) {
									var courier = $("#courier").val();
									var courierNumber = $("#courierNumber").val();
									if(courier==""){
										layer.msg("请选择快递公司", {icon: 2,anim: 6, time: 1000});
										return;
									}
									if(courierNumber==""){
										layer.msg("请输入快递单号", {icon: 2,anim: 6, time: 1000});
										return;
									}
									//console.log("data:"+JSON.stringify(data.field));
									ajaxPOST("integralOrder/deliveryOrder", {
										where:JSON.stringify(data.field),
										modelName:'${modelName}'
									}, 
										function(data) {
											console.log("data:"+JSON.stringify(data));	
											swalTip("提示", data.message, data.success,function(res){												
												if(res){
													if(data.success){
														var index = parent.layer.getFrameIndex(window.name);
														parent.location.reload(); 
														window.parent.layer.close(index);
													}
													
												}
											});
									});
									return false;
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
