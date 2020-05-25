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
<script>
	var sysUrl = '${sysUrl}';
	var sysMerchantUrl = '${sysMerchantUrl}';
	var frontUrl = '${frontUrl}';
</script>
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

.layui-form-checkbox{
	margin-left: 15px;
}
</style>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content layui-form">
					<input type="hidden" id="gsid" name="gsid"  value="${gsid}" >
					<input type="hidden" id="businesstype" name="businesstype"  value="${businesstype}" >
						<div class="layui-form" action="">
								<div class="layui-form-item" style="margin-top: 30px">
								<c:if test="${businesstype==1}">
									<label class="layui-form-label">餐厅名称</label>
								</c:if>
								<c:if test="${businesstype==2}">
								    <label class="layui-form-label">商品标题</label>
								</c:if>
									<div class="layui-input-block">
										<input type="text" name="title" id="title" 
											value="" placeholder="请输入内容"  lay-verify="" autocomplete="off"
											class="layui-input" style="width: 300px">
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
								
								
								
								
						<c:if test="${businesstype==1}">
								<div class="layui-form-item">
									<label class="layui-form-label">桌数</label>
									<div class="layui-input-block">
										<input type="text" name="desk" id="desk" 
											value="" placeholder="请输入桌数"  lay-verify="" autocomplete="off"
											class="layui-input" style="width: 300px">
									</div>
								</div>

								<div class="layui-form-item">
									<label class="layui-form-label">餐厅最低消费(单位/元)</label>
									<div class="layui-input-block">
										<input type="text" name="price" id="price" 
										value="" placeholder="请输入餐厅最低消费" required  lay-verify="" autocomplete="off"
										class="layui-input" style="width: 300px" >
										<!-- onkeyup="value=value.replace(/^[0-9]*[1-9][0-9]*$/g,'')" -->
									</div>
								</div>
								
								<div class="layui-form-item">
									<label class="layui-form-label">餐厅最高消费(单位/元)</label>
									<div class="layui-input-block">
										<input type="text" name="endprice" id="endprice" 
										value="" placeholder="请输入餐厅最高消费" required  lay-verify="" autocomplete="off"
										class="layui-input" style="width: 300px" >
										<!-- onkeyup="value=value.replace(/^[0-9]*[1-9][0-9]*$/g,'')" -->
									</div>
								</div>

								<div class="layui-form-item">
									<label class="layui-form-label">面积</label>
									<div class="layui-input-block">
										<input type="text" name="area" id="area" 
											value="" placeholder="请输入餐厅面积" required  lay-verify="" autocomplete="off"
											class="layui-input" style="width: 500px">
									</div>
								</div>

								<div class="layui-form-item" >
									<label class="layui-form-label">高度</label>
									<div class="layui-input-block">
										<input type="text" name="hige" id="hige"
											value="" placeholder="请输入餐厅高度" required  lay-verify="" autocomplete="off"
											class="layui-input" style="width: 300px">
									</div>
								</div>	
								<div class="layui-form-item" >
									<label class="layui-form-label">餐厅柱子</label>
									<div class="layui-input-block">
										<input type="text" name="pillar" id="pillar"
											value="" placeholder="请输入餐厅的柱子" required  lay-verify="" autocomplete="off"
											class="layui-input" style="width: 300px">
									</div>
								</div>	
								<div class="layui-form-item" >
									<label class="layui-form-label">餐厅形状</label>
									<div class="layui-input-block">
										<input type="text" name="shape" id="shape"
											value="" placeholder="请输入餐厅的形状" required  lay-verify="" autocomplete="off"
											class="layui-input" style="width: 300px">
									</div>
								</div>
								</c:if>
								<c:if test="${businesstype==2}">
									<div class="layui-form-item">
									<label class="layui-form-label">商品原价(单位/元)</label>
									<div class="layui-input-block">
										<input type="text" name="oprice" id="oprice" 
										value="" placeholder="请输入原价" required  lay-verify="" autocomplete="off"
										class="layui-input" style="width: 300px" >
										<!-- onkeyup="value=value.replace(/^[0-9]*[1-9][0-9]*$/g,'')" -->
									</div>
								</div>
								<div class="layui-form-item">
									<label class="layui-form-label">商品现价(单位/元)</label>
									<div class="layui-input-block">
										<input type="text" name="cprice" id="cprice" 
										value="" placeholder="请输入现价" required  lay-verify="" autocomplete="off"
										class="layui-input" style="width: 300px" >
										<!-- onkeyup="value=value.replace(/^[0-9]*[1-9][0-9]*$/g,'')" -->
									</div>
								</div>
								</c:if>
								<div class="layui-form-item">
									<label class="layui-form-label">套餐详情</label>
									<div class="layui-input-block" style="width:800">
										<textarea id="details" name="details" lay-verify="layedit" autocomplete="off" placeholder="请输入内容" class="layui-textarea layui-hide" >${record.details}</textarea>
									</div>
								</div>
								<div class="layui-form-item">
									<label class="layui-form-label">购买须知</label>
									<div class="layui-input-block" style="width:800">
										<textarea id="description" name="description" lay-verify="layedit" autocomplete="off" placeholder="请输入内容" class="layui-textarea layui-hide">${record.description}</textarea>
									</div>
								</div>
								<div class="layui-form-item">
									<div class="layui-input-block">
										<button class="layui-btn" lay-submit lay-filter="form">立即提交</button>
										<button class="layui-btn" type="button" onClick="backtrack();">返回</button>
										<!-- <button type="reset" class="layui-btn layui-btn-primary">重置</button> -->
									</div>
								</div>

						</div>
						<div style="display: none;">
							<input type="file" id="typePicApp" accept="image/jpg,image/png,image/jpeg" name="pic_app" >
						</div>
						<script type="text/javascript">	
							layui.use(['element', 'laypage', 'layer', 'form','upload','layedit'], function() {;  
							
								var element = layui.element()
            						,laypage = layui.laypage
            						,jq = layui.jquery
            						,layedit = layui.layedit
  									,laydate = layui.laydate
            						,form = layui.form();

								layui.upload({
								  elem:'#typePicApp',
								  url: sysMerchantUrl+'file/uploadImg',
								  ext: 'jpg|png|jpeg',
								  success: function(res){
								  	$('#pic_app').attr("src",res.data.img);
								  }
								}); 
								
								var details = layedit.build('details', {
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
										url: sysMerchantUrl+'file/uploadImage',
										type: 'post'
									},
									height: 300
								});
								
								var description = layedit.build('description', {
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
										url: sysMerchantUrl+'file/uploadImage',
										type: 'post'
									},
									height: 300
								});
								
								
								//表单验证
								form.verify({
									//编辑器数据同步
									layedit: function(value) {
										layedit.sync(details);
										layedit.sync(description);
									}
								});
								
								
								var form = layui.form();
								//监听提交
								form.on('submit(form)', function(data) {

									var title = $("#title").val();
									var price = $("#price").val();
									var pic =$('#pic_app').attr("src");/*$("#typePicApp").val();*/
									var phone = $("#phone").val();

									if(title==""){
										layer.msg("请输入标题名称", {icon: 2,anim: 6, time: 1000});
										return;
									}
									if(pic==""){
										layer.msg("请选择图片",{icon:2,anim:6,time:1000});
									}

								
									data.field.pic = $('#pic_app').attr("src");	
									console.log("data:"+JSON.stringify(data.field));
									var json = {where:JSON.stringify(data.field),modelName:'${modelName}'};
                					jq.post('businessmenadmin/room/addHall',json,function(data){
										console.log("data:"+JSON.stringify(data));
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
								url : sysMerchantUrl+url,
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
						//返回
						function backtrack(){
							var index = parent.layer.getFrameIndex(window.name);
							window.parent.layer.close(index);
						}
						</script>

					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
