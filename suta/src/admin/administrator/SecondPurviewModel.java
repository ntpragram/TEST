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
public class SecondPurviewModel extends BaseModel<SecondPurviewModel>{
	private static final long serialVersionUID = -211636534402983276L;

	public static final SecondPurviewModel dao = new SecondPurviewModel();

	@Override
	public boolean isReal() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public String tableName() {
		// TODO Auto-generated method stub
		return " t_qxsecond ";
	}

	@Override
	public String tableKey() {
		// TODO Auto-generated method stub
		return "sid";
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
	 * @since 2017年08月12日
	 * @return
	 */
	public List<Record> getTwoPurviewList(String fbh) {
		StringBuffer select = new StringBuffer();
		List<Object> list = new ArrayList<Object>();
		select.append(" select d.`sbh`,d.`sname` ");
		select.append(" from " + this.tableName() + " d ");
		select.append(" where d.isdel=0 and d.fbh = ? order by d.sid desc");
		list.add(fbh);
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
	public Record getFname(String bdhl) {
		StringBuffer select = new StringBuffer();
		select.append(" select sname,fbh,web ");
		select.append(" from " + this.tableName());
		select.append(" where sbh = ? ");
		return Db.findFirst(select.toString(), bdhl);
	}
}
