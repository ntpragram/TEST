
package utils.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Inherited;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 路由相对视图
 * 
 * @Description
 * 
 * @author C H
 * @version 1.0
 * @since 2017年5月22日
 */
@Inherited
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.TYPE)
public @interface RouteViewPath {
	public String value();
}
