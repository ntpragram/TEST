
package utils.jfinal;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import utils.other.ClassUtils;

import com.jfinal.plugin.IPlugin;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;

public class ModelPlugin implements IPlugin {

	private ActiveRecordPlugin arp = null;

	/**
	 * 扫描包的路径
	 */
	private String[] packagePath = {"admin","api","businessmenadmin"};

	public ModelPlugin(ActiveRecordPlugin arp) {
		this.arp = arp;
	}

	public ModelPlugin(ActiveRecordPlugin arp, String[] packagePath) {
		this.arp = arp;
		this.packagePath = packagePath;
	}

	public static final Logger logger = LoggerFactory
	.getLogger(ModelPlugin.class);

	/**
	 * 映射对象
	 */
	public static final Map<String, BaseModel<?>> models = new HashMap<String, BaseModel<?>>();

	@Override
	public boolean start() {
		for(int i = 0; i <packagePath.length; i++){
			List<Class<?>> clazzList = ClassUtils.getClasssFromPackage(packagePath[i]);
			List<Class<? extends BaseModel<?>>> modelList = ClassUtils
			.filterClassOfE(clazzList, BaseModel.class);
			String tableName, tableKey, modelName = null;
			BaseModel<?> model = null;
			char[] ch = null;
			try {
				for (Class<? extends BaseModel<?>> clazz : modelList) {
					if (BaseModel.class.isAssignableFrom(clazz)) {
						model = clazz.newInstance();
						if (!model.isEnable()) {
							continue;
						}
						tableName = model.tableName();
						if (tableName == null || "".equals(tableName.trim())) {
							System.out.println(clazz.getSimpleName() + "表名不可为空");
							continue;
						}
						tableKey = model.tableKey();
						if (StringUtils.isNotBlank(tableKey)) {
							arp.addMapping(tableName.trim(), tableKey, clazz);
						} else {
							arp.addMapping(tableName.trim(), "id", clazz);
						}
						modelName = clazz.getSimpleName().replace("Model", "");
						ch = modelName.toCharArray();
						if (ch[0] >= 'A' && ch[0] <= 'Z') {
							ch[0] -= 'A' - 'a';
						}
						models.put(new String(ch), model);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return true;
	}

	@Override
	public boolean stop() {
		return false;
	}

}
