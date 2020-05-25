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
<FORM name="form_qx"  id="form_qx">
  <TABLE id=temp align=center width="80%" >
    <TBODY>
      <TR class="t2">
        <TD style="width:80px;">权限设置:</TD>
        <TD colspan="3"><br/>
          <c:forEach items="${resultData}" var="v" varStatus="i">
              <div style="border-bottom:1px solid #ddd">
	          <INPUT  name="DHL" type="checkbox"  onClick="CheckAll('${v.fbh}');" value="${v.fbh}"  <c:if test="${v.pitchOn == 1}">checked</c:if> id="${v.fbh}">
	          <strong style="display:inline-block;padding:5px 10px;border-bottom:2px solid #009688">${v.fname}</strong><br/>
              </div>
              
	          <div id="BDHL${v.fbh} }" style="width:85%;margin:10px 0;">
	            <c:forEach items="${resultData[i.count-1].TwoPurviewList}" var="vv" varStatus="j">
                    <div style="display:inline-block;width:192px; ">
		            &nbsp;&nbsp;
		            <INPUT  name="BDHL"   onClick="CheckParent('${vv.sbh}');" type=checkbox value="${vv.sbh}" <c:if test="${vv.pitchOnT == 1}">checked</c:if> id="${vv.sbh}">
		            <span style="display:inline-table">${vv.sname}<span>
                    </div>
	            </c:forEach>
	          </div>
         </c:forEach>
          <strong>全部权限:</strong>
          <input type="checkbox" onClick="chkall('form_qx',this)">
          (选中代表是) 
          </TD>
      </TR>
      <TR class="t1 t2" style="padding-top:20px;">
        <TD colSpan=4 align=middle>
          <INPUT class=btn  value="保存" type="button" name="butsubmit" id="btnsubmit" onClick="changeBtn(${id});" style="    background-color: #009688;color:white;border:none;padding:5px 10px;margin-right:10px;cursor:pointer">
          <INPUT class=btn  value="返回" type="button" onClick="backtrack();" style="    background-color: #009688;color:white;border:none;padding:5px 10px;cursor:pointer">
          <INPUT class="btnbg"  value="数据处理中..." style="display:none" type="button"  id="btnbutton">
          &nbsp;&nbsp;
          <input type="hidden" name="submit" value="1">
          <input type="hidden" name="ygid" value="${id}">
        </TD>
      </TR>
    </TBODY>
  </TABLE>
  </FORM>
<script language="javascript">
	function chkall(input1,input2){
		var objForm = document.forms[input1];
		var objLen = objForm.length;
		for (var iCount = 0; iCount < objLen; iCount++){
			if (input2.checked == true){
				if (objForm.elements[iCount].type == "checkbox"){
					objForm.elements[iCount].checked = true;
				}
			}else{
				if (objForm.elements[iCount].type == "checkbox"){
					objForm.elements[iCount].checked = false;
				}
			}
		}
	}
	function changeBtn(id){
	 	document.getElementById('btnsubmit').style.display='none';
	 	document.getElementById('btnbutton').style.display='block';
	 	var url = sysUrl+"administrator/PurviewSettingSubmint?ygid=" + id;
	 	var data = $('#form_qx').serialize();
	 	$.ajax({
            cache: true,
            type: "POST",
            url: url,
            data:data,
            async: false,
            error: function(request) {
                alert("Connection error");
            },
            success: function(data) {
                swalTip("提示", data.message, data.success,function(res){
					if(res){
						if(data.success){
							var index = parent.layer.getFrameIndex(window.name);
							parent.location.reload(); 
							window.parent.layer.close(index);
						}
					}
				});
            }
        });
	}		

	function backtrack(){
		var index = parent.layer.getFrameIndex(window.name);
		window.parent.layer.close(index);
	}

	//全选全不全功能
	function CheckAll(id)
	{
	    if ($("input[type=checkbox][id='" + id + "']").is(":checked"))
	    {
	        $("input[type=checkbox][id^='" + id + "']").attr("checked", true);//当前ID开头的checkbox全选
	    }
	    else
	    {
	        $("input[type=checkbox][id^='" + id + "']").attr("checked", false); //当前ID开头的checkbox全不选
	    }
	
	}
	//checkbox联动
	function CheckParent(id)
	{
	    CheckAll(id);//先进行是否全选的操作
		//alert(id);
		var s_l=id.length;
		//alert(s_l);
	    var s_ParentID = id.substring(0, 1);//取得一级checkbox的id
		//alert(s_ParentID);
	    var s_tmp = id.substring(0, 4);//取得二级checkbox的id
	    //s_tmp = s_tmp.substring(0, s_tmp.indexOf('_'));
	    var s_ParentID_ID =  s_tmp;//取得二级checkbox的id
	    var tf = false;//一级checkbox是否全选
	    var tf1 = false;//二级checkbox是否全选
	    if (s_l == 6){//为空的话说明是点击的二级checkbox，不用判断三级checkbox的状态
	        if (!$("input[type=checkbox][id='" + s_ParentID_ID + "']").is(":checked")){
	            $("input[type=checkbox][id='" + s_ParentID_ID + "']").attr("checked", true);//如果三级checkbox有选中的情况，二级的checkbox也会选中
	        }else{
	            l = $("input[type=checkbox][id^='" + s_ParentID_ID + "']");//获取三级checkbox的集合
	
	            $.each(l, function (idx, item)//循环
	            {
	                if (s_ParentID_ID != $(item)[0].id)//不判断自己(二级checkbox)
	                {
	                    if ($("input[type=checkbox][id='" + $(item)[0].id + "']").is(":checked"))
	                    {
	                        tf1 = true;//如果三级checkbox有选中的直接赋值为true并退出each
	                        return false;
	                    }
	                }
	            })
	            $("input[type=checkbox][id='" + s_ParentID_ID + "']").attr("checked", tf1);//更新二级checkbox的选中状态
	
	        }
	    }
	
	    if (!$("input[type=checkbox][id='" + s_ParentID + "']").is(":checked"))
	    {
	        $("input[type=checkbox][id='" + s_ParentID + "']").attr("checked", true); //如果二级checkbox有选中的情况，一级的checkbox也会选中
	    }
	    else
	    {
	        var l = $("input[type=checkbox][id^='" + s_ParentID + "']"); //获取二级checkbox的集合
	        $.each(l, function (idx, item)//循环
	        {
	            if (s_ParentID != $(item)[0].id)//不判断自己(一级checkbox)
	            {
	                if ($("input[type=checkbox][id='" + $(item)[0].id + "']").is(":checked"))
	                {
	                    tf = true; //如果二级checkbox有选中的直接赋值为true并退出each
	                    return false;
	                }
	            }
	        })
	        $("input[type=checkbox][id='" + s_ParentID + "']").attr("checked", tf); //更新一级checkbox的选中状态
	    }
	}	
</script>
</body>
</html>