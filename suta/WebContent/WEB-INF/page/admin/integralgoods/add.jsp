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
						
							<input type="hidden" name="tag" id="tag" value="${tag}">
								<div class="layui-form-item" style="margin-top: 30px">
									<label class="layui-form-label">标题</label>
									<div class="layui-input-block">
										<input type="text" name="title" id="title" 
											value="" placeholder="请输入标题"  lay-verify="" autocomplete="off"
											class="layui-input">
									</div>
								</div>
								 <div class="layui-form-item">
									<label class="layui-form-label">简介</label>
									<div class="layui-input-block">
										<input type="text" name="introduce"  id="introduce"
											value="" placeholder="请输入简介"  lay-verify="" autocomplete="off"
											class="layui-input">
									</div>
								</div> 
								
								 
								 <div class="layui-form-item">
									<label class="layui-form-label"><c:if test="${tag==0}">所需云币</c:if><c:if test="${tag==1}">所需杉币</c:if></label>
									<div class="layui-input-block">
										<input type="number" name="integral"  id="integral"
											value="" placeholder="<c:if test="${tag==0}">请输入云币</c:if><c:if test="${tag==1}">请输入杉币</c:if>"  lay-verify="" autocomplete="off"
											class="layui-input">
									</div>
								</div> 
								
								<c:if test="${tag==1}">
								 <div class="layui-form-item">
									<label class="layui-form-label">所需金额</label>
									<div class="layui-input-block">
										<input type="number" name="price"  id="price"
											value="" placeholder="请输入金额"  lay-verify="" autocomplete="off"
											class="layui-input">
									</div>
								</div> 
								</c:if>
								
								 <div class="layui-form-item">
									<label class="layui-form-label">库存</label>
									<div class="layui-input-block">
										<input type="number" name="inventory"  id="inventory"
											value="" placeholder="请输入库存"  lay-verify="" autocomplete="off"
											class="layui-input">
									</div>
								</div> 
								
								
								 <div class="layui-form-item">
									<label class="layui-form-label">销量</label>
									<div class="layui-input-block">
										<input type="number" name="salesVolume"  id="salesVolume"
											value="" placeholder="请输入销量"  lay-verify="" autocomplete="off"
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
									<label class="layui-form-label">图片</label>
									<div class="layui-input-block">
										<img alt="暂无图片" src="" id="pic_app" style="width: 20%;">
									</div>
								</div>
								
								
									<div class="layui-form-item">
									<label class="layui-form-label">小图</label>
									<div class="layui-input-block">
										<a href="javascript:$('#typePicAppSmall').click();" class="layui-btn layui-btn-primary">上传图片</a>
									</div>
								</div>
								
							
								<div class="layui-form-item">
									<label class="layui-form-label">小图展示</label>
									<div class="layui-input-block">
										<img alt="暂无图片" src="" id="pic_appSmall" style="width: 20%;">
									</div>
								</div>
								
								
								
								<div class="layui-form-item">
									<label class="layui-form-label">详细内容</label>
									<div class="layui-input-block">
										<textarea id="content" name="content" id="content" lay-verify="layedit" autocomplete="off" placeholder="请输入内容" class="layui-textarea layui-hide"></textarea>
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
							<input type="file" id="typePicAppSmall" accept="image/jpg,image/png,image/jpeg" name="pic_appSmall" >
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
								  	$('#pic_app').attr("pic_src",res.data.img);
								
								  }
								});  
								
								layui.upload({
									  elem:'#typePicAppSmall',
									  url: sysUrl+'file/uploadImg',
									  ext: 'jpg|png|jpeg',
									  success: function(res){
									  	$('#pic_appSmall').attr("src","http://121.43.188.172:8019/ZhangShangYunShanPic/"+res.data.img);
									  	$('#pic_appSmall').attr("pic_src",res.data.img);
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
									var introduce = $("#introduce").val();
									var integral = $("#integral").val();
									var inventory = $("#inventory").val();
									var salesVolume = $("#salesVolume").val();
									var pic =$('#pic_app').attr("src");
									var content = $("#content").val();
									var picSmall =$('#pic_appSmall').attr("src");
									var tag = $("#tag").val();
									var price = $("#price").val();

									if(title==""){
										layer.msg("请输入标题", {icon: 2,anim: 6, time: 1000});
										return;
									}
									if(introduce==""){
										layer.msg("请输入摘要", {icon: 2,anim: 6, time: 1000});
										return;
									}
									
									if(tag==0){
										if(integral==""){
											layer.msg("请输入云币", {icon: 2,anim: 6, time: 1000});
											return;
										}
									}
									if(tag==1){
									
										if(integral==""){
											layer.msg("请输入杉币", {icon: 2,anim: 6, time: 1000});
											return;
										}
										
										if(price==""){
											layer.msg("请输入金额", {icon: 2,anim: 6, time: 1000});
											return;
										}
									}
									
									
								
									if(inventory==""){
										layer.msg("请输入库存", {icon: 2,anim: 6, time: 1000});
										return;
									}
									if(salesVolume==""){
										layer.msg("请输入销量", {icon: 2,anim: 6, time: 1000});
										return;
									}
									if(pic==""){
										layer.msg("请添加图片", {icon: 2,anim: 6, time: 1000});
										return;
									}
									
									if(picSmall==""){
										layer.msg("请添加小图片", {icon: 2,anim: 6, time: 1000});
										return;
									}
									
									if(content==""){
										layer.msg("请输入内容", {icon: 2,anim: 6, time: 1000});
										return;
									}
									data.field.pic = $('#pic_app').attr("pic_src");
									data.field.smallPic = $('#pic_appSmall').attr("pic_src");
									var json = {where:JSON.stringify(data.field),modelName:'${modelName}'};
									jq.post(sysUrl+'integralProduct/addSubmit',json,function(data){
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
