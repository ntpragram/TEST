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
public class UserSecondPurviewModel extends BaseModel<UserSecondPurviewModel>{
	private static final long serialVersionUID = -211636534402983276L;

	public static final UserSecondPurviewModel dao = new UserSecondPurviewModel();

	@Override
	public boolean isReal() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public String tableName() {
		// TODO Auto-generated method stub
		return " t_qxrolesecond ";
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
	 * 获取二级栏目
	 * 
	 * @author C H
	 * @since 
	 * @return
	 */
	public Record getUserTwoPurview(String sbh,String ygid){
		StringBuffer select = new StringBuffer();
		select.append(" select isNull(id) ");
		StringBuffer from = new StringBuffer();
		from.append(" from " + this.tableName());		
		from.append(" where sbh = ? and ygid = ? ");
		Record record = Db.findFirst(select.toString()+from.toString(),sbh,ygid);
		return record;
	}
	
	/**
	 * 清空原有数据
	 * 
	 * @author C H
	 * @since 
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
	 * @since 
	 * @return
	 */
	public boolean addqxrolesecond(String sbh,String sname,String fbh,String web,String ygid) {
		UserSecondPurviewModel model = new UserSecondPurviewModel();
		model.set("ygid", ygid);
		model.set("sbh", sbh);
		model.set("fbh", fbh);
		model.set("sname", sname);
		model.set("sweb", web);
		success = model.saveModel();
		return success;
	}
}
