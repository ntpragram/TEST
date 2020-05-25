package utils.methods;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.TreeSet;

public class JavaTest {

	 public static final int []num = {1, 2, 3, 4, 5,6,7,8,9,0};
	    public static int count = 0;
	    
	    
	    public static void main(String[] args) {
	    	String phone="1732709";
	        calculate(num,phone);
	        
	        System.out.println("总数为" + count);
	    }
	    public static void calculate(int []arr,String phone){
	        for(int i=0; i<arr.length; i++)
	        {
	            for(int j=0; j<arr.length; j++)
	            {
	                    for(int k=0; k<arr.length; k++)
	                    {
	                        	for(int p=0;p<arr.length;p++){
	                        		 count++;
	 	                            System.out.println(phone + arr[i] + "" + arr[j] + "" + arr[k]+""+arr[p]);
	                        	}
	                    }
	            }
	        }
	    }


	
}
