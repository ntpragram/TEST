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
              <input type="hidden" name="roid" id="roid" value="${record.roid}" title="">                


                <div class="layui-form-item" style="margin-top: 30px">
                  <label class="layui-form-label">订单号</label>
                  <div class="layui-input-block">
                    <input type="text" name="onumber" id="onumber" 
                      value="${record.onumber}" placeholder=""  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div> 

                <div class="layui-form-item" >
                  <label class="layui-form-label">订单状态</label>
                  <div class="layui-input-block">
                    <input type="text" name="ostatusName" id="ostatusName" 
                      value="${record.ostatusName}" placeholder=""  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div>  

                <div class="layui-form-item" >
                  <label class="layui-form-label">下单用户</label>
                  <div class="layui-input-block">
                    <input type="text" name="username" id="username" 
                      value="${record.username}" placeholder=""  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div>

                <div class="layui-form-item" >
                  <label class="layui-form-label">订单总金额</label>
                  <div class="layui-input-block">
                    <input type="text" name="summoney" id="summoney" 
                      value="${record.summoney}" placeholder=""  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div>

                <div class="layui-form-item" >
                  <label class="layui-form-label">单房间金额</label>
                  <div class="layui-input-block">
                    <input type="text" name="money" id="money" 
                      value="${record.money}" placeholder=""  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div>

                <div class="layui-form-item" >
                  <label class="layui-form-label">房间数</label>
                  <div class="layui-input-block">
                    <input type="text" name="num" id="num" 
                      value="${record.num}" placeholder=""  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div>

                <div class="layui-form-item" >
                  <label class="layui-form-label">联系电话</label>
                  <div class="layui-input-block">
                    <input type="text" name="phone" id="phone" 
                      value="${record.phone}" placeholder=""  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div>

                <div class="layui-form-item" >
                  <label class="layui-form-label">入住人</label>
                  <div class="layui-input-block">
                    <input type="text" name="checkInPerson" id="checkInPerson" 
                      value="${record.checkInPerson}" placeholder=""  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div>

                <div class="layui-form-item" >
                  <label class="layui-form-label">入住时间</label>
                  <div class="layui-input-block">
                    <input type="text" name="rzTime" id="rzTime" 
                      value="${record.rzTime}" placeholder=""  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div>  

                <div class="layui-form-item" >
                  <label class="layui-form-label">离店时间</label>
                  <div class="layui-input-block">
                    <input type="text" name="ldTime" id="ldTime" 
                      value="${record.ldTime}" placeholder=""  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div> 

                <div class="layui-form-item" >
                  <label class="layui-form-label">备注</label>
                  <div class="layui-input-block">
                    <input type="text" name="remark" id="remark" 
                      value="<c:if test="${record.remark==''||record.remark==null}">无</c:if><c:if test="${record.remark!=''}">${record.remark}</c:if>" placeholder=""  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div> 

                <div class="layui-form-item" >
                  <label class="layui-form-label">商家</label>
                  <div class="layui-input-block">
                    <input type="text" name="merchantName" id="merchantName" 
                      value="${record.merchantName}" placeholder=""  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div>   

                <div class="layui-form-item" >
                  <label class="layui-form-label">酒店</label>
                  <div class="layui-input-block">
                    <input type="text" name="grogTitle" id="grogTitle" 
                      value="${record.grogTitle}" placeholder=""  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div> 

                <div class="layui-form-item" >
                  <label class="layui-form-label">房间编号</label>
                  <div class="layui-input-block">
                    <input type="text" name="roomNum" id="roomNum" 
                      value="${record.roomNum}" placeholder=""  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div> 

                <div class="layui-form-item" >
                  <label class="layui-form-label">下单时间</label>
                  <div class="layui-input-block">
                    <input type="text" name="intime" id="intime" 
                      value="${record.intime}" placeholder=""  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div> 

                <c:if test="${record.invoiceNumber!='' && record.invoiceNumber!=null}">

                <div class="layui-form-item" >
                  <label class="layui-form-label">发票编号</label>
                  <div class="layui-input-block">
                    <input type="text" name="invoiceNumber" id="invoiceNumber" 
                      value="${record.invoiceNumber}" placeholder=""  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div>

                <div class="layui-form-item" >
                  <label class="layui-form-label">发票类型</label>
                  <div class="layui-input-block">
                    <input type="text" name="type" id="type" 
                      value="<c:if test='${record.type==0}'>增值税普通发票</c:if><c:if test='${record.type==1}'>增值税专用发票</c:if>" placeholder=""  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div>

                <div class="layui-form-item" >
                  <label class="layui-form-label">收票抬头（<c:if test='${record.ptype==0}'>个人</c:if><c:if test='${record.ptype==1}'>单位</c:if>）</label>
                  <div class="layui-input-block">
                    <input type="text" name="invoiceTitle" id="invoiceTitle" 
                      value="${record.invoiceTitle}" placeholder=""  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div>

              <c:if test="${record.type!='0'}">
                <div class="layui-form-item" >
                  <label class="layui-form-label">收票信息</label>
                </div> 

                <div class="layui-form-item" >
                  <label class="layui-form-label">开具类型</label>
                  <div class="layui-input-block">
                    <input type="text" name="OpenType" id="OpenType" 
                      value="${record.OpenType}" placeholder=""  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div>

                <div class="layui-form-item" >
                  <label class="layui-form-label">税务登记号</label>
                  <div class="layui-input-block">
                    <input type="text" name="taxNumber" id="taxNumber" 
                      value="${record.taxNumber}" placeholder=""  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div>

                <c:if test="${record.type=='1'}">
                <div class="layui-form-item" >
                  <label class="layui-form-label">开户行</label>
                  <div class="layui-input-block">
                    <input type="text" name="bank" id="bank" 
                      value="${record.bank}" placeholder=""  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div>

                <div class="layui-form-item" >
                  <label class="layui-form-label">账号</label>
                  <div class="layui-input-block">
                    <input type="text" name="bankNumber" id="bankNumber" 
                      value="${record.bankNumber}" placeholder=""  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div>

                <div class="layui-form-item" >
                  <label class="layui-form-label">注册场所地址</label>
                  <div class="layui-input-block">
                    <input type="text" name="address" id="address" 
                      value="${record.address}" placeholder=""  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div>

                <div class="layui-form-item" >
                  <label class="layui-form-label">注册固定电话</label>
                  <div class="layui-input-block">
                    <input type="text" name="telephone" id="telephone" 
                      value="${record.telephone}" placeholder=""  lay-verify="" autocomplete="off"
                      class="layui-input" style="width: 300px" readonly>
                  </div>
                </div>                

                <div class="layui-form-item">
                  <label class="layui-form-label">营业执照复印件</label>
                  <div class="layui-input-block">
                    <img alt="暂无图片" src="<%=basePath%>${record.businessLicense}" id="businessLicense" style="width: 20%;">
                  </div>
                </div>

                <div class="layui-form-item">
                  <label class="layui-form-label">税务登记复印件</label>
                  <div class="layui-input-block">
                    <img alt="暂无图片" src="<%=basePath%>${record.taxRegistration}" id="taxRegistration" style="width: 20%;">
                  </div>
                </div>

                <div class="layui-form-item">
                  <label class="layui-form-label">一般纳税人资格认证复印件</label>
                  <div class="layui-input-block">
                    <img alt="暂无图片" src="<%=basePath%>${record.ChFP}" id="ChFP" style="width: 20%;">
                  </div>
                </div>
                </c:if>
                </c:if>
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
