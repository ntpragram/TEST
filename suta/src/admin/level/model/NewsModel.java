package admin.level.model;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;

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
public class NewsModel extends BaseModel<NewsModel> {

	/**
	 * <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = -211636534402983276L;

	public static final NewsModel dao = new NewsModel();

	@Override
	public boolean isReal() {
		return false;
	}

	@Override
	public String tableName() {
		return " t_article ";
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
	public Page<Record> getSucess(int page, int pageSize, JSONObject json) {
		StringBuffer select = new StringBuffer();
		select.append("select id,title,remark,content,createTime,isDel,pic,type,url,status");
		StringBuffer from = new StringBuffer();
		from.append(" from " + this.tableName());
		from.append(" WHERE isDel = 0 AND type = ? ");
		List<Object> list = new ArrayList<Object>();
		list.add(json.getString("type"));
		from.append(" ORDER BY id DESC ");
		return Db.paginate(page, pageSize, select.toString(), from.toString(),
				list.toArray(new Object[list.size()]));
	}
	
	public boolean addNews(JSONObject value){
		NewsModel model = new NewsModel();
		model.set("title", value.getString("title"));
		model.set("remark",value.getString("remark"));
		model.set("content", value.getString("content"));
		model.set("pic", value.getString("picSmall"));
		model.set("bigpic", value.getString("picBig"));
		model.set("type", 3);
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
	
	public boolean modifyNews(JSONObject value){
		StringBuffer modify = new StringBuffer();
		modify.append("update "+this.tableName());
		modify.append(" set `title`=?,");
		modify.append(" `remark`=?,");
		modify.append(" `content`=?,");
		modify.append(" `status`=?,");
		modify.append(" `type`=?,");
		modify.append(" `pic`=?,");
		modify.append(" `bigpic`=?");
		modify.append(" where `id`=?");

		String title = value.getString("title");
		String smallPic = value.getString("picSmall");
		String bigPic = value.getString("picBig");
		
		smallPic=smallPic.substring(30);
		bigPic=bigPic.substring(30);
		
//		smallPic=smallPic.substring(32);
//		bigPic=bigPic.substring(32);
		
		String remark = value.getString("remark");
		String status = value.getString("status");
		String type = value.getString("type");
		String id = value.getString("id");
		String content = value.getString("content");
		success = Db.update(modify.toString(), title,remark,content,status,type,smallPic,bigPic,id) > 0;
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
	
	public Record getNewsDetail(String id){
		StringBuffer select = new StringBuffer();
		select.append(" select id,title,remark,content,createTime,type,pic,lid,isDel,bigpic,status");
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
		select.append("select id,title,remark,content,createTime,isDel,pic,type,status,bigpic");
		StringBuffer from = new StringBuffer();
		from.append(" from " + this.tableName());
		from.append(" WHERE isDel = 0 AND type = '"+type+"'");
		
		List<Object> list = new ArrayList<Object>();
		if (StringUtils.isNotBlank(json.getString("search"))) {
			from.append(" and title like ? ");
			list.add("%" + json.getString("search") + "%");
		}	
		from.append(" ORDER BY id DESC ");
		return Db.paginate(page, pageSize, select.toString(), from.toString(),list.toArray(new Object[list.size()]));
	}

}
