package admin.main;

import java.util.List;

import utils.jfinal.BaseModel;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

/**
 * 角色表
 * 
 * @Description
 * 
 * @author C H
 * @version 1.0
 * @since 
 */
public class RoleModel extends BaseModel<RoleModel> {

	/**
	 * <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = -7547182632995047224L;

	public static final RoleModel dao = new RoleModel();

	@Override
	public String tableName() {
		return " t_qxrolefirst ";
	}

	@Override
	public String tableKey() {
		return "roleId";
	}
	@Override
	public String fieldName() {
		// TODO Auto-generated method stub
		return null;
	}
	public List<Record> roleList() {
		StringBuffer select = new StringBuffer();
		select.append(" select roleId id,roleName name ");
		select.append(" from " + this.tableName());
		select.append(" where isDel = '0' ");
		return Db.find(select.toString());
	}
}
