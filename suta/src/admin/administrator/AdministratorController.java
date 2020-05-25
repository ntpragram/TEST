/**
 * 
 */
package admin.administrator;
import org.apache.commons.lang3.StringUtils;
import utils.commonUtil.StrManager;
import com.alibaba.fastjson.JSONObject;
import utils.commonUtil.sql_inserj;
import utils.interceptor.AdminInterceptor;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Record;
import controller.BaseAdminController;
import java.util.ArrayList;
import utils.other.PageUtils;
import utils.other.JSONCode;
import org.json.simple.JSONArray;
import java.util.List;
import com.jfinal.plugin.activerecord.tx.Tx;




/**
 * @author: C H
 */
@Before(AdminInterceptor.class)
public class AdministratorController extends BaseAdminController{
	StrManager str = new StrManager();
	sql_inserj inj = new sql_inserj();
	@Override
	public String route() {
		// TODO Auto-generated method stub
		return "admin/administrator";
	}
	/**
	 * 获取管理员列表
	 * @author: C H
	 * @throws
	 */
	public void getAdminList(){
		int page = getParaToInt("offset", 1);
		int pageSize = getParaToInt("limit", 10);
		String atype = getPara("atype");
		JSONObject json = new JSONObject();
		json.put("atype", atype);
		Page<Record> result = AdministratorModel.dao.getPaging(page, pageSize, json);
		if (result == null) {
			result = new Page<Record>(new ArrayList<Record>(), 1, pageSize, 0, 0);
		}
		JSONObject dataJson = new JSONObject();
		dataJson.put("dataList", result.getList());
		dataJson.put("pageNumber", result.getPageNumber());
		dataJson.put("pageSize", result.getPageSize());
		dataJson.put("totalPage", result.getTotalPage());
		dataJson.put("totalRow", result.getTotalRow());
		dataJson.put("isFirstPage", result.isFirstPage());
		dataJson.put("isLastPage", result.isLastPage());
		dataJson.put("atype", atype);
		//计算数字页码
		int[] nums = {result.getPageNumber(),result.getTotalPage()};
		int[] startAndEndNum = PageUtils.countPageNum(nums);
		dataJson.put("startNum", startAndEndNum[0]);
		dataJson.put("endNum", startAndEndNum[1]);
		setAttr("resultData", dataJson);
		JSONObject param = getAllParaName();
		param.put("viewList", true);
		setAttr("v", param);
		renderJsp("admin/administrator/index.jsp");
	}
	/**
	 * 添加管理员
	 * @author: C H
	 * @throws
	 */
	public void toAdd(){
		String atype = getPara("atype");
		setAttr("atype", atype);
		renderJsp("admin/administrator/add.jsp");
	}
	public void addAdmin(){
		String where = getPara("where");
		JSONObject value = JSONObject.parseObject(where);	

		String username = value.getString("username");
		String password = value.getString("password");
		if(!StringUtils.isBlank(username)&&!StringUtils.isBlank(password)){
			value.put("username", username);
			value.put("password", password);
			success = AdministratorModel.dao.addAdmin(value);
			if(success){
				renderJSON(JSONCode.请求通过, "添加成功", null);
			}else{
				renderJSON(JSONCode.请求出错, "添加失败", null);
			}
		}else{
			renderJSON(JSONCode.请求出错, "添加失败", null);
		}
	}
	public void delAll(){
		String ids = getPara("ids");
		if (sqlInjection.sqlInjection(ids)) {// 注入检查
			renderJSON(JSONCode.非法请求, "删除失败", null);
			return;
		}
		
		if(StringUtils.isBlank("ids")){
			renderJSON(JSONCode.参数不全, "至少选择一条记录", null);
			return;
		}
		
		success = AdministratorModel.dao.delAll(ids);
		if(success){
			renderJSON(JSONCode.请求通过, "删除成功", null);
		}else{
			renderJSON(JSONCode.请求出错, "删除失败", null);
		}
	}
	public void toModify(){
		String id = getPara("id");
		if(StringUtils.isNotBlank(id)){
			Record record = AdministratorModel.dao.getAdmin(id);
			if(record!=null){
				String username = record.getStr("username");
				setAttr("username",username);
				setAttr("comId",record.getInt("comId"));
				setAttr("id",id);
				renderJsp("admin/administrator/mod.jsp");
			}
		}		
	}
	public void modifyAdmin(){
		String where = getPara("where");
		JSONObject value = JSONObject.parseObject(where);
		String username = value.getString("username");
		String id = value.getString("id");
		if(!StringUtils.isBlank(username)&&!StringUtils.isBlank(id)){
			success = AdministratorModel.dao.modifyAdmin(value);
			if(success){
				renderJSON(JSONCode.请求通过, "修改成功", null);
			}else{
				renderJSON(JSONCode.请求出错, "修改失败", null);
			}
		}else{
			renderJSON(JSONCode.请求出错, "修改失败", null);
		}
	}
	/**
	 * 管理员权限设置
	 * 
	 * @author C H
	 * @since 
	 * @param 
	 * @param 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public void toPurviewSetting(){
		String id = getPara("id");
		if(StringUtils.isNotBlank(id)){
			JSONArray jsonArrSecond = new JSONArray();
			PurviewModel model = new PurviewModel();
			List<Record> recordList = model.getPurviewList();
			for(int i = 0;i<recordList.size();i++){
				JSONObject jsonSecond = new JSONObject();
				Record list= recordList.get(i); 
				String fbh=list.get("fbh");
				String fname =list.get("fname"); 
				//查询是否已分配给该用户
				int pitchOn = 0;
				Record rd = new UserPurviewModel().getUserPurview(fbh,id);
				if(rd != null){
					pitchOn = 1;
				}
				//查询二级权限
				List<Record> TwoPurviewList = new SecondPurviewModel().getTwoPurviewList(fbh);
				for(int j = 0;j<TwoPurviewList.size();j++){
					Record listRecord= TwoPurviewList.get(j); 
					String sbh=listRecord.get("sbh");
					//查询是否已分配给该用户
					int pitchOnT = 0;
					Record rdT = new UserSecondPurviewModel().getUserTwoPurview(sbh,id);
					if(rdT != null){
						pitchOnT = 1;
					}
					TwoPurviewList.get(j).set("pitchOnT", pitchOnT);
				}
						
				jsonSecond.put("pitchOn",pitchOn);
				jsonSecond.put("fbh",fbh);
				jsonSecond.put("fname",fname);
				jsonSecond.put("TwoPurviewList", TwoPurviewList);//二级栏目
				jsonArrSecond.add(jsonSecond);
			}
			setAttr("resultData",jsonArrSecond);
			setAttr("id",id);
			renderJsp("admin/administrator/PurviewSetting.jsp");
		}
	}
	@Before(Tx.class)
	public void PurviewSettingSubmint(){
		String submit = getPara("submit");
		String ygid = getPara("ygid");
		if("1".equals(submit)&&StringUtils.isNotBlank(ygid)){
			//清空原始数据
			UserPurviewModel.dao.delAll(ygid);
			UserSecondPurviewModel.dao.delAll(ygid);
			String[] dhl = getParaValues("DHL");
			if(dhl!=null){
				for(int i=0;i<dhl.length;i++){
					//System.out.println(dhl[i]);
					//查询一级栏目名称
					Record rd = new PurviewModel().getFname(dhl[i]);
					String fname = rd.get("fname").toString();
					String px = rd.get("px").toString();
					success = UserPurviewModel.dao.addQxrolefirst(fname,px,ygid,dhl[i]);
					if(!success){
						renderJSON(JSONCode.请求出错, "设置失败");
						return;
					}
				}
			}
			
			String[] bdhl = getParaValues("BDHL");
			if(bdhl!=null){
				for(int j=0;j<bdhl.length;j++){
					//查询二级栏目名称
					Record rd = new SecondPurviewModel().getFname(bdhl[j]);
					String sname = rd.get("sname").toString();
					String fbh = rd.get("fbh").toString();
					String web = rd.get("web").toString();
					success = UserSecondPurviewModel.dao.addqxrolesecond(bdhl[j], sname, fbh, web,ygid);
					if(!success){
						renderJSON(JSONCode.请求出错, "设置失败");
						return;
					}
				}
			}
			renderJSON(JSONCode.请求通过, "设置成功");
		}else{
			renderJSON(JSONCode.请求出错, "修改失败");
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
