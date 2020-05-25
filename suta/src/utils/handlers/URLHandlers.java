package utils.handlers;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import utils.jfinal.JFinalConst;

import com.jfinal.handler.Handler;

public class URLHandlers extends Handler {

	@Override
	public void handle(String target, HttpServletRequest request,
			HttpServletResponse response, boolean[] isHandled) {
		String[] suffix = { ".html" };

		/**
		 * restful
		 */
		if (target.startsWith(JFinalConst.base_admin_page)) {
			if (target.startsWith(JFinalConst.restful_admin_page_path)) {
				String baseUrl = target.replace(
						JFinalConst.restful_admin_page_path, "");
				target = JFinalConst.restful_admin_page_path.substring(0,
						JFinalConst.restful_admin_page_path.length() - 1)
						+ StringUtils.join(baseUrl.split("/"), "-");
			}
		}else if (target.startsWith(JFinalConst.base_api_path)) {

		} else if (target.startsWith("/template/")) {

		} else if (target.startsWith(JFinalConst.base_front_page)
				&& !target.startsWith("/chat/") && !target.startsWith("/app/")) {
			boolean isHTML = false;
			for (String string : suffix) {
				if (target.endsWith(string)) {
					request.setAttribute("suffix", string);
					target = target.replaceAll(string, "");
					isHTML = true;
					continue;
				}
			}
			if (!isHTML) {
				request.setAttribute("suffix", ".html");
			}
		}
		next.handle(target, request, response, isHandled);
	}
}
