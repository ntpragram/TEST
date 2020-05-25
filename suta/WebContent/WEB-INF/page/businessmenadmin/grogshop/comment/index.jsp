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
<meta charset="UTF-8">
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
</head><body>
<div class="layui-tab layui-tab-brief main-tab-container">
	<ul class="layui-tab-title main-tab-title">
		<li class="layui-this" style="border-bottom: 0px;top:0px;">评论管理</li>
		<div class="main-tab-item" style="left: 10px;top:0px;">
        <c:if test="${resultData.type=='0'}">
        商品评论列表
        </c:if>
        <c:if test="${resultData.type=='1'}">
        酒店评论列表
        </c:if>
        </div>
	</ul>
	<div class="layui-tab-content">

        <!-- 搜索 -->
            <form class="layui-form layui-form-pane search-form">
                <div class="layui-form-item">
                    <label class="layui-form-label">订单号</label>
                    <div class="layui-input-inline">
                        <input type="text" name="search" id="search" value="${resultData.search}" lay-verify="" placeholder="请输入订单号" autocomplete="off" class="layui-input">
                    </div>
                    <span class="layui-btn" lay-submit="" lay-filter="" onclick="pageJump(${resultData.pageNumber})">搜索</span>
                </div>

            </form>

		<div class="layui-tab-item layui-show">

            <form class="layui-form layui-form-pane search-form">
        <div class="layui-form-item">
        <div class="layui-btn-group">

          <!-- <span class="layui-btn layui-btn-small modal-catch" onclick="toAdd()">
            <img src="../../images/add.png">
            <a>添加</a>
          </span> -->
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
       
          

			<form class="layui-form">
                <input type="hidden" id="type" value="${resultData.type}" title=" ">
                <input type="hidden" id="modelName"  value="comment" >
				<table class="list-table">
					<thead>
						<tr>
						<!-- <th class="first" style="width: 120px"><input type="checkbox" name="checkAll" lay-filter="checkAll" title=" "></th> -->
						<th style="text-align: center;">序号</th>
						<th style="text-align: center;">用户账号</th>                      
						<th style="text-align: center;">订单号</th>                      
						<th style="text-align: center;">酒店名称</th>                      
						<th style="text-align: center;">餐厅名称</th>                      
                        <th style="text-align: center;">评论内容</th> 
                        <th style="text-align: center;">评论时间</th>                     
                       <!-- <th style="text-align: center;">排序</th>-->
                        <th style="text-align: center;">是否显示</th>
                        <!--<th style="text-align: center;">图片</th>-->
						<!-- <th>操作</th> -->
						</tr> 
					</thead>
					<tbody class="table-list-box">
						<c:forEach items="${resultData.dataList}" var="v" varStatus="i">
							<tr id="comment_tr${v.cid}">
								<!-- <td class="first" style="text-align: center;">
                                    <input type="checkbox" name="ids" lay-filter="checkOne" value="${v.id}" title=" ">
                                    <div class="layui-unselect layui-form-checkbox">
                                    <span></span>
                                    </div>
                                </td> -->
								<td style="text-align: center;">${i.count + (resultData.pageNumber - 1) * resultData.pageSize}</td>
                                <td style="text-align: center;">${v.username}</td>                                
                                <td style="text-align: center;">${v.onumber}</td>                                
                                <td style="text-align: center;">${v.gtitle}</td>                                
                                <td style="text-align: center;">${v.htitle}</td>                                
                                <td style="text-align: center;">${v.content}</td>
                                <td style="text-align: center;">${v.intime}</td>                           
                                <!--<td class="table2-edit" style="text-align: center;">
                                    <div class="layui-input-inline">
                                     <input type="text" name="px" id="px${v.id}" value="${v.px}" lay-verify="number" placeholder="" autocomplete="off" class="layui-input" style="width: 60px">
                                    </div>
                                    <a class="layui-btn layui-btn-mini" style="margin-left: 20px" onclick="modifyPx(${v.id},${v.px})">确定</a>
                                </td>-->

                                <td style="text-align: center;" id="comment_td${v.cid}">
                                    <c:choose>
                                        <c:when test="${v.ishide == 0}">  
                                            <a href="javascript:;" onclick="comment(${v.cid},${v.ishide})" class="layui-btn layui-btn-small" title="点击隐藏">显示中</a>
                                        </c:when>
                                        <c:otherwise> 
                                            <a href="javascript:;" onclick="comment(${v.cid},${v.ishide})" class="layui-btn layui-btn-small backgroud-gray" title="点击显示">隐藏中</a>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <!--<td style="text-align: center;">
                                <a href="<%=basePath%>grogshopMerchantAdmin/comment/getPics?id=${v.id}"  class="layui-btn layui-btn-small" title="查看图片">查看图片</a>
                                </td> --> 
								<!-- <td style="text-align: center;">
                                <a href="javascript:;" class="layui-btn layui-btn-small layui-btn-danger del_btn" feedback-id="${v.id}" title="删除" >
                                    <i class="layui-icon"></i>
                                </a>
                                </td> -->
							</tr>
						</c:forEach>

					</tbody>
					<thead>
						<tr>
							<!-- <th class="first" style="width: 120px">
                                                            <span class="layui-btn layui-btn-small" lay-submit lay-filter="add" onclick="toAdd()">添加</span>
                                                            <span class="layui-btn layui-btn-small" lay-submit lay-filter="delete" onclick="delAll()">删除</span>
                                                        </th> -->
							<!--分页代码开始-->
							<th colspan="11" style="text-align: center">
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

							<!--分页代码结束-->
						</tr> 
					</thead>
					</table>
			</form>
		</div>
	</div>
</div>

<script type="text/javascript">
	var pageNumber = "${resultData.pageNumber}";
    var page_size = "${resultData.pageSize}";
    var type = "${resultData.type}"; 
    var pid = "${resultData.pid}";
    var search = "${resultData.search}"; 
    var urlWhere = '?offset='+pageNumber+'&limit='+page_size+'&type='+type+'&pid='+pid+'&search='+search;

	function pageJump(pageNumber){
		var page_size = $("#page_size").val();
        var type = $("#type").val();
        var search = $("#search").val();
		window.location.href = '?offset='+pageNumber+'&limit='+page_size+'&type='+type+'&pid='+pid+'&search='+search;

	}
	
    var comment;
    layui.use(['element', 'laypage', 'layer', 'form'], function(){
        var element = layui.element()
            ,laypage = layui.laypage
            ,jq = layui.jquery
            ,form = layui.form();


        //显示隐藏
        comment = function(cid,ishide){

            loading = layer.load(2, {
                shade: [0.2,'#000'] //0.2透明度的白色背景
            });
            var json = {cid:cid,ishide:ishide};
			alert("cid:"+cid+"ishide:"+ishide);
            jq.post('ishide',json,function(data){
                 console.log("data:"+JSON.stringify(data));
                layer.close(loading);
                if(data.code==200){
                    layer.msg(data.message, {icon: 1, time: 1000},function(){
                        var content = '<a href="javascript:;" onclick="comment('+cid+',0)" class="layui-btn layui-btn-small" title="点击隐藏">显示中</a>';
                        if(ishide == 0){
                            content = '<a href="javascript:;" onclick="comment('+cid+',1)" class="layui-btn layui-btn-small backgroud-gray" title="点击显示">隐藏中</a>';
                        }
                        $("#comment_td"+cid).html(content);
                    });
                }else{
                    layer.msg(data.message, {icon: 2,anim: 6, time: 1000});
                }
            });
        };


    })

function toAdd(){
    var layer = layui.layer;
    var type = $("#type").val();

    //window.location.href = 'http://192.168.2.140:8088/jindu/admin/goodsType/toAdd?type='+type+'&grade='+grade+'&parentid='+parentid;
    layer.open({
      type: 2,
      icon: 2,
      maxmin: true,
      area: ['100%','100%'],
      title: '添加',
      content:'brand/toAdd?type='+type
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
      content:'brand/toModify?id='+id 
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
                ajaxPOST("comment/delAll",{ids:strlist,model:modelName},
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

</script>
</body>
</html>