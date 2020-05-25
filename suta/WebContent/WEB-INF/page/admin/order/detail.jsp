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
              <input type="hidden" name="id" id="id" value="${id}" title="">                


                <div class="layui-form-item" style="margin-top: 30px">
                  <label class="layui-form-label">订单号</label>
                  <div class="layui-input-block">
                    <input type="text" name="onumber" id="onumber" 
                      value="${onumber}" placeholder=""  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div> 

                <div class="layui-form-item" >
                  <label class="layui-form-label">订单状态</label>
                  <div class="layui-input-block">
                   <input type="text" name="sex"  style="width:300px;"
						<c:choose>
						<c:when test="${status==0}">value="待付款"</c:when>
						<c:when test="${status==1}">value="已付款"</c:when>
						<c:when test="${status==2}">value="卖家发货"</c:when>
						<c:when test="${status==3}">value=买家收货</c:when>
						<c:when test="${status==4}">value="买家寄送"</c:when>
						<c:when test="${status==5}">value="申请退货退款 待审核"</c:when>
						<c:when test="${status==6}">value="申请退货退款 审核通过"</c:when>
						<c:when test="${status==7}">value="申请退货退款 审核不通过"</c:when>
						<c:when test="${status==8}">value="取消交易"</c:when>
						<c:when test="${status==9}">value="已退款"</c:when>
						<c:when test="${status==10}">value="交易完成"</c:when>
						</c:choose>
						 autocomplete="off" readonly
						class="layui-input">
                  </div>
                </div>  

                <div class="layui-form-item" >
                  <label class="layui-form-label">下单用户</label>
                  <div class="layui-input-block">
                    <input type="text" name="musername" id="musername" 
                      value="${createOrderUser}" placeholder=""  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div>
                
                
                <c:if test="${userName!=null && userName !=''} ">
                
				 <div class="layui-form-item" >
                  <label class="layui-form-label">收货人</label>
                  <div class="layui-input-block">
                    <input type="text" name="busername" id="busername" 
                      value="${userName}" placeholder=""  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div>
                <div class="layui-form-item" >
                  <label class="layui-form-label">收货电话</label>
                  <div class="layui-input-block">
                    <input type="text" name="busername" id="busername" 
                      value="${phone}" placeholder=""  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div>
                
                
                <div class="layui-form-item" >
                  <label class="layui-form-label">收货地址</label>
                  <div class="layui-input-block">
                    <input type="text" name="busername" id="busername" 
                      value="${provinceName}+${cityName}+${districtName}+${addressDetail}" placeholder=""  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div>
                
                </c:if>
                
                
				 <div class="layui-form-item" >
                  <label class="layui-form-label">支付方式</label>
                  <div class="layui-input-block">
                   <input type="text" name="sex"  style="width:300px;"
						<c:choose>
							<c:when test="${zfStyle == 1}">value="支付宝"</c:when>
							<c:when test="${zfStyle == 2}">value="微信"</c:when>
						</c:choose>
						placeholder="用户暂未填写" autocomplete="off" readonly
						class="layui-input">
                  </div>
                </div>  

                <div class="layui-form-item" >
                  <label class="layui-form-label">订单总金额</label>
                  <div class="layui-input-block">
                    <input type="text" name="summoney" id="summoney" 
                      value="${allPrice}" placeholder=""  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div>

                <div class="layui-form-item" >
                  <label class="layui-form-label">实际消费</label>
                  <div class="layui-input-block">
                    <input type="text" name="paymoney" id="paymoney" 
                      value="${sfPrice}" placeholder=""  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div>
 				<div class="layui-form-item" >
                  <label class="layui-form-label">红包抵扣金额</label>
                  <div class="layui-input-block">
                    <input type="text" name="paytime" id="paytime" 
                      value="${redPacketPrice}" placeholder=""  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div> 
         
                <div class="layui-form-item" >
                  <label class="layui-form-label">下单时间</label>
                  <div class="layui-input-block">
                    <input type="text" name="intime" id="intime" 
                      value="${createTime}" placeholder=""  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div>  


 				<div class="layui-form-item" >
                  <label class="layui-form-label">产品名称</label>
                  <div class="layui-input-block">
                    <input type="text" name="intime" id="intime" 
                      value="${title}" placeholder=""  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div>  
                
                <div class="layui-form-item" >
                  <label class="layui-form-label">购买数量</label>
                  <div class="layui-input-block">
                    <input type="text" name="intime" id="intime" 
                      value="${num}" placeholder=""  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div>  

                <div class="layui-form-item" >
                  <label class="layui-form-label">备注</label>
                  <div class="layui-input-block">
                    <input type="text" name="remark" id="remark" 
                      value="<c:if test="${remark==''||remark==null}">无</c:if><c:if test="${remark!=''}">${remark}</c:if>" placeholder=""  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div> 
                
                
				<c:if test="${status==2}">
				 <div class="layui-form-item" >
                  <label class="layui-form-label">快递公司</label>
                  <div class="layui-input-block">
                    <input type="text" name="couriercompany" id="couriercompany" 
                      value="${courierCompany}" placeholder=""  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div> 
				 <div class="layui-form-item" >
                  <label class="layui-form-label">快递单号</label>
                  <div class="layui-input-block">
                    <input type="text" name="expresssingle" id="expresssingle" 
                      value="${CourierNumber}" placeholder=""  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div> 
				</c:if>
				
				
				
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

          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
