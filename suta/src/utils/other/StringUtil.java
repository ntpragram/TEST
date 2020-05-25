
package utils.other;

import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

public class StringUtil {

	/**
	 * 获取随机字符串
	 * 
	 * @param num
	 * @return
	 */
	public static String getRandomUnique(int num) {
		String region = "123456789abcdefghijkmnpqrstuvwxyzABCDEFGHIJKLMNPQRSTUVWXYZ";
		String result = "";
		Random r1 = new Random();
		int len = 0;
		while (len++ < num) {
			result += region.toCharArray()[r1.nextInt(region.length())];
		}
		return result;
	}

	/**
	 * 是否是数字
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isNumeric(String str) {
		Pattern pattern = Pattern.compile("[0-9]*");
		Matcher isNum = pattern.matcher(str);
		if (!isNum.matches()) {
			return false;
		}
		return true;
	}

	/**
	 * 判断是不是空
	 * 
	 * @author C H
	 * @since 2016年12月17日
	 * @param obj
	 * @return
	 */
	public static boolean isNull(Object obj) {
		if (obj == null || "".equals(obj.toString().trim())) {
			return true;
		}
		return false;
	}

	/**
	 * 获取服务器IP地址
	 * 
	 * @author C H
	 * @since 2017年2月6日
	 * @param request
	 * @return
	 */
	public static String getIPAddress(HttpServletRequest request) {
		String path = request.getContextPath();
		String basePath = request.getScheme() + "://" + request.getServerName()
				+ ":" + request.getServerPort() + path + "/";
		return basePath;
	}

	/**
	 * 获取用户请求的真实IP地址
	 * 
	 * @author C H
	 * @since 2017年5月22日
	 * @param request
	 * @return
	 */
	public static String getIpAddress(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}

}
