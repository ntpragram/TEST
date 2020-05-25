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
							<input type="hidden" name="uid" value="${memberInfo.id}" title=" ">
								<div class="layui-form-item" style="margin-top: 30px">
									<label class="layui-form-label">会员ID</label>
									<div class="layui-input-block">
										<input type="text" name="memberId"  style="width:400px;"
											value="${memberInfo.id}" placeholder="请输入账号" required  lay-verify="required" autocomplete="off" readonly
											class="layui-input">
									</div>
								</div>
								<div class="layui-form-item" style="margin-top: 30px">
									<label class="layui-form-label">账号</label>
									<div class="layui-input-block">
										<input type="text" name="phone"  style="width:400px;"
											value="${memberInfo.phone}" placeholder="请输入账号" required  lay-verify="required" autocomplete="off" readonly
											class="layui-input">
									</div>
								</div>
								
								<div class="layui-form-item">
									<label class="layui-form-label">昵称</label>
									<div class="layui-input-block">
										<input type="text" name="nickname"  style="width:400px;"
											value="${memberInfo.nickName}" placeholder="用户暂未填写" required  lay-verify="required" autocomplete="off" readonly
											class="layui-input">
									</div>
								</div>
								
							
								<div class="layui-form-item">
									<label class="layui-form-label">注册时间</label>
									<div class="layui-input-block">
										<input type="text" name="intime"  style="width:400px;"
											value="${memberInfo.createTime}" placeholder="用户暂未填写" autocomplete="off" readonly
											class="layui-input">
									</div>
								</div>
							
							
								<div class="layui-form-item">
									<label class="layui-form-label">现有头像</label>
									<div class="layui-input-block">
										<img alt="暂无图片" src="<%=basePath%>${memberInfo.headPic}" id="pic_app" style="width: 200px;">
									</div>
								</div>

								<div class="layui-form-item">
									<label class="layui-form-label">性别</label>
									<div class="layui-input-block">
										<input type="text" name="sex"  style="width:400px;"
											<c:choose>
												<c:when test="${memberInfo.sex == 1}">value="男"</c:when>
												<c:when test="${memberInfo.sex == 2}">value="女"</c:when>
												<c:otherwise>value="未知"</c:otherwise>
											</c:choose>
											placeholder="用户暂未填写" autocomplete="off" readonly
											class="layui-input">
									</div>
								</div>
								
							
								<%-- <div class="layui-form-item">
									<label class="layui-form-label">微信号</label>
									<div class="layui-input-block">
										<input type="text" name="wxcode"  style="width:400px;"
											value="${memberInfo.wxcode}" placeholder="用户暂未填写" autocomplete="off" readonly
											class="layui-input">
									</div>
								</div>
								<div class="layui-form-item">
									<label class="layui-form-label">QQ号</label>
									<div class="layui-input-block">
										<input type="text" name="qqcode"  style="width:400px;"
											value="${memberInfo.qqcode}" placeholder="用户暂未填写" autocomplete="off" readonly
											class="layui-input">
									</div>
								</div>
							 --%>
								<div class="layui-form-item">
									<div class="layui-input-block">
										<a href="javascript:parent.location.reload();" style="color:#fff;background-color: #FF5722;" type="reset" class="layui-btn layui-btn-primary">返回</a>
									</div>
								</div>
								
						</div>
						<div style="display: none;">
							<input type="file" id="typePicApp" accept="image/jpg,image/png,image/jpeg" name="pic_app">
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
	function certification(id,type){
		alert("id:"+id+"type:"+type);
		var layer = layui.layer;
		layer.open({
		  type: 2,
		  icon: 2,
		  maxmin: true,
		  area: ['100%','100%'],
		  title: '认证详情',
		  content: 'toCertification?id=' + id+'&type='+type
		});
	}
</script>
</body>
</html>
