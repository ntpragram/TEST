package utils.upload;

import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.PageContext;

import utils.commonUtil.StrManager;
import utils.jfinal.ConnDb;


public class UploadUtil {
	 /*
     * 上传代码封装 
     *
     *        方法：getUploadFile(pageContext,String[],boolean) 第一个为jsp上下文，第二个为html的file控件的name值数组，第三个为是否可为空，默认为false不可为空
     *        用途：初始化upload控件，并且获得一堆参数等等
     *        返回：code=0   出错/code=1 正确
     *                  msg=""   出错的提示，直接是个脚本，输出就行
     *                  request  request封装，直接调用
     *                  pathList 已经保存的文件名称的集合
     *                  
     *        方法：saveUploadFile(HashMap<String,String>) 上一个方法的pathList
     *        用途：保存相应的文件
     *        返回：boolean 是否保存成功，判断依据为是否抛出异常
     *
     *        方法：saveUploadFile(HashMap<String,String>,String[],String[]) 重载上一个方法，第一个参数为第一个方法pathList，第二个参数为html的file控件的name值数组，第三个参数为file控件的name值对应的数据库字段名称，后面两个数组按照顺序匹配
     *        用途：保存相应的文件
     *        返回：String 返回的是update语句字符串，如：[,file='1111.zip',pic='2222.jpg']，如果后两个参数不合法且上传成功，则返回字符串"完成"，如果后两个参数不合法且上传不成功，则返回字符串""
     *
     *        方法：printError(String) 需要输出(alert)的文字
     *  用途：打印脚本并回退上一个页面
     *  返回：脚本
     *                  
     */
     
    utils.upload.SmartUpload myUpload=null;
    
    public HashMap<String,Object> getUploadFile(PageContext pageContext,String[] fileName) throws Exception{
            return getUploadFile(pageContext,fileName,false);
    }
    
    public HashMap<String,Object> getUploadFile(PageContext pageContext,String[] fileName,boolean canNull) throws Exception{
    	return getUploadFile(pageContext,fileName,canNull,"utf-8");
    }
    
    public HashMap<String,Object> getUploadFile(PageContext pageContext,String[] fileName,boolean canNull,String charset) throws Exception{
            HashMap<String,Object> resultMap=new HashMap<String,Object>();
            myUpload=new utils.upload.SmartUpload();
            myUpload.initialize(pageContext);
            myUpload.upload(charset);
            StrManager str=new StrManager();
            
            /********************以上需要修改************************/
            /**
            * 文件上传部分处理
            * 需要判断文件大小，文件总和不超过800KB(850000B)
            * 需要判断文件类型，不能是jsp,inc,css,class,java,exe,asp
            * xml,htm,html,js,jsp
            * 文件命名规则是：科室缩写＋用户名＋new Date().getTime()＋.文件自己的扩展名
            */
            int maxFileSize = 8500000;  //根据实际大小定  //====》修改

            int filesCount = myUpload.getFiles().getCount();//得到上传文件个数
            long filesize = 0;//文件大小之和
            SmartFile upFile; //当前文件

            //能使用的扩展名
            String[] dontExtAry = {"asp", "xml", "htm", "html",
                             "class", "inc", "js","jsp","exe", "php", "aspx", "bat", "java", "css",
                             "sql", "ini", "properties"};

            //当前文件的扩展名数组
            String[] ext = new String[filesCount];
            int total_val=1;//定义全局判断上传文件类型.1为上传文件正确，0为上传错误
            //====》添加
            for(int i = 0; i < filesCount; i++){//依次检验每个文件

                    upFile = myUpload.getFiles().getFile(i);
                    String filename = upFile.getFileName();

                    if (!filename.equals("")){//文件不为空  ====》修改

                            int upFileSize = upFile.getSize();
                            if (upFileSize == 0){
                                    total_val=0;  //====》添加
                                    resultMap.put("code","0");
                                    resultMap.put("msg",printError("上传的文件不能为空!"));
                                    return resultMap;
                            }
                            if(upFileSize>maxFileSize)
                            {
                                    total_val=0;  //====》添加                                                        
                                    resultMap.put("code","0");
                                    resultMap.put("msg",printError("上传的文件大小不能超过8MB!"));
                                    return resultMap;
                            }
                            //====》添加
                            ext[i] = str.getFileExt(filename);
                            ext[i] = str.notEmpty(ext[i]);
                            for (int j = 0; j < dontExtAry.length; j++){
                                    if (ext[i].equals(dontExtAry[j])){//如果是不能使用的扩展名
                                            total_val=0;  //====》添加
                                            resultMap.put("code","0");
                                            resultMap.put("msg",printError("上传了不允许使用的文件类型!"));
                                            return resultMap;
                                    }
                            }
                    }else{
                            //是否可为空
                            if(!canNull){
                                    total_val=0; 
                            }
                    }
            }//依次检验每个文件
            if(total_val==1){   //====》添加

                    String path="";//文件路径
                    path += "file";
                    String newFileHead = "";//文件名的前一部分
                    //*************//
                    path += "/";

                    String timeStr;//时间字串
                    String newFileName = "";//新文件名

                    //ArrayList<String> pathList=new ArrayList<String>();
                    HashMap<String,String> pathList=new HashMap<String,String>();
                    for (int i = 0; i < filesCount; i++){
                            upFile = myUpload.getFiles().getFile(i);
                            String filename = upFile.getFileName();
                            if (!filename.equals("")){
                                    //timeStr = String.valueOf(new java.util.Date().getTime()).trim();
                                    java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy_MM_dd_HHmmss_SS"); 
                                    java.util.Date currentTime_1 = new java.util.Date();
                                    timeStr = formatter.format(currentTime_1); 
                                    newFileName = path + i +"_"+timeStr+"";
                                    if (!ext[i].equals("")){
                                            newFileName += "." + ext[i];
                                    }
                                    //myUpload.getFiles().getFile(i).saveAs(newFileName);
                                    //下面的getFieldName()用于取HTML表单中对应于此上传文件的表单项的名字。
                                    if(fileName!=null && fileName.length>0){
                                            for(int k=0;k<fileName.length;k++){
                                                    if(upFile.getFieldName().equals(fileName[k])){
                                                            pathList.put(fileName[k],newFileName);
                                                    }
                                            }
                                    }
                            }
                    }
                    resultMap.put("pathList",pathList);

                    /**
                     *接收可能的保存信息,对可能为null的字符串作处理
                     */
                    
                    /**********************需要修改的部分********************/
                    resultMap.put("code","1");
                    resultMap.put("request",myUpload.getRequest());
                    
                    //String BNAME = str.notEmpty((String)myUpload.getRequest().getParameter("BNAME")).trim();
                    /**********************需要修改的部分********************/
            }
            return resultMap;
    }
    
    public boolean saveUploadFile(HashMap<String,String> pathList){
            try{
                    String result=saveUploadFile(pathList,null,null);
                    if(result.length()>0){
                            return true;                                
                    }else{
                            return false;                        
                    }
            }catch(Exception e){
                    e.printStackTrace();
                    return false;
            }
    }
    
    public String saveUploadFile(HashMap<String,String> pathList,String[] fileName,String[] param){
            String paramStr="";
            try{
                    boolean appendSet=true;
                    if(fileName==null || param==null || param.length!=fileName.length){
                            appendSet=false;
                            paramStr="完成";
                    }
                    SmartFile upFile; //当前文件
                    int filesCount = myUpload.getFiles().getCount();
                    if(pathList!=null && pathList.size()>0){
                            Iterator<String> iter=pathList.keySet().iterator();
                            while (iter.hasNext()) {
                                    String key=iter.next();
                                    String val=pathList.get(key);
                                    for (int i = 0; i < filesCount; i++){
                                            upFile = myUpload.getFiles().getFile(i);
                                            String filename = upFile.getFileName();
                                            String filedName = upFile.getFieldName();
                                            if (!filename.equals("")){
                                                    if(filedName.equals(key)){
                                                            myUpload.getFiles().getFile(i).saveAs(val);
                                                    }
                                            }
                                    }
                                    if(appendSet){
                                            for(int i=0;i<fileName.length;i++){
                                                    if(key.equals(fileName[i])){
                                                            paramStr+=",`"+ param[i] +"`='"+ pathList.get(fileName[i]) +"'";
                                                    }                                                        
                                            }
                                    }
                            }
                    }
                    return paramStr;
            }catch(Exception e){
                    e.printStackTrace();
                    return "";
            }finally{
                    myUpload=null;
            }
    }
    
    /**
     * deleteOriginalFile
     * 删除原图片文件
     * @param db ConnDb实体类
     * @param tableName 数据库表名称
     * @param columnName 字段名称
     * @return
     */
    /**
     * deleteOriginalFile
     * 删除原图片文件
     * @param request HttpServletRequest实例
     * @param db ConnDb实体类
     * @param tableName 数据库表名称
     * @param columnName 字段名称
     * @param keyName 主键字段名称
     * @param keyValue 主键字段值
     * @return
     */
/*    public boolean deleteOriginalFile(HttpServletRequest request,ConnDb db,String tableName,String columnName,String keyName,String keyValue){
    	String sql="select `"+columnName+"` from "+tableName+" where `"+keyName+"`='"+ keyValue +"'";
    	try {
    		Hashtable hsTable=db.getValue(sql);
        	if (hsTable!=null && !hsTable.isEmpty()) {
    			String path=(String)hsTable.get(columnName);
    			return deleteOriginalFile(request, path);
    		}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
    }*/
    
    /**
     * deleteOriginalFile
     * 删除原图片文件
     * @param request HttpServletRequest
     * @param path 物理路径(file/1.jpg)
     * @return 
     */
    public boolean deleteOriginalFile(HttpServletRequest request,String path){
    	java.util.StringTokenizer st =
                new java.util.StringTokenizer(path, " ");
        String file = "";
        java.io.File attachFile;

        while(st.hasMoreTokens()){
            file = st.nextToken();
            file = request.getRealPath(file);
            attachFile = new  java.io.File(file);
            return attachFile.delete();
        }
        return false;
    }
    
    public String printError(String msg){
            return "<script>alert('"+ msg +"');history.back();</script>";
    }
    //////////////////////以上为上传封装////////////////////////////////
}
