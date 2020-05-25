package api.index.model;

import java.util.List;

import utils.jfinal.BaseModel;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

/**
 * 新闻表
 * @author Administrator
 *
 */
public class ArticleModel extends BaseModel<ArticleModel> {

	/**
	 * <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = -211636534402983276L;

	public static final ArticleModel dao = new ArticleModel();

	@Override
	public boolean isReal() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public String tableName() {
		// TODO Auto-generated method stub
		return " t_article ";
	}

	@Override
	public String tableKey() {
		// TODO Auto-generated method stub
		return "id";
	}

	@Override
	public String fieldName() {
		// TODO Auto-generated method stub
		return null;
	}

	/**
	 * @author: C H
	 * @return
	 * @throws
	 */
	public List<Record> getNewsList() {
		// TODO Auto-generated method stub
		StringBuffer select = new StringBuffer();
		select.append("select id,title,remark,content,createTime,type,concat('http://114.55.209.136:9090/suta/',pic) as pic,lid,isDel from");
//		select.append("select id,title,remark,content,createTime,type,concat('http://192.168.1.66:8080/suta/',pic) as pic,lid,isDel from");
		select.append(this.tableName());
		select.append("WHERE isdel=0 and type=3 order by id desc");
		return Db.find(select.toString());
	}

	
	public List<Record> getNewsListTotal() {
		// TODO Auto-generated method stub
		StringBuffer select = new StringBuffer();
		select.append(" select id,title,isDel,type,concat('http://114.55.209.136:9090/suta/',pic) as pic,concat('http://114.55.209.136:9090/suta/',bigPic) as bigPic,content,url,concat('http://114.55.209.136:9090/suta/',videoPath) as videoPath,concat('http://114.55.209.136:9090/suta/',mtpic) as mtpic,grade");
//		select.append(" select count(id) as count ");
		select.append(" from " + this.tableName());		
		return Db.find(select.toString());
	}
	
	public List<Record> getNewsListEntity(int page,int size) {
		// TODO Auto-generated method stub
		StringBuffer select = new StringBuffer();
		select.append(" select id,title,isDel,type,concat('http://114.55.209.136:9090/suta/',pic) as pic,concat('http://114.55.209.136:9090/suta/',bigPic) as bigPic,content,url,concat('http://114.55.209.136:9090/suta/',videoPath) as videoPath,concat('http://114.55.209.136:9090/suta/',mtpic) as mtpic,grade");
//		select.append(" select id,title,remark,content,createTime,type,concat('http://192.168.1.66:8080/suta/',pic) as pic,lid,isDel ");
		select.append(" from " + this.tableName());
		select.append("ORDER BY createTime DESC limit "+page+","+size);
		
		return Db.find(select.toString());
	}
	
	
	/**
	 * @author: C H
	 * @param id
	 * @return
	 * @throws
	 */
	public Record getNewsDetail(String id) {
		// TODO Auto-generated method stub
		StringBuffer select = new StringBuffer();
		select.append("select id,title,remark,content,createTime,type,concat('http://114.55.209.136:9090/suta/',pic) as pic,concat('http://114.55.209.136:9090/suta/',bigPic) as bigPic,lid,isDel from");
//		select.append("select id,title,remark,content,createTime,type,concat('http://192.168.1.66:8080/suta/',pic) as pic,concat('http://192.168.1.66:8080/suta/',bigPic) as bigPic,lid,isDel from");
		select.append(this.tableName());
		select.append("WHERE id=?");
		return Db.findFirst(select.toString(),id);
	}

}
