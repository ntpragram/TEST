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


                <c:forEach items="${orderSonDetail}" var="v" varStatus="i">
								<div class="layui-form-item" style="margin-top: 30px">
									<label class="layui-form-label">产品${v.id}</label>
									<div class="layui-input-block">
										<input type="text" name="title" 
											value="${v.title}  *  ${v.num}" placeholder="请输入标题" required readonly lay-verify="" autocomplete="off"
											class="layui-input">
									</div>
								</div>
								
				</c:forEach>
          
				
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
