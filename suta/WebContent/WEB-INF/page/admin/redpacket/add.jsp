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
							<input type="hidden" name="status" id="status" value="${status}" title=" ">
								<div class="layui-form-item" style="margin-top: 30px">
									<label class="layui-form-label">标题</label>
									<div class="layui-input-block">
										<input type="text" name="title" id="title" 
											value="" placeholder="请输入标题"  lay-verify="" autocomplete="off"
											class="layui-input">
									</div>
								</div>
							<c:if test="${status==0}">
							<div class="layui-form-item" style="margin-top: 30px">
										<label class="layui-form-label">抵扣价格</label>
										<div class="layui-input-block">
											<input type="number" name="price" id="price" 
												value="" placeholder="请输入价格"  lay-verify="" autocomplete="off"
												class="layui-input">
										</div>
							</div>
							</c:if>
							<c:if test="${status==1}">
							<div class="layui-form-item" style="margin-top: 30px">
										<label class="layui-form-label">折扣</label>
										<div class="layui-input-block">
											<input type="number" name="discount" id="discount" 
												value="" placeholder="请输入1到10之间的折扣"  lay-verify="" autocomplete="off"
												class="layui-input">
										</div>
							</div>
							</c:if>
							<div class="layui-form-item" style="margin-top: 30px">
										<label class="layui-form-label">最低消费</label>
										<div class="layui-input-block">
											<input type="number" name="fullPrice" id="fullPrice" 
												value="" placeholder="请输入最低消费金额"  lay-verify="" autocomplete="off"
												class="layui-input">
										</div>
							</div>
							<div class="layui-form-item" style="margin-top: 30px">
										<label class="layui-form-label">有效期</label>
										<div class="layui-input-block">
											<input type="number" name="period" id="period" 
												value="" placeholder="请输入有效期"  lay-verify="" autocomplete="off"
												class="layui-input">
										</div>
							</div>
							<div class="layui-form-item" style="margin-top: 30px">
										<label class="layui-form-label">红包数量</label>
										<div class="layui-input-block">
											<input type="number" name="num" id="num" 
												value="" placeholder="请输入红包数量"  lay-verify="" autocomplete="off"
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
							layui.use(['form','upload'], function() {
								var form = layui.form();
								//监听提交
								form.on('submit(form)', function(data) {

									var status = $("#status").val();
									var title = $("#title").val();
									var price = $("#price").val();
									var discount = $("#discount").val();
									var fullPrice = $("#fullPrice").val();
									var period = $("#period").val();
									var num = $("#num").val();
								
									if(title==""){
										layer.msg("请输入标题", {icon: 2,anim: 6, time: 1000});
										return;
									}
									if(status==0){
										if(price==""){
											layer.msg("请输入价格", {icon: 2,anim: 6, time: 1000});
											return;
										}
									}else{
										if(discount==""){
											layer.msg("请输入折扣", {icon: 2,anim: 6, time: 1000});
											return;	
										}
									}
									if(fullPrice==""){
										layer.msg("请输入最低消费", {icon: 2,anim: 6, time: 1000});
										return;
									}
									if(period==""){
										layer.msg("请输入有效期", {icon: 2,anim: 6, time: 1000});
										return;
									}
									if(num==""){
										layer.msg("请输入数量", {icon: 2,anim: 6, time: 1000});
										return;
									}

									var json = {where:JSON.stringify(data.field),modelName:'${modelName}'};
									$.post(sysUrl+'redPacket/addRedPacket',json,function(data){
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
