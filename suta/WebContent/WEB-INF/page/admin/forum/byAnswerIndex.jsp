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
		<li class="layui-this" style="border-bottom: 0px;top:0px;">问答管理</li>
		<div class="main-tab-item" style="left: 10px;top:0px;">
        	问答列表
        </div>
	</ul>
	<div class="layui-tab-content">

            <form class="layui-form layui-form-pane search-form">
                <div class="layui-form-item">
                    <label class="layui-form-label">标题</label>
                    <div class="layui-input-inline">
                        <input type="text" name="search" id="search" value="${resultData.search}" lay-verify="" placeholder="请输入标题搜索" autocomplete="off" class="layui-input">
                    </div>
                    <span class="layui-btn" lay-submit="" lay-filter="" onclick="pageJump(${resultData.pageNumber})">搜索</span>
                </div>

            </form>
      

		<div class="layui-tab-item layui-show">

            <form class="layui-form layui-form-pane search-form">
       <!--  <div class="layui-form-item">
        <div class="layui-btn-group">

          <span class="layui-btn layui-btn-small modal-catch" onclick="toAdd()">
            <img src="../../images/add.png">
            <a>添加</a>
          </span>
        </div>
      </div> -->

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
               
                <input type="hidden" id="modelName"  value="forumanswer" >
                 <input type="hidden" id="fid"  name="fid" value="${resultData.fid}" >
                  <input type="hidden" id="repUid"  name="repUid" value="${resultData.repUid}" >
				<table class="list-table">
					<thead>
						<tr>
						<!-- <th class="first" style="width: 120px"><input type="checkbox" name="checkAll" lay-filter="checkAll" title=" "></th> -->
						
						<th>内容</th>
                        <th>回复人</th>
						<th>被回复人</th>
                        <th>回复时间</th>  
                        <th>点赞数</th>                  
                       <!--  <th>回复答案管理</th>		 -->			
						</tr> 
					</thead>
					<tbody class="table-list-box">
						<c:forEach items="${resultData.dataList}" var="v" varStatus="i">
							<tr>
							<%-- 	<td class="first" style="text-align: center;">
									<input type="checkbox" name="ids" lay-filter="checkOne" value="${v.id}" title=" ">
									<div class="layui-unselect layui-form-checkbox">
									<span></span>
									</div>
								</td> --%>
								
								<td style="text-align: center;">${v.content}</td> 
								<td style="text-align: center;">${v.nickName1}</td> 
                                <td style="text-align: center;">${v.nickName2}</td>
                                <td style="text-align: center;">${v.createTime}</td>
                                <td style="text-align: center;">${v.zanNum}</td>                            
                          <%--        <td style="text-align: center;"><a href="javascript:;" class="layui-btn layui-btn-warm layui-btn-small" title="回答列表" onclick="answerList(${v.id})">回答列表</a></td>
							 --%></tr>
						</c:forEach>

					</tbody>
					<thead>
						<tr>
							<!-- <th class="first" style="width: 120px">
                                <span class="layui-btn layui-btn-small" lay-submit lay-filter="add" onclick="toAdd()">添加</span>
                                <span class="layui-btn layui-btn-small" lay-submit lay-filter="delete" >删除</span>
                            </th> -->
							<!--分页代码开始-->
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
    var search = "${resultData.search}";
    var fid = "${resultData.fid}";
    var repUid = "${resultData.repUid}";
    var urlWhere ='?offset='+pageNumber+'&limit='+page_size+'&search='+search+'&fid='+fid+'&repUid='+repUid;

	function pageJump(pageNumber){

        var ntype = $("#ntype").val();
        var search = $("#search").val();
        var fid = "${resultData.fid}";
        var repUid = "${resultData.repUid}";
        //console.log("url:"+sysUrl + 'goodsType/getTypeList?offset='+pageNumber+'&limit='+page_size+'&type='+type+'&grade='+grade+'&parentid='+parentid+'&title='+search);
		window.location.href = '?offset='+pageNumber+'&limit='+page_size+'&search='+search+'&fid='+fid+'&repUid='+repUid;

	}
	
    var release,recommend,modifyPx;
    layui.use(['element', 'laypage', 'layer', 'form'], function(){
        var element = layui.element()
            ,laypage = layui.laypage
            ,jq = layui.jquery
            ,form = layui.form();

//ajax删除
        var modelName = $("#modelName").val();
        jq('.del_btn').click(function(){
            var name = jq(this).attr('feedback-name');
            var id = jq(this).attr('feedback-id');
            layer.confirm('确定删除?', function(index){
                loading = layer.load(2, {
                    shade: [0.2,'#000'] //0.2透明度的白色背景
                });
                jq.post(sysUrl+'delete',{'ids':id,model:modelName},function(data){
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

        //119.10.105.209.cn
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
            layer.confirm('确定批量删除吗?', function(index){
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
                console.log("param:"+JSON.stringify(param));
                jq.post(sysUrl+'delete',param,function(data){
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



function answerList(fid){
    var layer = layui.layer;
     layer.open({
      type: 2,
      icon: 2,
      maxmin: true,
      area: ['90%','90%'],
      title: '添加',
      content: sysUrl+'forum/answerList?fid='+fid
    });

}


</script>
</body>
</html>