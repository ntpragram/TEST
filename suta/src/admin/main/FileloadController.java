package admin.main;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import utils.interceptor.AdminInterceptor;
import utils.other.EncodeUtils;
import utils.other.JSONCode;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.aop.Before;
import com.jfinal.kit.PathKit;
import com.jfinal.upload.UploadFile;

import controller.BaseAdminController;

/**
 * 附件上传
 * 
 * @Description
 * 
 * @author C H
 * @version 1.0
 * @since 
 */
@Before(AdminInterceptor.class)
public class FileloadController extends BaseAdminController {

	@Override
	public String route() {
		return "/admin/file";
	}

	public void uploadImg() {
		UploadFile files = getFile();	
		
		if (files == null) {
			renderJSON(JSONCode.请求出错, "请上传文件");
			return;
		}
		
		
		
		
		String uploadFileName = files.getFileName();
		String fileName = uploadFileName.substring(0,
				uploadFileName.lastIndexOf("."));
		String suffix = uploadFileName.substring(
				uploadFileName.lastIndexOf("."), uploadFileName.length());
		String newFileName = EncodeUtils.MD5Encode(fileName
				+ System.currentTimeMillis())
				+ suffix;
		
		//D:/photoApp/file/
		

		 files.getFile().renameTo(
				new File(PathKit.getWebRootPath() + "/file/" + newFileName));
	
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("img", "file/" + newFileName);
		renderJSON(JSONCode.请求通过, "文件上传成功", map);
	}

	
	
	
	/**
	 * @author: C H
	 * @param newFileName
	 * @throws
	 *//*
	private void uploadImgs(String newFileName) {
		// TODO Auto-generated method stub
		UploadFile files = getFile();	
		
		
		files.getFile().renameTo(
				new File("D:/photoApp/file/" + newFileName));
		
		System.out.println(files.getFile());
		
	}*/

	public void loadFile() {
		String fileName = getPara("fileName");
		renderFile(fileName);
	}
	
	//layUI 富文本编辑器
	public void uploadImage(){
		HttpServletRequest request = getRequest();
		String path = request.getContextPath();
		String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
		
		JSONObject jsonObj = new JSONObject();
		JSONObject jsonMx = new JSONObject();
		UploadFile files = getFile();	
		if (files == null) {
			jsonObj.put("code", 1);
			jsonObj.put("msg", "上传文件不能为空");
			jsonMx.put("src", "");
			jsonMx.put("title", "");
			jsonObj.put("data", jsonMx);
			renderJson(jsonObj);
			return;
		}
		String uploadFileName = files.getFileName();
		String fileName = uploadFileName.substring(0,
				uploadFileName.lastIndexOf("."));
		String suffix = uploadFileName.substring(
				uploadFileName.lastIndexOf("."), uploadFileName.length());
		String newFileName = EncodeUtils.MD5Encode(fileName
				+ System.currentTimeMillis())
				+ suffix;
		
		files.getFile().renameTo(
				new File(PathKit.getWebRootPath() + "/file/" + newFileName));
		
		/*files.getFile().renameTo(
				new File("/usr/local/ZhangShangYunShanPic/file/" + newFileName));*/
		


		jsonMx.put("src",  basePath+"file/"+newFileName);
		jsonMx.put("title", "");
		
		jsonObj.put("data", jsonMx);
		jsonObj.put("code", 0);
		jsonObj.put("msg", "文件上传成功");
		renderJson(jsonObj);
	}
}
