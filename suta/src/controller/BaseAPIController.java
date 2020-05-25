package controller;

import utils.commonUtil.PageKit;
import utils.interceptor.ApiIntercptor;
import utils.jfinal.BaseController;
import utils.jfinal.JFinalConst;

import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Record;

/**
 * API 接口基类
 * 
 * @Description
 * 
 * @author C H
 * @version 1.0
 * @since 2017年1月4日
 */
@Before(ApiIntercptor.class)
public abstract class BaseAPIController extends BaseController {
	private Record token;
	public void setToken(Record token) {
		this.token = token;
	}

	/**
	 * 必须拦截才能使用
	 * 
	 * @author C H
	 * @since 2017年1月11日
	 * @return
	 */
	protected Record getToken() {
		return token;
	}

	/**
	 * 获取当前登陆用户的memberId
	 * 
	 * @author C H
	 * @since 2017年1月22日
	 * @return
	 */
	protected String getMemberId() {
		return this.token.getStr(JFinalConst.member_id);
	}

	/**
	 * 获取当前登陆用户的userName
	 * 
	 * @author C H
	 * @since 2017年2月7日
	 * @return
	 */
	protected String getMemberUserName() {
		return this.token.getStr("userName");
	}

	
	protected int getPageStart() {
	        return PageKit.getStart(getParaToInt("pageIndex", 0), getPageSize());
	}

	protected int getPageSize() {
	        return getParaToInt("pageSize", 10);
	}


}
