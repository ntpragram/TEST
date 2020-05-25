<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator"
	prefix="decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html>
<head>
<title><decorator:title default="掌上云杉管理后台" /></title>

<decorator:head />

<link rel="shortcut icon" href="favicon.ico">
<link rel="stylesheet" href="../../layui/css/layui.css">
<link rel="stylesheet" href="../../css/global.css">
<link rel="stylesheet" href="../../css/sweetalert.css" >
<script src="../../js/jquery.min.js?v=2.1.4"></script>
<script type="text/javascript" src="../../layui/layui.js"></script>
<script type="text/javascript" src="../../js/SysCommon.js"></script>
<script type="text/javascript" src="../../js/sweetalert.min.js"></script>
<script>
	var sysUrl = '${sysUrl}';
	var sysMerchantUrl = '${sysMerchantUrl}';
	var frontUrl = '${frontUrl}';
</script>

</head>
<body class="gray-bg">



<decorator:body/>
</body>
</html>
