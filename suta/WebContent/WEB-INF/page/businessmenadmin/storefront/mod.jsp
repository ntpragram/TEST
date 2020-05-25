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
<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=eb53c21e3ddf940f4ea1e9f412ba614d"></script> 
<script type="text/javascript" src="http://cache.amap.com/lbs/static/addToolbar.js"></script>
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
</style>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content layui-form">
						<div class="layui-form" action="">
							<input type="hidden" name="type" id="type" value="${record.type}" title=" ">	
							<input type="hidden" name="gsid" id="gsid" value="${record.gsid}" title="">							
								<div class="layui-form-item">
            						
          						

								<div class="layui-form-item" >
									<label class="layui-form-label">酒店名称</label>
									<div class="layui-input-block">
										<input type="text" name="title" id="title" 
											value="${record.title}" placeholder="请输入酒店名称"  lay-verify="" autocomplete="off"
											class="layui-input" style="width: 300px">
									</div>
								</div>	
								<div class="layui-form-item">
            						<label class="layui-form-label">商家类型</label>
            						<div class="layui-input-inline input-custom-width">
            						  <select name="btype" id="btype" lay-verify="" lay-filter="province" style="display:block;height:38px;width: 150px" onchange="getSbtype()">
            						  <option value="${record.bid}" checked>${record.btitle}</option>
            						  <c:forEach items="${btypelist}" var="c">
            						  	<option value="${c.id}">${c.title}</option>
            						  </c:forEach>
            						  </select>           					
            						</div>
									<div class="layui-input-inline input-custom-width" >
            						  <select name="Sbtype" id="Sbtype" lay-verify="" lay-filter="province" style="display:block;height:38px;width: 150px">
            						  <option value="${record.sid}" checked>${record.stitle}</option>
            						  </select>           					
            						</div>
            						<div class="layui-form-mid layui-word-aux"></div>
          						</div>
								<div class="layui-form-item" >
									<label class="layui-form-label">酒店简介</label>
									<div class="layui-input-block">
										<input type="text" name="intro" id="intro" 
											value="${record.intro}" placeholder="请输入酒店简介"  lay-verify="" autocomplete="off"
											class="layui-input" style="width: 300px">
									</div>
								</div>

								<div class="layui-form-item" >
									<label class="layui-form-label">酒店起价(单位/元)</label>
									<div class="layui-input-block">
										<input type="text" name="price" id="price" 
										value="${record.price}" placeholder="请输入酒店起价" required  lay-verify="" autocomplete="off"
										class="layui-input" style="width: 300px" >
										<!-- onkeyup="value=value.replace(/^[0-9]*[1-9][0-9]*$/g,'')" -->
									</div>
								</div>	
								
								<div class="layui-form-item">
            						<label class="layui-form-label">退款选择项</label>
            						<div class="layui-input-inline input-custom-width">
            						  <select name="refunds" id="refunds" lay-verify="" lay-filter="province" style="display:block;height:38px;width: 100px" onchange="refund()">
            						  <c:choose>
									  <c:when test="${record.refunds==0}">
									  <option value="0" checked>全退</option>
									  </c:when>
									  <c:when test="${record.refunds==1}">
									  <option value="1" checked>不退</option>
									  </c:when>
									  <c:when test="${record.refunds==2}">
									  <option value="2" checked>收取手续费</option>
									  </c:when>
									  </c:choose>
            						  <option value="0" checked>全退</option>
            						  <option value="1" checked>不退</option>
            						  <option value="2" checked>收取手续费</option>
            						  </select>           					
            						</div>
            						<div class="layui-form-mid layui-word-aux"></div>
          						</div>
								
								<div class="layui-form-item" id="amounts" 
								<c:if test="${record.refunds!=2}">
								style="display:none"
								</c:if>
								>
									<label class="layui-form-label">手续费比例</label>
									<div class="layui-input-block">
										<input type="text" name="amount" id="amount" 
										value="${record.amount}" placeholder="收取手续费比例" required  lay-verify="" autocomplete="off"
										class="layui-input" style="width: 300px" >
										<!-- onkeyup="value=value.replace(/^[0-9]*[1-9][0-9]*$/g,'')" -->
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
            						  <select name="city" id="city" lay-verify="" style="display:block;height:38px;width: 150px" onchange="getDistrict()">
            						  <option value="${record.cityId}" checked>${record.cityName}</option>
                           <c:forEach items="${cityListInit}" var="v" varStatus="i">
                            <option value="${v.serialId}" <c:if test="${record.cityId==v.serialId}">selected</c:if>>${v.cityName}</option>
                          </c:forEach>
            						  </select>           					
            						</div>
            						<div class="layui-form-mid layui-word-aux"></div>
          						</div>

          						<div class="layui-form-item">
            						<label class="layui-form-label">区</label>
            						<div class="layui-input-inline input-custom-width">
            						  <select name="district" id="district" lay-verify="" style="display:block;height:38px;width: 150px" onchange="setAddress(3)">
            						  <option value="${record.districtId}" checked>${record.districtName}</option>
                          <c:forEach items="${districtListInit}" var="v" varStatus="i">
                            <option value="${v.serialId}" <c:if test="${record.districtId==v.serialId}">selected</c:if>>${v.districtName}</option>
                          </c:forEach>
            						  </select>           					
            						</div>
            						<div class="layui-form-mid layui-word-aux"></div>
          						</div>

								
								<div class="layui-form-item" >
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
                      value="${record.longitudeAndLatitude}" placeholder="请在下方地图上选择位置自动生成经纬度" required  lay-verify="" autocomplete="off" readonly
                      class="layui-input" style="width: 500px">
                  </div>
                </div>  
                
                <div class="layui-form-item">
                  <label class="layui-form-label">地图选点</label>
                  <div class="layui-input-block">
                    <div id="container" style="width:600px; height:400px"></div>
                  </div>
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
				function refund(){
								var refunds = $("#refunds").val();
								if(refunds==2){
									$("#amounts").css("display","block");
								}else{
									$("#amounts").css("display","none");
								}
							}
			 $(function(){
				setAddress(3);				  
                $('#address').bind('input propertychange', function() {
                  setAddress(3);
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
                mapSearch = function(title){
                  placeSearch.search(title);
                }
              });
              
              
              function setAddress(sign){
                var addressDetail;
                if(sign == 1){
                  var province = $("#province option:selected").html();
                  var address = $("#address").val();
                  addressDetail = province + address;
                }else if(sign == 2){
                  var province = $("#province option:selected").html();
                  var city = $("#city option:selected").html();
                  var address = $("#address").val();
                  addressDetail = province + city + address;
                }else if(sign == 3){
                  var province = $("#province option:selected").html();
                  var city = $("#city option:selected").html();
                  var district = $("#district option:selected").html();
                  var address = $("#address").val();
                  addressDetail = province + city + district + address;
                }
                
                console.log("addressDetail:"+addressDetail);
                mapSearch(addressDetail);
              }


							var getCity,getDistrict,getSbtype;	
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
                  jq.post('businessmenadmin/grogshop/getCityList',json,function(data){
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
                  
                  setAddress(1);
                }

                getDistrict = function(){
                  var cityId = $("#city option:selected").val();
                  if(cityId==""){
                        $("#district option").remove();
                        $("#district").append( "<option value=''>请选择区</option>" );
                        return;
                    }

                  var json = {cityId:cityId};
                  jq.post('businessmenadmin/grogshop/getDistrictList',json,function(data){
                    //console.log("data:"+JSON.stringify(data));                  
                    if(data.code==200){
                      var districtList = data.data;
                          $("#district option").remove(); 
                          $("#district").append( "<option value=''>请选择区</option>" );
                          for(var i=0;i<districtList.length;i++){
                          $("#district").append( "<option value="+districtList[i].serialId+">"+districtList[i].districtName+"</option>" );
                          }
                    }
                  });
                  
                  setAddress(2);
                }
				getSbtype = function(){
									var pid = $("#btype option:selected").val();
									//alert("pid:"+pid);
									if(pid==""){
      									$("#Sbtype option").remove();
      									$("#Sbtype").append( "<option value=''>请选择二级类</option>" );
      									return;
    								}

									var json = {pid:pid};
									jq.post('businessmenadmin/business/getSbtype',json,function(data){
										console.log("data:"+JSON.stringify(data));									
										if(data.code==200){
											var SbtypeList = data.data;
      										$("#Sbtype option").remove(); 
      										$("#Sbtype").append( "<option value='0'>请选择二级类</option>" );
      										for(var i=0;i<SbtypeList.length;i++){
      										$("#Sbtype").append( "<option value="+SbtypeList[i].id+">"+SbtypeList[i].title+"</option>" );
      										}
										}
									});
								}



							//初始化
					
							var hot = '${record.hot}';

								layui.upload({
								  elem:'#typePicApp',
								  url: sysMerchantUrl+'file/uploadImg',
								  ext: 'jpg|png|jpeg',
								  success: function(res){
								  	$('#pic_app').attr("src",res.data.img);
								  }
								}); 

								
								
								//表单验证
								form.verify({
									//编辑器数据同步
									layedit: function(value) {
									
									}
								}); 


								var form = layui.form();
								//监听提交
								form.on('submit(form)', function(data) {

									var title = $("#title").val();
									var intro = $("#intro").val();
									var price = $("#price").val();
									var pic =$('#pic_app').attr("src");/*$("#typePicApp").val();*/
									var province = $("#province option:selected").val();
									var city = $("#city option:selected").val();
									var district = $("#district option:selected").val();

									var provinceName = $("#province option:selected").text();
									var cityName = $("#city option:selected").text();
									var districtName = $("#district option:selected").text();
									var shengShiQu = provinceName+cityName+districtName;

									var address = $("#address").val();
									var phone = $("#phone").val();

									

									
									if(title==""){
										layer.msg("请输入酒店名称", {icon: 2,anim: 6, time: 1000});
										return;
									}
									if(intro==""){
										layer.msg("请输入酒店简介", {icon: 2,anim: 6, time: 1000});
										return;
									}
									if(price==""){
										layer.msg("请输入酒店价格", {icon: 2,anim: 6, time: 1000});
										return;
									}else{
										var reg = /^([1-9]\d*|0)(\.\d{1,2})?$/;
										if(!reg.test(price)){
											layer.msg("酒店价格格式不正确", {icon: 2,anim: 6, time: 1000});
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

									if(district==""){
										layer.msg("请选择区", {icon: 2,anim: 6, time: 1000});
										return;
									}

									if(address==""){
										layer.msg("请填写详细地址", {icon: 2,anim: 6, time: 1000});
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
									data.field.shengShiQu = shengShiQu;
									console.log("data:"+JSON.stringify(data.field));
									var json = {where:JSON.stringify(data.field),modelName:'${modelName}'};
                					jq.post('businessmenadmin/grogshop/modifyGrogshop',json,function(data){
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
