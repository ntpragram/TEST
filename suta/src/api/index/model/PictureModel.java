package api.index.model;

import java.util.List;

import utils.jfinal.BaseModel;
import com.jfinal.plugin.activerecord.Db;
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

	/**
	 * 首页轮播图
	 * @author: C H
	 * @param json
	 * @return
	 * @throws
	 */
	public List<Record> getCarousel(int type) {

		StringBuffer select = new StringBuffer(); 
		select.append("select id,title,remark,content,createTime,isDel,concat('http://114.55.209.136:9090/suta/',pic) as pic,type,url,status,concat('http://114.55.209.136:9090/suta/',mtpic) as mtpic");
//		select.append("select id,title,remark,content,createTime,isDel,concat('http://192.168.1.66:8080/suta/',pic) as pic,type,url,status,concat('http://192.168.1.66:8080/suta/',mtpic) as mtpic");
		select.append(" from " + this.tableName());
		select.append(" WHERE isDel = 0 AND type = ?");
		
		return  Db.find(select.toString(),type);
	}
	


	/**
	 * @author: C H
	 * @param i
	 * @return
	 * @throws
	 */
	public Record getPictureFindByType(int type) {
		// TODO Auto-generated method stub
		StringBuffer select = new StringBuffer();
		select.append(" select id,title,remark,content,createTime,isDel,concat('http://114.55.209.136:9090/suta/',pic) as pic,type,url,status,concat('http://114.55.209.136:9090/suta/',mtpic) as mtpic");
//		select.append("select id,title,remark,content,createTime,isDel,concat('http://192.168.1.66:8080/suta/',pic) as pic,type,url,status,concat('http://192.168.1.66:8080/suta/',mtpic) as mtpic");
		select.append(" from " + this.tableName());		
		select.append("where type=? limit 0,5");
		return Db.findFirst(select.toString(),type);
	}
	
	
}
 