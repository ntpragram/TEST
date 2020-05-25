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
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div>  

                <div class="layui-form-item" >
                  <label class="layui-form-label">酒店简介</label>
                  <div class="layui-input-block">
                    <input type="text" name="intro" id="intro" 
                      value="${record.intro}" placeholder="请输入酒店简介"  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div>

                <div class="layui-form-item" >
                  <label class="layui-form-label">酒店起价(单位/元)</label>
                  <div class="layui-input-block">
                    <input type="text" name="price" id="price" 
                    value="${record.price}" placeholder="请输入酒店起价" required  lay-verify="" autocomplete="off"
                    class="layui-input" style="width: 300px" readonly>
                    <!-- onkeyup="value=value.replace(/^[0-9]*[1-9][0-9]*$/g,'')" -->
                  </div>
                </div>  


                <div class="layui-form-item">
                  <label class="layui-form-label">图片</label>
                  <div class="layui-input-block">
                    <img alt="暂无图片" src="<%=basePath%>${record.pic}" id="pic_app" style="width: 20%;">
                  </div>
                </div>  

               

                      <div class="layui-form-item">
                        <label class="layui-form-label">热门酒店</label>
                        <div class="layui-input-block">
                        <input type="text" name="hot" id="hot" 
                          value="<c:if test="${record.hot=='0'}">否</c:if><c:if test="${record.hot=='1'}">是</c:if>" placeholder=""  lay-verify="" autocomplete="off"
                          class="layui-input" style="width: 300px" readonly>
                        </div>
                      </div>

                         

                      <div class="layui-form-item">
                        <label class="layui-form-label">省</label>
                        <div class="layui-input-block">
                        <input type="text" name="province" id="province" 
                          value="${record.provinceName}" placeholder="" required  lay-verify="" autocomplete="off"
                          class="layui-input" style="width: 500px" readonly="">
                        </div>
                      </div>

                      <div class="layui-form-item">
                        <label class="layui-form-label">市</label>
                       <input type="text" name="city" id="city" 
                          value="${record.cityName}" placeholder="" required  lay-verify="" autocomplete="off"
                          class="layui-input" style="width: 500px" readonly="">
                        </div>
                      </div>

                      <div class="layui-form-item">
                        <label class="layui-form-label">区</label>
                        <input type="text" name="district" id="district" 
                          value="${record.districtName}" placeholder="" required  lay-verify="" autocomplete="off"
                          class="layui-input" style="width: 500px" readonly="">
                        </div>
                      </div>

                
                <div class="layui-form-item" >
                  <label class="layui-form-label">详细地址</label>
                  <div class="layui-input-block">
                    <input type="text" name="address" id="address" 
                      value="${record.address}" placeholder="请输入详细地址" required  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 500px" readonly="">
                  </div>
                </div>  

                <div class="layui-form-item">
                  <label class="layui-form-label">经纬度</label>
                  <div class="layui-input-block">
                    <input type="text" name="longitude" id="longitude" 
                      value="${record.longitudeAndLatitude}" placeholder="" required  lay-verify="" autocomplete="off" readonly
                      class="layui-input" style="width: 500px">
                  </div>
                </div>  

                <div class="layui-form-item" >
                  <label class="layui-form-label">联系电话</label>
                  <div class="layui-input-block">
                    <input type="text" name="phone" id="phone"
                      value="${record.phone}" placeholder="请输入联系电话" required  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div>  

                

                <div class="layui-form-item">
                  <div class="layui-input-block">
                    <button class="layui-btn layui-btn-small layui-btn-normal ajax-all" >
                      <img src="<%=basePath%>images/back2.png">
                      <a href="javascript: 
                        window.parent.layer.close(parent.layer.getFrameIndex(window.name));">返回</a>
                    </button>
                  </div>
                </div>                          

            </div>
            <div style="display: none;">
              <input type="file" id="typePicApp" accept="image/jpg,image/png,image/jpeg" name="pic_app" >
            </div>
            <script type="text/javascript">           
          
              var getCity,getDistrict;  
              layui.use(['element', 'laypage', 'layer', 'form','upload','layedit'], function() {;  
              
              var element = layui.element()
                        ,laypage = layui.laypage
                        ,jq = layui.jquery
                        ,layedit = layui.layedit
                    ,laydate = layui.laydate
                        ,form = layui.form();           

                layui.upload({
                  elem:'#typePicApp',
                  url: sysUrl+'file/uploadImg',
                  ext: 'jpg|png|jpeg',
                  success: function(res){
                    $('#pic_app').attr("src",res.data.img);
                  }
                }); 

                var content_ = layedit.build('content', {
                  tool: [                    
                  ],
                  uploadImage: {
                    url: sysUrl+'file/uploadImage',
                    type: 'post'
                  },
                  height: 300,
                  disabled:true

                });

                var hotelPolicy_ = layedit.build('hotelPolicy', {
                  tool: [
                  ],
                  uploadImage: {
                    url: sysUrl+'file/uploadImage',
                    type: 'post'
                  },
                  height: 300,
                  disabled:true
                });

                var facilityServices_ = layedit.build('facilityServices', {
                  tool: [
                    ],
                  uploadImage: {
                    url: sysUrl+'file/uploadImage',
                    type: 'post'
                  },
                  height: 300,
                  disabled:true
                });

                var pccontent_ = layedit.build('pccontent', {
                  tool: [
                    ],
                  uploadImage: {
                    url: sysUrl+'file/uploadImage',
                    type: 'post'
                  },
                  height: 300,
                  disabled:true
                });

                var pchotelPolicy_ = layedit.build('pchotelPolicy', {
                  tool: [
                    ],
                  uploadImage: {
                    url: sysUrl+'file/uploadImage',
                    type: 'post'
                  },
                  height: 300,
                  disabled:true
                });

                var pcfacilityServices_ = layedit.build('pcfacilityServices', {
                  tool: [
                   ],
                  uploadImage: {
                    url: sysUrl+'file/uploadImage',
                    type: 'post'
                  },
                  height: 300,
                  disabled:true
                });
                
                //表单验证
                form.verify({
                  //编辑器数据同步
                  layedit: function(value) {
                    layedit.sync(content_);
                    layedit.sync(hotelPolicy_);
                    layedit.sync(facilityServices_);
                    layedit.sync(pccontent_);
                    layedit.sync(pchotelPolicy_);
                    layedit.sync(pcfacilityServices_);
                  }
                }); 

              });



            </script>

          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
