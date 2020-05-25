<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	
	basePath="http://121.43.188.172:8019/ZhangShangYunShanPic/";
	
%>
<!DOCTYPE html>
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
<body>
<div class="layui-tab layui-tab-brief main-tab-container">
	<ul class="layui-tab-title main-tab-title">
		<li class="layui-this" style="border-bottom: 0px;top:0px;">会员列表</li>
		<div class="main-tab-item" style="left: 10px;top:0px;">会员管理</div>
	</ul>
	<div class="layui-tab-content">
		<div class="layui-tab-item layui-show">
			<!-- 搜索 -->
			<form class="layui-form layui-form-pane search-form">
				<div class="layui-form-item">
					<div class="layui-input-inline" style="margin-right:10px">
					<input type="text" id="search" value="${resultData.search}" lay-verify="" placeholder="输入账号或昵称搜索" autocomplete="off" class="layui-input">
					</div>
					
					<label class="layui-form-label" style="width: 60px;">注册时间</label>
					<div class="layui-input-inline input-custom-width" style="width: 160px;">
						<input type="text" id="startTime" value="${resultData.startTime}" id="date" lay-verify="datetime" placeholder="开始时间" 
						autocomplete="off" class="layui-input" onclick="callDate({elem: this,istime: 1, format: 'YYYY-MM-DD hh:mm:ss' })">
					</div>
					
					
			<%-- 		<label class="layui-form-label" style="width: 60px;margin-left:10px">审核状态</label>
					<div class="layui-input-inline" style="width: 100px;">
						<select id="auditStatus" style="display:block;height:38px;">
							<option value="-1" <c:if test="${resultData.auditStatus == -1}">selected</c:if>>全部</option>
							<option value="0" <c:if test="${resultData.auditStatus == 0}">selected</c:if>>通过</option>
							<option value="1" <c:if test="${resultData.auditStatus == 1}">selected</c:if>>黑名单</option>
						</select>
					</div> --%>
					<span class="layui-btn" lay-submit="" lay-filter="" onclick="pageJump(1)">搜索</span>
					<span class="layui-btn" lay-submit="" lay-filter="" onclick="clearData()">清除</span>
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
			
				<table class="list-table">
					<thead>
						<tr>
						<!--<th class="first"><input type="checkbox" name="checkAll" lay-filter="checkAll" title=" "></th>-->
						<th>序号</th>
						<th>账号</th>
						<th>昵称</th>
						<th>头像</th>
						<th>性别</th>		
						<th>积分</th>			
						<th>余额</th>		
						<th>是否登陆</th>							
						<th>注册时间</th>
						<th>查看详情</th>
						<!--<th>操作</th>-->
						</tr> 
					</thead>
					<tbody class="table-list-box">
						<c:forEach items="${resultData.dataList}" var="v" varStatus="i">
							<tr>
								<!--
								<td class="first" style="text-align: center;">
									<input type="checkbox" name="ids" lay-filter="checkOne" value="${v.uid}" title=" ">
									<div class="layui-unselect layui-form-checkbox">
									<span></span>
									</div>
								</td>
								-->
								<td style="text-align: center;">${i.count + (resultData.pageNumber - 1) * resultData.pageSize}</td>
								<td style="text-align: center;">${v.phone}</td>
								<td style="text-align: center;">${v.nickName}</td>
								<td style="text-align: center;" class="table-img">
									<div class="img"><img src="<%=basePath%>${v.headPic}" alt="..." class="img-thumbnail" style="width: 80px;height: 80px;"></div>
								</td>
								<td style="text-align: center;">
									<c:choose>
										<c:when test="${v.sex == 1}">男</c:when>
										<c:when test="${v.sex == 2}">女</c:when>
										<c:otherwise>未知</c:otherwise>
									</c:choose>
								</td>
								<td style="text-align: center;">${v.integral}</td>
								<td style="text-align: center;">${v.blance}</td>
								<td style="text-align: center;">
									<c:choose>
										<c:when test="${v.isLogin == 0}">未登录</c:when>
										<c:when test="${v.isLogin == 1}">已登录</c:when>
									</c:choose>
								</td>
								<td style="text-align: center;">${v.createTime}</td>
								<td style="text-align: center;">
								<a href="javascript:;" class="layui-btn layui-btn-small" title="查看详情与修改" onclick="toMod(${v.id})">查看详情</a>
								</td>
								<!--
								<td style="text-align: center;">
								<a class="layui-btn layui-btn-small layui-btn-danger del_btn" feedback-id="${v.uid}" title="删除" feedback-name="${v.username}">
									<i class="layui-icon"></i>
								</a>
								</td>
								-->
							</tr>
						</c:forEach>

					</tbody>
					<thead>
						<tr>
							<!--<th class="first"><button class="layui-btn layui-btn-small" lay-submit lay-filter="delete">删除</button></th>-->
							<th colspan="10">
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
	var startTime = "${resultData.startTime}";
	var auditStatus = "${resultData.auditStatus}";
	var urlWhere = '?offset='+pageNumber+'&limit='+page_size+'&search='+search+'&startTime='+startTime+'&auditStatus='+auditStatus;		
	
	function pageJump(pageNumber){
		search = $("#search").val();
		startTime = $("#startTime").val();
		auditStatus = $("#auditStatus").val();
		window.location.href = '?offset='+pageNumber+'&limit='+page_size+'&search='+search+'&startTime='+startTime+'&auditStatus='+auditStatus;
	}
	
	function toMod(id){
		var layer = layui.layer;
		layer.open({
		  type: 2,
		  icon: 2,
		  maxmin: true,
		  area: ['100%','100%'],
		  title: '会员详情',
		  content: 'toDetails?id=' + id
		});
	}
	
	var audit, callDate;//在此声明方法名，在以下layui.use里赋值
	
    layui.use(['element', 'laypage', 'layer', 'form', 'laydate'], function(){
        var element = layui.element()
            ,laypage = layui.laypage
            ,jq = layui.jquery
			,form = layui.form()
        	,laydate = layui.laydate;

		//审核
		audit = function(id){
			var auditVal = $.trim($("#audit"+id).val());
			loading = layer.load(2, {
                shade: [0.2,'#000'] //0.2透明度的白色背景
            });
			var json = {id:id,auditVal:auditVal};
			jq.post('audit',json,function(data){
				// console.log("data:"+JSON.stringify(data));
				layer.close(loading);
				if(data.code==200){
					layer.msg(data.message, {icon: 1, time: 1000});
				}else{
					layer.msg(data.message, {icon: 2,anim: 6, time: 1000});
				}
			});
		};

		callDate = function(json){
			laydate(json);
		}

		//ajax删除
        jq('.del_btn').click(function(){
            var name = jq(this).attr('feedback-name');
            var id = jq(this).attr('feedback-id');
			
            layer.confirm('确定删除账号为【'+name+'】的用户吗?', function(index){
                loading = layer.load(2, {
                    shade: [0.2,'#000'] //0.2透明度的白色背景
                });
				var json = {id:id};
                jq.post('delete',json,function(data){
					// console.log("data:"+JSON.stringify(data));
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
                var param = {id:strlist};
				// console.log("param:"+JSON.stringify(param));
                jq.post('delete',param,function(data){
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


//调用分页
        /* var dataList=jq(".table-list-box tr");
        var data=new Array();
        dataList.each(function(){
            data.push(jq(this).html())
        });

        var nums = 10; //每页出现的数据量
        jq(".list-all").text(dataList.length);
        jq(".page-list-num input").val(nums);
        jq(".page-list-num a").click(function() {
            nums = jq(".page-list-num input").val();
            console.log(nums)
            laypage({
                cont: 'demo8'
                ,pages: Math.ceil(data.length/nums) //得到总页数
                ,jump: function(obj){
                    jq(".table-list-box").html(render(data, obj.curr));
                }
            })
        });
//模拟渲染
        var render = function(data, curr){
            var arr = []
                ,thisData = data.concat().splice(curr*nums-nums, nums);
            console.log(thisData)
            layui.each(thisData, function(index, item){
                arr.push("<tr>"+item+"</tr>");
            });
            return arr.join('');
        };

        laypage({
            cont: 'demo8'
            ,pages: Math.ceil(data.length/nums) //得到总页数
            ,jump: function(obj){
                jq(".table-list-box").html(render(data, obj.curr));
            }
        }); */
    })
	//清空搜索条件
function clearData(){
  location.href = "?";
}
</script>
</body>
</html>