package admin.main;

import java.util.ArrayList;
import java.util.List;
import org.apache.commons.lang3.StringUtils;
import utils.interceptor.AdminInterceptor;
import utils.jfinal.BaseModel;
import utils.jfinal.JFinalConst;
import utils.jfinal.ModelPlugin;
import utils.other.CodeBean;
import utils.other.EncodeUtils;
import utils.other.JSONCode;
import utils.other.PageUtils;
import com.alibaba.fastjson.JSONObject;
import com.jfinal.aop.Before;
import com.jfinal.aop.Clear;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.tx.Tx;
import controller.BaseAdminController;

/**
 * 后台通用方法
 * @author: C H
 */
@Before(AdminInterceptor.class)
public class MainController extends BaseAdminController {

	@Override
	public String route() {
		return "/admin";
	}

	public void index() {
		if (getPara(0) != null && !"index".equals(getPara(0))) {
			redirect("/admin/index");
			return;
		}
		Record recod = getAdminInfo();
		List<Record> menuList = MenuModel.dao.menuList(recod.getInt("id").toString());
		List<Record> menuSecList = MenuModel.dao.menuSecList(recod.getInt("id").toString());
		setAttr("menuList", menuList);
		setAttr("menuSecList", menuSecList);
		//System.out.println("==========================================="+recod);
		JSONObject dataJson = new JSONObject();
		dataJson.put("id", recod.get("id"));
		dataJson.put("username", recod.get("username"));
		dataJson.put("type", recod.get("type"));
		removeAttr("resultData");
		setAttr("resultData", dataJson);
		renderJsp("admin/index.jsp");
	}

	@Clear(AdminInterceptor.class)
	public void loginOut() {
		getSession().removeAttribute(JFinalConst.admin);
		redirect("/admin/login");
	}

	@Clear(AdminInterceptor.class)
	public void toLogin() {
		redirect("/admin/login");
	}

	/**
	 * 去登录页面
	 * @author: C H
	 * @throws
	 */
	@Clear(AdminInterceptor.class)
	public void login() {
		renderJsp("admin/login.jsp");
	}
	
	/**
	 * 登录验证
	 * @author: C H
	 * @throws
	 */
	@Clear(AdminInterceptor.class)
	public void loginVerify() {
		if (checkParaInjection("username", "password")) {
			String username = getPara("username");
			String password = getPara("password");
			Record admin = AdminModel.dao.adminInfo(username);
			if (admin == null) {
				renderJSON(false, "用户名不存在");
				return;
			}
			if (EncodeUtils.MD5Encode(password).equals(admin.getStr("password"))) {
				admin.remove("password");
				getSession().setAttribute(JFinalConst.admin, admin);
				renderJSON(true, "登陆成功");
				System.out.println("登陆成功");
			} else {
				renderJSON(false, "密码不正确");
			}
		}
	}
	
	/**
	 * restful
	 * 
	 * @author C H
	 * @since 
	 */
	@Deprecated
	public void page() {
		String rootPage = getPara(0);
		String nextPage = getPara(1);
		renderJsp("admin/" + rootPage + "/" + nextPage + ".jsp");
	}
	/**
	 * 去修改密码页面
	 */
	public void passwd() {
		String id = getPara("id");
		
		JSONObject dataJson = new JSONObject();
		dataJson.put("id", id);
		removeAttr("resultData");
		setAttr("resultData", dataJson);
		renderJsp("admin/passwd.jsp");
	}
	public void setPassword() {
		String where = getPara("where");
		JSONObject value = JSONObject.parseObject(where);
		String oldPassword = value.getString("oldPassword");
		String newPassword = value.getString("newPassword");
		String id = value.getString("id");
		System.out.println("idididididididid=========="+id);
		Record member = AdminModel.dao.adminInfoid(id);
		if (member == null) {
			renderJSON(JSONCode.请求出错, "登录异常");
		}
		if(!EncodeUtils.MD5Encode(oldPassword).equals(member.getStr("password"))){
			renderJSON(false, "原密码不正确");
			return;
		}
		member.set("password",EncodeUtils.MD5Encode(newPassword));
		member.set("id",id);
		AdminModel model = new AdminModel();
		success = model.updateInfo(member);
		if(success){
			renderJSON(JSONCode.请求通过,"修改成功");
		}else{
			renderJSON(JSONCode.请求出错,"修改失败，请重试");
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	/**
	 * 视图映射/数据拉取
	 * 
	 * @author C H
	 * @since 2017年2月15日
	 */
	public void viewList() {
		String modelName = getPara(0);
		BaseModel<?> baseModel = ModelPlugin.models.get(modelName);
		if (isPost()) {// 分页数据
			if (baseModel == null) {
				renderJSON(JSONCode.非法请求, "数据不完整", new Page<Record>(
						new ArrayList<Record>(), 1, 10, 0, 0));
				return;
			}
			int page = getParaToInt("offset", 1);
			int pageSize = getParaToInt("limit", 10);
			//System.out.println("page:"+page+",pageSize:"+pageSize);
//			page = (page / pageSize);
			JSONObject json = JSONObject.parseObject(getPara("where", "{}"));
			json.put("admin", getAdminInfo());
			Page<Record> result = baseModel.getPaging(page, pageSize, json);
			if (result == null) {
				result = new Page<Record>(new ArrayList<Record>(), 1, pageSize,
						0, 0);
			}
			JSONObject dataJson = new JSONObject();
			dataJson.put("dataList", result.getList());
			dataJson.put("pageNumber", result.getPageNumber());
			dataJson.put("pageSize", result.getPageSize());
			dataJson.put("totalPage", result.getTotalPage());
			dataJson.put("totalRow", result.getTotalRow());
			dataJson.put("isFirstPage", result.isFirstPage());
			dataJson.put("isLastPage", result.isLastPage());
			//System.out.println("post--------resultData："+ dataJson);
			removeAttr("resultData");
			setAttr("resultData", dataJson);
			JSONObject param = getAllParaName();
			param.put("viewList", true);
			setAttr("v", param);
//			renderJsp("admin/" + baseModel.view(modelName, param) + ".jsp");
			renderJSON(JSONCode.请求通过, "数据已更新", result);
		} else {// 视图数据
			if (baseModel == null) {
				renderError(500);
				return;
			}
			int page = getParaToInt("offset", 1);
			int pageSize = getParaToInt("limit", 10);
			System.out.println("page:"+page+",pageSize:"+pageSize);
//			int page = 1;//当前页数
//			int pageSize = 10;//每页显示的数量
			JSONObject json = JSONObject.parseObject(getPara("where", "{}"));
			json.put("admin", getAdminInfo());
			Page<Record> result = baseModel.getPaging(page, pageSize, json);
			if (result == null) {
				result = new Page<Record>(new ArrayList<Record>(), 1, pageSize,
						0, 0);
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
//			System.out.println("get--------resultData："+ dataJson);
			setAttr("resultData", dataJson);
			JSONObject param = getAllParaName();
			param.put("viewList", true);
			setAttr("v", param);
			renderJsp("admin/" + baseModel.view(modelName, param) + ".jsp");
		}
	}

	/**
	 * 分页显示数据
	 * 
	 * @author C H
	 * @since 2016年12月17日
	 */
	@Deprecated
	public void showList() {
		String modelName = getPara(0);
		BaseModel<?> baseModel = ModelPlugin.models.get(modelName);
		if (baseModel == null) {
			renderJSON(JSONCode.非法请求, "数据不完整");
			throw new RuntimeException("数据model没找到-----" + modelName);
		}
		int page = getParaToInt("offset", 1);
		int pageSize = getParaToInt("limit", 10);
		page = (page / pageSize);
		JSONObject json = JSONObject.parseObject(getPara("where", "{}"));
		json.put("admin", getAdminInfo());
		Page<Record> result = baseModel.getPaging(++page, pageSize, json);
		if (result == null) {
			result = new Page<Record>(new ArrayList<Record>(), 1, pageSize, 0,
					0);
		}
		renderJSON(JSONCode.请求通过, "数据已更新", result);
	}

	/**
	 * 显示单条信息
	 * 
	 * @author C H
	 * @since 2016年12月17日
	 */
	@Deprecated
	public void show() {
		String modelName = getPara("model");
		String modelId = getPara("id");
		BaseModel<?> baseModel = ModelPlugin.models.get(modelName);
		if (baseModel == null) {
			renderJSON(JSONCode.非法请求, "数据不完整");
			throw new RuntimeException("数据model没找到-----" + modelName);
		}
		setAttr("v",
				baseModel.showModel(modelId,
						JSONObject.parseObject(getPara("where", "{}"))));
		setAttr("op", getPara(0));
		setAttr("modelName", modelName);
		renderJsp("admin/" + modelName + "/" + "modify.jsp");
	}

	/**
	 * 显示单条信息 显示的视图根据model
	 * 
	 * @author C H
	 * @since 2016年12月17日
	 */
	public void view() {
		String modelName = getPara("model");
		String modelId = getPara("id");
		BaseModel<?> baseModel = ModelPlugin.models.get(modelName);
		if (baseModel == null) {
			renderJSON(JSONCode.非法请求, "数据不完整");
			throw new RuntimeException("数据model没找到-----" + modelName);
		}
		setAttr("v",
				baseModel.showModel(modelId,
						JSONObject.parseObject(getPara("where", "{}"))));
		setAttr("op", getPara(0));
		setAttr("modelName", modelName);
		JSONObject param = getAllParaName();
		param.put("view", true);
		setAttr("other", param);
		renderJsp("admin/" + baseModel.view(modelName, param) + ".jsp");
	}

	/**
	 * 根据主键判断操作 增加/修改
	 * 
	 * @author C H
	 * @since 2016年12月26日
	 */
	@Before(Tx.class)
	public void modify() {
		String modelName = getPara("modelName");
		BaseModel<?> baseModel = ModelPlugin.models.get(modelName);
		if (baseModel == null) {
			renderJSON(JSONCode.非法请求, "数据不完整");
			throw new RuntimeException("数据model没找到-----" + modelName);
		}
		String where = getPara("where");
		JSONObject json = new JSONObject();
		if (StringUtils.isBlank(where)) {
			renderJSON(JSONCode.非法请求, "操作失败");
			return;
		}
		json = JSONObject.parseObject(where);
		json.put("admin", getAdminInfo());
		CodeBean<BaseModel<?>> bean = baseModel.modifyModel(json);
		baseModel.clear(); // 清除
		if (bean.isSuccess()) {
			renderJSON(JSONCode.请求通过, bean.getMessage(), bean.getData());
		} else {
			renderJSON(JSONCode.请求出错, bean.getMessage());
		}
	}

	/**
	 * 删除数据 是否真删除根据model内的isReal判断
	 * 
	 * @author C H
	 * @since 2017年2月15日
	 */
	@Before(Tx.class)
	public void delete() {
		String modelName = getPara("model");
		String modelId = getPara("ids");
		//System.out.println("modelName:"+modelName+";modelId:"+modelId);
		BaseModel<?> baseModel = ModelPlugin.models.get(modelName);
		if (baseModel == null) {
			renderJSON(JSONCode.非法请求, "数据不完整");
			throw new RuntimeException("数据model没找到-----" + modelName);
		}
		CodeBean<Object> bean = baseModel.deleteModel(modelId);
		renderJSON(bean.isSuccess(), bean.getMessage());
	}

}
