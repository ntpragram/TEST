package admin.level;


import org.apache.commons.lang3.StringUtils;

import utils.commonUtil.StrManager;
import utils.commonUtil.sql_inserj;
import utils.other.JSONCode;
import admin.level.model.AboutModel;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.plugin.activerecord.Record;

import controller.BaseAdminController;

public class AboutController extends BaseAdminController{

	StrManager str = new StrManager();
	sql_inserj inj = new sql_inserj();
	@Override
	public String route() {
		return "admin/about";
	}

	/**
	 * (关于我们/人才招聘)修改页面跳转
	 * @author 
	 * @param:    
	 * @return: void   
	 * @throws 
	 */
	public void toModify(){
		if(!StringUtils.isBlank("id")){
			String id = str.notEmpty(getPara("id"));
			Record record =AboutModel.dao.getAboutDetail(id);
			if(record!=null){
				String title = str.notEmpty(record.getStr("title"));
				String remark = str.notEmpty(record.getStr("remark"));
				String type = str.notEmpty(record.getInt("type"));
				String content = str.notEmpty(record.getStr("content"));
				
				setAttr("title",title);
				setAttr("remark",remark);
				setAttr("content",content);
				setAttr("type",type);
				setAttr("id",id);
				
				renderJsp("admin/about/mod.jsp");
			}
		}	
	}
	
	/**
	 * 修改(关于我们/人才招聘)详情
	 * @author 
	 * @param:    
	 * @return: void   
	 * @throws 
	 */
	public void modifyAbout(){
		String where = str.notEmpty(getPara("where"));
		JSONObject value = JSONObject.parseObject(where);
		String title = str.notEmpty(value.getString("title"));
		String id = value.getString("id");
		if(!inj.sql_inserj(title+id)){
			if(!StringUtils.isBlank("id")){
				success = AboutModel.dao.modifyAbout(value);
				if(success){
					renderJSON(JSONCode.请求通过, "修改成功", null);
				}else{
					renderJSON(JSONCode.请求出错, "修改失败", null);
				}
			}
		}
	}

}
