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
<link rel="shortcut icon" href="favicon.ico">
<link rel="stylesheet" href="<%=basePath%>layui/css/layui.css">
<link rel="stylesheet" href="<%=basePath%>css/global.css">
<link rel="stylesheet" href="<%=basePath%>css/sweetalert.css" >
<script src="<%=basePath%>js/jquery.min.js?v=2.1.4"></script>
<script type="text/javascript" src="<%=basePath%>layui/layui.js"></script>
<script type="text/javascript" src="<%=basePath%>js/SysCommon.js"></script>
<script type="text/javascript" src="<%=basePath%>js/sweetalert.min.js"></script>
<script>
	var sysUrl = '${sysUrl}';
	var sysMerchantUrl = '${sysMerchantUrl}';
	var frontUrl = '${frontUrl}';
</script>
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
					<input type="hidden" name="id" id="id" value="${record.id}" title=" ">
						<div class="layui-form" action="">
								<div class="layui-form-item" style="margin-top: 30px">
									<label class="layui-form-label">主持人姓名</label>
									<div class="layui-input-block" style="width: 300px">
										<input type="text" name="realname" id="realname" 
											value="${record.realname}" placeholder="请输入主持人姓名"  lay-verify="" autocomplete="off"
											class="layui-input">
									</div>
								</div>																
								<div class="layui-form-item">
									<label class="layui-form-label">头像</label>
									<div class="layui-input-block">
										<a href="javascript:$('#typePicApp').click();" class="layui-btn layui-btn-primary">上传图片</a>
									</div>
								</div>

								<div class="layui-form-item">
									<label class="layui-form-label">头像</label>
									<div class="layui-input-block">
										<img alt="暂无图片" src="<%=basePath%>${record.headpic}" id="pic_app" style="width: 20%;">
									</div>
								</div>				
								
								<div class="layui-form-item">
									<label class="layui-form-label">性别</label>
									<div class="layui-input-block">
										<select id="sex" name="sex" style="display:block;height:38px;width:80px">
										<c:choose>
										<c:when test="${record.sex==1}">
										<option value="1">男</option>
										</c:when>
										<c:when test="${record.sex==2}">
										<option value="2">女</option>
										</c:when>
										</c:choose>
										<c:choose>
										<c:when test="${record.sex==1}">
										<option value="2">女</option>
										</c:when>
										<c:when test="${record.sex==2}">
										<option value="1">男</option>
										</c:when>
										</c:choose>
										</select>
									</div>
								</div>
								<div class="layui-form-item">
									<label class="layui-form-label">身高（取整）</label>
									<div class="layui-input-block">
										<input type="text" name="height" id="height" 
											value="${record.height}" placeholder="请输入主持人身高"  lay-verify="" autocomplete="off"
											class="layui-input" style="width: 300px">
									</div>
								</div>
								<div class="layui-form-item">
									<label class="layui-form-label">主持人年龄</label>
									<div class="layui-input-block">
										<input type="text" name="age" id="age" 
											value="${record.age}" placeholder="请输入主持人年龄"  lay-verify="" autocomplete="off"
											class="layui-input" style="width: 300px">
									</div>
								</div>
								<div class="layui-form-item">
									<label class="layui-form-label">主持人学历</label>
									<div class="layui-input-block">
										<select id="educationId" name="educationId" style="display:block;height:38px;">
										<option value="${record.educationId}">${record.etitle}</option>
										<c:forEach items="${educationList}" var="v">
										<option value="${v.id}">${v.title}</option>
										</c:forEach>
										</select>
									</div>
								</div>
								<div class="layui-form-item">
									<label class="layui-form-label">主持人简介</label>
									<div class="layui-input-block">
										<input type="text" name="introduce" id="introduce" 
											value="${record.introduce}" placeholder="请输入主持人简介"  lay-verify="" autocomplete="off"
											class="layui-input" style="width: 300px">
									</div>
								</div>
								
								<div class="layui-form-item">
									<label class="layui-form-label">工作经历</label>
									<div class="layui-input-block" style="width: 300px">
										<textarea name="experience" id="experience" lay-verify="layedit" autocomplete="off" placeholder="请输入内容" class="layui-textarea layui-hide">${record.experience}</textarea>
									</div>
								</div>

								<div class="layui-form-item">
									<label class="layui-form-label">酬金(单位/元)</label>
									<div class="layui-input-block">
										<input type="text" name="pay" id="pay" 
										value="${record.pay}" placeholder="请输入主持人酬金" required  lay-verify="" autocomplete="off"
										class="layui-input" style="width: 300px" >
										<!-- onkeyup="value=value.replace(/^[0-9]*[1-9][0-9]*$/g,'')" -->
									</div>
								</div>	

								<div class="layui-form-item">
									<label class="layui-form-label">酬金单位</label>
									<div class="layui-input-block">
										<input type="text" name="danwei" id="danwei" 
										value="${record.danwei}" placeholder="场/小时/次/每首歌等等" required  lay-verify="" autocomplete="off"
										class="layui-input" style="width: 300px" >
										<!-- onkeyup="value=value.replace(/^[0-9]*[1-9][0-9]*$/g,'')" -->
									</div>
								</div>
								
          						<div class="layui-form-item">
            						<label class="layui-form-label">省</label>
            						<div class="layui-input-inline input-custom-width">
            						  <select name="province" id="province" lay-verify="" lay-filter="province" style="display:block;height:38px;width: 150px" onchange="getCity()">
            						  <option value="${record.provinceId}" checked>${record.c.provinceName}</option>
            						  <c:forEach items="${provinceList}" var="v" varStatus="i">
            						  	<option value="${v.serialId}" <c:if test="${record.provinceId==v.serialId}">selected</c:if>>${v.provinceName}</option>
            						  </c:forEach>
            						  </select>           					
            						</div>
            						<div class="layui-form-mid layui-word-aux"></div>
          						</div>

          						<div class="layui-form-item">
            						<label class="layui-form-label">市</label>
            						<div class="layui-input-inline input-custom-width">
            						  <select name="city" id="city" lay-verify="" style="display:block;height:38px;width: 150px" >
            						  <option value="${record.cityId}" checked>${record.cityName}</option>
                           <c:forEach items="${cityListInit}" var="v" varStatus="i">
                            <option value="${v.serialId}" <c:if test="${record.cityId==v.serialId}">selected</c:if>>${v.cityName}</option>
                          </c:forEach>
            						  </select>           					
            						</div>
            						<div class="layui-form-mid layui-word-aux"></div>
          						</div>
								
								<div class="layui-form-item" >
									<label class="layui-form-label">联系电话</label>
									<div class="layui-input-block">
										<input type="text" name="phone" id="phone"
											value="${record.phone}" placeholder="请输入联系电话" required  lay-verify="" autocomplete="off"
											class="layui-input" style="width: 300px">
									</div>
								</div>	



								<div class="layui-form-item">
									<div class="layui-input-block">
									<a href="javascript:parent.location.reload();" style="color:#fff;background-color: #FF5722;" type="reset" class="layui-btn layui-btn-primary">返回</a>
										<button class="layui-btn" lay-submit lay-filter="form">提交修改</button>
										<!-- <button type="reset" class="layui-btn layui-btn-primary">重置</button> -->
									</div>
								</div>

						</div>
						<div style="display: none;">
							<input type="file" id="typePicApp" accept="image/jpg,image/png,image/jpeg" name="pic_app" >
						</div>

						<script type="text/javascript">
								var getCity;	
							layui.use(['element', 'laypage', 'layer', 'form','upload','layedit'], function() {;  
							
							var element = layui.element()
            						,laypage = layui.laypage
            						,jq = layui.jquery
            						,layedit = layui.layedit
  									,laydate = layui.laydate
            						,form = layui.form();

							getCity = function(){
                  var provinceId = $("#province option:selected").val();

                  if(provinceId==""){
                        $("#city option").remove(); 
                        $("#district option").remove();
                        $("#city").append( "<option value=''>请选择市</option>" );
                        $("#district").append( "<option value=''>请选择区</option>" );
                        return;
                    }

                  var json = {provinceId:provinceId};
                  jq.post('getCityList',json,function(data){
                    //console.log("data:"+JSON.stringify(data));                  
                    if(data.code==200){
                      var cityList = data.data;
                      $("#city option").remove(); 
                          $("#district option").remove(); 
                          $("#city").append( "<option value=''>请选择市</option>" );
                          $("#district").append( "<option value=''>请选择区</option>" );
                          for(var i=0;i<cityList.length;i++){
                          $("#city").append( "<option value="+cityList[i].serialId+">"+cityList[i].cityName+"</option>" );
                          }
                    }
                  });
                }

								layui.upload({
								  elem:'#typePicApp',
								  url: sysUrl+'file/uploadImg',
								  ext: 'jpg|png|jpeg',
								  success: function(res){
								  	$('#pic_app').attr("src","../../"+res.data.img);
								  	//$('#pic_app').attr("src",res.data.img);
									console.log("src:"+url);
								  }
								}); 
								var experience = layedit.build('experience', {
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
									layedit.sync(experience);
									}
								}); 


								var form = layui.form();
								//监听提交
								form.on('submit(form)', function(data) {

									var realname = $("#realname").val();
									var introduce = $("#introduce").val();
									var pay = $("#pay").val();
									var pic =$('#pic_app').attr("src");/*$("#typePicApp").val();*/
									var province = $("#province option:selected").val();
									var city = $("#city option:selected").val();
									var sex = $("#sex").val();
									var phone = $("#phone").val();

									

									
									if(realname==""){
										layer.msg("请输入主持人", {icon: 2,anim: 6, time: 1000});
										return;
									}
									if(introduce==""){
										layer.msg("请输入简介", {icon: 2,anim: 6, time: 1000});
										return;
									}
									if(pay==""){
										layer.msg("请输入酬金", {icon: 2,anim: 6, time: 1000});
										return;
									}else{
										var reg = /^([1-9]\d*|0)(\.\d{1,2})?$/;
										if(!reg.test(pay)){
											layer.msg("式不正确", {icon: 2,anim: 6, time: 1000});
											return;
										}
									}

									if(pic==""){
										layer.msg("请上传图片", {icon: 2,anim: 6, time: 1000});
										return;
									}

									if(province==""){
										layer.msg("请选择省", {icon: 2,anim: 6, time: 1000});
										return;
									}

									if(city==""){
										layer.msg("请选择市", {icon: 2,anim: 6, time: 1000});
										return;
									}

									if(phone==""){
										layer.msg("请填写联系电话", {icon: 2,anim: 6, time: 1000});
										return;
									}else{
										var myreg = /^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\d{8}$/;
										if(!myreg.test(phone)){
											layer.msg("请填写有效联系电话", {icon: 2,anim: 6, time: 1000});
										}
									}

									

									data.field.pic = $('#pic_app').attr("src");	
									console.log("data:"+JSON.stringify(data.field));
									var json = {where:JSON.stringify(data.field),modelName:'${modelName}'};
                					jq.post('modifyCompere',json,function(data){
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
