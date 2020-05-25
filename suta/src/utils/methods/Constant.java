/**
 * 
 */
package utils.methods;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author: C H
 */
public class Constant {
	
	/**
     * 数据结构里的Source 字段暂写0
     */
    public final static String Source = "0";
    
    /**
     * 访问链接地址
     */
    public final static String urls = "http://121.43.188.172:8019/ZhangShangYunShanPic/";
    
    //https://www.yunshan.live/ZhangShangYunShan/api/smallApplet/user/
    
    

    /**
     * 获取验证码类别
     */
    
    public static class getCodeType  {
        public final static int REG = 1;//注册
        public final static int FORGETPASSWORD = 2;//忘记密码
        public final static int MODIFYPASSWORD = 3;//修改密码
        public final static int MODIFYPHONE = 4;//更换手机号
        public final static int SHAREGETCODE = 5;
        public final static int CODELOGIN = 6;//验证码登陆
        public final static int BINDINGPHONE = 7;//微信绑定手机号
       
    }
    
    /**
     * 是否登陆
     */
    public static class isLogin {
        public final static int  NO= 0;//未登录
        public final static int YES = 1;//已登陆
       
    }
    
    /**
     * 手机系统
     */
    public static class platForm {
        public final static int  ANDROID= 1;//安卓
        public final static int IOS = 2;//苹果
        public final static int WX = 3;//微信
       
    }
	
    /**
     * 账号状态
     */
    public static class userStatus {
        public final static int  YES= 0;//账户正常使用
        public final static int NO = 1;//禁用 
    }
    
    /**
     * 地址默认状态
     */
    public static class addressIsDefult {
        public final static int  NO= 0;//不默认地址
        public final static int YES = 1;//默认地址 
    }
    
    /**
     * 删除状态
     */
    public static class isDel {
        public final static int  NO= 0;//未删除
        public final static int YES = 1;//已删除
    }
	
    
    /**
     * 红包类型
     */
    public static class redPacketType {
        public final static int  NEWPEOPLEREDPACKET= 1;//新人注册红包
        public final static int OTHERREDPACKET = 2;//其他红包
    }
    
    
    /**
     * 新人领取红包状态
     */
    public static class newMemberGetRedPacketStatus {
        public final static int  NOGET= 0;//未领取
        public final static int YESGET = 1;//已领取
    }

    
    /**
    * 单向省市区类型  
    */
   public static class PCD {
       public final static int  PROVINCE= 1;//省份
       public final static int CITY = 2;//城市
       public final static int AREA = 3;//地区
   }

   /** 
    * 收藏类型
    */
   public static class collectStatus {
       public final static int  NEWS= 0;//新闻
       public final static int  PROBLEM= 1;//问答
       
   }

   /** 
    *订单状态  0待付款 1 已付款  2卖家发货  3 买家收货   4 买家寄送   5 申请退货退款 待审核6 申请退货退款审核通过  7 申请退货退款审核不通过  8 取消交易  9 已退款 10 交易完成
    */
   public static class integralOrderStatus {
	       public final static int  DFK= 0;//待付款
	       public final static int  YFK= 1;//已付款
	       public final static int  MJFH= 2;//卖家发货
	       public final static int  MJSH= 3;//买家收货
	       public final static int  MJJS= 4;//买家寄送
	       public final static int  SQTHTKDSH= 5;//申请退货退款 待审核
	       public final static int  SQTHTKSHTG= 6;//申请退货退款审核通过 
	       public final static int  SQTHTKSHBTG= 7;//申请退货退款审核不通过  
	       public final static int  JYGB= 8;//交易关闭
	       public final static int  YTK= 9;//已退款
	       public final static int  WC= 10;//交易完成
   }
   /** 
    * 积分明细类型
    */
   public static class instralStatus {
       public final static int  ADD= 0;//加
       public final static int  SUBTRACT= 1;//减
       
   }
    
   /** 
    * 问题回复等级
    */
   public static class forumLevel {
       public final static int  ONE= 1;//一级
       public final static int  TWO= 2;//二级
       
   }
   
   /** 
    * 关注或者点赞
    */
   public static class facusOrDz {
       public final static int  GUANZHU= 0;//关注
       public final static int  DIANZAN= 1;//点赞
       
   }
   
   /** 
    * 红包类型
    */
   public static class redPacketStatus {
       public final static int  DIYONG= 0;//抵用券
       public final static int  ZHEKOU= 1;//折扣券
       
   }
   
   /** 
    * 支付方式
    */
   public static class zfStyle {
	   public final static int  NOPRICE= 0;
       public final static int  ZHIFUBAO= 1;//支付宝
       public final static int  WEIXIN= 2;//微信 
       public final static int  BALANCE= 3;//余额 
   }
   /** 
    * 订单状态  0待付款 1 已付款  2卖家发货  3 买家收货   4 买家寄送   5 申请退货退款 待审核6 申请退货退款审核通过  7 申请退货退款审核不通过  8 取消交易  9 已退款 10 交易完成
    * 
    *  
    * 
    */
   public static class OrderStatus {
	   
       public final static int  DFK= 0;//待付款
       public final static int  YFK= 1;//已付款
       public final static int  MJFH= 2;//卖家发货
       public final static int  MJSH= 3;//买家收货
       public final static int  MJJS= 4;//买家寄送
       public final static int  SQTHTKDSH= 5;//申请退货退款 待审核
       public final static int  SQTHTKSHTG= 6;//申请退货退款审核通过 
       public final static int  SQTHTKSHBTG= 7;//申请退货退款审核不通过  
       public final static int  JYGB= 8;//交易关闭
       public final static int  YTK= 9;//已退款
       public final static int  WC= 10;//交易完成
       
   }
   
   public static class IntegralType {
       public final static int  ZERO= 0;//购买消费退还积分
       public final static int  ONE= 1;//运动兑换积分
      
   }
  
   
   
   
   
  /* 
   //1.8 a为泛型中的对象
   list.forEach(a ->{
       System.out.println(a.getName());
   });
   
   //1.5 增强行for循环
   for (Animal a : list) {
       System.out.println(a.getName());
   }
   //普通循环
   for(int i =0;i<list.size();i++){
       System.out.println(list.get(i).getName());
   }
   */

   

}
