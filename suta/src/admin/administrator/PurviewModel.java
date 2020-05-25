/**
 * 
 */
package admin.administrator;
import java.util.ArrayList;
import java.util.List;

import utils.jfinal.BaseModel;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;


/**
 * @author: C H
 */
public class PurviewModel extends BaseModel<PurviewModel> {

	/**
	 * <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = -211636534402983276L;

	public static final PurviewModel dao = new PurviewModel();

	@Override
	public boolean isReal() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public String tableName() {
		// TODO Auto-generated method stub
		return " t_qxfirst ";
	}

	@Override
	public String tableKey() {
		// TODO Auto-generated method stub
		return "fid";
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
	public List<Record> getPurviewList() {
		StringBuffer select = new StringBuffer();
		List<Object> list = new ArrayList<Object>();
		select.append(" select `fbh`,`fname` ");
		select.append(" from " + this.tableName() +" where isdel=0");
		return Db.find(select.toString(),list.toArray(new Object[list.size()]));
	}

	/**
	 * 获取栏目名称
	 * 
	 * @author C H
	 * @since 2017年8月14日
	 * @param 
	 * @return
	 */
	public Record getFname(String fbh) {
		StringBuffer select = new StringBuffer();
		select.append(" select fname,px ");
		select.append(" from " + this.tableName());
		select.append(" where fbh = ? ");
		return Db.findFirst(select.toString(), fbh);
	}
}
