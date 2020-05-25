
package utils.jfinal;

import java.lang.reflect.Modifier;
import java.util.List;

import utils.annotation.RouteViewPath;
import utils.other.ClassUtils;

import com.jfinal.config.Routes;

/**
 * 路由插件
 * 
 * @Description
 * 
 * @author C H
 * @version 1.0
 * @since 2016年12月17日
 */
public class RoutePlugin extends Routes {
	/**
	 * 视图根路径
	 */
	private String basePath = null;

	/**
	 * 扫描包的路径
	 */
	private String[] packagePath = {"admin","businessmenadmin","api"};

	public RoutePlugin(String basePath, String[] packagePath) {
		this.basePath = basePath;
		this.packagePath = packagePath;
	}

	public RoutePlugin() {
	}

	public RoutePlugin(String basePath) {
		this.basePath = basePath;
	}

	public void RoutesConfig() throws InstantiationException,
			IllegalAccessException {
		for(int i = 0; i <packagePath.length; i++){
			List<Class<?>> clazzList = ClassUtils.getClasssFromPackage(packagePath[i]);
			List<Class<? extends BaseController>> controllers = ClassUtils
					.filterClass(clazzList, BaseController.class);
			String controllerKey = null, viewPath;
			RouteViewPath _route;
			BaseController base = null;
			if (basePath != null) {
				setBaseViewPath(basePath);
			}

			for (Class<? extends BaseController> clazz : controllers) {
				if (BaseController.class.isAssignableFrom(clazz)) {
					if (!Modifier.isAbstract(clazz.getModifiers())) {
						base = clazz.newInstance();
						controllerKey = base.route();
						if (controllerKey.endsWith("/")
								&& controllerKey.length() > 1) {
							controllerKey = controllerKey.substring(0,
									controllerKey.length() - 1);
						}

						viewPath = "/";
						if (clazz.getSuperclass().isAnnotationPresent(
								RouteViewPath.class)) {
							_route = clazz.getSuperclass().getAnnotation(
									RouteViewPath.class);
							viewPath = _route.value();
						}
						//System.out.println("controllerKey:"+controllerKey+",clazz:"+clazz+",viewPath:"+viewPath);
						add(controllerKey, clazz, viewPath);
					}
				}
			}
		}
		
	}

	@Override
	public void config() {
		try {
			RoutesConfig();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
