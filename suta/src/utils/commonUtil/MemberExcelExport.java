package utils.commonUtil;

import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

public class MemberExcelExport
{
  Date now = new Date();
  SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
  SimpleDateFormat formatters = new SimpleDateFormat("yyyyMMddHHmmss");
  String now_ydm = this.formatter.format(this.now);
  String now_ydms = this.formatters.format(this.now);
  
  public String Excel(List s, String _excelname, String _urlpath, String _filename)
    throws Exception
  {
    MemberExcelExport c = new MemberExcelExport();
    
    HSSFWorkbook wb = new HSSFWorkbook();
    
    HSSFSheet sheet = wb.createSheet(_excelname);
    



    HSSFCellStyle style = wb.createCellStyle();
    style.setAlignment((short)2);
    




    List list = s;
    System.out.println("listExcel:"+list);
    for (int i = 0; i < list.size(); i++)
    {
      LinkedHashMap hamap = (LinkedHashMap)list.get(i);
      
      Iterator iter = hamap.entrySet().iterator();
      int j = 0;
      while (iter.hasNext())
      {
        Map.Entry entry = (Map.Entry)iter.next();
        Object key = entry.getKey();
        Object val = entry.getValue();
        if (i == 0)
        {
          HSSFRow row = sheet.createRow(0);
          HSSFCell cell = row.createCell((short)j);
          cell.setCellValue(key.toString());
          cell.setCellStyle(style);
        }
        HSSFRow row = sheet.createRow(i + 1);
        row.createCell((short)j).setCellValue(val.toString());
        j++;
      }
    }
    FileOutputStream fout = new FileOutputStream(_urlpath + _filename);
    wb.write(fout);
    fout.close();
    return _filename;
  }
}
