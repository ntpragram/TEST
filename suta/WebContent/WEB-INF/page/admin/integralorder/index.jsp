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
</head>
<body>
<div class="layui-tab layui-tab-brief main-tab-container">
	<ul class="layui-tab-title main-tab-title">
		<li class="layui-this" style="border-bottom: 0px;top:0px;">订单查询</li>
		<div class="main-tab-item" style="left: 10px;top:0px;">订单列表</div>
	</ul>
	<div class="layui-tab-content">
		<div class="layui-tab-item layui-show">
			<!-- 搜索 -->
			<form class="layui-form layui-form-pane search-form">
				<div class="layui-form-item">
					<!-- <label class="layui-form-label">订单号</label> -->
					<div class="layui-inline">
						<div class="layui-input-inline" style="margin-right:10px">
						<input type="text" id="search" value="${resultData.search}" lay-verify="" placeholder="搜索订单号(全) 或下单用户" autocomplete="off" class="layui-input">
						</div>
			
								<label class="layui-form-label" style="width: 60px;margin-left:10px">订单状态</label>
					<div class="layui-input-inline" style="width: 100px;">
						<select id="status" style="display:block;height:38px;">
							<option value="-1">全部</option>
							<option value="0" <c:if test="${resultData.status ==0 }">selected</c:if>>待付款</option>
							<option value="1" <c:if test="${resultData.status ==1 }">selected</c:if>>已付款</option>
							<option value="2" <c:if test="${resultData.status ==2 }">selected</c:if>>卖家发货</option>
							<option value="3" <c:if test="${resultData.status ==3 }">selected</c:if>>买家收货</option>
							<option value="4" <c:if test="${resultData.status ==4 }">selected</c:if>>买家寄送</option>
							<option value="5" <c:if test="${resultData.status ==5 }">selected</c:if>>申请退货退款 待审核</option>
							<option value="6" <c:if test="${resultData.status ==6 }">selected</c:if>>申请退货退款审核通过</option>
							<option value="7" <c:if test="${resultData.status ==7 }">selected</c:if>>申请退货退款审核不通过</option>
							<option value="8" <c:if test="${resultData.status ==8 }">selected</c:if>>取消交易</option>
							<option value="9" <c:if test="${resultData.status ==9 }">selected</c:if>>已退款</option>
							<option value="10" <c:if test="${resultData.status ==10 }">selected</c:if>>交易完成</option>
						</select>
					</div>
			
					<label class="layui-form-label" style="width: 60px;">下单时间</label>
					<div class="layui-input-inline input-custom-width" style="width: 160px;">
						<input type="text" id="startTime" value="${resultData.startTime}" id="date" lay-verify="datetime" readonly="true" placeholder="下单时间" 
						autocomplete="off" class="layui-input" onclick="callDate({elem: this,istime: 1, format: 'YYYY-MM-DD hh:mm:ss' })">
					</div>
					
				
					
						<span class="layui-btn" lay-submit="" lay-filter="" onclick="pageJump(1)">搜索</span>
						<span class="layui-btn" lay-submit="" lay-filter="" onclick="clearData()">清除</span>
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
				<input type="hidden" id="status"  value="${resultData.status}" title=" ">
                <input type="hidden" id="modelName"  value="integralOrder" >
				<table class="list-table">
					<thead>
						<tr>
						<!-- <th class="first"><input type="checkbox" name="checkAll" lay-filter="checkAll" title=" "></th> -->
						<th style="text-align: center;">序号</th>
						<th style="text-align: center;">订单号</th>					
						<th style="text-align: center;">下单用户</th>
						<th style="text-align: center;">产品</th>
						<th style="text-align: center;">数量</th>
						<th style="text-align: center;">总消费</th>											
						<th style="text-align: center;">订单状态</th>						
						<th style="text-align: center;">下单备注</th>
						<th style="text-align: center;">下单时间</th>
						<th style="text-align: center;">详情</th>
						<th style="text-align: center;">操作</th>
						</tr> 
					</thead>
					<tbody class="table-list-box">
						<c:forEach items="${resultData.dataList}" var="v" varStatus="i">
							<tr>
								<td style="text-align: center;">${i.count + (resultData.pageNumber - 1) * resultData.pageSize}</td>
								<td style="text-align: center;">${v.onumber}</td>
								<td style="text-align: center;">${v.phone}</td>
								<td style="text-align: center;">${v.title}</td>
								<td style="text-align: center;">${v.num}</td>
								<td style="text-align: center;">${v.integral}</td>
								
								<td style="text-align: center;">
								<c:choose>
								<c:when test="${v.status==0}">待付款</c:when>
								<c:when test="${v.status==1}">已付款</c:when>
								<c:when test="${v.status==2}">卖家发货</c:when>
								<c:when test="${v.status==3}">买家收货</c:when>
								<c:when test="${v.status==4}">买家寄送</c:when>
								<c:when test="${v.status==5}">申请退货退款 待审核</c:when>
								<c:when test="${v.status==6}">申请退货退款 审核通过</c:when>
								<c:when test="${v.status==7}">申请退货退款 审核不通过</c:when>
								<c:when test="${v.status==8}">取消交易</c:when>
								<c:when test="${v.status==9}">已退款</c:when>
								<c:when test="${v.status==10}">交易完成</c:when>
								</c:choose>
								</td>
								<td style="text-align: center;">${v.remark}</td>
								<td style="text-align: center;">${v.createTime}</td>
								
								<td style="text-align: center;"><a href="javascript:;" class="layui-btn layui-btn-small" title="查看详情" onclick="toDetail(${v.id})">详情</a></td>
									
								<c:if test="${v.status==1}">
									<td style="text-align: center;"><a href="javascript:;" class="layui-btn layui-btn-normal layui-btn-small" title="发货" onclick="deliveryGoods(${v.id})">发货</a></td>
								</c:if>
								<c:if test="${v.status==2 || v.status==4}">
									<td style="text-align: center;"><a href="javascript:;" class="layui-btn layui-btn-warm layui-btn-small" title="查看物流" onclick="lookCourier(${v.id})">查看物流</a></td>
								</c:if>
								<c:if test="${v.status==5}">
									<td style="text-align: center;"><a href="javascript:;" class="layui-btn layui-btn-danger layui-btn-small" title="审核" onclick="shenhe(${v.id})">审核</a></td>
								</c:if>
							</tr>
						</c:forEach>

					</tbody>
					<thead>
						<tr>
							<!-- <th class="first"><span class="layui-btn layui-btn-small backgroud-gray" >删除</span></th> -->
							<th colspan="16" style="text-align :center">
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

	var pageNumber = "${resultData.pageNumber}";
	var page_size = "${resultData.page_size}";
	var ostatus = "${resultData.ostatus}";
	var paystyle = "${resultData.paystyle}";
	var platform = "${resultData.platform}";
	var search = "${resultData.search}";
	var startTime = "${resultData.startTime}";
	var endTime = "${resultData.endTime}";
	var urlWhere = '?offset='+pageNumber+'&limit='+page_size+'&ostatus='+ostatus+'&paystyle='+paystyle+'&platform='+platform+'&search='+search+'&startTime='+startTime+'&endTime='+endTime;
			
	function pageJump(pageNumber){
		//var ostatus = $("#ostatus").val();
		var paystyle = $("#paystyle").val();
		var platform = $("#platform").val();
		var search = $("#search").val();
		var startTime = $("#startTime").val();
		var endTime = $("#endTime").val();
		var status = $("#status").val();

		window.location.href = '?offset='+pageNumber+'&limit='+page_size+'&ostatus='+ostatus+'&paystyle='+paystyle+'&platform='+platform+'&search='+search+'&startTime='+startTime+'&endTime='+endTime+'&status='+status;
	}
	
	function toDetail(id){
		
    var layer = layui.layer;
    layer.open({
      type: 2,
      icon: 2,
      maxmin: true,
      area: ['90%','90%'],
      title: '订单详情',
      content: 'toDetail?id='+id 
    });
}
	
	
	function deliveryGoods(id){
		
	    var layer = layui.layer;
	    layer.open({
	      type: 2,
	      icon: 2,
	      maxmin: true,
	      area: ['70%','70%'],
	      title: '发货',
	      content: 'delivery?id='+id 
	    });
	}
	
	function shenhe(id){
		
	    var layer = layui.layer;
	    layer.open({
	      type: 2,
	      icon: 2,
	      maxmin: true,
	      area: ['70%','70%'],
	      title: '审核',
	      content: 'audit?id='+id 
	    });
	}
	
	
	function lookCourier(id){
	    var layer = layui.layer;
	    layer.open({
	      type: 2,
	      icon: 2,
	      maxmin: true,
	      area: ['90%','90%'],
	      title: '查看物流',
	      content: 'lookCourier?id='+id 
	    });

	}
	

	

function clearData(){
		$("#search").val("");
		$("#paystyle").val(-1);
		$("#platform").val(-1);	
		$("#startTime").val("");
		$("#endTime").val("");
		$("#status").val("");
		pageJump(1);
	}

	var modifyPx, shelve, audit, recommend,delivery,callDate;//在此声明方法名，在以下layui.use里赋值
	
    layui.use(['element', 'laypage', 'layer', 'form','laydate'], function(){
        var element = layui.element()
            ,laypage = layui.laypage
            ,jq = layui.jquery
            ,form = layui.form();

		//修改排序值
		modifyPx = function(pid,o_px){
			var px = $.trim($("#px"+pid).val());
			loading = layer.load(2, {
                shade: [0.2,'#000'] //0.2透明度的白色背景
            });
			var json = {pid:pid,px:px};
			jq.post('modifyPx',json,function(data){
				// console.log("data:"+JSON.stringify(data));
				layer.close(loading);
				if(data.code==200){
					layer.msg(data.message, {icon: 1, time: 1000});
				}else{
					$("#px"+pid).val(o_px);
					layer.msg(data.message, {icon: 2,anim: 6, time: 1000});
				}
			});
		};
		
		callDate = function(json){
			laydate(json);
		}

//ajax删除
		var modelName = $("#modelName").val();
        jq('.del_btn').click(function(){
            var name = jq(this).attr('feedback-name');
            var id = jq(this).attr('feedback-id');
			
            layer.confirm('确定删除【'+name+'】订单吗?', function(index){
                loading = layer.load(2, {
                    shade: [0.2,'#000'] //0.2透明度的白色背景
                });
				var json = {ids:id,model:modelName};
                jq.post(sysUrl+'delete',json,function(data){
					// console.log("data:"+JSON.stringify(data));
                    layer.close(loading);
					if(data.success){
						layer.msg(data.message, {icon: 1, time: 1000}, function(){
							location.reload();
						});
					}else{
						layer.msg(data.message, {icon: 2,anim: 6, time: 1000});
					}
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

//监听提交
        form.on('submit(delete)', function(data){
//判断是否有选项
            var is_check = false;
            jq("input[lay-filter='checkOne']").each(function(){
                if(jq(this).prop('checked')){ is_check = true; }
            });
            if(!is_check){
                layer.msg('请至少选择一条记录', {icon: 2,anim: 6,time: 1000});
                return false;
            }
//确认删除
            layer.confirm('确定批量删除选中的记录吗?', function(index){
                loading = layer.load(2, {
                    shade: [0.2,'#000'] //0.2透明度的白色背景
                });
				var ids = document.getElementsByName("ids");
				var strlist="";
				for (i = 0; i < ids.length; i++){
					if (ids[i].checked == true){
						strlist=strlist + ids[i].value + ",";
					}
				}
                var param = {strlist:strlist};
				// console.log("param:"+JSON.stringify(param));
                jq.post('memberDelAll',param,function(data){
					layer.close(loading);
					if(data.code==200){
						layer.msg(data.message, {icon: 1, time: 1000}, function(){
							window.location.href = 'memberList?offset='+pageNumber+'&limit='+page_size+'&search='+search;
						});
					}else{
						layer.msg(data.message, {icon: 2,anim: 6, time: 1000});
					}
                });
            });
            return false;
        });

        delivery = function(oid){
			var param = {oid:oid};
	 		jq.post('delivery',param,function(data){
					if(data.success){
						layer.msg(data.message, {icon: 1, time: 1000}, function(){
							location.reload();
						});
					}else{
						layer.msg(data.message, {icon: 2,anim: 6, time: 1000});
					}
   	 		});
		}
		
		//修改订单状态
		audit = function(id){
			var auditVal = $.trim($("#audit"+id).val());
			loading = layer.load(2, {
				shade: [0.2,'#000'] //0.2透明度的白色背景
			});
			var json = {id:id,auditVal:auditVal};
			jq.post('OrderAudit',json,function(data){
				layer.close(loading);
				if(data.code==200){
					layer.msg(data.message, {icon: 1, time: 1000});
					setTimeout(function(){
						location.reload();
					},1000)
				}else{
					layer.msg(data.message, {icon: 2,anim: 6, time: 1000});
				}
			});
		};

    })


</script>
</body>
</html>