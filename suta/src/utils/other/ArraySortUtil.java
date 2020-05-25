/**
 * 
 */
package utils.other;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class ArraySortUtil {
	
	
	public static void main(String[] args) {
		String url="http://121.43.188.172:8019/ZhangShangYunShanPic/file/2ee795fbff5e88f0a092deb1224bdcc9.png";
		System.out.println(url.substring(48)+"==========");
		
	}

    public static List<String> descartes(List<List<String>> strs) {
        
        int total = 1;
        for (int i = 0; i < strs.size(); i++) {
            total *= strs.get(i).size();
        }
        String[] mysesult = new String[total];
        int now = 1;
        //每个元素每次循环打印个数
        int itemLoopNum = 1;
        //每个元素循环的总次数
        int loopPerItem = 1;
        for (int i = 0; i < strs.size(); i++) {
            List temp = strs.get(i);
            now = now * temp.size();
            //目标数组的索引值
            int index = 0;
            int currentSize = temp.size();
            itemLoopNum = total / now;
            loopPerItem = total / (itemLoopNum * currentSize);
            int myindex = 0;
            for (int j = 0; j < temp.size(); j++) {

                //每个元素循环的总次数
                for (int k = 0; k < loopPerItem; k++) {
                    if (myindex == temp.size())
                        myindex = 0;
                    //每个元素每次循环打印个数
                    for (int m = 0; m < itemLoopNum; m++) {
                        mysesult[index] = (mysesult[index] == null ? "" : mysesult[index] + ",") + ((String) temp.get(myindex));
                        index++;
                    }
                    myindex++;

                }
            }
        }
        return Arrays.asList(mysesult);
    }

}
