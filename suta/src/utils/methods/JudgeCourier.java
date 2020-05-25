/**
 * 
 */
package utils.methods;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.log4j.chainsaw.Main;

/**
 * @author: C H
 */
public class JudgeCourier {
	
	 /**
	    * 
	    * 物流判断
	    * 
	    * 
	    */
	   
	   public boolean  judgeCourier(String courierNumber,String courierCompany){
		   
		   String regEx="";

		   if (courierCompany.equals("sf")) {
			   regEx = "^[A-Za-z0-9-]{4,35}$";
		   }
		  
		   if (courierCompany.equals("sto")) {
			   regEx = "^(888|588|688|468|568|668|768|868|968)[0-9]{9}$|^(11|22)[0-9]{10}$|^(STO)[0-9]{10}$|^(37|33|11|22|44|55|66|77|88|99)[0-9]{11}$|^(4)[0-9]{11}$";
		   }
		   if (courierCompany.equals("zto")) {
			   regEx = "^((768|765|778|828|618|680|518|528|688|010|880|660|805|988|628|205|717|718|728|761|762|763|701|757|719|751|358|100|200|118|128|689|738|359|779|852)[0-9]{9})$|^((5711|2008|7380|1180|2009|2013|2010|1000|1010)[0-9]{8})$|^((8010|8021|8831|8013)[0-9]{6})$|^((1111|90|36|11|50|53|37|39|91|93|94|95|96|98)[0-9]{10})$|^((a|b|h)[0-9]{13})$|^((90|80|60)[0-9]{7})$|^((80|81)[0-9]{6})$|^((21|23|24|25|93|94|95|96|97|110|111|112|113|114|115|116|117|118|119|121|122|123|124|125|126|127|128|129|130|131)[0-9]{8})$|^(100|101|102|103|104|105|106|107|503|504|505|506|507)[0-9]{10}$|^(4)[0-9]{11}$|^(120)[0-9]{9}$|^(780)[0-9]{9}$|^(881)[0-9]{9}$|^(882|885)[0-9]{9}$|^(91|92)[0-9]{10}$|^(54|55|56)[0-9]{10}$|^(63)[0-9]{10}$|^(7)[0-9]{9}$|^(64)[0-9]{10}$|^(72)[0-9]{10}$|^(220|221|223|224|225|226|227|228|229)[0-9]{7}$|^(21|22|23|24|25|26|27|28|29)[0-9]{10}$|^3[0-9]{9}$|^2710[0-9]{11}$|^731[0-9]{11}$|^751[0-9]{11}$|^7320[0-9]{10}$";
		   }
		   if (courierCompany.equals("yd")) {
			   regEx = "^(10|11|12|13|14|15|16|17|19|18|50|55|58|80|88|66|31|77|39)[0-9]{11}$|^[0-9]{13}$";
		   }
		   
		   if (courierCompany.equals("yt")) {
			   regEx = "^[A-Za-z0-9]{2}[0-9]{10}$|^[A-Za-z0-9]{2}[0-9]{8}$|^[6-9][0-9]{17}$|^[DD]{2}[8-9][0-9]{15}$|^[Y][0-9]{12}$";
		   }
		   if (courierCompany.equals("tt")) {
			   regEx = "^[0-9]{12}$";
		   }
		   if (courierCompany.equals("ems")) {
			   regEx = "^[A-Z]{2}[0-9]{9}[A-Z]{2}$|^(10|11)[0-9]{11}$|^(50|51)[0-9]{11}$|^(95|97)[0-9]{11}$";
		   }

		   if (courierCompany.equals("qf")) {
			   regEx = "^[0-6|9][0-9]{11}$|^[7][0-8][0-9]{10}$|^[0-9]{15}$|^[S][0-9]{9,11}(-|)P[0-9]{1,2}$|^[0-9]{13}$|^[8][0,2-9][0,2-9][0-9]{9}$|^[8][1][0,2-9][0-9]{9}$|^[8][0,2-9][0-9]{10}$|^[8][1][1][0][8][9][0-9]{6}$";
		   }
		   if (courierCompany.equals("db")) {
			   regEx = "^[5789]\\d{9}$";
		   }
		   if (courierCompany.equals("gt")) {
			   regEx = "^(3(([0-6]|[8-9])\\d{8})|((2|4|5|6)\\d{9})|(7(?![0|1|2|3|4|5|7|8|9])\\d{9})|(8(?![2-9])\\d{9})|(2|4)\\d{11})$";
		   }
		   if (courierCompany.equals("rfd")) {
			   regEx = "^[\\x21-\\x7e]{1,100}$";
		   }
		   if (courierCompany.equals("jd")) {
			   return true;
		   }
		   if (courierCompany.equals("zjs")) {
			   regEx = "^[a-zA-Z0-9]{10}$|^(42|16)[0-9]{8}$|^A[0-9]{12}";
		   }
		   if (courierCompany.equals("youzheng")) {
			   regEx = "^([GA]|[KQ]|[PH]){2}[0-9]{9}([2-5][0-9]|[1][1-9]|[6][0-5])$|^[99]{2}[0-9]{11}$|^[96]{2}[0-9]{11}$|^[98]{2}[0-9]{11}$";
		   }
		   if (courierCompany.equals("bsky")) {
			   regEx = "^((A|B|D|E)[0-9]{12})$|^(BXA[0-9]{10})$|^(K8[0-9]{11})$|^(02[0-9]{11})$|^(000[0-9]{10})$|^(C0000[0-9]{8})$|^((21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36|37|38|39|61|63)[0-9]{10})$|^((50|51)[0-9]{12})$|^7[0-9]{13}$|^6[0-9]{13}$|^58[0-9]{14}$";
		   }

		   Pattern pat = Pattern.compile(regEx);
		   Matcher matcher = pat.matcher(courierNumber);
		   if(matcher.find()) {
			   return true;
			 }else {
			   return false;
			 }
	   }
	   
	
	public static void main(String[] args) {
		
		JudgeCourier judgeCourier=new JudgeCourier();
		boolean isOk = judgeCourier.judgeCourier("212", "sf");
		
		System.out.println(isOk);
	}
	

}