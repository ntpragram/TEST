
package utils.jfinal;

import java.util.List;
import java.util.Set;

import utils.auto.generator.Generator;

import com.jfinal.plugin.IPlugin;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

public class AutoPlugin implements IPlugin {

	@Override
	public boolean start() {
		// TODO Auto-generated method stub
		Set<String> modelName = ModelPlugin.models.keySet();
		BaseModel<?> model = null;
		List<Record> column = null;
		for (String string : modelName) {
			model = ModelPlugin.models.get(string);
			if (model == null) {
				continue;
			}
			column = Db
					.find("select column_name name, column_comment comment from information_schema.columns where table_name = ? and TABLE_SCHEMA='xiaheng'",
							model.tableName().trim());
			Generator.build.buildJspOfModify(string, column, model.tableKey());

		}
		return true;
	}

	@Override
	public boolean stop() {
		// TODO Auto-generated method stub
		return false;
	}

}
