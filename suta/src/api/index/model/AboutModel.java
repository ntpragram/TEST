/*
 * @(#) MemberModel.java 2016年12月17日
 *
 * Copyright (c) 2015, XiaHeng NetWork. All Rights Reserved.
 * XiaHeng NetWork. CONFIDENTIAL
 */
package api.index.model;

import utils.jfinal.BaseModel;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

/**
 * 
 * @author Administrator
 *
 */
public class AboutModel extends BaseModel<AboutModel> {

	/**
	 * <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = -211636534402983276L;

	public static final AboutModel dao = new AboutModel();

	@Override
	public boolean isReal() {
		return false;
	}

	@Override
	public String tableName() {
		return " t_about ";
	}

	@Override
	public String tableKey() {
		return "id";
	}

	@Override
	public String fieldName() {
		// TODO Auto-generated method stub
		return null;
	}

	
	/**
	 * 获取信息
	 * @return
	 */
	public Record getAboutDetail() {
		// TODO Auto-generated method stub
	
		StringBuffer select = new StringBuffer();
		select.append(" select id,title,remark,content,createTime,type,isDel,concat('http://114.55.209.136:9090/suta/',pic) as pic");
//		select.append(" select id,title,remark,content,createTime,type,isDel,concat('http://192.168.1.66:8080/suta/',pic) as pic");
		select.append(" from " + this.tableName());
		select.append("where type=0");
		 
		return  Db.findFirst(select.toString());
	}
	

}
