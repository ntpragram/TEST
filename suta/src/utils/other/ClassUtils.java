package utils.other;

import java.io.File;
import java.io.FileFilter;
import java.net.URL;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

/**
 * utils
 * 
 * @Description
 * 
 * @author C H
 * @version 1.0
 * @since 2016年12月17日
 */
public class ClassUtils {

	@SuppressWarnings("unchecked")
	public static <T> List<Class<? extends T>> filterClass(List<Class<?>> list,
			Class<T> parentClass) {
		List<Class<? extends T>> classList = new ArrayList<Class<? extends T>>();
		for (Class<?> clazz : list) {
			if (parentClass.isAssignableFrom(clazz)) {
				classList.add((Class<? extends T>) clazz);
			}
		}
		return classList;
	}

	@SuppressWarnings("unchecked")
	public static <T, E> List<Class<? extends E>> filterClassOfE(
			List<Class<?>> list, Class<T> parentClass) {
		List<Class<? extends E>> classList = new ArrayList<Class<? extends E>>();
		for (Class<?> clazz : list) {
			if (parentClass.isAssignableFrom(clazz)) {
				classList.add((Class<? extends E>) clazz);
			}
		}
		return classList;
	}

	public static List<Class<?>> getClasssFromPackage(String pack) {
		List<Class<?>> clazzs = new ArrayList<Class<?>>();
		// 是否循环搜索子包
		boolean recursive = true;
		// 包名字
		String packageName = pack;
		// 包名对应的路径名称
		String packageDirName = packageName.replace('.', '/');

		Enumeration<URL> dirs;

		try {
			dirs = Thread.currentThread().getContextClassLoader()
					.getResources(packageDirName);
			while (dirs.hasMoreElements()) {
				URL url = dirs.nextElement();

				String protocol = url.getProtocol();
				if ("file".equals(protocol)) {
					String filePath = URLDecoder.decode(url.getFile(), "UTF-8");
					findClassInPackageByFile(packageName, filePath, recursive,
							clazzs);
				} else if ("jar".equals(protocol)) {
					System.out.println("jar类型的扫描");
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return clazzs;
	}

	/**
	 * 在package对应的路径下找到所有的class
	 * 
	 * @param packageName
	 *            package名称
	 * @param filePath
	 *            package对应的路径
	 * @param recursive
	 *            是否查找子package
	 * @param clazzs
	 *            找到class以后存放的集合
	 */
	public static void findClassInPackageByFile(String packageName,
			String filePath, final boolean recursive, List<Class<?>> clazzs) {
		File dir = new File(filePath);
		if (!dir.exists() || !dir.isDirectory()) {
			return;
		}
		// 在给定的目录下找到所有的文件，并且进行条件过滤
		File[] dirFiles = dir.listFiles(new FileFilter() {

			@Override
			public boolean accept(File file) {
				boolean acceptDir = recursive && file.isDirectory();// 接受dir目录
				boolean acceptClass = file.getName().endsWith("class");// 接受class文件
				return acceptDir || acceptClass;
			}
		});

		for (File file : dirFiles) {
			if (file.isDirectory()) {
				findClassInPackageByFile(packageName + "." + file.getName(),
						file.getAbsolutePath(), recursive, clazzs);
			} else {
				String className = file.getName().substring(0,
						file.getName().length() - 6);
				try {
					clazzs.add(Thread.currentThread().getContextClassLoader()
							.loadClass(packageName + "." + className));
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}
}
