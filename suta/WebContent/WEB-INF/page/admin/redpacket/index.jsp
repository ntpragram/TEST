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
</head>
<body>
<div class="layui-tab layui-tab-brief main-tab-container">
	<ul class="layui-tab-title main-tab-title">
		<li class="layui-this" style="border-bottom: 0px;top:0px;">红包列表</li>
		<div class="main-tab-item" style="left: 10px;top:0px;">红包管理</div>
	</ul>
	<div class="layui-tab-content">

		<!-- 搜索 -->
        
       

		<div class="layui-tab-item layui-show">
			<!-- 搜索 -->
			  <form class="layui-form layui-form-pane search-form">
              <div class="layui-form-item">
                  <label class="layui-form-label">标题</label>
                  <div class="layui-input-inline">
                      <input type="text" name="search" id="search" value="${resultData.search}" lay-verify="" placeholder="请输入标题搜索" autocomplete="off" class="layui-input">
                  </div>
                  <span class="layui-btn" lay-submit="" lay-filter="" onclick="pageJump(${resultData.pageNumber})">搜索</span>
              </div>
          
          </form> 
			<form class="layui-form layui-form-pane search-form">
				<!-- 每页数据量 -->
				  <div class="layui-form-item">
			  
        <div class="layui-btn-group">
          <span class="layui-btn layui-btn-small modal-catch" onclick="toAdd()">
            <img src="../../images/add.png">
            <a>添加</a>
          </span>
        </div>
    
      </div>
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
				<input type="hidden" id="status" value="${resultData.status}" title=" ">
                <input type="hidden" id="modelName"  value="redPacket" >
				<table class="list-table">
					<thead>
						<tr>
						<th class="first"><input type="checkbox" name="checkAll" lay-filter="checkAll" title=" "></th>
						<th>序号</th>
						<th>标题</th>
						<th>
						<c:if test="${resultData.status == '0'}">
						抵扣价格
						</c:if>
						<c:if test="${resultData.status == '1'}">
						折扣数
						</c:if>
						</th>
						<th>最低消费（元）</th>
						<th>有效期</th>
						<th>数量</th>
						<th>添加时间</th>
						<th>推送红包</th>
						<th>操作</th>
						</tr> 
					</thead>
					<tbody class="table-list-box">
						<c:forEach items="${resultData.dataList}" var="v" varStatus="i">
							<tr>
								
								<td class="first" style="text-align: center;">
									<input type="checkbox" name="ids" lay-filter="checkOne" value="${v.id}" title=" ">
									<div class="layui-unselect layui-form-checkbox">
									<span></span>
									</div>
								</td>
							
								<td style="text-align: center;">${i.count + (resultData.pageNumber - 1) * resultData.pageSize}</td>
								<td style="text-align: center;">${v.title}</td>
								<td style="text-align: center;">
								<c:if test="${resultData.status == 0}">${v.price}</c:if>
								<c:if test="${resultData.status == 1}">${v.discount}</c:if>
								</td>
								<td style="text-align: center;">${v.fullPrice}</td>
								<td style="text-align: center;">${v.period}天</td>
								<td style="text-align: center;">${v.num}</td>
								<td style="text-align: center;">${v.createTime}</td>
								
								<td style="text-align: center;">
								
								<c:if test="${v.pushStatus == 0}">
								<a href="javascript:;" class="layui-btn layui-btn-warm layui-btn-small" title="推送红包" onclick="dantui(${v.id})">单推</a>
								<a href="javascript:;" class="layui-btn layui-btn-normal layui-btn-small" title="推送红包" onclick="quantui(${v.id})">全推</a>
								</c:if>
								<c:if test="${v.pushStatus == 1}">
								已推送
								</c:if>
								</td>
							
								
								<td style="text-align: center;">
								<a href="javascript:;" class="layui-btn layui-btn-small" title="编辑" onclick="toMod(${v.id})"><i class="layui-icon"></i></a>
								<a class="layui-btn layui-btn-small layui-btn-danger del_btn" feedback-id="${v.id}" title="删除">
									<i class="layui-icon"></i>
								</a>
								</td>
							</tr>
						</c:forEach>

					</tbody>
					<thead>
						<tr>
							
							<th class="first"><button class="layui-btn layui-btn-small" lay-submit lay-filter="delete">删除</button></th>
						
							<th colspan="9">
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
	var status = "${resultData.status}";		
	function pageJump(pageNumber){
		search = $("#search").val();
		window.location.href = 'getRedPacket?offset='+pageNumber+'&limit='+page_size+'&search='+search+'&status='+status;
	}
	
	var modifyPx;
    layui.use(['element', 'laypage', 'layer', 'form'], function(){
        var element = layui.element()
            ,laypage = layui.laypage
            ,jq = layui.jquery
            ,form = layui.form();
		//ajax删除
        jq('.del_btn').click(function(){
            var name = jq(this).attr('feedback-name');
            var id = jq(this).attr('feedback-id');
			
            layer.confirm('确定删除此条记录吗?', function(index){
                loading = layer.load(2, {
                    shade: [0.2,'#000'] //0.2透明度的白色背景
                });
				var json = {id:id};
                jq.post('delete',json,function(data){
					// console.log("data:"+JSON.stringify(data));
                    layer.close(loading);
					if(data.code==200){
						layer.msg(data.message, {icon: 1, time: 1000}, function(){
							window.location.href = '?offset='+pageNumber+'&limit='+page_size+'&search='+search+'&status='+status;
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
							window.location.href = '?offset='+pageNumber+'&limit='+page_size+'&search='+search+'&status='+status;
						});
					}else{
						layer.msg(data.message, {icon: 2,anim: 6, time: 1000});
					}
                });
            });
            return false;
        });

    })
    
function tuisong(id){
    var layer = layui.layer;
    var type = $("#type").val();
    layer.open({
      type: 2,
      icon: 2,
      maxmin: true,
      area: ['40%','40%'],
      title: '推送',
      content: sysUrl+'redPacket/goPush?id='+id 
    });
}
    
    

function toAdd(){
    var layer = layui.layer;
    var status = $("#status").val();

    //window.location.href = 'http://192.168.2.140:8088/jindu/admin/goodsType/toAdd?type='+type+'&grade='+grade+'&parentid='+parentid;
    layer.open({
      type: 2,
      icon: 2,
      maxmin: true,
      area: ['90%','90%'],
      title: '添加',
      content: sysUrl+'redPacket/toAdd?status='+status
    });

}

function toMod(id){
    var layer = layui.layer;
    var type = $("#type").val();
    layer.open({
      type: 2,
      icon: 2,
      maxmin: true,
      area: ['90%','90%'],
      title: '修改',
      content: sysUrl+'redPacket/toModify?id='+id 
    });

}

function dantui(rid){
	
	var layer = layui.layer;
    var type = $("#type").val();
    layer.open({
      type: 2,
      icon: 2,
      maxmin: true,
      area: ['90%','90%'],
      title: '选择会员',
      content: sysUrl+'redPacket/getMemberList?rid='+rid 
    });
	
	

       
}

function quantui(rid){
    layer.confirm('确定推送此红包吗?', function(index){
        loading = layer.load(2, {
            shade: [0.2,'#000'] //0.2透明度的白色背景
        });
		var json = {id:rid};
        jq.post('allPush',json,function(data){
            layer.close(loading);
			if(data.code==200){
				layer.msg(data.message, {icon: 1, time: 1000}, function(){
					window.location.href = '?offset='+pageNumber+'&limit='+page_size+'&search='+search+'&status='+status;
				});
			}else{
				layer.msg(data.message, {icon: 2,anim: 6, time: 1000});
			}
        });
    });
}



</script>
</body>
</html>