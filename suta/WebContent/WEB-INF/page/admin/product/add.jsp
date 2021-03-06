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
								<div class="layui-form-item" style="margin-top: 30px">
									<label class="layui-form-label">标题</label>
									<div class="layui-input-block">
										<input type="text" name="title" id="title" 
											value="" placeholder="请输入标题"  lay-verify="" autocomplete="off"
											class="layui-input">
									</div>
								</div>





								<div class="layui-form-item" style="margin-top: 30px">
									<label class="layui-form-label">一级类别</label>
									<div class="layui-input-block">
										
									<select name="bid" id="bid" lay-filter="brickType">
										<option value="">请选择</option>
										
										<c:forEach items="${list}" var="v" varStatus="i">
										<option value="${v.id}">${v.title}</option>
										</c:forEach>
									</select>
									</div>
								</div>
								
								
								<div class="layui-form-item"  id="small" style="display:none">
									<label class="layui-form-label">二级类别</label>
									<div class="layui-input-block">	
									<select name="sid" id="sid" lay-filter="brickTypes">
										<option value="">请选择</option>
									</select>
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
									<label class="layui-form-label">当前价格</label>
									<div class="layui-input-block">
										<input type="text" name="price" id="price"
											value="" placeholder="请输入价格"  lay-verify="" autocomplete="off"
											class="layui-input">
									</div>
								</div> 
								
								 <div class="layui-form-item">
									<label class="layui-form-label">会员价格</label>
									<div class="layui-input-block">
										<input type="text" name="vipPrice"  id="vipPrice"
											value="" placeholder="请输入价格"  lay-verify="" autocomplete="off"
											class="layui-input">
									</div>
								</div> 
								
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
									<label class="layui-form-label">小图</label>
									<div class="layui-input-block">
										<a href="javascript:$('#typePicApp').click();" class="layui-btn layui-btn-primary">上传图片</a>
									</div>
								</div>

								<div class="layui-form-item">
									<label class="layui-form-label">小图</label>
									<div class="layui-input-block">
										<img alt="暂无图片" src="" id="pic_app" style="width: 20%;">
									</div>
								</div>
								
										<label class="layui-form-label">大图</label>
									<div class="layui-input-block">
										<a href="javascript:$('#typePicAppBig').click();" class="layui-btn layui-btn-primary">上传图片</a>
									</div>
								</div>
														
								<div class="layui-form-item">
									<label class="layui-form-label">大图</label>
									<div class="layui-input-block">
										<img alt="暂无图片" src="" id="pic_appBig" style="width: 20%;">
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
							<input type="file" id="typePicAppBig" accept="image/jpg,image/png,image/jpeg" name="pic_appBig" >
							
						</div>

						<script type="text/javascript">

							layui.use(['element','form','upload','layedit'], function() {

								var element = layui.element()
  								,form = layui.form()
  								,layedit = layui.layedit
  								,laydate = layui.laydate
  								,jq = layui.jquery;
								
								
								form.on('select(brickType)', function(data){   
									  var bid=data.value;							
									  jq.post(sysUrl+'product/searchSid',{'bid':bid,model:modelName},function(data){ 
										  var datas=data.data;
										  if(datas.length>0){
											  $("#small").css("display","block");
											  var htmls="";
											   for(var i=0;i<datas.length;i++){
												  htmls+='<option value='+datas[i].id+'>'+datas[i].title+'</option>'; 
											  }
											  $("#sid").html(htmls);
											  form.render("select");
										  }else{
											 var htmls='<option value="0">请选择</option>'; 
											 $("#sid").html(htmls);
											 $("#small").css("display","none");										 
											 form.render("select");
										  }
						                });
								});
								
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
									var price = $("#price").val();
									var vipPrice = $("#vipPrice").val();
									var inventory = $("#inventory").val();
									var salesVolume = $("#salesVolume").val();
									var pic =$('#pic_app').attr("src");
									var bigPic =$('#pic_appBig').attr("src");
									var content = $("#content").val();
									var bid = $("#bid").val();

									
									if(title==""){
										layer.msg("请输入标题", {icon: 2,anim: 6, time: 1000});
										return;
									}
									if(bid==""){
										layer.msg("请选择产品一级类别", {icon: 2,anim: 6, time: 1000});
										return;
									}
									
									
									if(introduce==""){
										layer.msg("请输入摘要", {icon: 2,anim: 6, time: 1000});
										return;
									}
									if(price==""){
										layer.msg("请输入价格", {icon: 2,anim: 6, time: 1000});
										return;
									}
									if(vipPrice==""){
										layer.msg("请输入会员价格", {icon: 2,anim: 6, time: 1000});
										return;
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
										layer.msg("请添加小图片", {icon: 2,anim: 6, time: 1000});
										return;
									}
									if(bigPic==""){
										layer.msg("请添加大图片", {icon: 2,anim: 6, time: 1000});
										return;
									}
									if(content==""){
										layer.msg("请输入内容", {icon: 2,anim: 6, time: 1000});
										return;
									}
									data.field.pic = $('#pic_app').attr("pic_src");
									data.field.bigPic = $('#pic_appBig').attr("pic_src");
									var json = {where:JSON.stringify(data.field),modelName:'${modelName}'};
									jq.post(sysUrl+'product/addSubmit',json,function(data){
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
