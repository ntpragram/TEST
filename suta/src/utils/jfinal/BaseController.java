package utils.jfinal;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import utils.beetl.BeetlRender;
import utils.other.JSONCode;
import utils.other.SqlInjection;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Record;

public abstract class BaseController extends Controller {

	// private final Logger logger =
	// LoggerFactory.getLogger(BaseController.class);

	/**
	 * 路由
	 * 
	 * @return
	 */
	public abstract String route();

	protected boolean success = false;

	protected SqlInjection sqlInjection = new SqlInjection();

	protected boolean isPost() {
		return "POST".equalsIgnoreCase(getRequest().getMethod().toUpperCase());
	}
	
	/**
	 * 将参数封到JSONObject 内
	 * 
	 * @author C H
	 * @since 2017年2月15日
	 * @return
	 */
	protected JSONObject getAllParaName() {
		Enumeration<String> names = getParaNames();
		JSONObject param = new JSONObject();
		while (names.hasMoreElements()) {
			String string = (String) names.nextElement();
			param.put(string, getPara(string));
		}
		return param;
	}

	/**
	 * 判断参数是否为空
	 * 
	 * @param name
	 * @return
	 */
	protected boolean checkPara(String... name) {
		for (String string : name) {
			String value = getPara(string);
			if (StringUtils.isBlank(value)) {
				renderJSON(JSONCode.参数不全, "网络异常");
				return false;
			}
		}
		return true;
	}
	
	/**
	 * 检测参数值是否有sql注入
	 * 
	 * @param name
	 * @return
	 */
	protected boolean checkParasqlInjection(String... name) {
		for (String string : name) {
			String value = getPara(string);
			if (!"content".equals(string) && sqlInjection.sqlInjection(value)) {
				renderJSON(JSONCode.非法请求, "非法操作");
				return false;
			}
		}
		return true;
	}

	/**
	 * 检测参数值是否为空,是否有sql注入
	 * 
	 * @param name
	 * @return
	 */
	protected boolean checkParaInjection(String... name) {
		for (String string : name) {
			String value = getPara(string);
			if (StringUtils.isBlank(value)) {
				renderJSON(JSONCode.参数不全, "参数不全");
				return false;
			}
			if (!"content".equals(string) && sqlInjection.sqlInjection(value)) {
				renderJSON(JSONCode.非法请求, "非法操作");
				return false;
			}
		}
		return true;
	}

	/**
	 * 返回beetl 视图
	 * 
	 * @author C H
	 * @since 2017年5月22日
	 * @param view
	 */
	protected void renderBeetl(String view) {
		render(BeetlRender.bee.getRender(view));
	}

	/**
	 * 检查注入
	 * 
	 * @author C H
	 * @since 2017年1月6日
	 * @param name
	 * @return
	 */
	protected boolean checkInjection(String... name) {
		for (String string : name) {
			String value = getPara(string);
			if (StringUtils.isBlank(value)) {
				continue;
			}
			if (sqlInjection.sqlInjection(value)) {
				renderJSON(JSONCode.非法请求, "非法操作");
				return false;
			}
		}
		return true;
	}

	protected void renderJSON(JSONCode code, String message) {
		renderJSON(code, message, null);
	}

	protected void renderJSON(boolean success) {
		if (success) {
			renderJSON(JSONCode.请求通过, "操作成功", null);
		} else {
			renderJSON(JSONCode.请求出错, "操作失败", null);
		}
	}

	protected void renderJSON(boolean success, String message) {
		if (success) {
			renderJSON(JSONCode.请求通过, message, null);
		} else {
			renderJSON(JSONCode.请求出错, message, null);
		}
	}

	/**
	 * 返回JSON
	 * 
	 * @author C H
	 * @since 2016年12月17日
	 * @param code
	 * @param message
	 * @param data
	 */
	protected void renderJSON(JSONCode code, String message, Object data) {
		Map<String, Object> json = new HashMap<String, Object>();
		json.put("code", code.getCode());
		if (!StringUtils.isBlank(message))
			json.put("message", message);
		json.put("data", data == null ? new Record() : data);
		// System.out.println(JsonKit.toJson(json));
		// logger.info("返回数据:{0}", JsonKit.toJson(json));
		renderJSON(json);
	}
	
	/**
	 * 返回JSON
	 * 
	 * @author C H
	 * @since 2016年12月17日
	 * @param code
	 * @param message
	 * @param data
	 */
	protected Map<String, Object> renderJSON2(JSONCode code, String message, Object data) {
		Map<String, Object> json = new HashMap<String, Object>();
		json.put("code", code.getCode());
		if (!StringUtils.isBlank(message))
			json.put("message", message);
		json.put("data", data == null ? new Record() : data);
		// System.out.println(JsonKit.toJson(json));
		// logger.info("返回数据:{0}", JsonKit.toJson(json));
//		renderJSON(json);
		return json;
	}
/**
 * 
 * 
 *{code:200,success:code==200,message:'123',data:{}}
 * @param json
 */
	private void renderJSON(Map<String, Object> json) {
		Integer code = (Integer) json.get("code");
		if (code != null) {
			if (200 == code) {
				json.put("success", true);
			} else {
				json.put("success", false);
			}
		}
		renderJson(json);
	}
}
