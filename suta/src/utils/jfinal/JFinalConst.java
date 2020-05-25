
package utils.jfinal;

public class JFinalConst {

	/**
	 * 网址
	 */
	public static final String WEB_URL = "http://192.168.2.168/commonJfinal/";

	/**
	 * 后台restful 路径
	 */
	public static final String restful_admin_page_path = "/admin/page/:";

	/**
	 * 自动登录的名字
	 */
	public static final String auto_userName = "auto_userName";

	/**
	 * 网易云信ID
	 */
	public static final String accId = "uid";

	/**
	 * 网易云信TOKEN
	 */
	public static final String netease_TOKEN = "sdktoken";

	/**
	 * admin 用户
	 */
	public static final String admin = "admin";
	
	/**
	 * 酒店商家admin 用户
	 */
	public static final String grogshopMerchantAdmin = "grogshopMerchantAdmin";
	
	/**
	 * 积分商城admin 用户
	 */
	public static final String integralShopAdmin = "integralShopAdmin";
	
	/**
	 * 酒店用品admin 用户
	 */
	public static final String grogshopProductAdmin = "grogshopProductAdmin";

	/**
	 * 入驻商家admin 用户
	 */
	public static final String businessmenadmin = "businessmenadmin";
	
	/**
	 * 入驻商家personaladmin 用户
	 */
	public static final String personaladmin = "personaladmin";
	
	/**
	 * 前台用户 member
	 */
	public static final String member = "member";
	
	/**
	 * PC用户 member
	 */
	public static final String pcmember = "pcmember";

	/**
	 * 前台用户memberId
	 */
	public static final String member_id = "memberId";

	/**
	 * 后台路径
	 */
	public static final String base_admin_page = "/admin/";
	
	/**
	 * 商家后台路径
	 */
	public static final String base_merchantAdmin_page = "/businessmenadmin/";
	
	
	/**
	 * swagger路径
	 */
	public static final String swagger_url= "/swagger/";

	

	/**
	 * 前台路径
	 */
	public static final String base_front_page = "/";

	/**
	 * 接口路径
	 */
	public static final String base_api_path = "/api/";
	
	/**
	 * pc接口路径
	 */
	public static final String base_pc_path = "/pc/";

	/**
	 * 用户协议
	 */
	public static final String user_must_agree = "agree";

	/**
	 * 关于我们
	 */
	public static final String web_about = "about";

	/**
	 * 联系我们
	 */
	public static final String web_contact = "contact";

	/**
	 * 最大洽谈上限人数
	 */
	public static final String maxChat = "maxChat";

	/**
	 * 二维码
	 */
	public static final String qrCode = "qrCode";

	/**
	 * 客服号
	 */
	public static final String customer_Service = "customer_Service";

	/**
	 * 平台统计
	 */
	public static final String sys_count = "sys_count";

	/**
	 * 今日发布数 是否显示
	 */
	public static final String today_release_count = "release";

	/**
	 * 今日成交数 是否显示
	 */
	public static final String today_done_count = "done";

	/**
	 * 平台发布数 是否显示
	 */
	public static final String all_release_count = "sys_release";

	/**
	 * 平台成交数 是否显示
	 */
	public static final String all_done_count = "sys_done";

	/**
	 * 新手指南
	 */
	public static final String newbie_guide = "newbie_guide";

	/**
	 * 版本简介
	 */
	public static final String company_introduce = "company_introduce";

	/**
	 * 声明
	 */
	public static final String advert = "advert";

	/**
	 * 卖家指南
	 */
	public static final String seller_user = "seller_guide";

	/**
	 * 买家指南
	 */
	public static final String buyer_user = "buyer_guide";

	/**
	 * 是否显示
	 * 
	 * @Description
	 * 
	 * @author C H
	 * @version 1.0
	 * @since 2016年12月23日
	 */
	public enum isShow {
		不显示, 显示;
	}

	/**
	 * 编码
	 * 
	 * @Description
	 * 
	 * @author Don Cui
	 * @version 1.0
	 * @since 2016年7月8日
	 */
	public enum CharsetName {
		UTF_8("UTF-8"), utf_8("utf-8");
		private final String value;

		CharsetName(String value) {
			this.value = value;
		}

		public String getCharsetValue() {
			return value;
		}
	}

	/**
	 * 签名类型
	 * 
	 * @Description
	 * 
	 * @author Don Cui
	 * @version 1.0
	 * @since 2016年7月8日
	 */
	public enum SignType {
		MD5("MD5"), SHA_1("SHA-1"), md5("md5"), sha_1("sha-1");
		private final String value;

		SignType(String value) {
			this.value = value;
		}

		public String getSignValue() {
			return value;
		}
	}

}
