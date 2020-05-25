package controller;

import java.util.Enumeration;

import utils.jfinal.BaseController;
import utils.jfinal.JFinalConst;
import admin.main.AdminModel;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.plugin.activerecord.Record;

/**
 * 后台基类
 * 
 * @Description
 * 
 * @author C H
 * @version 1.0
 * @since 2017年1月4日
 */

public abstract class BaseAdminController extends BaseController {

	/**
	 * 总后台用户
	 * 
	 * @author C H
	 * @since 2017年1月4日
	 * @return
	 */
	protected Record getAdminInfo() {
		Record adminInfo = (Record) getSession().getAttribute(JFinalConst.admin);
		if (adminInfo == null) {
			return null;
		}
		adminInfo = AdminModel.dao.adminInfo(adminInfo.getStr("username"));
		adminInfo.remove("password");
		return adminInfo;
	}

	/**
	 * 将参数封到JSONObject 内
	 * 
	 * @author C H
	 * @since 2017年2月15日
	 * @return
	 */
	protected JSONObject getAllParaName() {
		Enumeration<String> names = getParaNames();
		JSONObject param = new JSONObject();
		while (names.hasMoreElements()) {
			String string = (String) names.nextElement();
			param.put(string, getPara(string));
		}
		return param;
	}
}
