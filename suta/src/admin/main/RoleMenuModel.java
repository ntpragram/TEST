package admin.main;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;

import utils.jfinal.BaseModel;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

/**
 * 角色菜单关联表
 * 
 * @Description
 * 
 * @author C H
 * @version 1.0
 * @since 
 */
public class RoleMenuModel extends BaseModel<RoleMenuModel> {

	/**
	 * <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = -7496823324343383640L;

	public static final RoleMenuModel dao = new RoleMenuModel();

	@Override
	public String tableName() {
		// TODO Auto-generated method stub
		return " t_qxrolefirst ";
	}

	@Override
	public String tableKey() {
		// TODO Auto-generated method stub
		return "roleMenuId";
	}
	@Override
	public String fieldName() {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public Page<Record> getPaging(int page, int pageSize, JSONObject json) {
		// TODO Auto-generated method stub
		StringBuffer select = new StringBuffer();
		select.append(" select roleMenu.roleMenuId,menu.menuName,if(roleMenu.roleMenuId is null,'0','1') isGet ");
		select.append(" ,roleMenu.roleId,menu.menuId");
		StringBuffer from = new StringBuffer();
		List<Object> list = new ArrayList<Object>();
		from.append(" from " + RoleMenuModel.dao.tableName());
		from.append(" roleMenu right join " + MenuModel.dao.tableName());
		from.append(" menu on menu.menuId = roleMenu.menuId and roleMenu.roleId = ? ");
		list.add(json.getString("roleId"));
		from.append(" where menu.isDel ='0' ");
		if (StringUtils.isNotBlank(json.getString("isGet"))) {
			if ("1".equals(json.getString("isGet"))) {
				from.append(" and roleMenu.roleMenuId is not null ");
			} else {
				from.append(" and roleMenu.roleMenuId is null ");
			}
		}

		return paginate(page, pageSize, select, from, list);
	}

	/**
	 * 通过角色和菜单删除
	 * 
	 * @author C H
	 * @since 
	 * @param roleId
	 * @param menuId
	 * @return
	 */
	public boolean deleteByRoleAndMenu(String roleId, String menuId) {
		StringBuffer select = new StringBuffer();
		select.append(" delete from " + this.tableName());
		select.append(" where roleId = ? and menuId = ? ");
		return Db.update(select.toString(), roleId, menuId) > 0;
	}
}
