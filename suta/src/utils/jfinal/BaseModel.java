
package utils.jfinal;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.lang3.StringUtils;

import utils.other.CodeBean;
import utils.other.SqlInjection;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.Table;
import com.jfinal.plugin.activerecord.TableMapping;

public abstract class BaseModel<M extends Model<?>> extends Model<BaseModel<M>> {

	/**
	 * model 的列表库
	 */
	public static final Map<String, String[]> modelColumns = new HashMap<String, String[]>();

	/**
	 * 是否成功
	 */
	protected boolean success = false;

	/**
	 * 防注入
	 */
	protected SqlInjection sqlInjection = new SqlInjection();

	/**
	 * <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = 2001238148990294937L;

	/**
	 * 是否启用
	 * 
	 * @author C H
	 * @since 2017年5月22日
	 * @return
	 */
	protected boolean isEnable() {
		return true;
	}

	/**
	 * 数据库表名
	 * 
	 * @author C H
	 * @since 2016年12月17日
	 * @return
	 */
	public abstract String tableName();

	/**
	 * 数据表主键
	 * 
	 * @author C H
	 * @since 2016年12月19日
	 * @return
	 */
	public abstract String tableKey();
	
	/**
	 * 数据表字段
	 * 
	 * @author C H
	 * @since 2016年12月19日
	 * @return
	 */
	public abstract String fieldName();

	/**
	 * true(真删除 ) false(假删除-默认)
	 * 
	 * @author C H
	 * @since 2016年12月26日
	 * @return
	 */
	public boolean isReal() {
		return false;
	}

	/**
	 * 视图('admin/'+view+'.jsp')
	 * 
	 * @author C H
	 * @since 2017年2月15日
	 * @return
	 */
	public String view(String modelName, JSONObject param) {
		if (param.getBooleanValue("viewList")) {
			return modelName + "/index";
		} else if (param.getBooleanValue("view")) {
			return modelName + "/modify";
		} else {
			return modelName + "/index";
		}
	}

	/**
	 * 获取所有的字段
	 * 
	 * @author C H
	 * @since 2016年12月20日
	 * @param model
	 * @return
	 */
	public String[] getColumns() {
		String[] columns = null;
		if (modelColumns.get(this.tableName()) != null) {
			return modelColumns.get(this.tableName());
		}

		List<String> column = new ArrayList<String>();
		Table table = TableMapping.me().getTable(this.getClass());
		for (String col : table.getColumnTypeMap().keySet()) {
			column.add("`" + col + "`");
		}
		if (column == null || column.size() <= 0) {
			return null;
		}
		columns = column.toArray(new String[column.size()]);
		modelColumns.put(this.tableName(), columns);
		return columns;
	}

	/**
	 * 分页
	 * 
	 * @author C H
	 * @since 2017年1月3日
	 * @param page
	 * @param pageSize
	 * @param select
	 * @param from
	 * @return
	 */
	public Page<Record> paginate(int page, int pageSize, StringBuffer select,
			StringBuffer from) {
		// TODO Auto-generated method stub
		return paginate(page, pageSize, select, from, null);
	}

	/**
	 * 分页
	 * 
	 * @author C H
	 * @since 2017年1月3日
	 * @param page
	 * @param pageSize
	 * @param select
	 * @param from
	 * @param list
	 * @return
	 */
	public Page<Record> paginate(int page, int pageSize, StringBuffer select,
			StringBuffer from, List<Object> list) {
		// TODO Auto-generated method stub
		if (list == null || list.size() <= 0) {
			return Db.paginate(page, pageSize, select.toString(),
					from.toString());
		}
		return Db.paginate(page, pageSize, select.toString(), from.toString(),
				list.toArray(new Object[list.size()]));
	}

	/**
	 * 自动分页
	 * 
	 * @author C H
	 * @since 2017年1月7日
	 * @param page
	 * @param pageSize
	 * @return
	 */
	public Page<Record> getPaging(int page, int pageSize) {
		return getPaging(page, pageSize, new JSONObject());
	}

	/**
	 * 自动分页
	 * 
	 * @author C H
	 * @since 2016年12月20日
	 * @param model
	 * @param page
	 * @param pageSize
	 * @param where
	 * @return
	 */
	public Page<Record> getPaging(int page, int pageSize, JSONObject where) {
		StringBuffer select = new StringBuffer();
		StringBuffer from = new StringBuffer();
		select.append(" select ");
		String[] column = getColumns();
		if (column != null) {
			select.append(StringUtils.join(getColumns(), ","));
		} else {
			select.append(" * ");
		}
		from.append(" from  " + this.tableName()
				+ " where isDel='0' order by addTime desc");
		return Db.paginate(page, pageSize, select.toString(), from.toString());
	}

	/**
	 * 获取主键
	 * 
	 * @author C H
	 * @since 2016年12月20日
	 * @return
	 */
	public String getUUID() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}

	/**
	 * 查询
	 * 
	 * @author C H
	 * @since 2016年12月17日
	 * @param modelName
	 * @param modelId
	 * @param where
	 * @return
	 */
	public Record showModel(String modelId, JSONObject where) {
		if (StringUtils.isBlank(modelId)) {
			return new Record();
		}
		StringBuffer select = new StringBuffer();
		select.append(" select ");
		String[] column = getColumns();
		if (column != null) {
			select.append(StringUtils.join(getColumns(), ","));
		} else {
			select.append(" * ");
		}
		select.append(" from  " + this.tableName());
		select.append(" where " + this.tableKey());
		select.append(" = ? ");
		return Db.findFirst(select.toString(), modelId);
	}

	/**
	 * 通用保存
	 * 
	 * @author C H
	 * @since 2016年12月20日
	 * @param model
	 * @return
	 */
	public boolean saveModel() {
		return super.save();
	}

	/**
	 * 通用更新
	 * 
	 * @author C H
	 * @since 2016年12月20日
	 * @param model
	 * @return
	 */
	public boolean updateModel() {
		return super.update();
	}

	/**
	 * 是不是save方法
	 * 
	 * @author C H
	 * @since 2016年12月23日
	 * @param model
	 * @return
	 */
	public boolean isSave() {
		return StringUtils.isBlank(this.getStr(this.tableKey().trim()));
	}

	/**
	 * 是不是saveg方法
	 * 
	 * @author C H
	 * @since 2017年2月15日
	 * @param where
	 * @return
	 */
	public boolean isSave(JSONObject where) {
		return StringUtils.isBlank(where.getString(this.tableKey()));
	}

	/**
	 * 修改
	 * 
	 * @author C H
	 * @since 2016年12月17日
	 * @param model
	 * @param where
	 * @return
	 */
	public CodeBean<BaseModel<?>> modifyModel(JSONObject where) {
		Table table = TableMapping.me().getTable(this.getClass());
		for (String columnLabel : where.keySet()) {
			if (table.hasColumnLabel(columnLabel)) {// 有没有找到这一列
				this.set(columnLabel, where.get(columnLabel));
			}
		}
		return new CodeBean<BaseModel<?>>(isSave() ? this.saveModel()
				: this.updateModel(), "操作成功", this);
	}

	/**
	 * 删除
	 * 
	 * @author C H
	 * @since 2016年12月17日
	 * @param ids
	 *            逗号拼接的主键Id
	 * @return
	 */
	public CodeBean<Object> deleteModel(String ids) {
		return deleteModelByAttr(tableKey(), ids, null);
	}

	/**
	 * 
	 * 
	 * @author C H
	 * @since 2017年2月5日
	 * @param ids
	 *            逗号拼接的主键Id
	 * @param isReal
	 *            指定删除方式（未指定将采用该model配置的删除方式，配置方法:重新isReal方法。默认假删除）
	 * @return
	 */
	public CodeBean<Object> deleteModel(String ids, boolean isReal) {
		return deleteModelByAttr(tableKey(), ids, isReal);
	}

	/**
	 * 根据属性删除数据表
	 * 
	 * @author C H
	 * @since 2017年1月5日
	 * @param attr
	 * @param isVals
	 * @return
	 */
	public CodeBean<Object> deleteModelByAttr(String attr, String isVals,
			Boolean isReal) {
		if (sqlInjection.sqlInjection(isVals)) {// 注入检查
			return new CodeBean<Object>(false, "发现参数注入");
		}
		Table table = TableMapping.me().getTable(this.getClass());
		if (!table.hasColumnLabel(attr)) {
			return new CodeBean<Object>(false, "属性未找到");
		}
		List<Object> list = new ArrayList<Object>();
		String[] delIds = isVals.split(",");
		StringBuffer fromIn = new StringBuffer();
		for (int i = 0; i < delIds.length; i++) {
			if (i > 0) {
				fromIn.append(",");
			}
			fromIn.append("?");
//			System.out.println("delIds[i]:"+delIds[i]);
			list.add(delIds[i]);
		}

		if (isReal == null ? this.isReal() : isReal) {// 如果指定为空 采用配置确定真假删除
														// 否则采用指定方式
			success = Db.update("delete from" + this.tableName() + " where "
					+ attr + " in (" + fromIn.toString() + ")",
					list.toArray(new Object[list.size()])) > 0;
		} else {
			success = Db.update(
					"update " + this.tableName() + " set isdel='1' where "
							+ attr + " in (" + fromIn.toString()
							+ ") and isdel='0' ",
					list.toArray(new Object[list.size()])) > 0;
		}
		return new CodeBean<Object>(success, "删除成功");
	}



}
