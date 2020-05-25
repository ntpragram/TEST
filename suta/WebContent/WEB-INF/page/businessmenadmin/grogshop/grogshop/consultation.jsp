<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>扬州锦都管理后台</title>
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
</head>
<body>
<div class="layui-tab layui-tab-brief main-tab-container">
	<ul class="layui-tab-title main-tab-title">
		<li class="layui-this" style="border-bottom: 0px;top:0px;">售前咨询</li>
		<div class="main-tab-item" style="left: 10px;top:0px;">售前咨询列表</div>
	</ul>
	<div class="layui-tab-content">
		<div class="layui-tab-item layui-show">
			<!-- 搜索 -->
			<form class="layui-form layui-form-pane search-form">
				<div class="layui-form-item">					
					<div class="layui-inline" >
						<div class="layui-input-inline" style="margin-right:10px" >
						<input type="text" id="search" value="${resultData.search}" lay-verify="" placeholder="酒店名称/用户账号" autocomplete="off" class="layui-input">
						</div>
						<span class="layui-btn" lay-submit="" lay-filter="" onclick="pageJump(1)">搜索</span>
					</div>
				
				</div>
				<!-- 每页数据量 -->
				<div class="layui-form-item page-size page-list-num">
					<label class="layui-form-label total">共计 <span class="list-all">${resultData.totalRow}</span> 条</label>
					<label class="layui-form-label">每页数据条</label>
					<div class="layui-input-inline">
						<input type="text" name="page_size" id="page_size" value="${resultData.pageSize}" lay-verify="number" placeholder="" autocomplete="off" class="layui-input" readonly>
					</div>
					<!--<a class="layui-btn">确定</a>-->
				</div>
			</form>
			<div class="layui-tab-item layui-show">
			<!-- 搜索 -->
			<form class="layui-form layui-form-pane search-form">
				<div class="layui-form-item" style="margin-top: 5px;">
					<div class="layui-btn-group">
						<!--
						<button class="layui-btn layui-btn-small layui-btn-normal ajax-all">
						<img src="<%=basePath%>images/back2.png">
						<a>返回</a>
						</button>
						<button class="layui-btn layui-btn-small layui-btn-danger ajax-all">
						<img src="<%=basePath%>images/delete.png">
						<a>删除</a>
						</button>
						-->
					</div>
				</div>
			</form>
			<form class="layui-form">
				<input type="hidden" id="otype"  value="${resultData.otype}" title=" ">
                <input type="hidden" id="ostatus"  value="${resultData.ostatus}" title=" ">
                <input type="hidden" id="modelName"  value="grogshop" >
				<table class="list-table">
					<thead>
						<tr>
						<!-- <th class="first"><input type="checkbox" name="checkAll" lay-filter="checkAll" title=" "></th> -->
						<th style="text-align: center;">序号</th>
						<th style="text-align: center;">用户账号</th>
						<th style="text-align: center;">酒店</th>
						<th style="text-align: center;">房间</th>
						<th style="text-align: center;">内容</th>						
						<th style="text-align: center;">时间</th>
						<th style="text-align: center;">平台</th>
						<th style="text-align: center;">操作</th>
						</tr> 
					</thead>
					<tbody class="table-list-box">
						<c:forEach items="${resultData.dataList}" var="v" varStatus="i">
							<tr>
								<!-- <td class="first" style="text-align: center;">
									<input type="checkbox" name="ids" lay-filter="checkOne" value="${v.uid}" title=" ">
									<div class="layui-unselect layui-form-checkbox">
									<span></span>
									</div>
								</td> -->
								<td style="text-align: center;">${i.count + (resultData.pageNumber - 1) * resultData.pageSize}</td>
								<td style="text-align: center;">${v.username}</td>
								<td style="text-align: center;">${v.title}</td>
								<td style="text-align: center;">${v.pnumber}</td>
								<td style="text-align: center;">${v.content}</td>
								<td style="text-align: center;">${v.intime}</td>
								<td style="text-align: center;">
								<c:if test="${v.platform=='0'}">
								PC端
								</c:if>
								<c:if test="${v.platform=='1'}">
								微信端
								</c:if>
								<c:if test="${v.platform=='2'}">
								ios端
								</c:if>
								<c:if test="${v.platform=='3'}">
								android端
								</c:if>
								<c:if test="${v.platform=='4'}">
								后台
								</c:if>
								</td>
								<td style="text-align: center;">
									<a href="javascript:;" class="layui-btn layui-btn-small layui-btn-danger " feedback-name="${v.keywords}" title="删除" onclick="del(${v.id})">
										<i class="layui-icon"></i>
									</a>
								</td>
							</tr>
						</c:forEach>

					</tbody>
					<thead>
						<tr>
							<!-- <th class="first"><span class="layui-btn layui-btn-small backgroud-gray" >删除</span></th> -->
							<th style="text-align: center;" colspan="16">
								<div id="demo8">
									<div class="layui-box layui-laypage layui-laypage-default" id="layui-laypage-0">
										<c:if test="${!resultData.isFirstPage}">
											<a href="javascript:;" onclick="pageJump(${resultData.pageNumber - 1})" class="layui-laypage-next">上一页</a>
										</c:if>
										
										<c:if test="${resultData.startNum > 1}">
											<a href="javascript:;" onclick="pageJump(1)">1</a>
											<a href="javascript:;">...</a>
										</c:if>
										
										<c:forEach var="i" begin="${resultData.startNum}" end="${resultData.endNum}" step="1">
											<c:choose>
												<c:when test="${i == resultData.pageNumber}">  
													<span class="layui-laypage-curr">
														<em class="layui-laypage-em"></em>
														<em>${i}</em>
													</span>
												</c:when>
												<c:otherwise> 
													<a href="javascript:;" onclick="pageJump(${i})">${i}</a>
												</c:otherwise>
											</c:choose>
										</c:forEach>
										
										<c:if test="${resultData.endNum < resultData.totalPage}">
											<a href="javascript:;">...</a>
											<a href="javascript:;" onclick="pageJump(${resultData.totalPage})">${resultData.totalPage}</a>
										</c:if>
										
										<c:if test="${!resultData.isLastPage}">
											<a href="javascript:;" onclick="pageJump(${resultData.pageNumber + 1})" class="layui-laypage-next">下一页</a>
										</c:if>
									</div>
								</div>
							</th>
						</tr> 
					</thead>
					</table>
			</form>
		</div>
	</div>
</div>
<script type="text/javascript">
	//清空搜索条件
	function clearData(){
	  location.href = "?";
	}	

	function pageJump(pageNumber){
		var page_size = $("#page_size").val();
        var type = $("#type").val();
        var search = $("#search").val();
		location.href = '?offset='+pageNumber+'&limit='+page_size+'&type='+type+'&search='+search;
	}
	
    layui.use(['element', 'laypage', 'layer', 'form'], function(){
        var element = layui.element()
            ,laypage = layui.laypage
            ,jq = layui.jquery
            ,form = layui.form();

//ajax删除
        jq('.del_btn').click(function(){
            var name = jq(this).attr('feedback-name');
            var id = jq(this).attr('feedback-id');
            layer.confirm('确定删除【'+name+'】?', function(index){
                loading = layer.load(2, {
                    shade: [0.2,'#000'] //0.2透明度的白色背景
                });
                jq.post('',{'id':id},function(data){

                    layer.close(loading);
                    layer.msg(data.msg, {icon: 1, time: 1000}, function(){
                        location.reload();//do something
                    });

                });
            });

        });

//全选
        form.on('checkbox(checkAll)', function(data){
            if(data.elem.checked){
                jq("input[type='checkbox']").prop('checked',true);
            }else{
                jq("input[type='checkbox']").prop('checked',false);
            }
            form.render('checkbox');
        });

        form.on('checkbox(checkOne)', function(data){
            var is_check = true;
            if(data.elem.checked){
                jq("input[lay-filter='checkOne']").each(function(){
                    if(!jq(this).prop('checked')){ is_check = false; }
                });
                if(is_check){
                    jq("input[lay-filter='checkAll']").prop('checked',true);
                }
            }else{
                jq("input[lay-filter='checkAll']").prop('checked',false);
            }
            form.render('checkbox');
        });


    })

function toAdd(){
    var layer = layui.layer;
    var type = $("#type").val();
    layer.open({
      type: 2,
      icon: 2,
      maxmin: true,
      area: ['100%','100%'],
      title: '添加',
      content: sysMerchantUrl+'hotsearch/toAdd?type='+type
    });
}

function toMod(id){
    var layer = layui.layer;
    var type = $("#type").val();
    layer.open({
      type: 2,
      icon: 2,
      maxmin: true,
      area: ['100%','100%'],
      title: '修改',
      content: sysMerchantUrl+'hotsearch/toModify?id='+id 
    });

}

//删除
var del = function(id) {
    var modelName = $("#modelName").val();
    var array = new Array();
    array.push(id);
    swalWarning("确认删除?删除之后将无法恢复!",function(res){
        if(res){
            ajaxPOST("grogshop/deleteConsultation",{ids:array.join(","),model:modelName},
                function(data) {            
                    swalTip("提示", data.message, data.success,function(res){
                        if(res){
                            if(data.success){
                               location.reload();
                            } 
                        }
                        swal.close();
                    });
                });
        }
    });
}

//批量删除
function delAll(){
    var modelName = $("#modelName").val();
    var is_check = false;
            $("input[lay-filter='checkOne']").each(function(){
                if($(this).prop('checked')){ is_check = true; }
            });
            if(!is_check){
                layer.msg('请选择数据', {icon: 2,anim: 6,time: 1000});
                return false;
            }
//确认删除
            layer.confirm('确定批量删除?', function(index){
                loading = layer.load(2, {
                    shade: [0.2,'#000'] //0.2透明度的白色背景
                });
                var param = document.getElementsByName("child");
                var strlist = "";
                for (i = 0; i < param.length; i++) {
                     if (param[i].checked == true) {
                        strlist = strlist + "'" + param[i].value + "',";
                    }
                }

                if(strlist!=""){
                    strlist = strlist.substring(0,strlist.length-1);
                }
                //console.log("strlist:"+strlist);
                //console.log("modelName:"+modelName);   
                ajaxPOST("hotsearch/delAll",{ids:strlist,model:modelName},
                function(data) {  
                    //console.log("data:"+JSON.stringify(data));    
                    if(data.success){
                        layer.close(loading);
                        layer.msg(data.message, {icon: 1, time: 1000}, function(){
                            location.reload();//do something
                        });
                    }else{
                        layer.close(loading);
                        layer.msg(data.message, {icon: 2,anim: 6, time: 1000});
                    }    

                });

            });
            return false;
}

function set(id){
    var px = $("#px_" + id).val();
     ajaxPOST("hotsearch/set",{"columnName":"px","value":px,"id":id},
                function(data) {  
                    //console.log("data:"+JSON.stringify(data));    
                    if(data.success){
                        layer.msg(data.message, {icon: 1, time: 800}, function(){
                            location.reload();
                        });
                    }else{
                        layer.msg(data.message, {icon: 2,anim: 6, time: 800},function(){
                            location.reload();
                        });
                    }    

                });
}
</script>

</body>
</html>