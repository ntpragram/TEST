
package utils.interceptor;

import java.lang.reflect.Method;

import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang3.StringUtils;

import utils.annotation.ValidateTOKEN;
import utils.other.CodeBean;
import utils.other.JSONCode;

import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Record;

import controller.BaseAPIController;

/**
 * 接口拦截器
 * 
 * @Description
 * 
 * @author C H
 * @version 1.0
 * @since 2017年1月3日
 */
public class ApiIntercptor implements Interceptor {

	@Override
	public void intercept(Invocation inv) {
		// TODO Auto-generated method stub
		HttpServletRequest request = inv.getController().getRequest();
		if (!request.getMethod().equalsIgnoreCase("POST_")) {
			inv.getController().getResponse()
					.setHeader("Access-Control-Allow-Origin", "*");
			inv.getController().getResponse()
					.setContentType("text/html; charset=utf-8");
			
			
			Class<? extends Controller> clazz = inv.getController().getClass();
			Method method = inv.getMethod();

			if (method.isAnnotationPresent(ValidateTOKEN.class)) {
				if (!method.getAnnotation(ValidateTOKEN.class).isValidate()) {
					inv.invoke();
					return;
				}
			}

			if (clazz.isAnnotationPresent(ValidateTOKEN.class)) {
				if (!clazz.getAnnotation(ValidateTOKEN.class).isValidate()) {
					inv.invoke();
					return;
				}
			}

			/*String token = inv.getController().getPara("token");
			if (StringUtils.isBlank(token)) {
				inv.getController()
						.renderJson(
								new CodeBean<Object>(JSONCode.非法请求.getCode(),
										"您还没有登录"));
				return;
			}
			Record member = MemberModel.dao.infoByMemberId(token);

			if (member == null) {
				inv.getController().renderJson(
						new CodeBean<Object>(JSONCode.非法请求.getCode(),
								"访问受限,用户不存在"));
				return;
			}
			member.remove("passWord");
			Class<?> baseClass = BaseAPIController.class;
			try {
				method = baseClass.getMethod("setToken", Record.class);
				method.setAccessible(true);
				method.invoke(inv.getController(), member);
			} catch (Exception e) {
				e.printStackTrace();
			}
			inv.invoke();
		} else {
			inv.getController().renderError(404);
		}
		inv.invoke();*/
	}
}}
