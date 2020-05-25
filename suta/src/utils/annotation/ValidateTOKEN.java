package utils.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Inherited;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Inherited
@Target(value = { ElementType.METHOD, ElementType.TYPE })
@Retention(RetentionPolicy.RUNTIME)
public @interface ValidateTOKEN {

	
	
	/**
	 * 进行登陆验证
	 * 
	 * @return
	 */
	public boolean isValidate() default true;
}
