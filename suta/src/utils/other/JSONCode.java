
package utils.other;

/**
 * 返回码
 * @Description 
 * 
 * @author C H
 * @version 1.0
 * @since 2016年12月17日
 */
public enum JSONCode {
	请求通过(200), 
	参数不全(400), 
	请求出错(401), 
	未找到资源(404), 
	非法请求(201),
	上传文件不能为空(203),
	库存不足(204),
	账号已存在(206),
	登录异常(205);
	
	private int code;

	private JSONCode(int code) {
		this.code = code;
	}

	public int getCode() {
		return this.code;
	}
	
}
