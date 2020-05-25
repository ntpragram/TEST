package admin.level.model;

import java.util.ArrayList;
import java.util.List;

import utils.jfinal.BaseModel;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
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
	
	public Page<Record> getVRPagingMessage(int page, int pageSize, JSONObject json) {
		StringBuffer select = new StringBuffer();
		select.append("select id,title,remark,content,createTime,type,isDel");
		StringBuffer from = new StringBuffer();
		from.append(" from " + this.tableName());
		from.append(" WHERE isDel = 0 AND type = ? ");
		List<Object> list = new ArrayList<Object>();
		list.add(json.getString("type"));
		from.append(" ORDER BY id DESC ");
		return Db.paginate(page, pageSize, select.toString(), from.toString(),
				list.toArray(new Object[list.size()]));
	}
	
	public boolean addAbout(JSONObject value){
		AboutModel model = new AboutModel();
		model.set("title", value.getString("title"));
		model.set("remark",value.getString("remark"));
		model.set("content", value.getString("content"));
		model.set("type", 0);
		return model.saveModel();
	}
	
	
	/**
	 * 修改资讯
	 * 
	 * @author C H
	 * @since 
	 * @param 
	 * @param 
	 * @return
	 */
	
	public boolean modifyAbout(JSONObject value){
		StringBuffer modify = new StringBuffer();
		modify.append("update "+this.tableName());
		modify.append(" set `title`=?,");
		modify.append(" `remark`=?,");
		modify.append(" `content`=?,");
		modify.append(" `type`=?");
		modify.append(" where `id`=?");

		String title = value.getString("title");
		String remark = value.getString("remark");
		String content = value.getString("content"); 
		String type = value.getString("type"); 
		String id = value.getString("id");

		success = Db.update(modify.toString(), title,remark,content,type,id) > 0;
		return success;
	}

	/**
	 * 获取资讯信息
	 * 
	 * @author C H
	 * @since 
	 * @param 
	 * @param 
	 * @return
	 */
	
	public Record getAboutDetail(String id){
		StringBuffer select = new StringBuffer();
		select.append(" select id,title,remark,content,createTime,type,isDel");
		select.append(" from " + this.tableName());		
		select.append("where "+this.tableKey()+"=?");
		return Db.findFirst(select.toString(),id);
		
	}

	/**
	 * @author: C H
	 * @param page
	 * @param pageSize
	 * @param json
	 * @return
	 * @throws
	 */
	public Page<Record> getPagingMessage(int page, int pageSize, JSONObject json,int type) {
		// TODO Auto-generated method stub
		StringBuffer select = new StringBuffer();
		select.append("select id,title,remark,content,createTime,type,isDel");
		StringBuffer from = new StringBuffer();
		from.append(" from " + this.tableName());
		from.append(" WHERE isDel = 0 AND type = '"+type+"'");
		
		from.append(" ORDER BY id DESC ");
		return Db.paginate(page, pageSize, select.toString(), from.toString());
	}

}
