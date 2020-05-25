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
public class VREducationModel extends BaseModel<VREducationModel> {

	/**
	 * <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = -211636534402983276L;

	public static final VREducationModel dao = new VREducationModel();

	@Override
	public boolean isReal() {
		return false;
	}

	@Override
	public String tableName() {
		return " t_level ";
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
	
	public Page<Record> getVRPagingMessage(int page, int pageSize, JSONObject json,int type) {
		StringBuffer select = new StringBuffer();
		select.append("select id,title,isDel,type,pic,bigPic,content,createTime,videoPath");
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
	
	public boolean addVREducation(JSONObject value){
		VREducationModel model = new VREducationModel();
		model.set("title", value.getString("title"));
		model.set("pic", value.getString("picSmall"));
		model.set("bigPic", value.getString("picBig"));
		model.set("mtpic", value.getString("mtpic"));
		model.set("content", value.getString("content"));
		model.set("type", 1);
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
	
	public boolean modifyVREducation(JSONObject value){
		StringBuffer modify = new StringBuffer();
		modify.append("update "+this.tableName());
		modify.append(" set `title`=?,");
		modify.append(" `pic`=?,");
		modify.append(" `bigPic`=?,");
		modify.append(" `mtpic`=?,");
		modify.append(" `content`=?");
		modify.append(" where `id`=?");
		String title = value.getString("title");
		
		String smallPic = value.getString("picSmall");
		String bigPic = value.getString("picBig");
		String mtpic = value.getString("mtpic");
		smallPic=smallPic.substring(30);
		bigPic=bigPic.substring(30);
		mtpic=mtpic.substring(30);
		
//		smallPic=smallPic.substring(32);
//		bigPic=bigPic.substring(32);
//		mtpic=mtpic.substring(32);

		String content = value.getString("content");
		String id = value.getString("id");
		success = Db.update(modify.toString(), title,smallPic,bigPic,mtpic,content,id) > 0;
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
	
	public Record getVREducationDetail(String id){
		StringBuffer select = new StringBuffer();
		select.append(" select id,title,isDel,type,pic,bigPic,content,createTime,videoPath,mtpic");
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
		select.append("select id,title,isDel,type,concat('http://114.55.209.136:9090/suta/',pic) as pic,concat('http://114.55.209.136:9090/suta/',bigPic) as bigPic,content,createTime,concat('http://114.55.209.136:9090/suta/',videoPath) as videoPath");
		StringBuffer from = new StringBuffer();
		from.append(" from " + this.tableName());
		from.append(" WHERE isDel = 0 AND type = '"+type+"'");		
		from.append(" ORDER BY id DESC ");
		return Db.paginate(page, pageSize, select.toString(), from.toString());
	}
	
	
	
	
	
	
	
	
	//----------------------------------------成功案例--------------------------------------------------------------------
	public Page<Record> getSuccessPagingMessage(int page, int pageSize, JSONObject json,int type) {
		StringBuffer select = new StringBuffer();
		select.append("select id,title,isDel,type,pic,bigPic,content,createTime,videoPath");
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
	
	public boolean addSuccessCase(JSONObject value){
		VREducationModel model = new VREducationModel();
		model.set("title", value.getString("title"));
		model.set("pic", value.getString("picSmall"));
		model.set("bigPic", value.getString("picBig"));
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
	
	public boolean modifySuccessCase(JSONObject value){
		StringBuffer modify = new StringBuffer();
		modify.append("update "+this.tableName());
		modify.append(" set `title`=?,");
		modify.append(" `pic`=?,");
		modify.append(" `bigPic`=?,");
		modify.append(" `content`=?");
		modify.append(" where `id`=?");
		String title = value.getString("title");
		
		String smallPic = value.getString("picSmall");
		String bigPic = value.getString("picBig");		
		smallPic=smallPic.substring(30);
		bigPic=bigPic.substring(30);
		
//		smallPic=smallPic.substring(32);
//		bigPic=bigPic.substring(32);

		String content = value.getString("content");
		String id = value.getString("id");
		success = Db.update(modify.toString(), title,smallPic,bigPic,content,id) > 0;
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
	
	public Record getSuccessCaseDetail(String id){
		StringBuffer select = new StringBuffer();
		select.append(" select id,title,isDel,type,pic,bigPic,content,createTime,videoPath");
		select.append(" from " + this.tableName());		
		select.append("where "+this.tableKey()+"=?");
		return Db.findFirst(select.toString(),id);
		
	}
	
	/**
	 * 修改上传文件路径
	 * @param otherParameter
	 * @return
	 */
	public boolean modifyUpload(String id,String videoPath) {
		StringBuffer modify = new StringBuffer();
		modify.append("update "+this.tableName());
		modify.append(" set `videoPath`=?");
		modify.append(" where `id`=?");
		success = Db.update(modify.toString(),videoPath,id) > 0;
		return success;
	}

}
