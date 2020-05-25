package utils.commonUtil;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginFilter implements Filter {

	@Override
	public void destroy() {
		

	}

	@Override
	public void doFilter(ServletRequest arg0, ServletResponse arg1,
			FilterChain arg2) throws IOException, ServletException {
		
		HttpServletRequest request=(HttpServletRequest)arg0;  
		HttpServletResponse response=(HttpServletResponse)arg1;  
		String uri=request.getRequestURI();  
	      //判断当前请求地址是否是登录地址  
		 if(uri.contains("/admin/image.jsp")||uri.contains("/admin/yanzhen.jsp")){arg2.doFilter(request, response);return;}
	      if(!uri.contains("/admin/login.html")){  
	          //非登录请求  
	          if(request.getSession().getAttribute("admin_username")!=null){  
	              //说明已经登录过，放行
	        	  
	        	  arg2.doFilter(request, response);  
	          }else{  
	              //没有登录,跳转到登录界面  
	              response.sendRedirect(request.getContextPath()+"/admin/login.html");  
	         }  
	     }else{  
	         //登录请求，直接放行  
	    	 //System.out.println(uri);
	    	 arg2.doFilter(request, response);  
	      }  

	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub

	}

}
