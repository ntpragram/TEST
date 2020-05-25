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
<head>
<base href="<%=basePath%>">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script>
  var sysUrl = '${sysUrl}';
  var sysMerchantUrl = '${sysMerchantUrl}';
  var frontUrl = '${frontUrl}';
</script>
<link rel="stylesheet" href="layui/css/layui.css">
<link rel="stylesheet" href="css/global.css">
<script src="js/jquery.min.js?v=2.1.4"></script>
<script type="text/javascript" src="layui/layui.js"></script>
<script type="text/javascript" src="js/SysCommon.js"></script>
<link rel="stylesheet" href="css/sweetalert.css" >
<script type="text/javascript" src="js/sweetalert.min.js"></script>
<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=eb53c21e3ddf940f4ea1e9f412ba614d"></script> 
<script type="text/javascript" src="http://cache.amap.com/lbs/static/addToolbar.js"></script>
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
							<input type="hidden" name="id" value="${record.id}" title=" ">
							<input type="hidden" name="type" value="${record.type}" title=" ">
								<div class="layui-form-item" style="margin-top: 30px">
									<label class="layui-form-label">账号</label>
									<div class="layui-input-block">
										<input type="text" name="username"  style="width:400px;"
											value="${record.username}" placeholder="请输入账号" required  lay-verify="required" autocomplete="off" readonly
											class="layui-input">
									</div>
								</div>
								<div class="layui-form-item">
									<label class="layui-form-label">注册时间</label>
									<div class="layui-input-block">
										<input type="text" name="intime"  style="width:400px;"
											value="${record.intime}" placeholder="用户暂未填写" autocomplete="off" readonly
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
										<img alt="暂无图片" src="<%=basePath%>${record.pic}" id="pic_app" style="width: 20%;">
									</div>
								</div>	

								<c:if test="${resultData.type!=5}">
								<div class="layui-form-item">
									<label class="layui-form-label">公司名称</label>
									<div class="layui-input-block">
										<input type="text" name="company"  style="width:400px;"
											value="${record.company}" placeholder="用户暂未填写" autocomplete="off" 
											class="layui-input">
									</div>
								</div>
								</c:if>
								<div class="layui-form-item">
									<label class="layui-form-label">简介</label>
									<div class="layui-input-block">
										<input type="text" name="introduce"  style="width:400px;"
											value="${record.introduce}" placeholder="用户暂未填写" autocomplete="off" 
											class="layui-input">
									</div>
								</div>
								<c:if test="${resultData.type!=5}">
								<div class="layui-form-item">
									<label class="layui-form-label">详细地址</label>
									<div class="layui-input-block">
										<input type="text" name="address" id="address" 
											value="${record.address}" placeholder="请输入详细地址" required  lay-verify="" autocomplete="off"
											class="layui-input" style="width: 500px">
									</div>
								</div>	
								<div class="layui-form-item">
									<label class="layui-form-label">经纬度</label>
									<div class="layui-input-block">
										<input type="text" name="longitude" id="longitude" 
											value="${record.longitude},${record.latitude}" placeholder="请在下方地图上选择位置自动生成经纬度" required  lay-verify="" autocomplete="off" readonly
											class="layui-input" style="width: 500px">
									</div>
								</div>	
								<div class="layui-form-item">
									<label class="layui-form-label">地图选点</label>
									<div class="layui-input-block">
										<div id="container" style="width:600px; height:400px"></div>
									</div>
								</div>
								</c:if>
								
								<div class="layui-form-item">
									<div class="layui-input-block">
										<button class="layui-btn" lay-submit lay-filter="form">确认修改</button>
										<a href="javascript:parent.location.reload();" style="color:#fff;background-color: #FF5722;" type="reset" class="layui-btn layui-btn-primary">返回</a>
									</div>
								</div>
								
						</div>
						<div style="display: none;">
							<input type="file" id="typePicApp" accept="image/jpg,image/png,image/jpeg" name="pic_app">
						</div>
<script type="text/javascript">	
							$(function(){
								setAddress(1);
								$('#address').bind('input propertychange', function() {
									setAddress(1);
								});  
							})  
							var mapSearch;
							var map = new AMap.Map('container', {
								resizeEnable: true,
								zoom:11,
								center: [118.794192,32.064241]
							});

							//为地图注册click事件获取鼠标点击出的经纬度坐标
							var clickEventListener = map.on('click', function(e) {
								$("#longitude").val(e.lnglat.getLng() + ',' + e.lnglat.getLat());
							});
							
							
							AMap.service(["AMap.PlaceSearch"], function() {
								var placeSearch = new AMap.PlaceSearch({ //构造地点查询类
									map: map
								});
								//关键字查询
								mapSearch = function(address){
									console.log("address:"+address);
									placeSearch.search(address);
								}
							});
							function setAddress(sign){
							var addressDetail;
							if(sign==1){
							var address = $("#address").val();
							addressDetail = address;
							}
							mapSearch(addressDetail);
							}
							
							layui.use(['form','upload'], function() { 
								layui.upload({
								  elem:'#typePicApp',
								  url: sysMerchantUrl+'file/uploadImg',
								  ext: 'jpg|png|jpeg',
								  success: function(res){
								  	$('#pic_app').attr("src",res.data.img);
								  }
								}); 
								var form = layui.form();
								//监听提交
								form.on('submit(form)', function(data) {
									var pic =$('#pic_app').attr("src");
									data.field.pic = $('#pic_app').attr("src");	
									ajaxPOST("businessmodify", {
										where:JSON.stringify(data.field),
										modelName:'${modelName}'
									}, 
										function(data) {
											swalTip("提示", data.message, data.success,function(res){
												if(res){
													if(data.success){
														history.back();
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
</script>	
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
