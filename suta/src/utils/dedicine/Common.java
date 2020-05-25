package utils.dedicine;

import cn.jiguang.common.utils.StringUtils;

/**
 * @author: C H
 */
public class Common {
	/**
	 * 平台标志
	 * 
	 * @author: C H
	 * @since 2017年07月26日
	 */
	public static final String getPlatform(String platform){
		String platformNum = "-1";
		if(StringUtils.isNotEmpty(platform)){
			if(platform.equals("ios")){
				platformNum = "2";
			}else if(platform.equals("android")){
				platformNum = "3";
			}else if(platform.equals("wx")){
				platformNum = "1";
			}
		}
		return platformNum;
	};
}
