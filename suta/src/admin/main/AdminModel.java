package admin.main;

import org.apache.commons.lang3.StringUtils;

import utils.jfinal.BaseModel;
import utils.other.CodeBean;
import utils.other.EncodeUtils;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

/**
 * 后台管理员表
 * 
 * @Description
 * 
 * @author C H
 * @version 1.0
 * @since 
 */
public class AdminModel extends BaseModel<AdminModel> {

	public static final AdminModel dao = new AdminModel();
	/**
	 * <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = -9211114245371927205L;

	@Override
	public String tableName() {
		return " t_admin ";
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
	@Override
	public Page<Record> getPaging(int page, int pageSize, JSONObject json) {
		StringBuffer select = new StringBuffer();
		select.append(" select admin.id,admin.userName,role.roleName ");
		StringBuffer from = new StringBuffer();
		from.append(" from " + this.tableName());
		from.append(" admin left join " + RoleModel.dao.tableName());
		from.append(" role on admin.userRole=role.roleId ");
		from.append(" where admin.isDel = 0 ");
		return Db.paginate(page, pageSize, select.toString(), from.toString());
	}

	@Override
	public Record showModel(String modelId, JSONObject where) {
		// TODO Auto-generated method stub
		Record record = super.showModel(modelId, where);
		record.set("list", RoleModel.dao.roleList());
		return record;
	}

	@Override
	public CodeBean<BaseModel<?>> modifyModel(JSONObject where) {
		String passWord = where.getString("passWord");
		if (StringUtils.isNotBlank(passWord)) {
			where.put("realPwd", passWord);
			where.put("passWord", EncodeUtils.MD5Encode(passWord));
		}
		if (isSave(where)) {
			String userName = where.getString("userName");
			if (adminInfo(userName) != null) {
				return new CodeBean<BaseModel<?>>(false, "用户名已被使用");
			}
		}
		return super.modifyModel(where);
	}

	/**
	 * 用户信息
	 * 
	 * @author C H
	 * @since 
	 * @param userName
	 * @return
	 */
	public Record adminInfo(String username) {
		StringBuffer select = new StringBuffer();
		select.append(" select admin.`id`,admin.`password`,admin.`username`,admin.`comId` ");
		select.append(" from " + this.tableName());
		select.append(" admin ");
		select.append(" where admin.username = ? and admin.isdel = '0' ");
		return Db.findFirst(select.toString(), username);
	}
	public Record adminInfoid(String id) {
		StringBuffer select = new StringBuffer();
		select.append(" select admin.`password`,admin.`username`,admin.`comId` ");
		select.append(" from " + this.tableName());
		select.append(" admin ");
		select.append(" where admin.id = ? and admin.isdel = '0' ");
		return Db.findFirst(select.toString(), id);
	}
	public boolean updateInfo(Record re) {
		return Db.update(this.tableName(), this.tableKey(), re);
	}

}
