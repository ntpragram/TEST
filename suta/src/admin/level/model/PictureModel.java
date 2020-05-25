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
public class PictureModel extends BaseModel<PictureModel> {

	/**
	 * <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = -211636534402983276L;

	public static final PictureModel dao = new PictureModel();

	@Override
	public boolean isReal() {
		return false;
	}

	@Override
	public String tableName() {
		return " t_picture ";
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


	/**获取单个图片对象
	 * @author: C H
	 * @param type
	 * @return
	 * @throws
	 */
	public Record getPictureDetailByType(String type) {
		StringBuffer select = new StringBuffer();
		select.append(" select id,title,remark,content,createTime,isDel,pic,type,url,status");
		select.append(" from " + this.tableName());		
		select.append("where type"+"=?");
		return Db.findFirst(select.toString(),type);
	}
	
	/**获取单个图片对象
	 * @author: C H
	 * @param id
	 * @return
	 * @throws
	 */
	public Record getPictureDetailByID(String id) {
		StringBuffer select = new StringBuffer();
		select.append(" select id,title,remark,content,createTime,isDel,pic,type,url,status");
		select.append(" from " + this.tableName());		
		select.append("where id"+"=?");
		return Db.findFirst(select.toString(),id);
	}
	
	
	/**
	 * 获取图片集合
	 * @author: C H
	 * @param id
	 * @return
	 * @throws
	 */
	public Page<Record> getPictureListDetail(int page, int pageSize, JSONObject json) {	
		StringBuffer select = new StringBuffer();
		select.append("select id,title,remark,content,createTime,isDel,pic,type,url,status");
		String type = json.getString("type");
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
	
	/**
	 * 修改图片
	 * 
	 * @author C H
	 * @since 
	 * @param 
	 * @param 
	 * @return
	 */
	
	public boolean modifyOnePicture(JSONObject value){
		StringBuffer modify = new StringBuffer();
		modify.append("update "+this.tableName());
		modify.append(" set `pic`=?");
		modify.append(" where `id`=?");

		String smallPic = value.getString("picSmall");		
		smallPic=smallPic.substring(30);
		
//		smallPic=smallPic.substring(32);

		String id = value.getString("id");
		success = Db.update(modify.toString(),smallPic,id) > 0;
		return success;
	}

	/**
	 * @author: C H
	 * @param value
	 * @return
	 * @throws
	 */
	public boolean addPicture(JSONObject value) {
		PictureModel model = new PictureModel();
		model.set("title", value.getString("title"));
		model.set("type",value.getString("type"));
		model.set("pic", value.getString("picSmall"));
		model.set("mtpic", value.getString("picBig"));
		model.set("content", value.getString("content"));
		return model.saveModel();
	}

	/**
	 * @author: C H
	 * @param value
	 * @return
	 * @throws
	 */
	public boolean modifyPicture(JSONObject value) {
		StringBuffer modify = new StringBuffer();
		modify.append("update "+this.tableName());
		modify.append(" set `title`=?,");
		modify.append(" `content`=?,");
		modify.append(" `pic`=?,");
		modify.append(" `mtpic`=?");
		modify.append(" where `id`=?");

		String title = value.getString("title");
		String pic = value.getString("picSmall");
		String mtpic = value.getString("picBig");
		pic=pic.substring(30);
		mtpic = mtpic.substring(30);
		
//		pic=pic.substring(32);
//		mtpic = mtpic.substring(32);
		String content = value.getString("content");		
		String id = value.getString("id");

		success = Db.update(modify.toString(), title,content,pic,mtpic,id) > 0;
		return success;
	}


}
