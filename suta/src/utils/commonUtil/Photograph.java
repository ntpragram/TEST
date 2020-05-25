package utils.commonUtil;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;


public class Photograph
{
  public static void main(String[] args)
  {
    String strImg = GetImageStr();

    System.out.println(getPhotoByAndroid(strImg, "f:/b2015/hrwy/", "file/123.jpg"));
  }

  public static String GetImageStr() {
    String imgFile = "c:\\pic2.jpg";
    InputStream in = null;
    byte[] data = (byte[])null;
    try
    {
      in = new FileInputStream(imgFile);
      data = new byte[in.available()];
      in.read(data);
      in.close();
    }
    catch (IOException e)
    {
      e.printStackTrace();
    }

    BASE64Encoder encoder = new BASE64Encoder();
    return encoder.encode(data);
  }

  public static String getPhotoByAndroid(String photoPath, String basePath, String basePathFile)
  {
    String newFilePath = basePath;

    String newFileName = basePathFile;
    FileOutputStream fos = null;
    try
    {
      byte[] buffer = new BASE64Encoder().decodeBuffer(photoPath);

      File destDir = new File(newFilePath);
      if (!destDir.exists()) destDir.mkdir();
      fos = new FileOutputStream(new File(destDir, newFileName));
      fos.write(buffer);
      fos.flush();
      fos.close();
    }
    catch (IOException e) {
      e.printStackTrace();
    }

    return newFileName;
  }
}