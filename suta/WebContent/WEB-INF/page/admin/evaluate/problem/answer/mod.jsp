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
							<input type="hidden" name="eid" id="eid" value="${eid}" title=" ">
							<input type="hidden" name="pid" id="pid" value="${pid}" title=" ">
								
								<div class="layui-form-item" style="margin-top: 30px">
									<label class="layui-form-label">答案序列</label>
									<div class="layui-input-block">
									<select name="titleChar" id="titleChar">
										<option value="">请选择</option>
										<option value="A" <c:if test="${titleChar=='A'}">selected</c:if>>A</option>
										<option value="B" <c:if test="${titleChar=='B'}">selected</c:if>>B</option>
										<option value="C" <c:if test="${titleChar=='C'}">selected</c:if>>C</option>
										<option value="D" <c:if test="${titleChar=='D'}">selected</c:if>>D</option>
										<option value="E" <c:if test="${titleChar=='E'}">selected</c:if>>E</option>
										<option value="F" <c:if test="${titleChar=='F'}">selected</c:if>>F</option>
										<option value="G" <c:if test="${titleChar=='G'}">selected</c:if>>G</option>
									
									</select>
									</div>
								</div>	
								
								<div class="layui-form-item" style="margin-top: 30px">
									<label class="layui-form-label">答案内容</label>
									<div class="layui-input-block">
										<input type="text" name="answer" id="answer" 
											value="${answer}" placeholder="请输入答案"  lay-verify="" autocomplete="off"
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
							//Demo
							layui.use(['element','form','upload','layedit'], function() {
								var form = layui.form();
								//监听提交
								form.on('submit(form)', function(data) {
									var titleChar= $("#titleChar").val();
									if(titleChar==""){
										layer.msg("请选择答案序列", {icon: 2,anim: 6, time: 1000});
										return;
									}
									var answer= $("#answer").val();
									if(answer==""){
										layer.msg("请输入答案", {icon: 2,anim: 6, time: 1000});
										return;
									}
									var json = {where:JSON.stringify(data.field),modelName:'${modelName}'};
									$.post(sysUrl+'evaluate/modifyProblemAnswerSubmit',json,function(data){
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
