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
		<li class="layui-this" style="border-bottom: 0px;top:0px;">评论管理</li>
		<div class="main-tab-item" style="left: 10px;top:0px;">评论图片</div>
	</ul>
	<div class="layui-tab-content">
		<div class="layui-tab-item layui-show">

			<div class="layui-tab-item layui-show">
			<!-- 搜索 -->
			<form class="layui-form layui-form-pane search-form">
				<div class="layui-form-item" style="margin-top: 5px;">
					<div class="layui-btn-group">
						<button class="layui-btn layui-btn-small layui-btn-normal ajax-all" onclick="history.back()">
						<img src="<%=basePath%>images/back2.png">
						<a>返回</a>
						</button>
					</div>
				</div>
			</form>
			<form class="layui-form">
				<input type="hidden" id="modelName"  value="grogshop" >
				<table class="list-table">
					<thead>
						<tr>
						<th style="text-align: center;">序号</th>
						<th style="text-align: center;">图片</th>						
						</tr> 
					</thead>
					<tbody class="table-list-box">
						<c:forEach items="${pics}" var="v" varStatus="i">
							<tr>

								<td style="text-align: center;">${i.count}</td>
								<td style="text-align: center;" class="table-img">
									<div class="img"><img src="<%=basePath%>${v}" alt="..." class="img-thumbnail" style="width: 80px;height: 80px;"></div>
								</td>

							</tr>
						</c:forEach>

					</tbody>
					</table>
			</form>
		</div>
	</div>
</div>

<script type="text/javascript">
	
	var pageNumber = "${resultData.pageNumber}";
	var page_size = "${resultData.pageSize}";
	var search = "${resultData.title}";	
	var productType = "${resultData.type}";
			
	function pageJump(pageNumber){
		search = $("#search").val();
		window.location.href = '?type='+productType+'&offset='+pageNumber+'&limit='+page_size+'&title='+search;
	}
	
	function toAdd(){
		var layer = layui.layer;
		layer.open({
		  type: 2,
		  icon: 2,
		  maxmin: true,
		  area: ['100%','100%'],
		  title: '添加商品',
		  content: 'toAdd?type='+productType
		});
	}
	
	var modifyPx, shelve, audit, recommend;//在此声明方法名，在以下layui.use里赋值
	
    layui.use(['element', 'laypage', 'layer', 'form'], function(){
        var element = layui.element()
            ,laypage = layui.laypage
            ,jq = layui.jquery
            ,form = layui.form();

		//修改排序值
		modifyPx = function(gsid,o_px){
			var px = $.trim($("#px"+gsid).val());
			loading = layer.load(2, {
                shade: [0.2,'#000'] //0.2透明度的白色背景
            });
			var json = {gsid:gsid,px:px};
			jq.post('modifyPx',json,function(data){
				// console.log("data:"+JSON.stringify(data));
				layer.close(loading);
				if(data.code==200){
					layer.msg(data.message, {icon: 1, time: 1000});
				}else{
					$("#px"+gsid).val(o_px);
					layer.msg(data.message, {icon: 2,anim: 6, time: 1000});
				}
			});
		};
		
		//上下架
		shelve = function(gsid,shelveStatus){
			loading = layer.load(2, {
                shade: [0.2,'#000'] //0.2透明度的白色背景
            });
			var json = {gsid:gsid,shelveStatus:shelveStatus};
			jq.post('shelve',json,function(data){
				// console.log("data:"+JSON.stringify(data));
				layer.close(loading);
				if(data.code==200){
					layer.msg(data.message, {icon: 1, time: 1000},function(){
						var content = '<a href="javascript:;" onclick="shelve('+gsid+',0)" class="layui-btn layui-btn-small" title="点击下架">已上架</a>';
						if(shelveStatus == 0){
							content = '<a href="javascript:;" onclick="shelve('+gsid+',1)" class="layui-btn layui-btn-small backgroud-gray" title="点击上架">已下架</a>';
						}
						$("#shelve_td"+gsid).html(content);
					});
				}else{
					layer.msg(data.message, {icon: 2,anim: 6, time: 1000});
				}
			});
		};
		
		//推荐
		recommend = function(type,gsid,status){
			loading = layer.load(2, {
                shade: [0.2,'#000'] //0.2透明度的白色背景
            });
			var json = {type:type,gsid:gsid,status:status};
			jq.post('recommend',json,function(data){
				// console.log("data:"+JSON.stringify(data));
				layer.close(loading);
				if(data.code==200){
					layer.msg(data.message, {icon: 1, time: 1000},function(){
						var content = '<a href="javascript:;" onclick="recommend(\''+type+'\','+gsid+',1)" class="layui-btn layui-btn-small" title="取消推荐">已推荐</a>';
						if(status == 1){
							content = '<a href="javascript:;" onclick="recommend(\''+type+'\','+gsid+',0)" class="layui-btn layui-btn-small backgroud-gray" title="点击推荐">未推荐</a>';
						}
						$("#"+type+"_recommend_td"+gsid).html(content);
					});
				}else{
					layer.msg(data.message, {icon: 2,anim: 6, time: 1000});
				}
			});
		};
		
		//审核
		audit = function(gsid){
			var auditVal = $.trim($("#audit"+gsid).val());
			loading = layer.load(2, {
                shade: [0.2,'#000'] //0.2透明度的白色背景
            });
			var json = {gsid:gsid,auditVal:auditVal};
			jq.post('audit',json,function(data){
				//console.log("data:"+JSON.stringify(data));
				layer.close(loading);
				if(data.code==200){
					layer.msg(data.message, {icon: 1, time: 1000});
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
				var json = {ids:id,model:modelName};
                jq.post(sysUrl+'delete',json,function(data){
					// console.log("data:"+JSON.stringify(data));
                    layer.close(loading);
					if(data.code==200){
						layer.msg(data.message, {icon: 1, time: 1000}, function(){
							window.location.href = '?type='+productType+'&offset='+pageNumber+'&limit='+page_size+'&search='+search;
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
                jq.post(sysUrl+'delete',param,function(data){
					layer.close(loading);
					if(data.code==200){
						layer.msg(data.message, {icon: 1, time: 1000}, function(){
							window.location.href = '?type='+productType+'&offset='+pageNumber+'&limit='+page_size+'&search='+search;
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