/**
 * 
 */
package admin.administrator;
import utils.jfinal.BaseModel;
import utils.commonUtil.StrManager;

import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.Page;
import com.alibaba.fastjson.JSONObject;

import java.util.ArrayList;
import java.util.List;

import utils.other.EncodeUtils;

import com.jfinal.plugin.activerecord.Db;

import org.apache.commons.lang3.StringUtils;
/**
 * @author: C H
 */
public class AdministratorModel extends BaseModel<AdministratorModel>{
	private static final long serialVersionUID = -2168268737150466534L;
	public static AdministratorModel dao = new AdministratorModel();
	StrManager str = new StrManager();
	@Override
	public String tableName() {
		// TODO Auto-generated method stub
		return "t_admin";
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
	public Page<Record> getPaging(int page, int pageSize, JSONObject where) {

		StringBuffer select = new StringBuffer();
		select.append(" select `id`,`username`,`updatetime` ");
		StringBuffer from = new StringBuffer();
		from.append(" from " + this.tableName());		
		from.append(" where `isdel`=0 and `atype`=? ");
		from.append(" order by px asc , id desc");
		List<Object> list = new ArrayList<Object>();
		list.add(where.getString("atype"));
		return paginate(page, pageSize, select, from,list);
	}
	public boolean addAdmin(JSONObject value){
		AdministratorModel model = new AdministratorModel();
		model.set("username", value.getString("username"));
		model.set("password", EncodeUtils.MD5Encode(value.getString("password")));
		model.set("comId", value.getString("company"));
		return model.saveModel();
	}
	public boolean delAll(String ids){
		StringBuffer update = new StringBuffer();
		update.append("update "+this.tableName());
		update.append(" set isdel=1");
		update.append(" where "+this.tableKey());
		update.append(" in ("+ids+")");
		success = Db.update(update.toString()) > 0;
		return success;
	}
	public Record getAdmin(String id){
		StringBuffer select = new StringBuffer();
		select.append(" select `username`,`comId` ");
		StringBuffer from = new StringBuffer();
		from.append(" from " + this.tableName());		
		from.append(" where "+this.tableKey()+"=? ");
		Record record = Db.findFirst(select.toString()+from.toString(),id);
		return record;
	}
	public boolean modifyAdmin(JSONObject value){
		StringBuffer modify = new StringBuffer();
		
		String username = value.getString("username");
		String id = value.getString("id");
		String password = value.getString("password");
		String company = value.getString("company");
		modify.append("update "+this.tableName());
		if(StringUtils.isBlank(password)){
			modify.append(" set `username`=?");
			modify.append(" where `id`=?");
			success = Db.update(modify.toString(), username,id) > 0;
		}else{
			modify.append(" set `username`=? , password = ? ,comId=? ");
			modify.append(" where `id`=?");
			success = Db.update(modify.toString(), username,EncodeUtils.MD5Encode(password),company,id) > 0;
		}
		
		return success;
	}
	
	
	
	
	
	
}
