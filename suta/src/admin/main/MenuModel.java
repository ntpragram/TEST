package admin.main;

import java.util.List;

import utils.jfinal.BaseModel;
import admin.main.AdminModel;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

/**
 * 菜单表
 * 
 * @Description
 * 
 * @author C H
 * @version 1.0
 * @since 
 */
public class MenuModel extends BaseModel<MenuModel> {

	/**
	 * <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = -5365503140478458213L;

	public static final MenuModel dao = new MenuModel();

	@Override
	public String tableName() {
		return " t_qxrolefirst ";
	}

	@Override
	public String tableKey() {
		return "menuId";
	}

	@Override
	public boolean isReal() {
		return true;
	}
	@Override
	public String fieldName() {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public Page<Record> getPaging(int page, int pageSize, JSONObject json) {
		StringBuffer select = new StringBuffer();
		select.append(" select menu.menuId,menu.menuName,menu.menuUrl,pMenu.menuName pMenuName,menu.sort ");
		
		StringBuffer from = new StringBuffer();
		from.append(" from " + MenuModel.dao.tableName());
		from.append(" menu left join " + MenuModel.dao.tableName());
		from.append(" pMenu on menu.pMenuId = pMenu.menuId ");
		from.append(" where menu.isDel='0' ");
		return Db.paginate(page, pageSize, select.toString(), from.toString());
	}

	@Override
	public Record showModel(String modelId, JSONObject where) {
		Record menu = super.showModel(modelId, where);
		menu.set("list", getParentMenu());
		return menu;
	}

	/**
	 * 所有父级菜单
	 * 
	 * @author C H
	 * @since 
	 * @return
	 */
	public List<Record> getParentMenu() {
		return Db.find(" select menuId,menuName from "
				+ MenuModel.dao.tableName() + " where pMenuId='0' ");
	}

	/**
	 * 获取一级菜单列表
	 * 
	 * @author C H
	 * @since 
	 * @param role
	 * @return
	 */
	public List<Record> menuList(String id) {
		StringBuffer select = new StringBuffer();
		select.append(" select menu.fname,menu.fbh ");
		select.append(" from " + AdminModel.dao.tableName());
		select.append(" admin left join " + this.tableName());
		select.append(" menu on admin.id = menu.ygid ");
		select.append(" where admin.id = ? ");
		select.append(" order by menu.px ");
		return Db.find(select.toString(), id);
	}
	
	/**
	 * 获取二级菜单列表
	 * 
	 * @author C H
	 * @since 
	 * @param role
	 * @return
	 */
	public List<Record> menuSecList(String id) {
		StringBuffer select = new StringBuffer();
		select.append(" select secmenu.sbh,secmenu.sname,secmenu.sweb,secmenu.fbh ");
		select.append(" from " + AdminModel.dao.tableName());
		select.append(" admin left join t_qxrolesecond ");
		select.append(" secmenu on admin.id = secmenu.ygid ");
		select.append(" where admin.id = ? ");
		select.append(" order by secmenu.sbh ");
		return Db.find(select.toString(), id);
	}
}
