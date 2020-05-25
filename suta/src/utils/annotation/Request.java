
package utils.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Inherited;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import utils.state.RequestType;

/**
 * 请求方式
 * 
 * @Description
 * 
 * @author C H
 * @version 1.0
 * @since 2017年5月22日
 */
@Inherited
@Target(value = { ElementType.METHOD, ElementType.TYPE })
@Retention(RetentionPolicy.RUNTIME)
public @interface Request {
	public RequestType method();
}
