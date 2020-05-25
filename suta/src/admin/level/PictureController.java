package admin.level;


import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang3.StringUtils;
import utils.commonUtil.StrManager;
import utils.commonUtil.sql_inserj;
import utils.other.JSONCode;
import utils.other.PageUtils;
import admin.level.model.PictureModel;
import com.alibaba.fastjson.JSONObject;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import controller.BaseAdminController;

public class PictureController extends BaseAdminController{

	StrManager str = new StrManager();
	sql_inserj inj = new sql_inserj();
	@Override
	public String route() {
		return "admin/picture";
	}
	HttpServletRequest request;
	
	/**
	 * 更新各首页头部图页面跳转
	 * @author
	 * @param 
	 * @return: void   
	 * @throws
	 */
	public void updateOnePicture(){
		if(!StringUtils.isBlank("type")){
			String type = str.notEmpty(getPara("type"));
			Record record =PictureModel.dao.getPictureDetailByType(type);
			if(record!=null){
				String title = str.notEmpty(record.getStr("title"));
				String pic = str.notEmpty(record.getStr("pic"));
				String id = str.notEmpty(record.getInt("id"));
				
				setAttr("title",title);
				setAttr("pic",pic);
				setAttr("type",type);
				setAttr("id",id);
				
				renderJsp("admin/picture/updateOnePicture.jsp");
			}
		}	
	}
	
	/**
	 * 更新各首页头部图
	 * @author
	 * @param 
	 * @return: void   
	 * @throws
	 */
	public void modifyOnePicture(){
		String where = str.notEmpty(getPara("where"));
		JSONObject value = JSONObject.parseObject(where);
		success = PictureModel.dao.modifyOnePicture(value);
		if(success){
			renderJSON(JSONCode.请求通过, "修改成功", null);
		}else{
			renderJSON(JSONCode.请求出错, "修改失败", null);
		}
		
	}
	
	/**
	 * 首页轮播图、业务板块图以及关于我们轮播图详情页面
	 * @author
	 * @param  
	 * @return: void   
	 * @throws UnsupportedEncodingException
	 */
	public void getPictureList() throws UnsupportedEncodingException{	
		if(!StringUtils.isBlank("type")){
			String type = str.notEmpty(getPara("type"));
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
			json.put("type", type);
			Page<Record> result = PictureModel.dao.getPictureListDetail(page, pageSize, json);
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
			dataJson.put("type", type);
			setAttr("resultData", dataJson);		
			renderJsp("admin/picture/index.jsp");
		}	
	}

	/**
	 * 轮播图添加页面跳转
	 * @author
	 * @param   
	 * @return: void   
	 * @throws 
	 */
	public void toAdd(){
		renderJsp("admin/picture/add.jsp");
	}

	/**
	 * 添加轮播图
	 * @author 
	 * @param  
	 * @return: void   
	 * @throws 
	 */
	public void addPicture(){
		String where = str.notEmpty(getPara("where"));
		JSONObject value = JSONObject.parseObject(where);	
		String id = str.notEmpty(value.getString("id"));
		String title = str.notEmpty(value.getString("title"));
		String picSmall = str.notEmpty(value.getString("picSmall"));
		if(StringUtils.isBlank(picSmall)){
			renderJSON(JSONCode.上传文件不能为空,"上传文件不能为空",null);
			return;
		}
		
		if(!inj.sql_inserj(id+title) ){
			success = PictureModel.dao.addPicture(value);
			if(success){
				renderJSON(JSONCode.请求通过, "添加成功", null);
			}else{
				renderJSON(JSONCode.请求出错, "添加失败", null);
			}
		}
	}
	
	/**
	 * 轮播图修改页面跳转
	 * @author
	 * @param   
	 * @return: void   
	 * @throws 
	 */
	public void toModify(){			
		if(!StringUtils.isBlank("id")){
			String id = str.notEmpty(getPara("id"));
			Record record =PictureModel.dao.getPictureDetailByID(id);
			if(record!=null){
				String title = str.notEmpty(record.getStr("title"));
				String pic = str.notEmpty(record.getStr("pic"));
				String mtpic = str.notEmpty(record.getStr("mtpic"));
				String remark = str.notEmpty(record.getStr("remark"));
				String content = str.notEmpty(record.getStr("content"));
				String status=str.notEmpty(record.getStr("status")); 
				int type=record.getInt("type");
				
				setAttr("title",title);
				setAttr("remark",remark);
				setAttr("content",content);
				setAttr("pic",pic);
				setAttr("mtpic",mtpic);
				setAttr("type",type);
				setAttr("status",status);
				setAttr("id",id);
	
				renderJsp("admin/picture/mod.jsp");
			}
		}		
	}

	/**
	 * 修改轮播图
	 * @author
	 * @param   
	 * @return: void   
	 * @throws 
	 */
	public void modifyPicture(){
		String where = str.notEmpty(getPara("where"));
		JSONObject value = JSONObject.parseObject(where);
		String title = str.notEmpty(value.getString("title"));
		String id = value.getString("id");
		if(!inj.sql_inserj(title+id)){
			if(!StringUtils.isBlank("id")){
				success = PictureModel.dao.modifyPicture(value);
				if(success){
					renderJSON(JSONCode.请求通过, "修改成功", null);
				}else{
					renderJSON(JSONCode.请求出错, "修改失败", null);
				}
			}
		}
	}
    

}
