package utils.commonUtil;

import java.util.Random;

public class GetRandom {

	// 生成N位 随机数getRandom
	public static String getRandom(int num) {
	    String sRand = "";
	    Random random = new Random();
	    for (int i = 0; i < num; i++) {
	    	String rand1 = String.valueOf(random.nextInt(10));
	    	sRand += rand1;
	    }
	    return sRand;
	}
}
