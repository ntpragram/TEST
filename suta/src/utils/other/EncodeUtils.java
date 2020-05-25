package utils.other;

import java.security.MessageDigest;

import utils.jfinal.JFinalConst.CharsetName;
import utils.jfinal.JFinalConst.SignType;

/**
 * MD5加密
 * 
 * @Description
 * 
 * @author Don Cui
 * @version 1.0
 * @since 2016年6月29日
 */
public class EncodeUtils {// encode

	private final static String[] strDigits = { "0", "1", "2", "3", "4", "5",
			"6", "7", "8", "9", "a", "b", "c", "d", "e", "f" };

	public static void main(String[] args) {
		System.out.println(MD5Encode("14e1b600b1fd579f47433b88e8d85291"));
	}
	
	/**
	 * 对字符串进行MD5加密
	 * 
	 * @author Don Cui
	 * @since 2016年6月29日
	 * @param str
	 * @return 返回加密的字符串
	 */
	public static String MD5Encode(String str) {
		return MD5Encode(str, CharsetName.UTF_8);
	}

	/**
	 * 对字符串进行MD5加密
	 * 
	 * @author Don Cui
	 * @since 2016年6月29日
	 * @param str
	 *            需要转换的字符串
	 * @param charsetName
	 *            编码格式
	 * @return 返回加密字符串
	 */
	public static String MD5Encode(String str, CharsetName charset) {
		return Encode(str, charset, SignType.MD5);
	}

	/**
	 * SHA-1 加密
	 * 
	 * @author Don Cui
	 * @since 2016年7月8日
	 * @param str
	 * @return
	 */
	public static String SHAEncode(String str) {
		return SHAEncode(str, CharsetName.UTF_8);
	}

	/**
	 * SHA-1 加密
	 * 
	 * @author Don Cui
	 * @since 2016年7月8日
	 * @param str
	 * @param charset
	 * @return
	 */
	public static String SHAEncode(String str, CharsetName charset) {
		return Encode(str, charset, SignType.SHA_1);
	}

	/**
	 * 加密方法
	 * 
	 * @author Don Cui
	 * @since 2016年7月8日
	 * @param str
	 *            需要加密的字符串
	 * @param charset
	 *            默认UTF-8
	 * @param sign
	 *            默认MD5
	 * @return
	 */
	public static String Encode(String str, CharsetName charset, SignType sign) {
		String resultString = null;
		if (charset == null) {
			charset = CharsetName.UTF_8;
		}
		String charsetName = charset.getCharsetValue();

		if (sign == null) {
			sign = SignType.MD5;
		}
		String signType = sign.getSignValue();

		try {
			resultString = new String(str);
			MessageDigest md = MessageDigest.getInstance(signType);
			if (charsetName == null || "".equals(charsetName)) {
				resultString = byteArrayToHexString(md.digest(resultString
						.getBytes()));
			} else {
				resultString = byteArrayToHexString(md.digest(resultString
						.getBytes(charsetName)));
			}
		} catch (Exception exception) {
		}
		return resultString;

	}

	/**
	 * 将数组转换为16进制
	 * 
	 * @author Don Cui
	 * @since 2016年6月29日
	 * @param b
	 * @return
	 */
	private static String byteArrayToHexString(byte b[]) {
		StringBuffer resultSb = new StringBuffer();
		for (int i = 0; i < b.length; i++)
			resultSb.append(byteToHexString(b[i]));
		return resultSb.toString();
	}

	/**
	 * 转换成16进制
	 * 
	 * @author Don Cui
	 * @since 2016年6月29日
	 * @param b
	 * @return
	 */
	private static String byteToHexString(byte b) {
		int n = b;
		if (n < 0)
			n += 256;
		int d1 = n / 16;
		int d2 = n % 16;
		return strDigits[d1] + strDigits[d2];
	}

}