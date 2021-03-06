<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	//System.out.println("basePath:"+basePath);
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
		<li class="layui-this" style="border-bottom: 0px;top:0px;">管理列表</li>
		<div class="main-tab-item" style="left: 10px;top:0px;">商品列表</div>
	</ul>
	<div class="layui-tab-content">
		<div class="layui-tab-item layui-show">
			<!-- 搜索 -->
			<form class="layui-form layui-form-pane search-form">
				
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
			<form class="layui-form layui-form-pane search-form">
				<div class="layui-form-item" style="margin-top: 5px;">
				<c:if test="${resultData.guanli!=0}">
					<div class="layui-btn-group">
						<span class="layui-btn layui-btn-small modal-catch" onclick="toAdd(${resultData.gsid})">
						<img src="<%=basePath%>images/add.png">
						<a style="color: #fff;position: relative;top: 1px;">添加</a>
						</span>
					</div>
				</c:if>
				</div>
			</form>
			<form class="layui-form">
				<input type="hidden" id="gsid"  value="${resultData.gsid}" >
				<input type="hidden" id="type"  value="${resultData.type}" >
				<input type="hidden" id="modelName"  value="grogshop" >
				<table class="list-table">
					<thead>
						<tr>
						<th style="text-align: center;">序号</th>
						<c:choose>
						<c:when test="${resultData.type==1}">
						<th style="text-align: center;">酒店名称</th>
						<th style="text-align: center;">餐厅名称</th>
						<th style="text-align: center;">餐厅消费</th>
						</c:when>
						<c:otherwise>
						<th style="text-align: center;">店面名称</th>
						<th style="text-align: center;">产品名称</th>
						<th style="text-align: center;">价格</th>
						</c:otherwise>
						</c:choose>
						<th style="text-align: center;">主图</th>
						<th style="text-align: center;">图片管理</th>
						<th style="text-align: center;">上下架</th>
						<th style="text-align: center;">是否推荐到店面首页</th>
						<c:if test="${resultData.guanli!=0}">
						<th style="text-align: center;">操作</th>
						</c:if>
						</tr> 
					</thead>
					<tbody class="table-list-box">
						<c:forEach items="${resultData.dataList}" var="v" varStatus="i">
							<tr>
								
								<td style="text-align: center;">${i.count + (resultData.pageNumber - 1) * resultData.pageSize}</td>
								<td style="text-align: center;">${v.gtitle}</td>
								<td style="text-align: center;">${v.title}</td>
								<c:choose>
								<c:when test="${resultData.type==1}">
								<td style="text-align: center;">${v.price}-${v.endprice}</td>
								</c:when>
								<c:otherwise>
								<td style="text-align: center;">${v.cprice}</td>
								</c:otherwise>
								</c:choose>
								<td style="text-align: center;" class="table-img">
									<div class="img"><img src="<%=basePath%>${v.pic}" alt="..." class="img-thumbnail" style="width: 80px;height: 80px;"></div>
								</td>
								<td style="text-align: center;"><a href="<%=basePath%>businessmenadmin/pic/getPicList?pid=${v.rid}&type=0&gsid=${resultData.gsid}"  class="layui-btn layui-btn-small" title="图片管理">图片管理</a></td>
								<td style="text-align: center;" id="shelve_td${v.rid}">
									<c:choose>
										<c:when test="${v.shelve == 0}">  
											<a href="javascript:;" onclick="shelve(${v.rid},${v.shelve})" class="layui-btn layui-btn-small" title="点击下架">已上架</a>
										</c:when>
										<c:otherwise> 
											<a href="javascript:;" onclick="shelve(${v.rid},${v.shelve})" class="layui-btn layui-btn-small backgroud-gray" title="点击上架">已下架</a>
										</c:otherwise>
									</c:choose>
								</td>
								<td style="text-align: center;" id="tj_td${v.rid}">
									<c:choose>
										<c:when test="${v.tj == 1}">  
											<a href="javascript:;" onclick="tj(${v.rid},${v.tj})" class="layui-btn layui-btn-small" title="点击取消">已推荐</a>
										</c:when>
										<c:otherwise> 
											<a href="javascript:;" onclick="tj(${v.rid},${v.tj})" class="layui-btn layui-btn-small backgroud-gray" title="点击推荐">已取消</a>
										</c:otherwise>
									</c:choose>
								</td>
								<c:if test="${resultData.guanli!=0}">
								<td style="text-align: center;">
									<a href="javascript:;" class="layui-btn layui-btn-small" title="编辑" onclick="toMod(${v.rid})"><i class="layui-icon"></i></a>
									<a class="layui-btn layui-btn-small layui-btn-danger del_btn" feedback-id="${v.rid}" feedback-name="${v.title}" title="删除">
										<i class="layui-icon"></i>
									</a>
								</td>
								</c:if>
							</tr>
						</c:forEach>

					</tbody>
					<thead>
						<tr>
							<!--<th class="first"><button class="layui-btn layui-btn-small" lay-submit lay-filter="delete">删除</button></th>-->
							<th colspan="25" style="text-align: center;">
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
	var page_size = "${resultData.pageSize}";
	var search = "${resultData.search}";	
	var sh = "${resultData.sh}";
	var starLevel = "${resultData.starLevel}";
	var hot = "${resultData.hot}";
	var Boutique = "${resultData.Boutique}";
	var shelve = "${resultData.shelve}";
	
	var urlWhere = '?offset='+pageNumber+'&limit='+page_size+'&search='+search+'&sh='+sh+'&starLevel='+starLevel+'&hot='+hot+'&Boutique='+Boutique+'&shelve='+shelve;
			
	function pageJump(pageNumber){
		search = $("#search").val();
		sh = $("#sh").val();
		starLevel = $("#starLevel").val();	
		hot = $("#hot").val();
		Boutique = $("#Boutique").val();
		shelve = $("#shelve").val();
			
		window.location.href = '?offset='+pageNumber+'&limit='+page_size+'&search='+search+'&sh='+sh+'&starLevel='+starLevel+'&hot='+hot+'&Boutique='+Boutique+'&shelve='+shelve;
	}

	//清空搜索条件
	function clearData(){
	  location.href = "?";
	}
		
	function toAdd(gsid){
		var layer = layui.layer;
		layer.open({
		  type: 2,
		  icon: 2,
		  maxmin: true,
		  area: ['100%','100%'],
		  title: '添加',
		  content: 'toAdd?gsid='+gsid
		});
	}

	function toMod(id){
    var layer = layui.layer;

    layer.open({
      type: 2,
      icon: 2,
      maxmin: true,
      area: ['100%','100%'],
      title: '修改',
      content: 'toModify?rid='+id 
    });

}

function toDetail(id){
    var layer = layui.layer;

    layer.open({
      type: 2,
      icon: 2,
      maxmin: true,
      area: ['100%','100%'],
      title: '酒店详情',
      content: 'toDetail?gsid='+id 
    });

}
	
	var  shelve,tj;//在此声明方法名，在以下layui.use里赋值
	
    layui.use(['element', 'laypage', 'layer', 'form'], function(){
        var element = layui.element()
            ,laypage = layui.laypage
            ,jq = layui.jquery
            ,form = layui.form();


		
		//上下架
		shelve = function(rid,shelveStatus){
			loading = layer.load(2, {
                shade: [0.2,'#000'] //0.2透明度的白色背景
            });
			var json = {rid:rid,shelveStatus:shelveStatus};
			jq.post('shelve',json,function(data){
				// console.log("data:"+JSON.stringify(data));
				layer.close(loading);
				if(data.code==200){
					layer.msg(data.message, {icon: 1, time: 1000},function(){
						var content = '<a href="javascript:;" onclick="shelve('+rid+',0)" class="layui-btn layui-btn-small" title="点击下架">已上架</a>';
						if(shelveStatus == 0){
							content = '<a href="javascript:;" onclick="shelve('+rid+',1)" class="layui-btn layui-btn-small backgroud-gray" title="点击上架">已下架</a>';
						}
						$("#shelve_td"+rid).html(content);
					});
				}else{
					layer.msg(data.message, {icon: 2,anim: 6, time: 1000});
				}
			});
		};

	//推荐
		tj = function(rid,tj){
			loading = layer.load(2, {
                shade: [0.2,'#000'] //0.2透明度的白色背景
            });
			var json = {rid:rid,tj:tj};
			jq.post('tj',json,function(data){
				// console.log("data:"+JSON.stringify(data));
				layer.close(loading);
				if(data.code==200){
					layer.msg(data.message, {icon: 1, time: 1000},function(){
						var content = '<a href="javascript:;" onclick="tj('+rid+',1)" class="layui-btn layui-btn-small" title="点击取消">已推荐</a>';
						if(tj == 1){
							content = '<a href="javascript:;" onclick="tj('+rid+',0)" class="layui-btn layui-btn-small backgroud-gray" title="点击推荐">已取消</a>';
						}
						$("#tj_td"+rid).html(content);
					});
				}else{
					layer.msg(data.message, {icon: 2,anim: 6, time: 1000});
				}
			});
		};

		//ajax删除
		var modelName = $("#modelName").val();
        jq('.del_btn').click(function(){
            var id = jq(this).attr('feedback-id');
            var name = jq(this).attr('feedback-name');
            layer.confirm('确定删除【'+name+'】吗?', function(index){
                loading = layer.load(2, {
                    shade: [0.2,'#000'] //0.2透明度的白色背景
                });
				var json = {id:id,model:modelName};
                jq.post('delete',json,function(data){
					//console.log("data:"+JSON.stringify(data));
					//console.log("sysMerchantUrl:"+sysMerchantUrl);
                    layer.close(loading);
					if(data.code==200){
						layer.msg(data.message, {icon: 1, time: 1000}, function(){
							window.location.href = urlWhere;
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
			//批量删除
            layer.confirm('确定批量删除选中的商品吗?', function(index){
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
                var param = {ids:strlist,model:modelName};
				// console.log("param:"+JSON.stringify(param));
                jq.post(sysMerchantUrl+'delete',param,function(data){
					layer.close(loading);
					if(data.code==200){
						layer.msg(data.message, {icon: 1, time: 1000}, function(){
							window.location.href = urlWhere;
						});
					}else{
						layer.msg(data.message, {icon: 2,anim: 6, time: 1000});
					}
                });
            });
            return false;
        });


    })
</script>
</body>
</html>