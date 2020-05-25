/**
 * 
 */
package admin.administrator;
import utils.jfinal.BaseModel;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
/**
 * @author: C H
 */
public class UserPurviewModel extends BaseModel<UserPurviewModel> {

	/**
	 * <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = -211636534402983276L;

	public static final UserPurviewModel dao = new UserPurviewModel();

	@Override
	public boolean isReal() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public String tableName() {
		// TODO Auto-generated method stub
		return " t_qxrolefirst ";
	}

	@Override
	public String tableKey() {
		// TODO Auto-generated method stub
		return "id";
	}
	@Override
	public String fieldName() {
		// TODO Auto-generated method stub
		return null;
	}
	/**
	 * 获取一级栏目
	 * 
	 * @author C H
	 * @since 2017年08月12日
	 * @return
	 */
	public Record getUserPurview(String fbh,String ygid){
		StringBuffer select = new StringBuffer();
		select.append(" select isNull(id) pitchOn ");
		StringBuffer from = new StringBuffer();
		from.append(" from " + this.tableName());		
		from.append(" where fbh = ? and ygid = ? ");
		Record record = Db.findFirst(select.toString()+from.toString(),fbh,ygid);
		return record;
	}
	
	
	/**
	 * 清空原有数据
	 * 
	 * @author C H
	 * @since 2017年08月14日
	 * @param 
	 * @return
	 */
	
	public boolean delAll(String ygid){
		StringBuffer delete = new StringBuffer();
		delete.append("delete from "+this.tableName());
		delete.append(" where ygid = ? ");
		success = Db.update(delete.toString(),ygid) > 0;
		return success;
	}
	
	/**
	 * 添加数据
	 * 
	 * @author C H
	 * @since 2017年08月14日
	 * @return
	 */
	public boolean addQxrolefirst(String fname,String px,String ygid,String fbh) {
		UserPurviewModel model = new UserPurviewModel();
		model.set("ygid", ygid);
		model.set("fbh", fbh);
		model.set("px", px);
		model.set("fname", fname);
		success = model.saveModel();
		return success;
	}
}
