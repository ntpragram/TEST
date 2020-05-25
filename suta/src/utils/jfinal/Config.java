package utils.jfinal;

import javax.servlet.ServletContext;

import utils.handlers.URLHandlers;

import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.jfinal.config.Constants;
import com.jfinal.config.Handlers;
import com.jfinal.config.Interceptors;
import com.jfinal.config.JFinalConfig;
import com.jfinal.config.Plugins;
import com.jfinal.config.Routes;
import com.jfinal.core.JFinal;
import com.jfinal.ext.handler.UrlSkipHandler;
import com.jfinal.ext.interceptor.POST;
import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.druid.DruidPlugin;
import com.jfinal.render.ViewType;
import com.jfinal.server.undertow.UndertowServer;
import com.jfinal.template.Engine;
import live.autu.plugin.jfinal.swagger.config.SwaggerPlugin;
import live.autu.plugin.jfinal.swagger.model.SwaggerApiInfo;
import live.autu.plugin.jfinal.swagger.model.SwaggerDoc;




/**
 * 配置文件
 * 
 * @Description
 * 
 * @author C H
 * @version 1.0
 * @since 2016年12月17日
 */
public class Config extends JFinalConfig {

	
  /** 
    *配置全局变量
    */
    public static int pageSize = 20;
    public static String saveDirectory = ""; // 上传文件目录，默认为upload
    public static int maxPostSize = 1024 * 1024 * 1024; // 默认上传文件大小 1G
	 
	
	@Override
	public void configConstant(Constants me) {
		me.setDevMode(false);//开发模式常量值
		me.setEncoding("utf-8");
		me.setViewType(ViewType.JSP);
		me.setBaseUploadPath(PathKit.getWebRootPath() + "/file");
		me.setMaxPostSize(1024 * 1024 * 100);
		me.setError404View("/WEB-INF/page/admin/404.jsp");
		me.setError500View("/WEB-INF/page/admin/500.jsp");
		
		// JFinal3BeetlRenderFactory rf = new JFinal3BeetlRenderFactory();
		// rf.config();
		// me.setRenderFactory(rf);
	}

	@Override
	public void configRoute(Routes me) {
		me.add(new RoutePlugin("WEB-INF/page/"));
		//me.add("/swagger", SwaggerController.class);
	}

	@Override
	public void configPlugin(Plugins me) {
	/*	ConnDb con = new ConnDb();
		me.add(con);*/
		
		DruidPlugin dp = new DruidPlugin("jdbc:mysql://114.55.209.136:3306/sutawebsite?characterEncoding=UTF-8", "root", "suta123456","com.mysql.jdbc.Driver");
//		DruidPlugin dp = new DruidPlugin("jdbc:mysql://192.168.1.66:3306/sutawebsite?characterEncoding=UTF-8", "root", "123","com.mysql.jdbc.Driver");
		me.add(dp);
		ActiveRecordPlugin arp = new ActiveRecordPlugin(dp);
		me.add(new ModelPlugin(arp));
		me.add(arp);
		arp.setShowSql(false);//控制台是否打印sql语句
		/*me.add(new SwaggerPlugin(new SwaggerDoc().setBasePath("/").setHost("127.0.0.1").setSwagger("2.0")
				.setInfo(new SwaggerApiInfo("jfinal swagger demo", "1.0", "jfinal swagger", ""))));*/
		/*me.add(new SwaggerPlugin());
		 me.add(new SwaggerPlugin(new SwaggerDoc().setBasePath("/").setHost("127.0.0.1").setSwagger("2.0")
	                .setInfo(new SwaggerApiInfo("jfinal swagger demo", "1.0", "jfinal swagger", ""))));*/
		//me.add(new SpringPlugin("com.ch.demo"));
		/*//缓存产品列表
		RedisPlugin productRedis = new RedisPlugin("productList", "localhost");
	    me.add(productRedis);
	 
	    // 用于缓存news模块的redis服务
	    RedisPlugin newsRedis = new RedisPlugin("news", "localhost");
	    me.add(newsRedis);*/
		// me.add(new AutoPlugin());

	}

	@Override
	public void configInterceptor(Interceptors me) {
		//me.add(new POST());
		//me.add(new IocInterceptor());
		//me.add(new SpringInterceptor());
	}

	@Override
	public void configHandler(Handlers me) {
		 me.add(new UrlSkipHandler("/api/UserPic",false));  
		 me.add(new URLHandlers());
	}

	@Override
	public void afterJFinalStart() {
		ServletContext context = JFinal.me().getServletContext();
		context.setAttribute("sysUrl", JFinal.me().getContextPath()
				+ JFinalConst.base_admin_page);// 后台路径
		context.setAttribute("sysMerchantUrl", JFinal.me().getContextPath()
				+ JFinalConst.base_merchantAdmin_page);// 商家后台路径
		context.setAttribute("frontUrl", JFinal.me().getContextPath()
				+ JFinalConst.base_front_page);
		
		context.setAttribute("swaggerUrl", JFinal.me().getContextPath()
				+ JFinalConst.swagger_url);
		
		
		super.afterJFinalStart();
	}

	@Override
	public void configEngine(Engine me) {

	}

}
