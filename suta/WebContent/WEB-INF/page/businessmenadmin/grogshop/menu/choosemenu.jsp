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
  //返回
	function backtrack(){
		window.parent.layer.close(parent.layer.getFrameIndex(window.name));
	}
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
.inline-block{
	display: inline-block !important;
	margin-left: 20px;
}
.layui-form-checkbox{
	display:none;
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
              <input type="hidden" name="pid" id="pid" value="${record.pid}" title="">             
                <div class="layui-form-item">
                        
				<div class="layui-form-item" style="margin-top: 30px">
					<div class="layui-input-block" style="margin: 0 80px;">
					<c:forEach items="${MenuList}" var="v">
                    	<div style="display:inline-block;width:200px;">
						<input name="mids" type="checkbox" value="${v.mid}" class="inline-block" id="${v.mid}"/>
                        
                        <label for="${v.mid}">${v.title}</label>
                        </div>
					</c:forEach>
					</div>
				</div>


                <div class="layui-form-item">
                  <div style="margin-left: 100px">
				  <button class="layui-btn layui-btn-small" lay-submit lay-filter="form" >点击提交</button>
                    <!--<button class="layui-btn layui-btn-small layui-btn-normal ajax-all" onclick="backtrack()" style="margin-left: 30px">
                      <img src="<%=basePath%>images/back2.png">
                      <span>返回</span>
                    </button>-->
                  </div>
                </div>     

            </div>
            <div style="display: none;">
              <input type="file" id="typePicApp" accept="image/jpg,image/png,image/jpeg" name="pic_app" >
            </div>
            <script type="text/javascript">           
          
			$(function(){
				var mids = "${mids}";
				mids = mids.split(",");
				for(var i=0;i<mids.length;i++){
					$("input:checkbox[value='"+mids[i]+"']").attr('checked','true');
				}
			});
			


			layui.use(['element', 'laypage', 'layer', 'form'], function() {
              
				var element = layui.element()
                        ,laypage = layui.laypage
                        ,jq = layui.jquery
                        ,form = layui.form();
			
				//监听提交
				form.on('submit(form)', function(data) {
		
					var pid = "${pid}";
					var id_array=new Array();  
					$('input[name="mids"]:checked').each(function(){  
						id_array.push($(this).val());//向数组中添加元素  
					});
					var idstr=id_array.join(',');//将数组元素连接起来以构建一个字符串  

					// console.log("data:"+idstr);
					var json = {mids:idstr,pid:pid};
					jq.post('businessmenadmin/menu/modifTaoCanyMenu',json,function(data){
						//console.log("data:"+JSON.stringify(data));
						if(data.code==200){
							layer.msg(data.message, {icon: 1, time: 1000}, function(){
								var index = parent.layer.getFrameIndex(window.name);
								window.parent.layer.close(index);
								// parent.location.reload(); 
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

            </script>

          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
