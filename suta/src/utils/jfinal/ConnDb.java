package utils.jfinal;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.jfinal.kit.Prop;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.IPlugin;
import com.jfinal.plugin.activerecord.IDataSourceProvider;

public class ConnDb implements IPlugin, IDataSourceProvider {

	DataSource dataSource;

	boolean isStarted = false;

	String jdbcName = "jdbc/ZhangShangYunShan";

	@Override
	public boolean start() {
		Prop prop = PropKit.use("devMode.properties");
		if (prop != null && "true".equals(prop.get("debug"))) {
			jdbcName = "jdbc/ZhangShangYunShan";
		}
		if (isStarted) {
			return true;
		}
		// TODO Auto-generated method stub
		try {
			Context env = (Context) new InitialContext()
					.lookup("java:comp/env");
			dataSource = (DataSource) env.lookup(jdbcName);
			isStarted = true;
			return true;
		} catch (NamingException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean stop() {
		// TODO Auto-generated method stub
		dataSource = null;
		isStarted = false;
		return true;
	}

	@Override
	public DataSource getDataSource() {
		return dataSource;
	}

}
