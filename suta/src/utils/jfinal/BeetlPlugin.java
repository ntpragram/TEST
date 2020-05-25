
package utils.jfinal;

import java.io.IOException;

import org.beetl.core.Configuration;
import org.beetl.core.GroupTemplate;
import org.beetl.core.resource.WebAppResourceLoader;

import utils.beetl.BeetlRender;

import com.jfinal.kit.PathKit;
import com.jfinal.plugin.IPlugin;

/**
 * beetl 模板插件
 * 
 * @Description
 * 
 * @author C H
 * @version 1.0
 * @since 2017年5月22日
 */
public class BeetlPlugin implements IPlugin {

	public GroupTemplate groupTemplate;

	@Override
	public boolean start() {
		// TODO Auto-generated method stub
		String root = PathKit.getWebRootPath();
		WebAppResourceLoader resourceLoader = new WebAppResourceLoader(root);
		Configuration cfg;
		if (groupTemplate != null)
			groupTemplate.close();
		try {
			cfg = Configuration.defaultConfiguration();
			groupTemplate = new GroupTemplate(resourceLoader, cfg);
			BeetlRender.bee.setGroupTemplate(groupTemplate);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			throw new RuntimeException("\u52A0\u8F7DGroupTemplate\u5931\u8D25",
					e);
		}
		return true;
	}

	@Override
	public boolean stop() {
		// TODO Auto-generated method stub
		return false;
	}

}
