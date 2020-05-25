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
		<div class="main-tab-item" style="left: 10px;top:0px;">菜单列表</div>
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
						<a style="color: #fff;position: relative;top: 1px;">添加菜单</a>
						</span>
					</div>
				</c:if>
				</div>
			</form>
			<form class="layui-form">
				<input type="hidden" id="id"  value="${resultData.businessid}" >
				<input type="hidden" id="modelName"  value="grogshop" >
				<table class="list-table">
					<thead>
						<tr>
						<th style="text-align: center;">序号</th>
						<th style="text-align: center;">名称</th>
						<th style="text-align: center;">图片</th>
						<th style="text-align: center;">价格</th>
						<th style="text-align: center;">上下架</th>
						<c:if test="${resultData.guanli!=0}">
						<th style="text-align: center;">操作</th>
						</c:if>
						</tr> 
					</thead>
					<tbody class="table-list-box">
						<c:forEach items="${resultData.dataList}" var="v" varStatus="i">
							<tr>
								</td>
								<td style="text-align: center;">${i.count + (resultData.pageNumber - 1) * resultData.pageSize}</td>
								<td style="text-align: center;">${v.title}</td>
								<td style="text-align: center;" class="table-img">
									<div class="img"><img src="<%=basePath%>${v.pic}" alt="..." class="img-thumbnail" style="width: 80px;height: 80px;"></div>
								</td>
								<td style="text-align: center;">${v.price}</td>
								<td style="text-align: center;" id="shelve_td${v.mid}">
									<c:choose>
										<c:when test="${v.shelve == 0}">  
											<a href="javascript:;" onclick="shelve(${v.mid},${v.shelve})" class="layui-btn layui-btn-small" title="点击下架">已上架</a>
										</c:when>
										<c:otherwise> 
											<a href="javascript:;" onclick="shelve(${v.mid},${v.shelve})" class="layui-btn layui-btn-small backgroud-gray" title="点击上架">已下架</a>
										</c:otherwise>
									</c:choose>
								</td>
								<c:if test="${resultData.guanli!=0}">
								<td style="text-align: center;">
									<a href="javascript:;" class="layui-btn layui-btn-small" title="编辑" onclick="toMod(${v.mid})"><i class="layui-icon"></i></a>
									<a class="layui-btn layui-btn-small layui-btn-danger del_btn" feedback-id="${v.mid}" feedback-name="${v.title}" title="删除">
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
	var gsid = "${resultData.gsid}";
	var shelve = "${resultData.shelve}";
	
	var urlWhere = '?offset='+pageNumber+'&limit='+page_size+'&shelve='+shelve+'&gsid='+gsid;
			
	function pageJump(pageNumber){
		search = $("#search").val();
		sh = $("#sh").val();
		starLevel = $("#starLevel").val();	
		hot = $("#hot").val();
		gsid = $("#gsid").val();
		shelve = $("#shelve").val();
			
		window.location.href = '?offset='+pageNumber+'&limit='+page_size+'&search='+search+'&sh='+sh+'&starLevel='+starLevel+'&hot='+hot+'&gsid='+gsid+'&shelve='+shelve;
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
		  content: 'toAdd1?gsid='+gsid
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
      content: 'toModify1?mid='+id 
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
	
	var  shelve;//在此声明方法名，在以下layui.use里赋值
	
    layui.use(['element', 'laypage', 'layer', 'form'], function(){
        var element = layui.element()
            ,laypage = layui.laypage
            ,jq = layui.jquery
            ,form = layui.form();


		
		//上下架
		shelve = function(mid,shelveStatus){
			loading = layer.load(2, {
                shade: [0.2,'#000'] //0.2透明度的白色背景
            });
			var json = {mid:mid,shelveStatus:shelveStatus};
			jq.post('shelves',json,function(data){
				// console.log("data:"+JSON.stringify(data));
				layer.close(loading);
				if(data.code==200){
					layer.msg(data.message, {icon: 1, time: 1000},function(){
						var content = '<a href="javascript:;" onclick="shelve('+mid+',0)" class="layui-btn layui-btn-small" title="点击下架">已上架</a>';
						if(shelveStatus == 0){
							content = '<a href="javascript:;" onclick="shelve('+mid+',1)" class="layui-btn layui-btn-small backgroud-gray" title="点击上架">已下架</a>';
						}
						$("#shelve_td"+mid).html(content);
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
                jq.post('delete1',json,function(data){
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