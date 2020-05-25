package admin.level;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import org.apache.commons.lang3.StringUtils;
import utils.commonUtil.StrManager;
import utils.commonUtil.sql_inserj;
import utils.other.JSONCode;
import utils.other.PageUtils;
import admin.level.model.NewsModel;
import api.index.model.PictureModel;
import com.alibaba.fastjson.JSONObject;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import controller.BaseAdminController;

public class NewsController extends BaseAdminController{

	StrManager str = new StrManager();
	sql_inserj inj = new sql_inserj();
	@Override
	public String route() {
		return "admin/news";
	}

	/**
	 * 分页获取新闻
	 * @author
	 * @param  
	 * @return: void   
	 * @throws 
	 */
	public void getNewsList(){					
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
		Page<Record> result = NewsModel.dao.getPagingMessage(page, pageSize, json,3);
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
		renderJsp("admin/news/index.jsp");		
	}
	
	/**
	 * 删除新闻
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
	 * 新闻添加页面跳转
	 * @author
	 * @param:    
	 * @return: void   
	 * @throws 
	 */
	public void toAdd(){
		renderJsp("admin/news/add.jsp");
	}
	
	/**
	 * 添加新闻
	 * @author
	 * @param  
	 * @return: void   
	 * @throws 
	 */
	public void addNews(){
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
			success = NewsModel.dao.addNews(value);
			if(success){
				renderJSON(JSONCode.请求通过, "添加成功", null);
			}else{
				renderJSON(JSONCode.请求出错, "添加失败", null);
			}
		}
	}
	
	/**
	 * 新闻修改页面跳转
	 * @author
	 * @param   
	 * @return: void   
	 * @throws 
	 */
	public void toModify(){		
		if(!StringUtils.isBlank("id")){
			String id = str.notEmpty(getPara("id"));
			Record record =NewsModel.dao.getNewsDetail(id);
			if(record!=null){
				String title = str.notEmpty(record.getStr("title"));
				String pic = str.notEmpty(record.getStr("pic"));
				String bigpic = str.notEmpty(record.getStr("bigpic"));
				String remark = str.notEmpty(record.getStr("remark"));
				String content = str.notEmpty(record.getStr("content"));
				String status=str.notEmpty(record.getStr("status")); 
				int type=record.getInt("type");
				
				setAttr("title",title);
				setAttr("pic",pic);
				setAttr("bigpic",bigpic);
				setAttr("content",content);
				setAttr("remark",remark);
				setAttr("status",status);
				setAttr("id",id);
				setAttr("type",type);
				
				renderJsp("admin/news/mod.jsp");
			}
		}		
	}
	
	/**
	 * 修改新闻
	 * @author 
	 * @param  
	 * @return: void   
	 * @throws 
	 */
	public void modifyNews(){
		String where = str.notEmpty(getPara("where"));
		JSONObject value = JSONObject.parseObject(where);
		String title = str.notEmpty(value.getString("title"));
		String id = value.getString("id");
		if(!inj.sql_inserj(title+id)){
			if(!StringUtils.isBlank("id")){
				success = NewsModel.dao.modifyNews(value);
				if(success){
					renderJSON(JSONCode.请求通过, "修改成功", null);
				}else{
					renderJSON(JSONCode.请求出错, "修改失败", null);
				}
			}
		}
	}

}
