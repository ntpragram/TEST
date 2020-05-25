package api.index;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import api.index.model.AboutModel;
import api.index.model.ArticleModel;
import api.index.model.LevelModel;
import api.index.model.PictureModel;
import com.alibaba.fastjson.JSONObject;
import com.jfinal.plugin.activerecord.Record;
import utils.annotation.ValidateTOKEN;
import utils.jfinal.JFinalConst;
import utils.other.JSONCode;
import controller.BaseAPIController;

/**
 * 首页模块
 * 
 * @Description
 * 
 * @author C H
 * @version 1.0
 * @since 
 */
public class IndexController extends BaseAPIController {
	@Override
	public String route() {
		return JFinalConst.base_api_path + "index";
	}
	HttpServletRequest request;

	
	/**
	 * 获取首页信息
	 * 
	 * @author C H
	 * @since 
	 */
	@ValidateTOKEN(isValidate = false)
	public void getIndexMessage() {
		List<Record> bannerList = PictureModel.dao.getCarousel(7);
		List<Record> plateList = PictureModel.dao.getCarousel(0);
		JSONObject dataJson = new JSONObject(); 
		dataJson.put("bannerList",bannerList);
		dataJson.put("plateList",plateList);
		renderJSON(JSONCode.请求通过, "成功",dataJson); 
		
	}
	
	
	/**
	 * 获取成功案例首页类别
	 * 
	 * @author: C H
	 * @throws
	 */
	
	@ValidateTOKEN(isValidate = false)
	public void getSuccessCaseLevel(){
		Record casePicture=PictureModel.dao.getPictureFindByType(2);
		List<Record> caseList= LevelModel.dao.getLevelList(0);
		JSONObject dataJson = new JSONObject(); 
		dataJson.put("casePicture",casePicture);
		dataJson.put("caseList",caseList);
		renderJSON(JSONCode.请求通过, "成功",dataJson); 
	}
	
	

	/**
	 * 获取成功案例详情
	 * 
	 * @author: C H
	 * @throws
	 */	
	@ValidateTOKEN(isValidate = false)
	public void getSuccessCaseDetailList(){
		
		String lid=getPara("id");
		Record record =LevelModel.dao.getSuccessCaseDetailList(lid);
		JSONObject dataJson = new JSONObject(); 
		dataJson.put("record",record);
		renderJSON(JSONCode.请求通过, "成功",dataJson); 
		
	}
		
	
	@ValidateTOKEN(isValidate = false)
	public void getSuccess(){
		Record casePicture=PictureModel.dao.getPictureFindByType(2);
		List<Record> caseList= LevelModel.dao.getLevelGradeList();
		JSONObject dataJson = new JSONObject(); 
		dataJson.put("casePicture",casePicture);
		dataJson.put("caseList",caseList);
		renderJSON(JSONCode.请求通过, "成功",dataJson); 
	}
	
	@ValidateTOKEN(isValidate = false)
	public void getSuccessGradeDetailList(){
		
//		String grade=getPara("grade");
		String grade="101";
		List<Record> caseList = null;
		Record record = null;
		if(grade.equals("199")){
			caseList = LevelModel.dao.getLevelList(0);
		}else{
			record =LevelModel.dao.getSuccessGradeDetailList(grade);
		}
		JSONObject dataJson = new JSONObject(); 
		dataJson.put("caseList",caseList);
		dataJson.put("record",record);
		renderJSON(JSONCode.请求通过, "成功",dataJson); 
		
	}
	
	

	/**
	 * 获取VR教育
	 * @author: C H
	 * @throws
	 */
	@ValidateTOKEN(isValidate = false)
	public void getVREducation(){
		
		List<Record> typeList=LevelModel.dao.getLevelList(1);
		JSONObject dataJson = new JSONObject(); 
		dataJson.put("vrList",typeList);
		renderJSON(JSONCode.请求通过, "成功",dataJson); 
	}
	
	
	
	/**
	 * 获取新闻中心
	 * 
	 * @author: C H
	 * @throws
	 */
	
	@ValidateTOKEN(isValidate = false)
	public void getNewsList(){
		Record firstPicture=PictureModel.dao.getPictureFindByType(4);
		List<Record> newsList= ArticleModel.dao.getNewsList();
		
		JSONObject dataJson = new JSONObject(); 
		dataJson.put("firstPicture",firstPicture);
		dataJson.put("newsList",newsList);
		renderJSON(JSONCode.请求通过, "成功",dataJson); 
		
	}
	
	
	@ValidateTOKEN(isValidate = false)
	public void getNewsList1(){
		List<Record> total =ArticleModel.dao.getNewsListTotal();	
		List<Record> entity =ArticleModel.dao.getNewsListEntity(0,2);	
		JSONObject dataJson = new JSONObject(); 
		dataJson.put("total",total);
		dataJson.put("entity",entity);
		renderJSON(JSONCode.请求通过, "成功",dataJson); 
		
	}
	
	
	
	/**
	 * 获取新闻中心详情
	 * 
	 * @author: C H
	 * @throws
	 */
	
	@ValidateTOKEN(isValidate = false)
	public void getNewsDetail(){
		String id=getPara("id");
		System.out.println("------------1234detail");
		System.out.println(id);
		Record newsDetail=ArticleModel.dao.getNewsDetail(id);

		JSONObject dataJson = new JSONObject(); 
		dataJson.put("newsDetail",newsDetail);
		renderJSON(JSONCode.请求通过, "成功",dataJson); 
	}
	
	/**
	 * 关于我们
	 * @author: C H
	 * @throws
	 */
	@ValidateTOKEN(isValidate = false)
	public void getAbout(){
		Record aboutPicture=PictureModel.dao.getPictureFindByType(5);
		List<Record> bannerList = PictureModel.dao.getCarousel(1);
		Record text = AboutModel.dao.getAboutDetail();
		JSONObject dataJson = new JSONObject();
		dataJson.put("aboutPicture",aboutPicture);
		dataJson.put("bannerList",bannerList);
		dataJson.put("text",text); 
		renderJSON(JSONCode.请求通过, "成功",dataJson);

	}
	
	/**
	 * 人才招聘
	 * @author: C H
	 * @throws
	 */
	@ValidateTOKEN(isValidate = false)
	public void getInvitation(){
		Record invitationPicture=PictureModel.dao.getPictureFindByType(6);
		JSONObject dataJson = new JSONObject();
		dataJson.put("invitationPicture",invitationPicture);
		renderJSON(JSONCode.请求通过, "成功",dataJson);

	}
}
