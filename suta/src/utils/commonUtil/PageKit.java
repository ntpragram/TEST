package utils.commonUtil;


/**
 * Created by Admin on 16/8/9.
 */
public class PageKit {
    /**
     * 分页获取开始
     *
     * @param pageIndex
     * @param pageSize
     * @return
     */
    public static int getStart(int pageIndex, int pageSize) {
        return (pageIndex-1) * 10;
    }

    /**
     * 将页数和每页条目数转换为开始位置和结束位置<br>
     * 此方法用于不包括结束位置的分页方法<br>
     * 例如：<br>
     * 页码：1，每页10 -> [0, 10]<br>
     * 页码：2，每页10 -> [10, 20]<br>
     * 。。。<br>
     *
     * @param pageNo
     *            页码（从1计数）
     * @param countPerPage
     *            每页条目数
     * @return 第一个数为开始位置，第二个数为结束位置
     */
    public static int[] transToStartEnd(int pageNo, int countPerPage) {
        if (pageNo < 1) {
            pageNo = 1;
        }

        if (countPerPage < 1) {
            countPerPage = 0;
//			LogKit.warn("Count per page  [" + countPerPage + "] is not valid!");
        }

        int start = (pageNo - 1) * countPerPage;
        int end = start + countPerPage;

        return new int[] { start, end };
    }
}
