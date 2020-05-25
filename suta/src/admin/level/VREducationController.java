package admin.level;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import org.apache.commons.lang3.StringUtils;

import utils.commonUtil.StrManager;
import utils.commonUtil.sql_inserj;
import utils.other.JSONCode;
import utils.other.PageUtils;
import admin.level.model.VREducationModel;
import api.index.model.PictureModel;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.upload.UploadFile;

import controller.BaseAdminController;

public class VREducationController extends BaseAdminController{

	StrManager str = new StrManager();
	sql_inserj inj = new sql_inserj();
	@Override
	public String route() {
		return "admin/level";
	}

	/**
	 * 分页获取资讯列表
	 * @author
	 * @param 
	 * @return: void   
	 * @throws
	 */
	public void getVREducationList(){
					
			int page = getParaToInt("offset", 1);
			int pageSize = getParaToInt("limit", 2);
			String search = getPara("search", "");
			
			try {
				search = new String(search.getBytes("UTF-8"),"UTF-8");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			JSONObject json = JSONObject.parseObject(getPara("where", "{}"));
			json.put("search", search);
			Page<Record> result = VREducationModel.dao.getVRPagingMessage(page, pageSize, json,1);
			if (result == null) {
				result = new Page<Record>(new ArrayList<Record>(), 1, pageSize,0, 0);
			}
			JSONObject dataJson = new JSONObject();
			dataJson.put("dataList", result.getList());
			dataJson.put("pageNumber", result.getPageNumber());
			dataJson.put("pageSize", result.getPageSize());
			dataJson.put("totalPage", result.getTotalPage());
			dataJson.put("totalRow", result.getTotalRow());
			dataJson.put("isFirstPage", result.isFirstPage());
			dataJson.put("isLastPage", result.isLastPage());
			//计算数字页码
			int[] nums = {result.getPageNumber(),result.getTotalPage()};
			int[] startAndEndNum = PageUtils.countPageNum(nums);
			dataJson.put("startNum", startAndEndNum[0]);
			dataJson.put("endNum", startAndEndNum[1]);
			dataJson.put("search", search);
			setAttr("resultData", dataJson);
			renderJsp("admin/vreducation/index.jsp");
		
	}
	
	/**
	 * 删除
	 * @author
	 * @param 
	 * @return: void   
	 * @throws
	 */
	public void delete(){
		if (checkParaInjection("id")) {
			success = PictureModel.dao.deleteModel(getPara("id")).isSuccess();
			renderJSON(success);
		}
	}
	
	/**
	 * VR教育添加页面跳转
	 * @author
	 * @param 
	 * @return: void   
	 * @throws
	 */
	public void toAdd(){
		renderJsp("admin/vreducation/add.jsp");
	}
	
	/**
	 * 添加VR教育
	 * @author
	 * @param  
	 * @return: void   
	 * @throws
	 */
	public void addVREducation(){
		String where = str.notEmpty(getPara("where"));
		JSONObject value = JSONObject.parseObject(where);
		
		String title = str.notEmpty(value.getString("title"));
		String picSmall = str.notEmpty(value.getString("picSmall"));
		String picBig = str.notEmpty(value.getString("picBig"));
		
		if(StringUtils.isBlank(picBig) || StringUtils.isBlank(picSmall)){
			renderJSON(JSONCode.上传文件不能为空,"上传文件不能为空",null);
			return;
		}
		
		if(!inj.sql_inserj(title) ){

			success = VREducationModel.dao.addVREducation(value);
			if(success){
				renderJSON(JSONCode.请求通过, "添加成功", null);
			}else{
				renderJSON(JSONCode.请求出错, "添加失败", null);
			}
		}
	}
	
	/**
	 * VR教育修改页面跳转
	 * @author
	 * @param
	 * @return: void   
	 * @throws
	 */
	public void toModify(){
		
		if(!StringUtils.isBlank("id")){
			String id = str.notEmpty(getPara("id"));
			Record record =VREducationModel.dao.getVREducationDetail(id);
			if(record!=null){
				String title = str.notEmpty(record.getStr("title"));
				String pic = str.notEmpty(record.getStr("pic"));
				String bigPic = str.notEmpty(record.getStr("bigPic"));
				String mtpic = str.notEmpty(record.getStr("mtpic")); 
				String content = str.notEmpty(record.getStr("content")); 
				String type=record.getStr("type");
				
				setAttr("title",title);
				setAttr("pic",pic);
				setAttr("bigPic",bigPic);
				setAttr("mtpic",mtpic);
				setAttr("content",content);
				setAttr("id",id);
				setAttr("type",type);
				
				renderJsp("admin/vreducation/mod.jsp");
			}

		}		
	}
	
	/**
	 * 修改VR教育
	 * @author
	 * @param
	 * @return: void   
	 * @throws
	 */
	public void modifyVREducation(){
		String where = str.notEmpty(getPara("where"));
		JSONObject value = JSONObject.parseObject(where);
		String title = str.notEmpty(value.getString("title"));
		String id = value.getString("id");

		if(!inj.sql_inserj(title+id)){
			if(!StringUtils.isBlank("id")){
				success = VREducationModel.dao.modifyVREducation(value);
				if(success){
					renderJSON(JSONCode.请求通过, "修改成功", null);
				}else{
					renderJSON(JSONCode.请求出错, "修改失败", null);
				}
			}
		}
	}
	
	
	
	//----------------------------------------成功案例--------------------------------------------------------------------
	
	
	/**
	 * 分页获取资讯列表
	 * @author
	 * @param
	 * @return: void   
	 * @throws
	 */
	public void getSuccessCaseList(){
					
			int page = getParaToInt("offset", 1);
			int pageSize = getParaToInt("limit", 5);
			String search = getPara("search", "");
			
			try {
				search = new String(search.getBytes("UTF-8"),"UTF-8");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			JSONObject json = JSONObject.parseObject(getPara("where", "{}"));
			json.put("search", search);
			Page<Record> result = VREducationModel.dao.getSuccessPagingMessage(page, pageSize, json,0);
			if (result == null) {
				result = new Page<Record>(new ArrayList<Record>(), 1, pageSize,0, 0);
			}
			JSONObject dataJson = new JSONObject();
			dataJson.put("dataList", result.getList());
			dataJson.put("pageNumber", result.getPageNumber());
			dataJson.put("pageSize", result.getPageSize());
			dataJson.put("totalPage", result.getTotalPage());
			dataJson.put("totalRow", result.getTotalRow());
			dataJson.put("isFirstPage", result.isFirstPage());
			dataJson.put("isLastPage", result.isLastPage());
			//计算数字页码
			int[] nums = {result.getPageNumber(),result.getTotalPage()};
			int[] startAndEndNum = PageUtils.countPageNum(nums);
			dataJson.put("startNum", startAndEndNum[0]);
			dataJson.put("endNum", startAndEndNum[1]);
			dataJson.put("search", search);
			setAttr("resultData", dataJson);
			renderJsp("admin/successCase/index.jsp");
		
	}
	
	
	/**
	 * 成功案例添加页面跳转
	 * @author
	 * @param 
	 * @return: void   
	 * @throws
	 */
	public void toSuccessCaseAdd(){
		renderJsp("admin/successCase/add.jsp");
	}
	
	/**
	 * 添加成功案例
	 * @author
	 * @param 
	 * @return: void   
	 * @throws
	 */
	public void addSuccessCase(){
		String where = str.notEmpty(getPara("where"));
		JSONObject value = JSONObject.parseObject(where);
		
		String title = str.notEmpty(value. getString("title"));
		String picSmall = str.notEmpty(value.getString("picSmall"));
		String picBig = str.notEmpty(value.getString("picBig"));
		System.out.println("-----小图"+picSmall);
		System.out.println("-----大图"+picBig);
		
		if(StringUtils.isBlank(picBig) || StringUtils.isBlank(picSmall)){
			renderJSON(JSONCode.上传文件不能为空,"上传文件不能为空",null);
			return;
		}
		
		if(!inj.sql_inserj(title) ){
			success = VREducationModel.dao.addSuccessCase(value);
			if(success){
				renderJSON(JSONCode.请求通过, "添加成功", null);
			}else{
				renderJSON(JSONCode.请求出错, "添加失败", null);
			}
		}
	}
	
	/**
	 * 成功案例修改页面跳转
	 * @author
	 * @param 
	 * @return: void   
	 * @throws
	 */
	public void toModifySuccessCase(){
		
		if(!StringUtils.isBlank("id")){
			String id = str.notEmpty(getPara("id"));
			Record record =VREducationModel.dao.getSuccessCaseDetail(id);
			if(record!=null){
				String title = str.notEmpty(record.getStr("title"));
				String pic = str.notEmpty(record.getStr("pic"));
				String bigPic = str.notEmpty(record.getStr("bigPic"));
				String content = str.notEmpty(record.getStr("content")); 
				String type=record.getStr("type");
				
				setAttr("title",title);
				setAttr("pic",pic);
				setAttr("bigPic",bigPic);
				setAttr("content",content);
				setAttr("id",id);
				setAttr("type",type);
				
				renderJsp("admin/successCase/mod.jsp");
			}

		}		
	}
	
	/**
	 * 修改成功案例
	 * @author
	 * @param  
	 * @return: void   
	 * @throws
	 */
	public void modifySuccessCase(){
		String where = str.notEmpty(getPara("where"));
		JSONObject value = JSONObject.parseObject(where);
		String title = str.notEmpty(value.getString("title"));
		String id = value.getString("id");

		if(!inj.sql_inserj(title+id)){
			if(!StringUtils.isBlank("id")){
				success = VREducationModel.dao.modifySuccessCase(value);
				if(success){
					renderJSON(JSONCode.请求通过, "修改成功", null);
				}else{
					renderJSON(JSONCode.请求出错, "修改失败", null);
				}
			}
		}
	}
	
	/**
	 * 视频上传
	 * @author
	 * @param
	 * @return: void   
	 * @throws
	 */
	 public void uploadFILE(){
	     /*使用UploadFile获取前台文件
	      *第一个参数是页面file的name名，第二个参数是指定保存的文件夹，第三个参数是设置文件的最大值，第四个参数是设置文件的编码方式
	      *UploadFile  upFile = getFile("fileText", filedir); //或getFile(getPara("fileText"), filedir); 
	      */
	 	  final int maxSize = 100 * 1024 * 1024;
//	      String filedir=PathKit.getWebRootPath()+"/text";
	      UploadFile  upFile = getFile("file","",maxSize);
	
	      /*对文件进行重命名
	      *upFile.getFile().renameTo(dest);可使用file的原生方法去对file进行重命名，
	      *jf3.1版本已经添加自定义名称功能，所以这个适合3.1之前的版本使用;
	      *根据原文件名使用时间戳和随机数重命名，保存，原来的临时文件会自动删除
	      */
	      SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmss");
	      String fileName = upFile.getFileName();
	      String lastThreeLetter = fileName.substring(fileName.lastIndexOf("."));
	      String sqlName = sdf.format(new Date())+(int)(Math.random()*10000)+lastThreeLetter;
	      System.out.println("-------"+sqlName);
	      upFile.getFile().renameTo(new File(PathKit.getWebRootPath()+"/file/"+sqlName));
	      String videoPath = "file/"+sqlName;
	
	      /*
	      *上传文件的同时，如果包含其他的携带的变量 的话需要先使用getFile方法，之后才能获取其他的变量参数
	      */
	      String levelid = getPara("levelid");
	      System.out.println("获取到的额外的参数："+levelid);
	
	      /*
	       * jf后台在获取文件的时候可直接获取文件文件的修改名称、原名称、上传保存的路径
	       *(getUploadPath(),不包含文件，只到达文件夹；getFile()能够直接获取到文件，包括文件名)、
	       * 文件的类型（例如jpeg文件格式，获取到的是image/jpeg）
	       */
	      System.out.println("1："+upFile.getFileName()+" 2："+upFile.getOriginalFileName()+" 3："+upFile.getUploadPath());
	      System.out.println("文件："+upFile.getFile()+" 4："+upFile.getContentType());
	
	      /*
	       * jf获取文件根路径的方法：
	       */
	      String path = PathKit.getWebRootPath();
	      System.out.println(path);
	
	      /*
	       * 1.返回的是text/html，前台需使用json工具转换成json对象才能获取数据，var htmlToJson = JSON.parse(data);
	       * 2.如果不包含文件上传的form表单提交异步刷新，则直接使用renderJSON(params);
	       */
	
	      success = VREducationModel.dao.modifyUpload(levelid,videoPath);
		  if(success){
			renderJSON(JSONCode.请求通过, "成功", null);
		  }else{
			renderJSON(JSONCode.请求出错, "失败", null);
		  }
		  
	 }
	 
	 
		
	 /*	public void upload(){
 		 final int maxSize = 100 * 1024 * 1024;
         UploadFile  upFile = getFile("file","UTF-8",maxSize);
         SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmss");
         String fileName = upFile.getFileName();
         String lastThreeLetter = fileName.substring(fileName.lastIndexOf("."));
         String sqlName = sdf.format(new Date())+(int)(Math.random()*10000)+lastThreeLetter;
         System.out.println(sqlName);
         upFile.getFile().renameTo(new File(PathKit.getWebRootPath()+"/file/"+sqlName));
                  
		 String videoPath = "/file/"+sqlName; 
         String str = "{\"ifSuccess\":\"success\",\"status\":\"0\"}";
         JSONObject json = JSONObject.parseObject(str);  
         renderJSON(JSONCode.请求通过, "成功", json);
	     }*/

}
