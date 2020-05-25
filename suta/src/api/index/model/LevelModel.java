/**
 * 
 */
package api.index.model;

import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

import utils.jfinal.BaseModel;

/**
 * @author: C H
 */
public class LevelModel  extends BaseModel<PictureModel> {
	
	/**
	 * <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = -211636534402983276L;
	
	public static final LevelModel dao = new LevelModel();

	/* (non-Javadoc)
	 * @see utils.jfinal.BaseModel#tableName()
	 */
	@Override
	public String tableName() {
		// TODO Auto-generated method stub
		return "t_level";
	}

	/* (non-Javadoc)
	 * @see utils.jfinal.BaseModel#tableKey()
	 */
	@Override
	public String tableKey() {
		// TODO Auto-generated method stub
		return "id";
	}

	/* (non-Javadoc)
	 * @see utils.jfinal.BaseModel#fieldName()
	 */
	@Override
	public String fieldName() {
		// TODO Auto-generated method stub
		return null;
	}
	
	/**
	 * 成功案例首页
	 * @author: C H
	 * @param json
	 * @return
	 * @throws
	 */
	public List<Record> getLevelList(int type){
		StringBuffer select = new StringBuffer();
		select.append(" select id,title,isDel,type,concat('http://114.55.209.136:9090/suta/',pic) as pic,concat('http://114.55.209.136:9090/suta/',bigPic) as bigPic,content,url,concat('http://114.55.209.136:9090/suta/',videoPath) as videoPath,concat('http://114.55.209.136:9090/suta/',mtpic) as mtpic,grade");
//		select.append(" select id,title,isDel,type,concat('http://192.168.1.66:8080/suta/',pic) as pic,concat('http://192.168.1.66:8080/suta/',bigPic) as bigPic,content,url,concat('http://192.168.1.66:8080/suta/',videoPath) as videoPath,concat('http://192.168.1.66:8080/suta/',mtpic) as mtpic,grade");
		select.append(" from " + this.tableName());
		select.append(" where type=? ");
		
		return Db.find(select.toString(),type);
		 
	}


	/**
	 * @author: C H
	 * @param lid
	 * @return
	 * @throws
	 */
	public Record getSuccessCaseDetailList(String lid) {
		// TODO Auto-generated method stub
		StringBuffer select = new StringBuffer();
		select.append(" select id,title,isDel,type,concat('http://114.55.209.136:9090/suta/',pic) as pic,concat('http://114.55.209.136:9090/suta/',bigPic) as bigPic,content,url,concat('http://114.55.209.136:9090/suta/',videoPath) as videoPath,concat('http://114.55.209.136:9090/suta/',mtpic) as mtpic,grade");
//		select.append(" select id,title,isDel,type,concat('http://192.168.1.66:8080/suta/',pic) as pic,concat('http://192.168.1.66:8080/suta/',bigPic) as bigPic,content,url,concat('http://192.168.1.66:8080/suta/',videoPath) as videoPath,concat('http://192.168.1.66:8080/suta/',mtpic) as mtpic,grade");
		select.append(" from " + this.tableName());
		select.append(" where id=?");
		
		return Db.findFirst(select.toString(),lid);
	}
	

	public List<Record> getLevelGradeList() {
		StringBuffer select = new StringBuffer();
		select.append(" select id,title,isDel,type,concat('http://114.55.209.136:9090/suta/',pic) as pic,concat('http://114.55.209.136:9090/suta/',bigPic) as bigPic,content,url,concat('http://114.55.209.136:9090/suta/',videoPath) as videoPath,concat('http://114.55.209.136:9090/suta/',mtpic) as mtpic,grade");
//		select.append(" select id,title,isDel,type,concat('http://192.168.1.66:8080/suta/',pic) as pic,concat('http://192.168.1.66:8080/suta/',bigPic) as bigPic,content,url,concat('http://192.168.1.66:8080/suta/',videoPath) as videoPath,concat('http://192.168.1.66:8080/suta/',mtpic) as mtpic,grade");
		select.append(" from " + this.tableName());
		select.append(" where grade like '%1%' ");
		
		return Db.find(select.toString());
	}

	public Record getSuccessGradeDetailList(String grade) {
		// TODO Auto-generated method stub
		StringBuffer select = new StringBuffer();
		select.append(" select id,title,isDel,type,concat('http://114.55.209.136:9090/suta/',pic) as pic,concat('http://114.55.209.136:9090/suta/',bigPic) as bigPic,content,url,concat('http://114.55.209.136:9090/suta/',videoPath) as videoPath,concat('http://114.55.209.136:9090/suta/',mtpic) as mtpic,grade");
//		select.append(" select id,title,isDel,type,concat('http://192.168.1.66:8080/suta/',pic) as pic,concat('http://192.168.1.66:8080/suta/',bigPic) as bigPic,content,url,concat('http://192.168.1.66:8080/suta/',videoPath) as videoPath,concat('http://192.168.1.66:8080/suta/',mtpic) as mtpic,grade");
		select.append(" from " + this.tableName());
		select.append(" where grade=?");
		
		return Db.findFirst(select.toString(),grade);
	}

}
