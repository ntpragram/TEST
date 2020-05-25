
package utils.other;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.ParseException;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

/**
 * Http 请求
 * 
 * @Description
 * 
 * @author C H
 * @version 1.0
 * @since 2017年1月4日
 */
public class HttpUtils {

	/**
	 * 发送POST 请求
	 * 
	 * @author C H
	 * @since 2017年4月5日
	 * @param url
	 * @param param
	 * @return
	 */
	public static String sendPost(String url, Map<String, String> param) {
		return sendPost(url, param, null);
	}

	/**
	 * GET 请求
	 * 
	 * @author C H
	 * @since 2017年4月5日
	 * @param url
	 * @param param
	 * @return
	 */
	public static String sendGet(String url) {
		return sendGet(url, null);
	}

	/**
	 * GET 请求
	 * 
	 * @author C H
	 * @since 2017年4月5日
	 * @param url
	 * @param param
	 * @return
	 */
	public static String sendGet(String url, Map<String, String> param) {
		return sendGet(url, param, null);
	}

	/**
	 * 发送GET 请求
	 * 
	 * @author C H
	 * @since 2017年4月5日
	 * @param url
	 * @param param
	 *            自动拼接
	 * @param headers
	 * @return
	 */
	public static String sendGet(String url, Map<String, String> param,
			Map<String, String> headers) {
		CloseableHttpClient httpClient = HttpClients.createDefault();
		Set<String> key = null;
		if (param != null) {
			key = param.keySet();
		}
		HttpGet httpGet = new HttpGet(url);
		if (headers != null) {
			key = headers.keySet();
			for (String str : key) {
				httpGet.addHeader(str, headers.get(str));
			}
		}
		try {
			HttpResponse response = httpClient.execute(httpGet);
			return EntityUtils.toString(response.getEntity(), "utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "{\"code\":500,\"info\":\"请求失败\"}";
	}

	/**
	 * 发送POST 请求
	 * 
	 * @author C H
	 * @since 2017年4月5日
	 * @param url
	 * @param param
	 * @param headers
	 * @return
	 */
	public static String sendPost(String url, Map<String, String> param,
			Map<String, String> headers) {
		CloseableHttpClient httpClient = HttpClients.createDefault();
		Set<String> key = null;
		HttpPost httpPost = new HttpPost(url);
		if (headers != null) {
			key = headers.keySet();
			for (String str : key) {
				httpPost.addHeader(str, headers.get(str));
			}
		}
		List<NameValuePair> nvps = new ArrayList<NameValuePair>();
		if (param != null) {
			key = param.keySet();
			for (String string : key) {
				if (StringUtils.isNotBlank(param.get(string))) {
					nvps.add(new BasicNameValuePair(string, param.get(string)));
				}
			}
		}

		try {
			httpPost.setEntity(new UrlEncodedFormEntity(nvps, "utf-8"));
			HttpResponse response = httpClient.execute(httpPost);
			return EntityUtils.toString(response.getEntity(), "utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "{\"code\":500,\"info\":\"请求失败\"}";
	}
}
