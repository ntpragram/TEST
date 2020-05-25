package utils.other;

/**
 * 分页工具类
 * @author: C H
 */
public class PageUtils {
	/**
	 * 计算数字页码
	 * @author: C H
	 * @param nums
	 */
	public static int[] countPageNum(int[] nums){
		int pageIndex=nums[0];//当前页码
		int totlePage=nums[1];//总页数
		int pageGroup=5;
		if(totlePage==0){
			totlePage=1;
		}				
		int startNum = 1;
		int endNum = 1;
		if(totlePage>0){
			int middleNum = (pageGroup - 1) / 2;
			if (pageIndex <= middleNum + 1) {
				startNum = 1;
				if (totlePage > pageGroup) {
					endNum = pageGroup;
				} else {
					endNum = totlePage;
				}
			} else if (pageIndex + middleNum >= totlePage) {
				endNum = totlePage;
				if (totlePage - middleNum - 2 < 1) {
					startNum = 1;
				} else {
					startNum = totlePage - middleNum - 2;
				}
			} else {
				startNum = pageIndex + middleNum;
				endNum = pageIndex - middleNum;
			}
			if (endNum < startNum) {
				startNum = startNum + endNum;
				endNum = startNum - endNum;
				startNum = startNum - endNum;
			}
		}
		int[] startAndEndNum = {startNum,endNum};
		return startAndEndNum;
	}
}
