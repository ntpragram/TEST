package utils.interceptor;

import utils.jfinal.JFinalConst;

import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.jfinal.plugin.activerecord.Record;

/**
 * 后台登陆拦截器
 * 
 * @Description
 * 
 * @author C H
 * @version 1.0
 * @since 2016年12月20日
 */
public class AdminInterceptor implements Interceptor {

	@Override
	public void intercept(Invocation inv) {
		Record recod = (Record) inv.getController().getSessionAttr(
				JFinalConst.admin);
		if (recod == null) {
			inv.getController().redirect("/admin/login");
			return;
		}
		inv.invoke();
		
	}

}
